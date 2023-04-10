#include <iostream>
#include <fstream>
#include <sstream>
#include <cassert>
#include <vector>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <dlfcn.h>
#include "elf-parser.h"

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
 //   print_elf_header64(eh64);
    Elf64_Shdr*sh_tbl=(Elf64_Shdr*)malloc(eh64.e_shentsize*eh64.e_shnum);
    read_section_header_table64(fd,eh64,sh_tbl);
//    print_section_headers64(fd,eh64,sh_tbl);
//    print_symbols64(fd, eh64, sh_tbl);

    Elf64_Sym*sym_tbl;
    char*str_tbl;
    for(int i=0;i<eh64.e_shnum;++i){
        if(sh_tbl[i].sh_type==SHT_SYMTAB || sh_tbl[i].sh_type==SHT_DYNSYM){
            sym_tbl=(Elf64_Sym*)read_section64(fd,sh_tbl[i]);
            str_tbl=read_section64(fd,sh_tbl[sh_tbl[i].sh_link]);
        }
    }

    for(size_t i=0;i<eh64.e_shnum;++i){
        if(sh_tbl[i].sh_type==SHT_RELA){
//            cout<<"link: "<<sh_tbl[i].sh_link<<endl;
//            cout<<"Got relocation section at i="<<i<<endl;
            Elf64_Rela*rela_tbl=(Elf64_Rela*)read_section64(fd,sh_tbl[i]);
            for(size_t j=0;j<sh_tbl[i].sh_size/sh_tbl[i].sh_entsize;j++){
//                cout<<i<<' '<<j<<endl;
                size_t sym_idx=ELF64_R_SYM(rela_tbl[j].r_info);
//                printf("sym_idx: %02d ",sym_idx);
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

#define log cout<<"[logger] "

int open_api(const char*path,int oflag){
    log<<"open"<<endl;
    return open(path,oflag);
}

ssize_t read_api(int fildes,void*buf,size_t nbyte){
    log<<"read"<<endl;
    return read(fildes,buf,nbyte);
}

int write_api(int fildes,void*buf,size_t nbyte){
    log<<"write"<<endl;
    return write(fildes,buf,nbyte);
}

int connect_api(int socket,const struct sockaddr*address,socklen_t address_len){
    log<<"connect"<<endl;
    return connect(socket,address,address_len);
}

int getaddrinfo_api(const char*node,const char*service,const struct addrinfo*hints,struct addrinfo**res){
    log<<"getaddrinfo"<<endl;
    return getaddrinfo(node,service,hints,res);
}

int system_api(const char*command){
    log<<"system"<<endl;
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

    cout<<"config path: "<<getenv("SANDBOX_CONFIG")<<endl;
    cout<<"Logger fd: "<<getenv("LOGGER_FD")<<endl;

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

