#include <iostream>
#include <fstream>
#include <cassert>
#include <filesystem>
#include "config.h"

namespace fs=filesystem;

Config::Config(){}

void Config::parse(cstr&fname){
    ifstream fin(fname);
    str line;
    str section;
    while(getline(fin,line)){
        if(line.substr(0,6)=="BEGIN "){
            assert(section=="");
            size_t dash=line.find("-blacklist");
            assert(dash!=string::npos);
            section=line.substr(6,dash-6);
        }else if(line.substr(0,4)=="END "){
            assert(section!="");
            size_t dash=line.find("-blacklist");
            assert(dash!=string::npos);
            section="";
        }else if(line==""){
            continue;
        }else{
            assert(section!="");
            if(section=="open"){
                open.emplace_back(line);
            }else if(section=="read"){
                read.emplace_back(line);
            }else if(section=="connect"){
                cout<<"connect not parse yet"<<endl;
            }else if(section=="getaddrinfo"){
                getaddrinfo.emplace_back(line);
            }else{
                assert(false);
            }
        }
    }
}

void Config::show(){
    cout<<"open blacklist:"<<endl;
    for(auto b:open){
        cout<<b<<endl;
    }
    cout<<"read blacklist:"<<endl;
    for(auto b:read){
        cout<<b<<endl;
    }
    cout<<"connect blacklist:"<<endl;
    for(auto b:connect){
        cout<<b<<endl;
    }
    cout<<"getaddrinfo blacklist:"<<endl;
    for(auto b:getaddrinfo){
        cout<<b<<endl;
    }
}

bool Config::check_open(cstr&path){
    for(auto p:open){
        try{
            if(fs::equivalent(path,p))
                return false;
        }catch(fs::filesystem_error e){
//            cout<<e.what()<<endl;
        }
    }
    return true;
}
