#define CL_TARGET_OPENCL_VERSION 300
#include <iostream>
#include <string>
#include <fstream>
#include <random>
#include <sstream>
#include <igraph/igraph.h>
#include <igraph/igraph_games.h>
#include <igraph/igraph_layout.h>
#include <SIR_Bernoulli_Network.hpp>
#include <algorithm>
#include <graph_connect.hpp>
#define SUCCESS 0
#define FAILURE 1




enum SIR_State { SIR_Susceptible = 1, SIR_Infected = 2, SIR_Recovered = 3 };

void write_graph_structure(igraph_t& graph, size_t N_nodes, size_t N_edges);
void write_trajectories(std::vector<cl_uint>& x_traj, std::vector<cl_uint>& v_traj, size_t N_workers, size_t Nt, size_t N_nodes);

int main(int argc, char *argv[])
{
    cl_uint N_nodes = 0;
    cl_uint N_simulations = 256;
    cl_uint Nt = 100;
    float p_ER = 0.01;
    float p_I_0 = .1;
    float bernoulli_p_I = .1;
    float bernoulli_p_R = .01;
    float p_ER_cluster = 0.0001;
    size_t N_clusters = 1;
    std::ifstream param_file(std::string(CLG::DATA_DIR) + "/Bernoulli_Network/params.txt");
    if (param_file.is_open())
    {
        std::string line;
        while (std::getline(param_file, line))
        {
            std::istringstream iss(line);
            std::string param_name;
            iss >> param_name;
            if (param_name == "N_nodes")
            {
                iss >> N_nodes;
            }
            else if (param_name == "N_simulations")
            {
                iss >> N_simulations;
            }
            else if (param_name == "Nt")
            {
                iss >> Nt;
            }
            else if (param_name == "p_ER")
            {
                iss >> p_ER;
            }
            else if (param_name == "p_I_0")
            {
                iss >> p_I_0;
            }
            else if (param_name == "bernoulli_p_I")
            {
                iss >> bernoulli_p_I;
            }
            else if (param_name == "bernoulli_p_R")
            {
                iss >> bernoulli_p_R;
            }
            else if (param_name == "N_clusters")
            {
                iss >> N_clusters;
            }
            else if (param_name == "p_ER_cluster")
            {
                iss >> p_ER_cluster;
            }
        }
        param_file.close();
    }
    else
    {
        std::cout << "Unable to open file" << std::endl;
        return FAILURE;
    }
    igraph_vector_ptr_t p_clusters;
    igraph_vector_ptr_init(&p_clusters, N_clusters);
    size_t N_cluster_nodes = N_nodes/N_clusters;
    igraph_t clusters[N_clusters];
    for (cl_uint i = 0; i < N_clusters; i++)
    {
        igraph_erdos_renyi_game(&clusters[i], IGRAPH_ERDOS_RENYI_GNP, N_cluster_nodes, p_ER, IGRAPH_UNDIRECTED, 0);
        igraph_vector_ptr_set(&p_clusters, i, &clusters[i]);
    }
    igraph_t graph;
    

    igraph_disjoint_union_many(&graph, &p_clusters);

    for (cl_uint i = 1; i < N_clusters; i++)
    {
        for (cl_uint j = 0; j < i; j++)
        {
            if (i != j)
            {
                connect_clusters((igraph_t*)VECTOR(p_clusters)[i], (igraph_t*)VECTOR(p_clusters)[j], &graph, p_ER_cluster);
            }
        }
    }



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
    std::cout << "Compiling kernel with " << N_nodes << " nodes, " << N_edges << " edges and " << N_simulations << " simulations\nInfected: " << N_infected << std::endl;
    
    CLG::CL_Instance clInstance;
    char device_name[100];
    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_NAME, sizeof(char)*100, device_name, NULL);
    std::cout << "Using device: " << device_name << std::endl;

    //Get max work group size
    size_t max_work_group_size;
    clGetDeviceInfo(clInstance.device_ids[0], CL_DEVICE_MAX_WORK_GROUP_SIZE, sizeof(size_t), &max_work_group_size, NULL);
    std::cout << "Max work group size: " << max_work_group_size << std::endl;

    size_t N_workers = (N_simulations > max_work_group_size) ? max_work_group_size : N_simulations;
    size_t N_runs = (N_simulations > max_work_group_size) ? ((int)N_simulations/max_work_group_size): 1;
    SIR_Bernoulli_Network_Kernel kernel(N_workers);
    kernel.compile(N_nodes, N_edges, Nt, CLCPP::PRNG_TYPE_ISAAC);
    
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



    assert(kernel.create_cl_kernel(clInstance.program) == CL_SUCCESS);

    cl_int err;

    kernel.create_buffers(clInstance, v0, edges_to, edges_from, seeds, Nt);
    assert(kernel.set_kernel_args(bernoulli_p_I, bernoulli_p_R) == CL_SUCCESS);

    assert(err == CL_SUCCESS);
    std::cout << "Executing kernel..." << std::endl;
    std::vector<cl_uint> v_traj;
    std::vector<cl_uint> x_traj;
    for (cl_uint i = 0; i < N_runs; i++)
    {
        std::cout << "Run " << i + 1 <<  "/" << N_runs << std::endl;
        kernel.run_kernel(clInstance.commandQueue);
        clFinish(clInstance.commandQueue);
        auto[v_traj_i, x_traj_i] = kernel.read_results(clInstance.commandQueue, err);
        v_traj.insert(v_traj.end(), v_traj_i.begin(), v_traj_i.end());
        x_traj.insert(x_traj.end(), x_traj_i.begin(), x_traj_i.end());

    }

    write_trajectories(x_traj, v_traj, N_workers, Nt, N_nodes);

    status = clReleaseProgram(clInstance.program); //Release the program object.
    status = clReleaseCommandQueue(clInstance.commandQueue); //Release  Command queue.
    status = clReleaseContext(clInstance.context);           //Release context.

    write_graph_structure(graph, N_nodes, N_edges);

    return SUCCESS;
}


