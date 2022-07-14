#ifndef SIR_BERNOULLI_NETWORK_HPP
#define SIR_BERNOULLI_NETWORK_HPP
#include "CFE_SPIRV_Compiler.hpp"
#include <CLCPP_PRNG/CLCPP_PRNG.hpp>
#include <Utils.hpp>
#include <string>
#include <vector>

class SIR_Bernoulli_Network_Kernel {

private:
  cl_mem v0_buffer;
  cl_mem target_node_buffer;
  cl_mem source_node_buffer;
  cl_mem seed_buffer;
  cl_mem v_traj_buffer;
  cl_mem x_traj_buffer;
  size_t v_traj_length;
  size_t x_traj_length;
  cl_kernel kernel;
  size_t N_workers;

public:
  SIR_Bernoulli_Network_Kernel(size_t _N_workers) : N_workers(_N_workers) {}
  void compile(size_t N_nodes, size_t N_edges, size_t Nt,
                      CLCPP::PRNG_TYPE prng_type);

  cl_int build_program(CLG::CL_Instance &clInstance);

  void create_buffers(CLG::CL_Instance &clInstance, const std::vector<cl_uint> &v0,
                      const std::vector<cl_uint> &edges_to,
                      const std::vector<cl_uint> &edges_from,
                      const std::vector<cl_ulong> &seeds, size_t Nt);

  cl_int create_cl_kernel(cl_program program);

  cl_int set_kernel_args(const float bernoulli_p_I, const float bernoulli_p_R);

  cl_int run_kernel(cl_command_queue queue);
  std::pair<std::vector<cl_uint>, std::vector<cl_uint>>
  read_results(cl_command_queue queue, cl_int &err);

~SIR_Bernoulli_Network_Kernel() {
  clReleaseMemObject(v0_buffer);
  clReleaseMemObject(source_node_buffer);
  clReleaseMemObject(target_node_buffer);
  clReleaseMemObject(seed_buffer);
  clReleaseMemObject(v_traj_buffer);
  clReleaseMemObject(x_traj_buffer);
  clReleaseKernel(kernel);
}
};
#endif