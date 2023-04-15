#include <iostream>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

using namespace std;

int main(){
    open("open2.tmp",O_CREAT,0);
    open("open3.tmp",0);
    open("bl-open.tmp",0);
    perror("open balcklist");

    char buf[128];
    int fd;
    fd=open("read.tmp",O_RDONLY);
    memset(buf,0,128);
    read(fd,buf,4);
    cout<<buf<<endl;
    memset(buf,0,128);
    read(fd,buf,6);
    cout<<buf<<endl;
    close(fd);
}
