#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <CL/cl.h>
#include <CLG_Kernel_Generators.hpp>
#include <CLG_DefaultInstance.hpp>
int main()
{
    std::string kernel_fname = "test_kernel.cl";
    std::vector<std::string> functions = {"fun_1", "fun_2", "fun_3"};

    std::ofstream outfile(kernel_fname);

    outfile << CLG_generate_vertex_integrator(functions);

    outfile.close();


    CLG_Instance clInstance = clDefaultInitialize();

    int err = 0;
    clInstance.program = clLoadProgram(kernel_fname.c_str(), clInstance.context, err);

    assert(err == CL_SUCCESS);

    /*Step 6: Build program. */
    int status = clBuildProgram(clInstance.program, 1, clInstance.device_ids.data(), , NULL, NULL);

    assert(err == CL_SUCCESS);

    float xk[3];
    float x_res[3];
    float param[3];

    cl_mem xkBuffer = clCreateBuffer(clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                       3*sizeof(float), xk, &err);

    cl_mem resBuffer = clCreateBuffer(clInstance.context, CL_MEM_WRITE_ONLY,
                                         3*sizeof(float), NULL, &err);
    cl_mem paramBuffer = clCreateBuffer(clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                                        3 * sizeof(float), (void *)param, &err);
    /*Step 8: Create kernel object */
    cl_kernel kernel = clCreateKernel(clInstance.program, "SIR_Compute_Stochastic", &err);
    assert(err == CL_SUCCESS);
    /*Step 9: Sets Kernel arguments.*/
    // status = clSetKernelArg(kernel, 0, sizeof(size_t), &num);
    status = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&seedBuffer);
    status = clSetKernelArg(kernel, 1, sizeof(cl_mem), (void *)&x0Buffer);
    status = clSetKernelArg(kernel, 2, sizeof(cl_mem), (void *)&outputBuffer);
    // status = clSetKernelArg(kernel, 3,  trajectorySize, NULL);
    status = clSetKernelArg(kernel, 3, sizeof(float), (void *)&dt);
    status = clSetKernelArg(kernel, 4, sizeof(uint), (void *)&Nt);
    status = clSetKernelArg(kernel, 5, sizeof(cl_mem), &paramBuffer);

}