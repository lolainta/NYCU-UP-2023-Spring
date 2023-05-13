#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <stdio.h>

int main(){
    printf("flag=%d\n",SHM_RDONLY);
    int shm_id=shmget(0x1337,100,SHM_RDONLY);
    if(shm_id<0){
        printf("shmget error\n");
        exit(1);
    }
    printf("shm_id=%d\n",shm_id);
    char*data=shmat(shm_id,NULL,0);
    for(int i=0;i<100;++i)
        data[i]='A';
    for(int i=0;i<100;++i)
        printf("%x ",data[i]);
}

