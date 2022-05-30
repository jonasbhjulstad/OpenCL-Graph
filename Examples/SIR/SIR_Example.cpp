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

#ifndef CLG_SPIRV_COMPILER
#define CLG_SPIRV_COMPILER "clang-14"
#endif

void write_SIR_trajectories(std::ofstream &outfile, float *x_traj, size_t Nt, size_t N_SingleRun_Trajectories)
{
    //write all trajectories in x_traj to csv
    for (int i = 0; i < N_SingleRun_Trajectories; i++)
    {
        size_t offset = 3 * (Nt + 1) * i;
        for (int j = 0; j < Nt; j++)
        {
            outfile << x_traj[offset + 3 * j] << ", " << x_traj[offset + 3 * j + 1] << ", " << x_traj[offset + 3 * j + 2] << "\n";
        }
    }
}

std::string kernel_file = std::string(CLG_KERNEL_DIR) + "/Epidemiological/SIR_Compute_Stochastic";


void compile_kernel(size_t Nt, float SIR_Binomial_Tolerance = 1e-2, CLG_PRNG_TYPE prng_type = CLG_PRNG_TYPE_KISS99)
{
    std::string spirv_compile_command = std::string(CLG_SPIRV_COMPILER) + " -c -target64 -cl-kernel-arg-info -cl-std=clc++2021 " + kernel_file + ".clcpp -o " + kernel_file + ".spv";
    std::string preprocessor_definitions = " -D PRNG_generator=" + CLG_PRNG_class_strmap.at(prng_type) + 
     + " -D SIR_Binomial_Tolerance=" + std::to_string(SIR_Binomial_Tolerance) + "f"
     " -D N_TRAJECTORY_TIMESTEPS=" + std::to_string(Nt);

    std::string kernel_include_directories = " -I " + std::string(CLG_KERNEL_DIR) + "/Distributions/" + 
    " -I " + std::string(CLG_GENERATOR_DIR) + 
    " -I " + std::string(CLG_KERNEL_DIR) + "/Epidemiological/";


    int res = std::system((spirv_compile_command + preprocessor_definitions + kernel_include_directories).c_str());
    std::cout << "system Error code: " << res << std::endl;
}


