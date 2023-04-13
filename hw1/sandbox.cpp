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
//    print_elf_header64(eh64);
    Elf64_Shdr*sh_tbl=(Elf64_Shdr*)malloc(eh64.e_shentsize*eh64.e_shnum);
    read_section_header_table64(fd,eh64,sh_tbl);
//    print_section_headers64(fd,eh64,sh_tbl);
//    print_symbols64(fd, eh64, sh_tbl);

    Elf64_Sym*sym_tbl=nullptr;
    char*str_tbl=nullptr;
    for(int i=0;i<eh64.e_shnum;++i){
        if(sh_tbl[i].sh_type==SHT_SYMTAB || sh_tbl[i].sh_type==SHT_DYNSYM){
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

int lfd;

int open_api(const char*path,int oflag,...){
    if(oflag&O_CREAT){
        cout<<"got O_CREAT in open"<<endl;
    }else{
        cout<<"No O_CREAT"<<endl;
    }
    auto ret=open(path,oflag);
    dprintf(lfd,"[logger] open(\"%s\", %d) = %d\n",path,oflag,ret);
    return ret;
}

ssize_t read_api(int fildes,void*buf,size_t nbyte){
    str fname(to_string(getpid())+'-'+to_string(lfd)+"-read.log");
    auto ret=read(fildes,buf,nbyte);
    FILE*log=fopen(fname.c_str(),"wb");
    fwrite(buf,sizeof(char),ret,log);
    dprintf(lfd,"[logger] read(%d, %p, %ld) = %ld\n",fildes,buf,nbyte,ret);
    return ret;
}

int write_api(int fildes,void*buf,size_t nbyte){
    auto ret=write(fildes,buf,nbyte);
    dprintf(lfd,"[logger] write(%d, %p, %ld) = %ld\n",fildes,buf,nbyte,ret);
    return ret;
}

int connect_api(int socket,const struct sockaddr*address,socklen_t address_len){
    auto ret=connect(socket,address,address_len);
    dprintf(lfd,"[logger] connect(%d, \"%s\", %d) = %d\n",socket,"IP",address_len,ret);
    return ret;
}

int getaddrinfo_api(const char*node,const char*service,const struct addrinfo*hints,struct addrinfo**res){
    auto ret=getaddrinfo(node,service,hints,res);
    dprintf(lfd,"[logger] getaddrinfo(\"%s\", \"%s\", %p, %p) = %d\n",node,service,hints,res,ret);
    return ret;
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

    cout<<"config path: "<<getenv("SANDBOX_CONFIG")<<endl;
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

