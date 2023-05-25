#include<sys/user.h>
#include<map>
#include<vector>
#include<utility>

using namespace std;
using ull=unsigned long long;
using pull=pair<ull,ull>;

class PCB{
private:
    int pid;
    user_regs_struct regs;
    void store(ull,ull);
    map<ull,ull> data;
public:
    PCB(int);
    vector<pull> mems;
    void snap();
    void restore();
};
