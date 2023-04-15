#ifndef CONFIG_H
#define CONFIG_H
#include <vector>
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
public:
    Config();
    void parse(cstr&);
    void show();
    bool check_open(cstr&);
    bool check_read(cstr&);
    bool check_connect(cstr&,uint16_t);
    bool check_getaddrinfo(cstr&);
};
#endif
