#ifndef CLG_KERNEL_GENERATORS_HPP
#define CLG_KERNEL_GENERATORS_HPP
#include <string>
#include <vector>

std::string CLG_generate_function_dispatcher(std::vector<std::string>& functions, const std::string& args)
{
	std::string res;
	res += "if (dispatch_id == 0)\n{\n";
	res += functions[0] + "(" + args + ");\n}\n";


	for (size_t i = 0; i < functions.size(); i++)
	{
		res += std::string("else if (dispatch_id == ") + std::to_string(i) + ")\n{\n";
		res += functions.at(i) + "(" + args + ");\n}\n";
	}
	return res;
}

std::string CLG_generate_vertex_integrator(std::vector<std::string>& functions)
{
	const std::string args = "x_current, x_next, Nx, param";
	std::string res;
	res += "void vertex_integrate(" + args + ")\n{\n";
	res += CLG_generate_function_dispatcher(functions, args);
	res += "}\n";
	return res;
}

#endif