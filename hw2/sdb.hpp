#include<iostream>
#include<fstream>
#include<iomanip>
#include<vector>
#include<cassert>
#include<string>
#include<cstdint>
#include<unistd.h>
#include<capstone/capstone.h>
#include<sys/user.h>
#include<sys/ptrace.h>
#include<sys/wait.h>

using namespace std;

struct BreakPoint{
    uint64_t addr;
    uint8_t org;
    BreakPoint(uint64_t addr,uint8_t org):addr(addr),org(org){}
};

struct Anchor{
    user_regs_struct regs;
    vector<pair<uint64_t,uint64_t>> data;
};

class SDB{
private:
    int child;
    char**program;
    int status;
    user_regs_struct regs;
    user_regs_struct sync_regs();
    uint8_t poke(uint64_t,uint8_t);
    BreakPoint findbp(uint64_t);
    vector<BreakPoint> bps;
    Anchor snapshot;
    void shell();

    void disas();
    void si();
    void cont();
    void brk(uint64_t);
    void anchor();
    void timetravel();

    void log(string,...);
public:
    SDB(char**);
    void run();
};
