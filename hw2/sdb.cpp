#include "sdb.hpp"
#include "utils.hpp"

SDB::SDB(char**program):program(program){}

user_regs_struct SDB::sync_regs(){
    if(ptrace(PTRACE_GETREGS,child,0,&regs)!=0){
        perror("SDB::sync_regs");
        exit(1);
    }
    return regs;
}

uint8_t SDB::poke(uint64_t addr,uint8_t data){
    uint64_t org=ptrace(PTRACE_PEEKTEXT,child,addr,0);
    ptrace(PTRACE_POKETEXT,child,addr,org&~0xff|data);
    return org&0xff;
}

BreakPoint SDB::findbp(uint64_t addr){
    for(auto bp:bps)
        if(bp.addr==addr)
            return bp;
    return BreakPoint(0,0);
}

void SDB::disas(){
    uint8_t code[64];
    uint64_t rip=sync_regs().rip;
    long ret;
    unsigned char*ptr=(unsigned char*)&ret;

    for(int i=0;i<8;++i){
        ret=ptrace(PTRACE_PEEKTEXT,child,rip+8*i,0);
        for(int j=0;j<8;++j)
            code[i*8+j]=ptr[j];
    }

    for(auto[addr,org]:bps){
        if(rip<=addr && addr<rip+64){
            code[addr-rip]=org;
        }       
    }

    csh handle;
    cs_insn*insn;
    if(cs_open(CS_ARCH_X86,CS_MODE_64,&handle)!=CS_ERR_OK){
        perror("SDB::disas cs_open");
        exit(1);
    }
	int count=cs_disasm(handle,code,sizeof(code)-1,rip,0,&insn);
	if(count>0){
        bool flag=false;
	    for(int i=0;i<5;i++){
            if(flag){
                log("the address is out of the range of the text segment.");
                break;
            }
            cout<<hex<<setfill(' ')<<setw(12)<<insn[i].address<<": ";
            stringstream ss;
            for(int j=0;j<insn[i].size;++j)
                ss<<hex<<setfill('0')<<setw(2)<<(int)insn[i].bytes[j]<<' ';
            cout<<setw(24)<<left<<ss.str();
            cout<<setw(10)<<insn[i].mnemonic<<' ';
            cout<<insn[i].op_str<<right<<endl;
            if(string(insn[i].mnemonic)=="ret")
                flag=true;
		}
		cs_free(insn,count);
	}else
		cerr<<"ERROR: Failed to disassemble given code!"<<endl;
	cs_close(&handle);
}

void SDB::si(){
    if(!WIFSTOPPED(status)){
        log("program not running.");
        exit(1);
    }
    uint64_t rip=sync_regs().rip;
    BreakPoint bp=findbp(rip);
    if(bp.addr==0){
        ptrace(PTRACE_SINGLESTEP,child,0,0);
        waitpid(child,&status,0);
    }else{
        poke(bp.addr,bp.org);
        ptrace(PTRACE_SINGLESTEP,child,0,0);
        waitpid(child,&status,0);
        poke(bp.addr,0xcc);
    }
    if(WIFSTOPPED(status))
        disas();
    else
        log("the target program terminated.");
}

void SDB::cont(){
    if(!WIFSTOPPED(status)){
        log("program not running.");
        exit(1);
    }
    uint64_t rip=sync_regs().rip;
    BreakPoint bp=findbp(rip);
    if(bp.addr==0){
        ptrace(PTRACE_CONT,child,0,0);
        waitpid(child,&status,0);
    }else{
        poke(bp.addr,bp.org);
        ptrace(PTRACE_CONT,child,0,0);
        waitpid(child,&status,0);
        poke(bp.addr,0xcc);
    }
    if(WIFSTOPPED(status)){
        rip=sync_regs().rip;
        bp=findbp(rip-1);
        log("hit a breakpoint at %p,",rip-1);
        assert(bp.addr!=0);

        poke(bp.addr,bp.org);
        regs.rip-=1;
        ptrace(PTRACE_SETREGS,child,0,&regs);
        disas();

        poke(bp.addr,0xcc);
    }else
        log("the target program terminated.");
}

void SDB::brk(uint64_t addr){
    log("set break point at %p",addr);
    bps.emplace_back(addr,poke(addr,0xcc));
}

void SDB::anchor(){
    string mfile="/proc/"+to_string(child)+"/maps";
    ifstream is(mfile);
    string line;
    vector<pair<uint64_t,uint64_t>> mems;
    while(getline(is,line)){
        auto dashidx=line.find('-');
        auto spaceidx=line.find(' ');
        string lb=line.substr(0,dashidx);
        string ub=line.substr(dashidx+1,spaceidx-dashidx);
        mems.emplace_back(stoull(lb,nullptr,16),stoull(ub,nullptr,16));
    }
    if(ptrace(PTRACE_GETREGS,child,0,&snapshot.regs)!=0){
        perror("PTRACE_GETREGS");
        exit(1);
    }
    for(auto[u,v]:mems)
        for(uint64_t i=u;i<v;i+=8){
            auto ret=ptrace(PTRACE_PEEKTEXT,child,i,0);
            snapshot.data.emplace_back(i,ret);
        }
    log("dropped an anchor");
}

void SDB::timetravel(){
    ptrace(PTRACE_SETREGS,child,0,&snapshot.regs);
    for(auto[u,v]:snapshot.data)
        ptrace(PTRACE_POKETEXT,child,u,v);
    for(auto[u,v]:bps){
        assert(v==poke(u,0xcc));
    }
    log("go back to the anchor point");
    disas();
}

void SDB::run(){
    this->child=fork();
    if(child<0){
        perror("SDB::run fork");
        exit(1);
    }else if(child==0){
        if(ptrace(PTRACE_TRACEME,0,0,0)<0){
            perror("SDB::run PTRACE_TRACEME");
            exit(1);
        }
        execvp(program[0],program+1);
        perror("SDB::run execvp");
    }else{
        if(waitpid(child,&status,0)<0){
            perror("SDB::run waitpid");
            exit(1);
        }
        assert(WIFSTOPPED(status));
        ptrace(PTRACE_SETOPTIONS,child,0,PTRACE_O_EXITKILL);
    }
    log("program '%s' loaded. entry point %p",program[0],sync_regs().rip);
    disas();
    this->shell();
}

void SDB::shell(){
    while(true){
        printf("(sdb) ");
        string input;
        getline(cin,input);
        auto cmd=split(input);
        if(cmd.empty())
            continue;
        if(cmd.front()=="disas")
            disas();
        else if(cmd.front()=="si")
            si();
        else if(cmd.front()=="cont")
            cont();
        else if(cmd.front()=="break"){
            if(cmd.size()==1){
                log("please enter an address.");
                continue;
            }
            brk(stoull(cmd[1],nullptr,16));
        }else if(cmd.front()=="anchor")
            anchor();
        else if(cmd.front()=="timetravel")
            timetravel();
        else{
            log("Unknown command");
            for(auto x:cmd)
                cout<<x<<' ';
            cout<<endl;
        }
    }
}

void SDB::log(string fmt,...){
    printf("** ");
    va_list args;
    va_start(args,fmt.c_str());
    vprintf(fmt.c_str(),args);
    va_end(args);
    printf("\n");

}
