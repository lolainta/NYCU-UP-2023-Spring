#include<iostream>
#include<sys/ptrace.h>
#include<sys/wait.h>
#include<sys/user.h>

int child_pid=-1;
user_regs_struct regs,anchor;

int main(int argc,char**argv){
    child_pid=fork();
    if(child_pid<0){
        perror("fork");
        exit(1);
    }else if(child_pid==0){
        if(ptrace(PTRACE_TRACEME,0,0,0)<0){
            perror("PTRACE_TRACEME");
            exit(1);
        }
        execvp(argv[1],argv+1);
        perror("execvp");
    }else{
        waitpid(child_pid,nullptr,0);
        ptrace(PTRACE_SETOPTIONS,child_pid,0,PTRACE_O_EXITKILL);
        ptrace(PTRACE_CONT,child_pid,0,0);
        waitpid(child_pid,nullptr,0);
        ptrace(PTRACE_CONT,child_pid,0,0);
        waitpid(child_pid,nullptr,0);
        ptrace(PTRACE_GETREGS,child_pid,0,&regs);
        unsigned long long maddr=regs.rax;
        ptrace(PTRACE_CONT,child_pid,0,0);
        waitpid(child_pid,nullptr,0);
        ptrace(PTRACE_GETREGS,child_pid,0,&anchor);
        for(int i=0;i<(1<<9);++i){
            ptrace(PTRACE_SETREGS,child_pid,0,&anchor);
            ptrace(PTRACE_CONT,child_pid,0,0);
            waitpid(child_pid,nullptr,0);
            unsigned long long magic=0;
            for(int j=0;j<8;++j)
                if(i&(1<<j))
                    magic|=0x31ull<<j*8;
                else
                    magic|=0x30ull<<j*8;
            ptrace(PTRACE_POKETEXT,child_pid,maddr,magic);
            ptrace(PTRACE_POKETEXT,child_pid,maddr+1,((magic>>8)|(i&(1<<8)?0x31ull:0x30ull)<<56));
            ptrace(PTRACE_CONT,child_pid,0,0);
            waitpid(child_pid,nullptr,0);
            ptrace(PTRACE_GETREGS,child_pid,0,&regs);
            if(regs.rax==0)
                break;
        }
    }
    return 0;
}
