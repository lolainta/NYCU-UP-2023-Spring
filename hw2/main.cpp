#include<iostream>
#include"sdb.hpp"

using namespace std;

int main(int argc,char*argv[]){
    if(argc<2){
        cout<<"Usage: "<<argv[0]<<" <program>"<<endl;
        exit(1);
    }
    SDB sdb(argv+1);
    sdb.run();
}
