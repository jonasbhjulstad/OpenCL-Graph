#ifndef CLG_DEFAULT_INSTANCE_HPP
#define CLG_DEFAULT_INSTANCE_HPP
#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <fstream>
#include <CL/cl.h>
namespace CLG
{
std::string convertToString(const char *filename)
{	
	std::ifstream t(filename);
	std::stringstream buffer;
	buffer << t.rdbuf();
	return buffer.str();
}
struct CL_Instance
{
	CL_Instance()
	{
	cl_uint numPlatforms; //the NO. of platforms
	cl_int status = clGetPlatformIDs(0, NULL, &numPlatforms);
	if (status != CL_SUCCESS)
	{
		std::cout << "Error: Getting platforms!" << std::endl;
	}

	/*For clarity, choose the first available platform. */
	if (numPlatforms > 0)
	{
		cl_platform_id* platforms = 
                     (cl_platform_id*)malloc(numPlatforms * sizeof(cl_platform_id));
		status = clGetPlatformIDs(numPlatforms, platforms, NULL);
		platform = platforms[0];
		free(platforms);
	}

	status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 0, NULL, &numDevices);
	if (numDevices == 0) //no GPU available.
	{
		std::cout << "No GPU device available." << std::endl;
		std::cout << "Choose CPU as default device." << std::endl;
		status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_CPU, 0, NULL, &numDevices);
		device_ids.resize(numDevices);
		status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_CPU, numDevices, device_ids.data(), NULL);
	}
	else
	{
		device_ids.resize(numDevices);
		status = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, numDevices, device_ids.data(), NULL);
	}


	context = clCreateContext(NULL, 1, device_ids.data(), NULL, NULL, NULL);

	commandQueue = clCreateCommandQueueWithProperties(context, device_ids[0], NULL, NULL);
    
    clGetDeviceInfo(device_ids[0], CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, sizeof(size_t), &global_mem_cache_size, NULL);

    clGetDeviceInfo(device_ids[0], CL_DEVICE_GLOBAL_MEM_SIZE, sizeof(size_t), &global_mem_size, NULL);

    clGetDeviceInfo(device_ids[0], CL_DEVICE_MAX_WORK_GROUP_SIZE, sizeof(size_t), &max_work_group_size, NULL);
	
	}
    cl_uint numPlatforms;
    cl_platform_id platform;
    cl_uint numDevices = 0;
    std::vector<cl_device_id> device_ids;
    cl_context context;
    cl_command_queue commandQueue;
    cl_program program;
	size_t global_mem_size;
	size_t global_mem_cache_size;
	size_t max_work_group_size;
};


cl_program clLoadProgram(std::string filename, cl_context& context, int& err, std::string prependData = "")
{
	std::string sourceStr = convertToString(filename.c_str());
	const std::string fullSourcestr = prependData + sourceStr;
	const char* fullSource = fullSourcestr.c_str();
	const size_t strSize = fullSourcestr.size();
	return clCreateProgramWithSource(context, 1, &fullSource, &strSize, &err);
}
}

#endif