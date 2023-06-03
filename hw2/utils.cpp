#pragma once
#include "utils.hpp"

std::vector<std::string> Utils::split(std::string s){
    std::stringstream ss(s);
    std::vector<std::string> ret;
    while(ss>>s)
        ret.emplace_back(s);
    return ret;
}
