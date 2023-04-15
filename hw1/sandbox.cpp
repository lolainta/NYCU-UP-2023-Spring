#include <iostream>
#include <fstream>
#include <sstream>
#include <cassert>
#include <cerrno>
#include <vector>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <dlfcn.h>

#include "elf-parser.h"
#include "config.h"

using namespace std;
using str=string;

typedef int(*main_t)(int,char**,char**);
typedef long long loli;
typedef unsigned long long ull;
typedef tuple<ull,ull> tull;

Config config;

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
//    ifstream fin(cmd,ios::binary|ios::in);
//    fin.read((char*)&elf_hdr,sizeof(elf_hdr));
    int fd=open(cmd.c_str(),O_RDONLY|O_SYNC);
    Elf32_Ehdr eh;
    read_elf_header(fd,&eh);
//    assert(is_ELF(eh));
    assert(is64Bit(eh));

    Elf64_Ehdr eh64;
    read_elf_header64(fd,&eh64);
//    print_elf_header64(eh64);
    Elf64_Shdr*sh_tbl=(Elf64_Shdr*)malloc(eh64.e_shentsize*eh64.e_shnum);
    read_section_header_table64(fd,eh64,sh_tbl);
//    print_section_headers64(fd,eh64,sh_tbl);
//    print_symbols64(fd, eh64, sh_tbl);

    Elf64_Sym*sym_tbl=nullptr;
    char*str_tbl=nullptr;
    for(int i=0;i<eh64.e_shnum;++i){
        if(sh_tbl[i].sh_type==SHT_DYNSYM){
            sym_tbl=(Elf64_Sym*)read_section64(fd,sh_tbl[i]);
            str_tbl=read_section64(fd,sh_tbl[sh_tbl[i].sh_link]);
        }
    }
    assert(sym_tbl && str_tbl);

    for(size_t i=0;i<eh64.e_shnum;++i){
        if(sh_tbl[i].sh_type==SHT_RELA){
//            cout<<"link: "<<sh_tbl[i].sh_link<<endl;
//            cout<<"Got relocation section at i="<<i<<endl;
            Elf64_Rela*rela_tbl=(Elf64_Rela*)read_section64(fd,sh_tbl[i]);
            for(size_t j=0;j<sh_tbl[i].sh_size/sh_tbl[i].sh_entsize;j++){
//                cout<<i<<' '<<j<<endl;
                size_t sym_idx=ELF64_R_SYM(rela_tbl[j].r_info);
//                printf("sym_idx: %02ld ",sym_idx);
//                printf("sym_name: %s \n",(str_tbl+sym_tbl[sym_idx].st_name));
                if(str(str_tbl+sym_tbl[sym_idx].st_name)==target){
                    return rela_tbl[j].r_offset;
                }
			}
        }else if(sh_tbl[i].sh_type==SHT_REL){
            cout<<"Got SHT_REL"<<endl;
        }
    }
    return 0xdeadbeaf;
}

int lfd;

int open_api(const char*path,int oflag,mode_t mode){
    if(config.check_open(str(path))){
        auto ret=open(path,oflag);
        if(oflag&O_CREAT){
            dprintf(lfd,"[logger] open(\"%s\", %d, %d) = %d\n",path,oflag,mode,ret);
        }else{
            dprintf(lfd,"[logger] open(\"%s\", %d) = %d\n",path,oflag,ret);
        }
        return ret;
    }else{
        if(oflag&O_CREAT){
            dprintf(lfd,"[logger] open(\"%s\", %d, %d) = -1\n",path,oflag,mode);
        }else{
            dprintf(lfd,"[logger] open(\"%s\", %d) = -1\n",path,oflag);
        }
        errno=EACCES;
        return -1;
    }
}

ssize_t read_api(int fildes,void*buf,size_t nbyte){
    str fname(to_string(getpid())+'-'+to_string(lfd)+"-read.log");
    auto ret=read(fildes,buf,nbyte);
    if(config.check_read(str((char*)buf))){
        FILE*log=fopen(fname.c_str(),"a");
        fwrite(buf,sizeof(char),ret,log);
        dprintf(lfd,"[logger] read(%d, %p, %ld) = %ld\n",fildes,buf,nbyte,ret);
        fclose(log);
        return ret;
    }else{
        dprintf(lfd,"[logger] read(%d, %p, %ld) = -1\n",fildes,buf,nbyte);
        errno=EIO;
        return -1;
    }
}

