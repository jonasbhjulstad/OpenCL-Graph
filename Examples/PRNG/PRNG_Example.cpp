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
#include <cmath>
#define SUCCESS 0
#define FAILURE 1
#include <CLG.hpp>


void CompileExecuteWithGenerator(CLG_Instance& clInstance, CLG_PRNG_TYPE rng_type)
{
    std::string pwd = std::string(CLG_ROOT_DIR) + "/Examples/";
    std::string PRNG_example_kernel = std::string(CLG_KERNEL_DIR) + "Examples/PRNG/PRNG.cl";

    std::string cl_generator_dir = CLG_GENERATOR_DIR;
    std::string build_options = "-I " + cl_generator_dir;
    build_options += " -I " + std::string(CLG_KERNEL_DIR) + "Distributions/";
    
    size_t Nfloat_generated = 1024;
    build_options += " -DPRNG_N_SAMPLES=" + std::to_string(Nfloat_generated);

    std::string prependData = CLG_Configure_Generator(rng_type);

    int err = 0;
    clInstance.program = clLoadProgram(PRNG_example_kernel.c_str(), clInstance.context, err, prependData);

    assert(err == CL_SUCCESS);


    // std::cout << build_options << std::endl;
    /*Step 6: Build program. */
    int status = clBuildProgram(clInstance.program, 1, clInstance.device_ids.data(), build_options.c_str(), NULL, NULL);
    if (status == CL_BUILD_PROGRAM_FAILURE)
    {
        // Determine the size of the log
        size_t log_size;
        clGetProgramBuildInfo(clInstance.program, clInstance.device_ids[0], CL_PROGRAM_BUILD_LOG, 0, NULL, &log_size);

        // Allocate memory for the log
        char *log = (char *)malloc(log_size);

        // Get the log
        clGetProgramBuildInfo(clInstance.program, clInstance.device_ids[0], CL_PROGRAM_BUILD_LOG, log_size, log, NULL);

        // Print the log
        printf("%s\n", log);
    }

    /* Parameter/Buffer initialization */
    constexpr size_t workgroupSize = 256;

    cl_uint seeds[workgroupSize];
    float rng_result[Nfloat_generated * workgroupSize];
    size_t seedBufferSize = workgroupSize * sizeof(cl_uint);
    size_t outputBufferSize = Nfloat_generated * workgroupSize*sizeof(float);

    assert(outputBufferSize < clInstance.global_mem_size);

    cl_mem seedBuffer = clCreateBuffer(clInstance.context, CL_MEM_READ_ONLY,
                                       seedBufferSize, NULL, &err);

    cl_mem outputBuffer = clCreateBuffer(clInstance.context, CL_MEM_WRITE_ONLY,
                                         outputBufferSize, NULL, &err);
    /*Step 8: Create kernel object */
    cl_kernel kernel = clCreateKernel(clInstance.program, "PRNG_Generate", &err);
    assert(err == CL_SUCCESS);
    /*Step 9: Sets Kernel arguments.*/
    // status = clSetKernelArg(kernel, 0, sizeof(size_t), &num);
    status = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&seedBuffer);
    status = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void *)&outputBuffer);

    assert(status == CL_SUCCESS);

    std::ofstream outfile;
    outfile.open(std::string(CLG_DATA_DIR) + "/PRNG/result_" + CLG_PRNG_strmap.at(rng_type) + ".csv");
    // std::cout << std::string(CLG_DATA_DIR) + "/PRNG/result_" + CLG_PRNG_strmap.at(rng_type) + ".csv" << std::endl;
    std::mt19937 rng;
    std::uniform_int_distribution<cl_uint> dist(0, UINT32_MAX);

    size_t N_runs = 4;
    std::cout << "Generating numbers for " << CLG_PRNG_strmap.at(rng_type) << std::endl;
    for (int i = 0; i < N_runs; i++)
    {
        for (int j = 0; j < workgroupSize; j++)
        {
            seeds[j] = dist(rng);
            // std::cout << seeds[j] << std::endl;
        }
        clEnqueueWriteBuffer(clInstance.commandQueue, seedBuffer, CL_TRUE, 0, seedBufferSize, seeds, 0, NULL, NULL);
        // std::cout << "Run " << i << std::endl;
        size_t global_work_size[1] = {workgroupSize};
        status = clEnqueueNDRangeKernel(clInstance.commandQueue, kernel, 1, NULL,
                                        global_work_size, NULL, 0, NULL, NULL);

        clFinish(clInstance.commandQueue);

        status = clEnqueueReadBuffer(clInstance.commandQueue, outputBuffer, CL_TRUE, 0,
                                     outputBufferSize, (void *)rng_result, 0, NULL, NULL);

        //write rng_result to outfile
        for (int i = 0; i < workgroupSize; i++)
        {
            outfile << rng_result[i * Nfloat_generated];
            for (int j = 1; j < Nfloat_generated; j++)
            {
                outfile << "," << rng_result[i * Nfloat_generated + j];
            }
            outfile << std::endl;
        }
    }
    outfile.close();
}


int main(int argc, char *argv[])
{

    CLG_Instance clInstance = clDefaultInitialize();

    std::vector<CLG_PRNG_TYPE> rng_types = {
    CLG_PRNG_TYPE_ISAAC,
    // CLG_PRNG_TYPE_KISS09,
    CLG_PRNG_TYPE_KISS99,
    // CLG_PRNG_TYPE_LCG12864,
    CLG_PRNG_TYPE_LCG6432,
    CLG_PRNG_TYPE_LFIB,
    CLG_PRNG_TYPE_MRG31K3P,
    CLG_PRNG_TYPE_MRG63K3A,
    CLG_PRNG_TYPE_MSWS,
    CLG_PRNG_TYPE_MT19937,
    CLG_PRNG_TYPE_MWC64X,
    CLG_PRNG_TYPE_PCG6432,
    CLG_PRNG_TYPE_PHILOX2X32_10,
    CLG_PRNG_TYPE_RAN2,
    CLG_PRNG_TYPE_TINYMT32,
    CLG_PRNG_TYPE_TINYMT64,
    CLG_PRNG_TYPE_WELL512,
    // CLG_PRNG_TYPE_XORSHIFT1024,
    CLG_PRNG_TYPE_XORSHIFT6432STAR};

    for (CLG_PRNG_TYPE rng_type: rng_types)
    {
        CompileExecuteWithGenerator(clInstance, rng_type);
    }

    return SUCCESS;
}