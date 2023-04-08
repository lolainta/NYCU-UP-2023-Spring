#include <iostream>
#include <fstream>
#include <sstream>
#include <string.h>
#include <vector>
#include <bits/stdc++.h>
#include <dlfcn.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

using namespace std;
using str=string;

typedef int(*main_t)(int,char**,char**);
typedef long long loli;
typedef unsigned long long ull;
typedef tuple<ull,ull> tull;

ull mp_on(string&cmd){
    str tar=cmd;
    ull ret=0;
    ifstream procFile("/proc/self/maps");
    string line;
    unsigned long long lb=0,ub=0;
    while(getline(procFile,line)){
        if(line.find(tar)!=string::npos){
//            cout<<line<<endl;
            sscanf(line.c_str(),"%llx-%llx ",&lb,&ub);
            if(!ret)
                ret=lb;
            cout<<hex<<lb<<' '<<ub<<endl;
            if(mprotect((void*)lb,ub-lb,PROT_READ|PROT_WRITE|PROT_EXEC)==-1){
                perror("mprotect");
                exit(1);
            }
            stringstream ss(line);
            while(ss>>cmd);
        }
    }
    return ret;
}

ull get_offset(const str&cmd,const str&target){
    return 0x8f70ull;
}

static int open_api(const char*path,int oflag){
    cout<<"My open"<<endl;
    return open(path,oflag);
}

extern "C"
int __libc_start_main(main_t main_func,int argc,char**ubp_av,void(*init_func)(),void(*fini_func)(),void(*rtld_fini_func)(),void*stack_end){
    cout<<"pid: "<<getpid()<<endl;
    str cmd=ubp_av[0];
    ull lb=mp_on(cmd);
    cout<<"lb: "<<lb<<endl;
    cout<<"cmd: "<<cmd<<endl;

    vector<pair<string,ull>> hooks;
    hooks.emplace_back("open",(ull)&open_api);

    for(auto hook:hooks){
        ull offset=get_offset(cmd,hook.first);
        unsigned long*addr=(unsigned long*)(lb+offset);
        *addr=hook.second;
    }

    typeof(&__libc_start_main) libc_start_main =(typeof(&__libc_start_main))dlsym(RTLD_NEXT,"__libc_start_main");
    return libc_start_main(main_func,argc,ubp_av,init_func,fini_func,rtld_fini_func,stack_end);
}