int close_api(int fildes){
    cout<<dec<<fildes<<" closed"<<endl;
    return close(fildes);
}

int write_api(int fildes,void*buf,size_t nbyte){
    str fname(to_string(getpid())+'-'+to_string(lfd)+"-write.log");
    auto ret=write(fildes,buf,nbyte);
    FILE*log=fopen(fname.c_str(),"a");
    fwrite(buf,sizeof(char),ret,log);
    fclose(log);
    dprintf(lfd,"[logger] write(%d, %p, %ld) = %ld\n",fildes,buf,nbyte,ret);
    return ret;
}

int connect_api(int socket,const struct sockaddr*address,socklen_t address_len){
    uint16_t port=ntohs(((sockaddr_in*)address)->sin_port);
    str ip(inet_ntoa(((sockaddr_in*)address)->sin_addr));
    if(config.check_connect(ip,port)){
        auto ret=connect(socket,address,address_len);
        dprintf(lfd,"[logger] connect(%d, \"%s\", %d) = %d\n",socket,ip.c_str(),address_len,ret);
        return ret;
    }else{
        dprintf(lfd,"[logger] connect(%d, \"%s\", %d) = -1\n",socket,ip.c_str(),address_len);
        errno=ECONNREFUSED;
        return -1;
    }
}

int getaddrinfo_api(const char*node,const char*service,const struct addrinfo*hints,struct addrinfo**res){
    if(config.check_getaddrinfo(str(node))){
        auto ret=getaddrinfo(node,service,hints,res);
        dprintf(lfd,"[logger] getaddrinfo(\"%s\", \"%s\", %p, %p) = %d\n",node,service,hints,res,ret);
        return ret;
    }else{
        dprintf(lfd,"[logger] getaddrinfo(\"%s\", \"%s\", %p, %p) = %d\n",node,service,hints,res,EAI_NONAME);
        return EAI_NONAME;
    }
}

int system_api(const char*command){
    auto ret=system(command);
    dprintf(lfd,"[logger] system(\"%s\") = %d\n",command,ret);
    return system(command);
}

extern "C"
int __libc_start_main(main_t main_func,int argc,char**ubp_av,void(*init_func)(),void(*fini_func)(),void(*rtld_fini_func)(),void*stack_end){
    cout<<"pid: "<<getpid()<<endl;
    str cmd=ubp_av[0];
    ull lb=mp_on(cmd);
    cout<<"lb: "<<hex<<lb<<endl;
    cout<<"cmd: "<<cmd<<endl;

    vector<pair<string,ull>> hooks;
    hooks.emplace_back("open",(ull)&open_api);
    hooks.emplace_back("read",(ull)&read_api);
    hooks.emplace_back("write",(ull)&write_api);
    hooks.emplace_back("connect",(ull)&connect_api);
    hooks.emplace_back("getaddrinfo",(ull)&getaddrinfo_api);
    hooks.emplace_back("system",(ull)&system_api);
    hooks.emplace_back("close",(ull)&close_api);

    config.parse(getenv("SANDBOX_CONFIG"));
//    config.show();
    cout<<"Logger fd: "<<getenv("LOGGER_FD")<<endl;
    lfd=stoi(getenv("LOGGER_FD"));

    for(auto hook:hooks){
        ull offset=get_offset(cmd,hook.first);
        if(offset==0xdeadbeaf){
            cout<<"WARNING: off_set not found for "<<hook.first<<endl;
            continue;
            exit(1);
        }
        cout<<hook.first<<" offset="<<offset<<endl;
        unsigned long*addr=(unsigned long*)(lb+offset);
        *addr=hook.second;
    }

    typeof(&__libc_start_main) libc_start_main =(typeof(&__libc_start_main))dlsym(RTLD_NEXT,"__libc_start_main");
    return libc_start_main(main_func,argc,ubp_av,init_func,fini_func,rtld_fini_func,stack_end);
}

