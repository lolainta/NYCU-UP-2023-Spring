#include "utils.hpp"

vector<string> split(string s){
    stringstream ss(s);
    vector<string> ret;
    while(ss>>s)
        ret.emplace_back(s);
    return ret;
}
