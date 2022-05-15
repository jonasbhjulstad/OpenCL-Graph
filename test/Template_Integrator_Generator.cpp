#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <CL/cl.h>
#include <cassert>
#include <CLG_Kernel_Generators.hpp>
#include <CLG_DefaultInstance.hpp>

int main()
{

    std::string fname = "fun";
    // std::string res = Generator::CLG_generate_template_integrator(fname);
    float dt = .1;
    constexpr size_t N_stages = 2;
    float A[N_stages*N_stages] = {0,0,1,0};
    float b[2] = {.5, .5};
    float c[2] = {.0, .1};

    std::string res = Generator::CLG_Generate_ERK(dt, 2, A, b, c);
    std::cout << res << std::endl;
    return 0;
}