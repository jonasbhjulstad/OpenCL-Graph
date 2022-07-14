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
#include <Utils.hpp>
#include <CLCPP_PRNG/CLCPP_PRNG.hpp>


void compile_execute_with_generator(CLG::CL_Instance& clInstance, CLCPP::PRNG_TYPE rng_type)
{
    using namespace CLCPP;
    std::string pwd = std::string(CLG::ROOT_DIR) + "/Examples/";
    std::string PRNG_example_kernel = std::string(CLG::KERNEL_DIR) + "Examples/PRNG/PRNG.cl";

    std::string cl_generator_dir = CLG::GENERATOR_DIR;
    std::string build_options = "-I " + cl_generator_dir;
    build_options += " -I " + std::string(CLG::KERNEL_DIR) + "Distributions/";
    
    size_t Nfloat_generated = 1024;
    build_options += " -DPRNG_N_SAMPLES=" + std::to_string(Nfloat_generated);

    std::string prependData = configure_generator(rng_type);

    int err = 0;
    clInstance.program = CLG::clLoadProgram(PRNG_example_kernel.c_str(), clInstance.context, err, prependData);

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
    outfile.open(std::string(CLG::DATA_DIR) + "/PRNG/result_" + PRNG_strmap.at(rng_type) + ".csv");
    // std::cout << std::string(CLG::DATA_DIR) + "/PRNG/result_" + PRNG_strmap.at(rng_type) + ".csv" << std::endl;
    std::mt19937 rng;
    std::uniform_int_distribution<cl_uint> dist(0, UINT32_MAX);

    size_t N_runs = 4;
    std::cout << "Generating numbers for " << PRNG_strmap.at(rng_type) << std::endl;
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
    using namespace CLCPP;
    CLG::CL_Instance clInstance;

    std::vector<PRNG_TYPE> rng_types = {
    PRNG_TYPE_ISAAC,
    // PRNG_TYPE_KISS09,
    PRNG_TYPE_KISS99,
    // PRNG_TYPE_LCG12864,
    PRNG_TYPE_LCG6432,
    PRNG_TYPE_LFIB,
    PRNG_TYPE_MRG31K3P,
    PRNG_TYPE_MRG63K3A,
    PRNG_TYPE_MSWS,
    PRNG_TYPE_MT19937,
    PRNG_TYPE_MWC64X,
    PRNG_TYPE_PCG6432,
    PRNG_TYPE_PHILOX2X32_10,
    PRNG_TYPE_RAN2,
    PRNG_TYPE_TINYMT32,
    PRNG_TYPE_TINYMT64,
    PRNG_TYPE_WELL512,
    // PRNG_TYPE_XORSHIFT1024,
    PRNG_TYPE_XORSHIFT6432STAR};

    for (PRNG_TYPE rng_type: rng_types)
    {
        compile_execute_with_generator(clInstance, rng_type);
    }

    return SUCCESS;
}