void write_graph_structure(igraph_t& graph, size_t N_nodes, size_t N_edges)
{
    igraph_matrix_t pos;
    igraph_matrix_init(&pos, N_edges/2, 2);
    igraph_vector_t weights;

    igraph_vector_init(&weights, N_edges/2);

    igraph_vector_fill(&weights, 1.0f);
    //get kamada_kawai layout
    // igraph_layout_kamada_kawai(&graph, &pos, false, 500, 0, N_nodes, &weights, NULL, NULL, NULL, NULL);
    igraph_layout_gem(&graph, &pos, false, 500, N_nodes, 1/10.f, sqrt(N_nodes));
    //write pos to file
    std::ofstream f;
    f.open(std::string(CLG::DATA_DIR) + "/Bernoulli_Network/pos.csv");
    for (int i = 0; i < N_nodes; i++)
    {
        f << MATRIX(pos,i,0) << "," << MATRIX(pos,i,1) << "\n";
    }
    f.close();

    // //write edges to file
    f.open(std::string(CLG::DATA_DIR) + "/Bernoulli_Network/edges.csv");
    // for (int i = 0; i < N_edges; i++)
    // {
    //     f << edges_to[i] << " " << edges_from[i] << " {} \n";
    // }
    // f.close();
    FILE* file = fopen((std::string(CLG::DATA_DIR) + "/Bernoulli_Network/edges.csv").c_str(), "w");
    igraph_write_graph_edgelist(&graph, file);
    fclose(file);
}


void write_trajectories(std::vector<cl_uint>& x_traj, std::vector<cl_uint>& v_traj, size_t N_workers, size_t Nt, size_t N_nodes)
{
    std::ofstream f;
    for (cl_uint i = 0; i < N_workers; i++)
    {
        f.open(std::string(CLG::DATA_DIR) + "/Bernoulli_Network/v_traj_" + std::to_string(i) + ".csv");
        for (cl_uint j = 0; j < Nt; j++)
        {
            f << v_traj[i*N_nodes*Nt + j*N_nodes];
            for (cl_uint k = 1; k < N_nodes; k++)
            {
                f << ", " <<  v_traj[i*N_nodes*Nt + j*N_nodes + k];
            }
            f << "\n";
        }
        f.close();
    }

    //write the state of each node to separate files
    for (cl_uint i = 0; i < N_nodes; i++)
    {
        f.open(std::string(CLG::DATA_DIR) + "/Bernoulli_Network/v_" + std::to_string(i) + ".csv");
        for (cl_uint j = 0; j < Nt; j++)
        {
            for (cl_uint k = 0; k < N_workers; k++)
            {
                f << v_traj[k*N_nodes*Nt + j*N_nodes + i] << ",";
            }
            f << "\n";
        }
        f.close();
    }


    cl_uint x_traj_offset = 3*Nt;

    // for (cl_uint i = 0; i < Nt; i++)
    // {
    //     std::cout << x_traj[x_traj_offset + 3*i] << ", " << x_traj[x_traj_offset + 3*i + 1] << ", " << x_traj[x_traj_offset + 3*i + 2] << std::endl;
    // }
    for (cl_uint i = 0; i < N_workers; i++)
    {
        f.open(std::string(CLG::DATA_DIR) + "/Bernoulli_Network/x_traj_" + std::to_string(i) + ".csv");
        for (cl_uint j = 0; j < Nt; j++)
        {
            f << x_traj[3*j + i*3*Nt] << "," << x_traj[3*j + 1 + i*3*Nt] << "," << x_traj[3*j + 2 + i*3*Nt] << "\n";
        }
        f.close();
    }
}