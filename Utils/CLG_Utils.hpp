#ifndef CLG_UTIL_HPP
#define CLG_UTIL_HPP
#include <string>
#include <vector>
#include <fstream>
#include <iostream>
#include <sstream>
/* convert the kernel file into a string */
std::string convertToString(const char *filename)
{	
	std::ifstream t(filename);
	std::stringstream buffer;
	buffer << t.rdbuf();
	return buffer.str();
}


#endif