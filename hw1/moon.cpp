#include <iostream>
#include <fcntl.h>

using namespace std;

int main(){
    open("open2.tmp",O_CREAT,0);
    open("open3.tmp",0);
    open("bl-open.tmp",0);
    perror("open balcklist");
}
