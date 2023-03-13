#include<iostream>
#include<fstream>
#include<string>
#include<filesystem>

using namespace std;

using str=string;
namespace fs=std::filesystem;

str ans;
bool dfs(str dir,const str magic){
    for(const auto&entry:fs::directory_iterator(dir)){
        if(fs::is_symlink(entry.path())){
            str linkto=read_symlink(entry.path());
            if(linkto!="." && linkto!=".."){
                cerr<<"symlink: "<<entry.path()<<" -> ";
                cerr<<linkto<<endl;
            }
        }else if(fs::is_directory(entry.path())){
//            cerr<<"dir: "<<entry.path()<<endl;
            dfs(entry.path(),magic);
        }else if(fs::is_regular_file(entry.path())){
//            cerr<<"regular: "<<entry.path()<<endl;
//            cerr<<"magic: "<<magic<<endl;
            ifstream ifs;
            ifs.open(entry.path());
            str content;
            while(ifs>>content){
//                cerr<<content<<endl;
                if(content==magic){
                    ans=entry.path();
                    return true;
                }
            }
            ifs.close();
        }else{
            cerr<<"Others"<<endl;
            exit(2);
        }
    }
    return false;
}

int main(int argc,char**argv){
    string path(argv[1]);
    string magic(argv[2]);
    if(!dfs(path,magic))
        cout<<ans<<endl;
}
