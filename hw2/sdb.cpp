#include<iostream>
#include<sstream>
#include<iomanip>
#include<cassert>
#include<unistd.h>
#include<capstone/capstone.h>
#include<sys/ptrace.h>
#include<sys/wait.h>
#include<sys/user.h>

using namespace std;

int child=-1;

user_regs_struct get_regs(){
    user_regs_struct regs;
    unsigned long long rip;
    if(ptrace(PTRACE_GETREGS,child,0,&regs)!=0){
        perror("PTRACE_GETREGS");
        exit(1);
    }
    return regs;
}

void get_imem(){
    unsigned char code[64];
    unsigned long long rip=get_regs().rip;
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
        perror("cs_open");
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

int handle_cmd(){
    int status;
cmd:
    cout<<"(sdb) ";
    string cmd;
    getline(cin,cmd);
    if(cmd=="cont"){
        ptrace(PTRACE_CONT,child,0,0);
        waitpid(child,&status,0);
        return status;
    }else if(cmd=="si"){
        ptrace(PTRACE_SINGLESTEP,child,0,0);
        waitpid(child,&status,0);
        if(WIFSTOPPED(status))
            get_imem();
        return status;
    }else if(cmd=="ls"){
        get_imem();
        goto cmd;
    }else{
        goto cmd;
    }
}

int main(int argc,char**argv){
    if(argc<2){
        cerr<<"Usage: "<<argv[0]<<" <program>"<<endl;
        exit(1);
    }
    child=fork();
    if(child<0){
        perror("fork");
        exit(1);
    }else if(child==0){
        if(ptrace(PTRACE_TRACEME,0,0,0)<0){
            perror("PTRACE_TRACEME");
            exit(1);
        }
        execvp(argv[1],argv+1);
        perror("execvp");
    }else{
        int status;
        if(waitpid(child,&status,0)<0){
            perror("waitpid");
            exit(1);
        }
        assert(WIFSTOPPED(status));
        ptrace(PTRACE_SETOPTIONS,child,0,PTRACE_O_EXITKILL);
        cout<<"** program '"<<argv[1]<<"' loaded. entry point 0x"<<hex<<get_regs().rip<<endl;
        get_imem();
        while(WIFSTOPPED(status)){
            status=handle_cmd();
        }
        perror("done");
    }

    return 0;
}
