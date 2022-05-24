#define CL_TARGET_OPENCL_VERSION 300

#include <CL/cl.h>
#include <iostream>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <fstream>
#include <cassert>
#include <array>
#include <random>
#include <sstream>
#include <cmath>
#define SUCCESS 0
#define FAILURE 1

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

/* convert the kernel file into a string */
std::string convertToString(const char *filename)
{	
	std::ifstream t(filename);
	std::stringstream buffer;
	buffer << t.rdbuf();
	return buffer.str();
}

const char pwd[] = "/home/deb/Documents/OpenCL-Graph/test/";

int main(int argc, char *argv[])
{

    CLG_Instance clInstance;
	cl_uint numPlatforms; //the NO. of platforms
	cl_int status = clGetPlatformIDs(0, NULL, &numPlatforms);

	if (numPlatforms > 0)
	{
		cl_platform_id* platforms = 
                     (cl_platform_id*)malloc(numPlatforms * sizeof(cl_platform_id));
		status = clGetPlatformIDs(numPlatforms, platforms, NULL);
		clInstance.platform = platforms[0];
		free(platforms);
	}

    cl_uint deviceType = CL_DEVICE_TYPE_GPU;

	status = clGetDeviceIDs(clInstance.platform, deviceType, 0, NULL, &clInstance.numDevices);

    clInstance.device_ids.resize(clInstance.numDevices);

    status = clGetDeviceIDs(clInstance.platform, deviceType, clInstance.numDevices, clInstance.device_ids.data(), NULL);

	clInstance.context = clCreateContext(NULL, 1, clInstance.device_ids.data(), NULL, NULL, NULL);

	clInstance.commandQueue = clCreateCommandQueueWithProperties(clInstance.context, clInstance.device_ids[0], NULL, NULL);
    
    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, sizeof(size_t), &clInstance.global_mem_cache_size, NULL);

    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_GLOBAL_MEM_SIZE, sizeof(size_t), &clInstance.global_mem_size, NULL);

    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_MAX_WORK_GROUP_SIZE, sizeof(size_t), &clInstance.max_work_group_size, NULL);

	

    int err = 0;
    std::string programBinary = convertToString((std::string(pwd) + "kernel.spv").c_str());
    long unsigned int programSize = sizeof(char)*programBinary.length();
    clInstance.program = clCreateProgramWithIL(clInstance.context, (const void*) programBinary.data(), sizeof(char)*programBinary.length(), &err);
    assert(err == CL_SUCCESS);
    status = clBuildProgram(clInstance.program, 1, clInstance.device_ids.data(), NULL, NULL, NULL);
    
    if (status == CL_BUILD_PROGRAM_FAILURE)
    {
        size_t log_size;
        clGetProgramBuildInfo(clInstance.program, clInstance.device_ids[0], CL_PROGRAM_BUILD_LOG, 0, NULL, &log_size);

        // Allocate memory for the log
        char *log = (char *)malloc(log_size);

        // Get the log
        clGetProgramBuildInfo(clInstance.program, clInstance.device_ids[0], CL_PROGRAM_BUILD_LOG, log_size, log, NULL);

        // Print the log
        printf("%s\n", log);
    }



    float x0[3] = {1.0,2.0,3.0};
    float x_res[3] = {-10,-10,-10};

    size_t inputBufferSize = sizeof(float)*3;
    // size_t outputBufferSize = sizeof(float)*3;

    cl_mem inputBuffer = clCreateBuffer(clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, inputBufferSize, (void*) x0, &err);
    assert(err == CL_SUCCESS);

    // cl_mem outputBuffer = clCreateBuffer(clInstance.context, CL_MEM_WRITE_ONLY, outputBufferSize, NULL, &err);
    // assert(err == CL_SUCCESS);

    cl_kernel kernel;
    kernel = clCreateKernel(clInstance.program, "foo", &err);
    assert(err == CL_SUCCESS);
    uint num_args = 0;
    size_t numargSize = sizeof(uint);
    status = clGetKernelInfo(kernel, CL_KERNEL_NUM_ARGS, numargSize, &num_args, &numargSize);
    std::cout << "number of arguments: " << num_args << std::endl;
    
    //get kernel argument names
    std::vector<std::string> arg_names;
    std::string arg_name;
    for (uint i = 0; i < num_args; i++)
    {
        size_t arg_name_size = 0;
        status = clGetKernelArgInfo(kernel, i, CL_KERNEL_ARG_NAME, 0, NULL, &arg_name_size);
        arg_name.resize(arg_name_size);
        status = clGetKernelArgInfo(kernel, i, CL_KERNEL_ARG_NAME, arg_name_size, (void*) arg_name.data(), NULL);
        arg_names.push_back(std::string(arg_name));
    }

    for (uint i = 0; i < num_args; i++)
    {
        std::cout << arg_names[i] << std::endl;
    }


    //get kernel argument type names
    std::vector<std::string> arg_type_names;
    std::string arg_type_name;
    for (uint i = 0; i < num_args; i++)
    {
        size_t arg_type_name_size = 0;
        status = clGetKernelArgInfo(kernel, i, CL_KERNEL_ARG_TYPE_NAME, 0, NULL, &arg_type_name_size);
        arg_type_name.resize(arg_type_name_size);
        status = clGetKernelArgInfo(kernel, i, CL_KERNEL_ARG_TYPE_NAME, arg_type_name_size, (void*) arg_type_name.data(), NULL);
        arg_type_names.push_back(std::string(arg_type_name));
    }
    //print arg_type_names
    for (uint i = 0; i < num_args; i++)
    {
        std::cout << arg_type_names[i] << std::endl;
    }


    // err = clSetKernelArg(kernel, 1, sizeof(float), &df);

    assert(err == CL_SUCCESS);

    // err = clSetKernelArg(kernel, 1, sizeof(cl_mem), &outputBuffer);

    // assert(err == CL_SUCCESS);

    size_t globalWorkSize[1] = {8};

    err = clEnqueueNDRangeKernel(clInstance.commandQueue, kernel, 1, NULL, globalWorkSize, NULL, 0, NULL, NULL);

    assert(err == CL_SUCCESS);

    // err = clEnqueueReadBuffer(clInstance.commandQueue, outputBuffer, CL_TRUE, 0, outputBufferSize, x_res, 0, NULL, NULL);

    // assert(err == CL_SUCCESS);

    status = clReleaseKernel(kernel);              //Release kernel.
    status = clReleaseProgram(clInstance.program); //Release the program object.
    status = clReleaseMemObject(inputBuffer);
    // status = clReleaseMemObject(outputBuffer);
    status = clReleaseCommandQueue(clInstance.commandQueue); //Release  Command queue.
    status = clReleaseContext(clInstance.context);           //Release context.



    return SUCCESS;
}