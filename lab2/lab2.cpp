#include<iostream>
#include<fstream>
#include<string>
#include<filesystem>

using namespace std;
namespace fs=std::filesystem;

int main(int argc,char**argv){
    string path(argv[1]),magic(argv[2]),content;
    for(const auto&entry:fs::recursive_directory_iterator(path)){
        ifstream ifs(entry.path());
        ifs>>content;
        if(content==magic)
            return cout<<str(entry.path())<<endl,0;
    }
    return 0;
}
