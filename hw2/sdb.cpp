#include "sdb.hpp"
#include "utils.hpp"

SDB::SDB(char**program):program(program){

}

user_regs_struct SDB::sync_regs(){
    if(ptrace(PTRACE_GETREGS,child,0,&regs)!=0){
        perror("SDB::sync_regs");
        exit(1);
    }
    return regs;
}

void SDB::disas(){
    unsigned char code[64];
    unsigned long long rip=sync_regs().rip;
    long ret;
    unsigned char*ptr=(unsigned char*)&ret;
    for(int i=0;i<8;++i){
        ret=ptrace(PTRACE_PEEKTEXT,child,rip+8*i,0);
        for(int j=0;j<8;++j)
            code[i*8+j]=ptr[j];
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
                cout<<"** the address is out of the range of the text segment."<<endl;
                break;
            }
            cout<<hex<<setfill(' ')<<setw(12)<<insn[i].address<<": ";
            stringstream ss;
            for(int j=0;j<insn[i].size;++j)
                ss<<hex<<setfill('0')<<setw(2)<<(int)insn[i].bytes[j]<<' ';
            cout<<setw(20)<<left<<ss.str();
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
    ptrace(PTRACE_SINGLESTEP,child,0,0);
    waitpid(child,&status,0);
}

void SDB::cont(){

}

void SDB::brk(uint64_t addr){

}

void SDB::anchor(){
    
}

void SDB::timetravel(){

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
    printf("** program '%s' loaded. entry point %p\n",program[0],sync_regs().rip);
    disas();
    this->shell();
}

void SDB::shell(){
    while(true){
        cout<<"(sdb) ";
        string input;
        getline(cin,input);
        auto cmd=split(input);
        if(cmd.empty())
            continue;
        if(cmd.front()=="disas")
            disas();
        else if(cmd.front()=="si"){
            si();
            if(WIFSTOPPED(status))
                disas();
        }
        else if(cmd.front()=="cont")
            cont();
        else if(cmd.front()=="brk")
            brk(stoull(cmd[1]));
        else if(cmd.front()=="anchor")
            anchor();
        else if(cmd.front()=="timetravel")
            timetravel();
        else{
            for(auto x:cmd)
                cout<<x<<' ';
            cout<<endl;
        }
    }
}
