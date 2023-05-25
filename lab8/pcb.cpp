#include "pcb.h"
#include<iostream>
#include<fstream>
#include<sys/ptrace.h>

PCB::PCB(int pid):pid(pid){
    string mfile="/proc/"+to_string(pid)+"/maps";
    cout<<mfile<<endl;
    ifstream is(mfile);
    string line;
    while(getline(is,line)){
        auto dashidx=line.find('-');
        auto spaceidx=line.find(' ');
        string lb=line.substr(0,dashidx);
        string ub=line.substr(dashidx+1,spaceidx-dashidx);
        mems.emplace_back(stoull(lb,nullptr,16),stoull(ub,nullptr,16));
    }
    return;
}

void PCB::snap(){
    if(ptrace(PTRACE_GETREGS,this->pid,0,&this->regs)!=0){
        perror("PTRACE_GETREGS");
        exit(1);
    }
    for(auto[u,v]:mems)
        store(u,v);
    cout<<"stored "<<this->data.size()<<endl;
}

void PCB::store(ull lb,ull ub){
    for(ull i=lb;i<ub;i+=8){
        auto ret=ptrace(PTRACE_PEEKTEXT,this->pid,i,0);
        this->data[i]=ret;
    }
    return;
}

void PCB::restore(){
    ptrace(PTRACE_SETREGS,this->pid,0,&this->regs);
    for(auto[u,v]:data)
        ptrace(PTRACE_POKETEXT,this->pid,u,v);
}



