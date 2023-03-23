#include<stdio.h>

int main(){
    FILE* f=fopen("gotentry.txt","r");
    int num,got,off;
    while(fscanf(f,"code_%d %x %x\n",&num,&got,&off)!=EOF){
        printf("{%d,%d,%d},",num,got,off);
    }
}
