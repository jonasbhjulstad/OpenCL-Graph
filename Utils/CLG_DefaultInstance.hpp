#ifndef CLG_DEFAULT_INSTANCE_HPP
#define CLG_DEFAULT_INSTANCE_HPP
#include <iostream>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <vector>
#include <fstream>
#include <cassert>
#include <stdlib.h>
#include <CL/cl.h>
#include <CLG_Util.hpp>

struct CLG_Instance
{
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

CLG_Instance clDefaultInitialize(cl_uint device_type = CL_DEVICE_TYPE_GPU, bool verbose = false)
{
    CLG_Instance clInstance;
    	/*Step1: Getting platforms and choose an available one.*/
	cl_uint numPlatforms; //the NO. of platforms
	cl_int status = clGetPlatformIDs(0, NULL, &numPlatforms);
	if (status != CL_SUCCESS)
	{
		std::cout << "Error: Getting platforms!" << std::endl;
		return clInstance;
	}

	/*For clarity, choose the first available platform. */
	if (numPlatforms > 0)
	{
		cl_platform_id* platforms = 
                     (cl_platform_id*)malloc(numPlatforms * sizeof(cl_platform_id));
		status = clGetPlatformIDs(numPlatforms, platforms, NULL);
		clInstance.platform = platforms[0];
		free(platforms);
	}

	status = clGetDeviceIDs(clInstance.platform, device_type, 0, NULL, &clInstance.numDevices);
	if (clInstance.numDevices == 0) //no GPU available.
	{
		std::cout << "No GPU device available." << std::endl;
		std::cout << "Choose CPU as default device." << std::endl;
		status = clGetDeviceIDs(clInstance.platform, device_type, 0, NULL, &clInstance.numDevices);
		clInstance.device_ids.resize(clInstance.numDevices);
		status = clGetDeviceIDs(clInstance.platform, device_type, clInstance.numDevices, clInstance.device_ids.data(), NULL);
	}
	else
	{
		clInstance.device_ids.resize(clInstance.numDevices);
		status = clGetDeviceIDs(clInstance.platform, device_type, clInstance.numDevices, clInstance.device_ids.data(), NULL);
	}


	clInstance.context = clCreateContext(NULL, 1, clInstance.device_ids.data(), NULL, NULL, NULL);

	clInstance.commandQueue = clCreateCommandQueueWithProperties(clInstance.context, clInstance.device_ids[0], NULL, NULL);
    
    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, sizeof(size_t), &clInstance.global_mem_cache_size, NULL);

    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_GLOBAL_MEM_SIZE, sizeof(size_t), &clInstance.global_mem_size, NULL);

    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_MAX_WORK_GROUP_SIZE, sizeof(size_t), &clInstance.max_work_group_size, NULL);

	if (verbose)
	{
    std::cout << "Device global memory size:\t" << clInstance.global_mem_size << std::endl;
    std::cout << "Device cache size:\t" << clInstance.global_mem_cache_size << std::endl;
    std::cout << "Device max work group size:\t" << clInstance.max_work_group_size << std::endl;
	}
	
	return clInstance;

}
cl_program clLoadProgram(std::string filename, cl_context& context, int& err, std::string prependData = "")
{
	std::string sourceStr = convertToString(filename.c_str());
	const std::string fullSourcestr = prependData + sourceStr;
	const char* fullSource = fullSourcestr.c_str();
	const size_t strSize = fullSourcestr.size();
	return clCreateProgramWithSource(context, 1, &fullSource, &strSize, &err);
}

#endif