int main(int argc, char *argv[])
{

    std::string DATA_PATH = CLG_DATA_DIR;
    std::string cl_generator_dir = CLG_GENERATOR_DIR;
    std::string pwd = std::string(CLG_ROOT_DIR) + "/Examples/";
    std::string epidemiological_kernel_dir = std::string(CLG_KERNEL_DIR) + "/Epidemiological/";

    CLG_Instance clInstance = clDefaultInitialize();

    std::string kernel_file = epidemiological_kernel_dir + "SIR_Compute_Stochastic";

    constexpr uint Nt = 100;

    compile_kernel(Nt);

    int err = 0;
    std::string programBinary = convertToString((kernel_file + ".spv").c_str());
    long unsigned int programSize = sizeof(char)*programBinary.length();


    clInstance.program = clCreateProgramWithIL(clInstance.context, (const void*) programBinary.data(), sizeof(char)*programBinary.length(), &err);
    assert(err == CL_SUCCESS);

    std::string build_options = "-I " + cl_generator_dir + " -I " + epidemiological_kernel_dir;
    /*Step 6: Build program. */
    int status = clBuildProgram(clInstance.program, 1, clInstance.device_ids.data(), build_options.c_str(), NULL, NULL);
    CLG_print_build_log(status, clInstance);
    /* Parameter/Buffer initialization */
    constexpr size_t N_trajectories = 10 * 1024;
    size_t N_SingleRun_Trajectories = (N_trajectories > clInstance.max_work_group_size) ? clInstance.max_work_group_size : N_trajectories;

    size_t N_runs = std::ceil(N_trajectories / N_SingleRun_Trajectories);

    ulong seeds[N_SingleRun_Trajectories];

    float dt = 5.;

    typedef std::array<float, 3> state_t;
    float N_pop = 1e2;
    state_t x0;
    x0[1] = 10;
    x0[0] = N_pop - x0[1];
    x0[2] = 0;

    float R0 = 2.0;
    float alpha = .1 / 9;
    float beta = alpha * R0;

    std::array<float, 3> param;
    param[0] = alpha;
    param[1] = beta;
    param[2] = N_pop;

    size_t seedBufferSize = N_SingleRun_Trajectories * sizeof(ulong);
    size_t trajectorySize = 3 * (Nt + 1) * sizeof(float);
    size_t trajectoryBufferSize = trajectorySize * N_SingleRun_Trajectories;

    assert(trajectoryBufferSize < clInstance.global_mem_size);

    std::vector<float> x_traj(3 * (Nt + 1) * N_SingleRun_Trajectories);

    cl_mem seedBuffer = clCreateBuffer(clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                       seedBufferSize, (void *)seeds, &err);

    cl_mem x0Buffer = clCreateBuffer(clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                     sizeof(state_t), (void *)&x0, &err);
    cl_mem outputBuffer = clCreateBuffer(clInstance.context, CL_MEM_WRITE_ONLY,
                                         trajectoryBufferSize, NULL, &err);
    cl_mem paramBuffer = clCreateBuffer(clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                        3 * sizeof(float), (void *)param.data(), &err);
    /*Step 8: Create kernel object */
    cl_kernel kernel = clCreateKernel(clInstance.program, "SIR_Compute_Stochastic", &err);
    assert(err == CL_SUCCESS);
    /*Step 9: Sets Kernel arguments.*/
    status = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&seedBuffer);
    status = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void *)&x0Buffer);
    status = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void *)&outputBuffer);
    status = clSetKernelArg(kernel, 3, sizeof(float), (void *)&dt);
    status = clSetKernelArg(kernel, 4, sizeof(uint), (void *)&Nt);
    status = clSetKernelArg(kernel, 5, sizeof(cl_mem), &paramBuffer);

    assert(status == CL_SUCCESS);

    std::ofstream outfile;
    outfile.open(DATA_PATH + "/SIR_Stochastic/x_traj.csv");
    std::mt19937 rng;
    std::uniform_int_distribution<ulong> dist(0, UINT64_MAX);

    for (int i = 0; i < N_runs; i++)
    {
        for (int j = 0; j < N_SingleRun_Trajectories; j++)
        {
            seeds[j] = dist(rng);
        }
        clEnqueueWriteBuffer(clInstance.commandQueue, seedBuffer, CL_TRUE, 0, seedBufferSize, seeds, 0, NULL, NULL);
        std::cout << "Run " << i << std::endl;
        size_t global_work_size[1] = {N_SingleRun_Trajectories};
        status = clEnqueueNDRangeKernel(clInstance.commandQueue, kernel, 1, NULL,
                                        global_work_size, NULL, 0, NULL, NULL);

        clFinish(clInstance.commandQueue);

        status = clEnqueueReadBuffer(clInstance.commandQueue, outputBuffer, CL_TRUE, 0,
                                     trajectoryBufferSize, (void *)x_traj.data(), 0, NULL, NULL);

        assert(status == CL_SUCCESS);
        write_SIR_trajectories(outfile, x_traj.data(), Nt, N_SingleRun_Trajectories);
    }

    status = clReleaseKernel(kernel);              //Release kernel.
    status = clReleaseProgram(clInstance.program); //Release the program object.
    status = clReleaseMemObject(outputBuffer);
    status = clReleaseCommandQueue(clInstance.commandQueue); //Release  Command queue.
    status = clReleaseContext(clInstance.context);           //Release context.

    outfile.close();

    //write parameters to csv with names
    outfile.open(DATA_PATH + "/SIR_Stochastic/param.csv");
    outfile << "alpha,beta,N_pop,N_trajectories,Nt,dt\n";
    outfile << alpha << "," << beta << "," << N_pop << "," << N_trajectories << "," << Nt << "," << dt << "\n";
    outfile.close();

    float tvec[Nt + 1];
    for (int i = 0; i < Nt + 1; i++)
    {
        tvec[i] = i * dt;
    }

    //write time vector to csv
    outfile.open(DATA_PATH + "/SIR_Stochastic/tvec.csv");
    for (int i = 0; i < Nt + 1; i++)
    {
        outfile << tvec[i] << "\n";
    }

    return SUCCESS;
}