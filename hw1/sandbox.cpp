#include <iostream>
#include <dlfcn.h>

using namespace std;

typedef int(*main_t)(int,char**,char**);

extern "C"
int __libc_start_main(main_t main_func,int argc,char**ubp_av,void(*init_func)(),void(*fini_func)(),void(*rtld_fini_func)(),void*stack_end){
    cout<<"Hello, World!"<<endl;
    typeof(&__libc_start_main) libc_start_main =(typeof(&__libc_start_main))dlsym(RTLD_NEXT,"__libc_start_main");
    int result=libc_start_main(main_func,argc,ubp_av,init_func,fini_func,rtld_fini_func,stack_end);
    cout<<"Good bye, World!"<<endl;
    return result;
}

