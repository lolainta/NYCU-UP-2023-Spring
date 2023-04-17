#include <iostream>
#include <fstream>
#include <cassert>
#include <filesystem>
#include <netdb.h>
#include <arpa/inet.h>
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
                size_t col=line.find(":");
                assert(col!=str::npos);
                str hostname=line.substr(0,col);
                uint16_t port=stoi(line.substr(col+1));
                struct hostent*host=gethostbyname(hostname.c_str());
                in_addr**addr_list=(in_addr**)host->h_addr_list;
                for(int i=0;addr_list[i];++i){
                    str ip(inet_ntoa(*addr_list[i]));
                    connect.emplace_back(ip,port);
                }
            }else if(section=="getaddrinfo"){
                getaddrinfo.emplace_back(line);
            }else{
                assert(false);
            }
        }
    }
}

void Config::show(){
    cout<<dec;
    cout<<"open blacklist:"<<endl;
    for(auto b:open)
        cout<<b<<endl;

    cout<<"read blacklist:"<<endl;
    for(auto b:read)
        cout<<b<<endl;

    cout<<"connect blacklist:"<<endl;
    for(auto [ip,port]:connect)
        cout<<ip<<' '<<port<<endl;

    cout<<"getaddrinfo blacklist:"<<endl;
    for(auto b:getaddrinfo)
        cout<<b<<endl;
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

bool Config::check_read(int fd,cstr&content){
    str tar=status[fd]+content;
    for(auto p:read)
        if(tar.find(p)!=str::npos)
            return false;
    status[fd]=tar;
    return true;
}

bool Config::check_connect(cstr&ip,uint16_t port){
    for(auto[u,v]:connect)
        if(u==ip && port==v)
            return false;
    return true;
}

bool Config::check_getaddrinfo(cstr&node){
    for(auto p:getaddrinfo)
        if(p==node)
            return false;
    return true;
}

void Config::clear_status(int fd){
    status.erase(fd);
}
