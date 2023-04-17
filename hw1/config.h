#ifndef CONFIG_H
#define CONFIG_H
#include <vector>
#include <map>
#include <string>


using namespace std;

using str=string;
using cstr=const str;

class Config{
private:
    vector<str> open;
    vector<str> read;
    vector<pair<cstr,uint16_t>> connect;
    vector<str> getaddrinfo;
    map<int,str> status;
public:
    Config();
    void parse(cstr&);
    void show();
    bool check_open(cstr&);
    bool check_read(int,cstr&);
    bool check_connect(cstr&,uint16_t);
    bool check_getaddrinfo(cstr&);
    void clear_status(int);
};
#endif
