#include<iostream>
#include<iomanip>
#include<cassert>
#include<string>
#include<cstdint>
#include<unistd.h>
#include<sys/user.h>
#include<sys/ptrace.h>
#include<sys/wait.h>
#include<capstone/capstone.h>

using namespace std;

class SDB{
private:
    int child;
    char**program;
    int status;
    user_regs_struct regs;
    user_regs_struct sync_regs();
    void shell();
    void disas();
    void si();
    void cont();
    void brk(uint64_t);
    void anchor();
    void timetravel();
public:
    SDB(char**);
    void run();
};
