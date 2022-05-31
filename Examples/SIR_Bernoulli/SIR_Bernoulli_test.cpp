#define CL_TARGET_OPENCL_VERSION 300
#include <CLG.hpp>
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
#include <igraph/igraph.h>
#include <igraph/igraph_games.h>
#include <igraph/igraph_layout.h>
#include <SIR_Bernoulli_Network.hpp>
#include <chrono>
#define SUCCESS 0
#define FAILURE 1



enum SIR_State { SIR_Susceptible = 1, SIR_Infected = 2, SIR_Recovered = 3 };

int main(int argc, char *argv[])
{

    cl_uint N_nodes = 200;

    // Generate erdos renyi graph with N_nodes

    cl_uint N_workers =256;
    cl_uint Nt = 100;

    float p_ER = 1.0;
    igraph_t graph;
    igraph_erdos_renyi_game(&graph, IGRAPH_ERDOS_RENYI_GNP, N_nodes, p_ER, IGRAPH_UNDIRECTED, 0);

    //Get vertices in edges
    igraph_vector_t edges;
    igraph_vector_init(&edges, 0);
    igraph_get_edgelist(&graph, &edges, 0);
    size_t N_edges = 2*igraph_vector_size(&edges);
    //Print source and target vertices
    std::vector<cl_uint> edges_to(N_edges);
    std::vector<cl_uint> edges_from(N_edges);

    for (int i = 0; i < igraph_vector_size(&edges); i++)
    {
        edges_to[2*i] = (int)VECTOR(edges)[i];
        edges_to[2*i+1] = (int)VECTOR(edges)[i+1];
        edges_from[2*i] = (int)VECTOR(edges)[i+1];
        edges_from[2*i+1] = (int)VECTOR(edges)[i];
    }

    float p_I_0 = .1;
    float bernoulli_p_I = .0001;
    float bernoulli_p_R = .001;

    //Generate N_worker random uints
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis;

    std::vector<cl_uint> v0(N_nodes, 1);
    //randomly assign state 2 to fraction p_I_0 of v0
    std::vector<cl_uint> v1(N_nodes, 0);
    std::uniform_real_distribution<float> dis_float(0.0, 1.0);
    size_t N_infected = 0;
    for (int i = 0; i < N_nodes; i++)
    {
        if (dis_float(gen) < p_I_0)
        {
            v0[i] = 2;
            N_infected += 1;
        }
    }
    std::cout << "Compiling kernel with " << N_nodes << " nodes, " << N_edges << " edges and " << N_workers << " workers\nInfected: " << N_infected << std::endl;
    
    CLG_Instance clInstance = clDefaultInitialize();
    char device_name[100];
    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_NAME, sizeof(char)*100, device_name, NULL);
    std::cout << "Using device: " << device_name << std::endl;
    SIR_Bernoulli_Network_Kernel kernel(N_workers);
    kernel.compile(N_nodes, N_edges, Nt);
    
    //print available cl devices

    cl_uint status = kernel.build_program(clInstance);
    
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

    std::vector<cl_ulong> seeds(N_workers);
    std::uniform_int_distribution<cl_ulong> dist(0, UINT64_MAX);

    for (int i = 0; i < N_workers; i++)
    {
        seeds[i] = dist(gen);
    }



    // cl_mem outputBuffer = clCreateBuffer(clInstance.context, CL_MEM_WRITE_ONLY, outputBufferSize, NULL, &err);
    // assert(err == CL_SUCCESS);
    assert(kernel.create_cl_kernel(clInstance.program) == CL_SUCCESS);

    cl_int err;

    kernel.create_buffers(clInstance, v0, edges_to, edges_from, seeds, Nt);
    assert(kernel.set_kernel_args(bernoulli_p_I, bernoulli_p_R) == CL_SUCCESS);

    assert(err == CL_SUCCESS);
    std::cout << "Executing kernel..." << std::endl;
    kernel.run_kernel(clInstance.commandQueue);
    assert(err == CL_SUCCESS);
    clFinish(clInstance.commandQueue);

    auto[v_traj, x_traj] = kernel.read_results(clInstance.commandQueue, err);
    assert(err == CL_SUCCESS);


    status = clReleaseProgram(clInstance.program); //Release the program object.
    status = clReleaseCommandQueue(clInstance.commandQueue); //Release  Command queue.
    status = clReleaseContext(clInstance.context);           //Release context.


    std::ofstream f;
    for (cl_uint i = 0; i < N_workers; i++)
    {
        f.open(std::string(CLG_DATA_DIR) + "/Bernoulli_Network_Test/v_traj_" + std::to_string(i) + ".csv");
        for (cl_uint j = 0; j < Nt; j++)
        {
            for (cl_uint k = 0; k < N_nodes; k++)
            {
                f << v_traj[i*N_nodes*Nt + j*N_nodes + k] << ",";
            }
            f << "\n";
        }
        f.close();
    }

    cl_uint x_traj_offset = 3*Nt;

    for (cl_uint i = 0; i < Nt; i++)
    {
        std::cout << x_traj[x_traj_offset + 3*i] << ", " << x_traj[x_traj_offset + 3*i + 1] << ", " << x_traj[x_traj_offset + 3*i + 2] << std::endl;
    }
    for (cl_uint i = 0; i < N_workers; i++)
    {
        f.open(std::string(CLG_DATA_DIR) + "/Bernoulli_Network_Test/x_traj_" + std::to_string(i) + ".csv");
        for (cl_uint j = 0; j < Nt; j++)
        {
            f << x_traj[3*j + i*3*Nt] << "," << x_traj[3*j + 1 + i*3*Nt] << "," << x_traj[3*j + 2 + i*3*Nt] << "\n";
        }
        f.close();
    }


    igraph_matrix_t pos;
    igraph_matrix_init(&pos, N_nodes, 2);
    igraph_vector_t weights;
    igraph_vector_fill(&weights, 1.0);
    //get kamada_kawai layout
    igraph_layout_kamada_kawai(&graph, &pos, false, 500, 0, N_nodes, &weights, NULL, NULL, NULL, NULL);

    //write pos to file
    f.open(std::string(CLG_DATA_DIR) + "/Bernoulli_Network_Test/pos.csv");
    for (int i = 0; i < N_nodes; i++)
    {
        f << MATRIX(pos,i,0) << "," << MATRIX(pos,i,1) << "\n";
    }
    f.close();


    return SUCCESS;
}