#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>

#define errquit(m) { perror(m); exit(-1); }

#define LEN_CODE	(10*0x10000)

int main(int argc,char*argv[]) {
	char *code;
	uint32_t *codeint;
	long i, t;
	code=mmap(NULL,LEN_CODE,PROT_READ|PROT_WRITE|PROT_EXEC,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
	if(code==MAP_FAILED)
        errquit("mmap");
	codeint=(uint32_t*)code;
    t=atoi(argv[1]);
    srand(t);
    for(i=0;i<LEN_CODE/4;i++)
		codeint[i]=(rand()<<16)|(rand()&0xffff);
	codeint[rand()%(LEN_CODE/4-1)]=0xc3050f;
    for(int i=0;i<LEN_CODE;++i)
        printf("%02hhx",code[i]);
    printf("\n");
	return 0;
}
