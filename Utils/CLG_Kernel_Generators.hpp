#ifndef CLG_KERNEL_GENERATORS_HPP
#define CLG_KERNEL_GENERATORS_HPP
#include <string>
#include <vector>
namespace Generator
{
const std::vector<std::string> ODE_INTEGRATOR_INPUT_TYPES = {"float*", "float*", "uint", "constant float*"};
const char* ODE_INTEGRATOR_INPUT_DEF = "float* x_current, float* x_dot, uint Nx, constant float* param";
const char* ODE_INTEGRATOR_INPUT = "x_current, x_dot, Nx, param";




std::string CLG_generate_ODE_dynamics(std::string& fname, std::string& fn_body)
{
    std::string res;
    std::string fname_upper = fname;
    for (auto &c: fname_upper) c = std::toupper(c);
    res +=  "#ifndef " + fname_upper + "_CL\n";
    res +=  "#define " + fname_upper + "_CL\n";
    res +=  "void " + fname + "(" + ODE_INTEGRATOR_INPUT + ")\n{\n";
    res += fn_body;
    res +=  "}\n";
    res +=  "#endif\n";
    return res;
}
}
#endif