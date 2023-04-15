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
    vector<str> connect;
    vector<str> getaddrinfo;
public:
    Config();
    void parse(cstr&);
    void show();
    bool check_open(cstr&);
};
#endif
