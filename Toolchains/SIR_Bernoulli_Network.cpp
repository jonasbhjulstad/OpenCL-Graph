#include "SIR_Bernoulli_Network.hpp"

void SIR_Bernoulli_Network_Kernel::compile(size_t N_nodes, size_t N_edges,
                                           size_t Nt,
                                           CLCPP::PRNG_TYPE prng_type) {

  std::string kernel_file =
      std::string(CLG::KERNEL_DIR) + "Epidemiological/SIR_Bernoulli_Network";

  std::vector<const char *> preprocessor_definitions;

  preprocessor_definitions.push_back(
      ("PRNG_generator=" + CLCPP::PRNG_class_strmap.at(prng_type)).c_str());
  preprocessor_definitions.push_back(
      ("N_NETWORK_VERTICES=" + std::to_string(N_nodes)).c_str());
  preprocessor_definitions.push_back(
      ("N_NETWORK_EDGES=" + std::to_string(N_edges)).c_str());
  preprocessor_definitions.push_back(
      ("N_NETWORK_TIMESTEPS=" + std::to_string(Nt)).c_str());

  std::vector<const char *> kernel_include_directories = {
      CLG::KERNEL_DIR, CLG::GENERATOR_DIR,
      (std::string(CLG::KERNEL_DIR) + "/Epidemiological/").c_str()};

  SPIRV_Compiler compiler(kernel_file + ".clcpp", kernel_file + ".spv");
  compiler.add_preprocessor_definitions(preprocessor_definitions);
  compiler.add_include_directories(kernel_include_directories);
  compiler.compile();
}

cl_int
SIR_Bernoulli_Network_Kernel::build_program(CLG::CL_Instance &clInstance) {
  int err = 0;
  std::string kernel_file =
      std::string(CLG::KERNEL_DIR) + "/Epidemiological/SIR_Bernoulli_Network";
  std::string programBinary =
      CLG::convertToString((kernel_file + ".spv").c_str());
  long unsigned int programSize = sizeof(char) * programBinary.length();
  clInstance.program = clCreateProgramWithIL(
      clInstance.context, (const void *)programBinary.data(),
      sizeof(char) * programBinary.length(), &err);
  assert(err == CL_SUCCESS);
  return clBuildProgram(clInstance.program, 1, clInstance.device_ids.data(),
                        NULL, NULL, NULL);
}

void SIR_Bernoulli_Network_Kernel::create_buffers(
    CLG::CL_Instance &clInstance, const std::vector<cl_uint> &v0,
    const std::vector<cl_uint> &edges_to,
    const std::vector<cl_uint> &edges_from, const std::vector<cl_ulong> &seeds,
    size_t Nt) {

  size_t N_workers = seeds.size();
  size_t N_nodes = v0.size();
  cl_int err;
  v0_buffer = clCreateBuffer(
      clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
      sizeof(cl_uint) * v0.size(), (void *)v0.data(), &err);
  assert(err == CL_SUCCESS);
  source_node_buffer = clCreateBuffer(
      clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
      sizeof(cl_uint) * edges_from.size(), (void *)edges_from.data(), &err);
  assert(err == CL_SUCCESS);
  target_node_buffer = clCreateBuffer(
      clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
      sizeof(cl_uint) * edges_to.size(), (void *)edges_to.data(), &err);
  assert(err == CL_SUCCESS);
  seed_buffer = clCreateBuffer(
      clInstance.context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
      sizeof(cl_ulong) * seeds.size(), (void *)seeds.data(), &err);

  v_traj_length = N_nodes * N_workers * Nt;
  x_traj_length = 3 * N_workers * Nt;
  v_traj_buffer = clCreateBuffer(clInstance.context, CL_MEM_WRITE_ONLY,
                                 sizeof(cl_uint) * v_traj_length, NULL, &err);
  assert(err == CL_SUCCESS);
  x_traj_buffer = clCreateBuffer(clInstance.context, CL_MEM_WRITE_ONLY,
                                 sizeof(cl_uint) * x_traj_length, NULL, &err);
  assert(err == CL_SUCCESS);
}

cl_int SIR_Bernoulli_Network_Kernel::create_cl_kernel(cl_program program) {
  cl_int err;
  kernel = clCreateKernel(program, "SIR_Compute_Network", &err);
  return err;
}

cl_int
SIR_Bernoulli_Network_Kernel::set_kernel_args(const float bernoulli_p_I,
                                              const float bernoulli_p_R) {
  cl_int err = 0;
  // Initial state
  err = clSetKernelArg(kernel, 0, sizeof(cl_mem), &v0_buffer);
  // Source nodes
  err |= clSetKernelArg(kernel, 1, sizeof(cl_mem), &source_node_buffer);
  // Target nodes
  err |= clSetKernelArg(kernel, 2, sizeof(cl_mem), &target_node_buffer);
  // Infection probability
  err |= clSetKernelArg(kernel, 3, sizeof(float), &bernoulli_p_I);
  // Recovery probability
  err |= clSetKernelArg(kernel, 4, sizeof(float), &bernoulli_p_R);
  // Seeds
  err |= clSetKernelArg(kernel, 5, sizeof(cl_mem), &seed_buffer);
  // Output node trajectory
  err |= clSetKernelArg(kernel, 6, sizeof(cl_mem), &v_traj_buffer);
  // Output total count trajectory
  err |= clSetKernelArg(kernel, 7, sizeof(cl_mem), &x_traj_buffer);
  return err;
}

cl_int SIR_Bernoulli_Network_Kernel::run_kernel(cl_command_queue queue) {
  size_t globalWorkSize[1] = {N_workers};

  return clEnqueueNDRangeKernel(queue, kernel, 1, NULL, globalWorkSize, NULL, 0,
                                NULL, NULL);
}
std::pair<std::vector<cl_uint>, std::vector<cl_uint>>
SIR_Bernoulli_Network_Kernel::read_results(cl_command_queue queue,
                                           cl_int &err) {
  std::vector<cl_uint> v_traj(v_traj_length);
  std::vector<cl_uint> x_traj(x_traj_length);
  err = clEnqueueReadBuffer(queue, v_traj_buffer, CL_TRUE, 0,
                            sizeof(cl_uint) * v_traj_length,
                            (void *)v_traj.data(), 0, NULL, NULL);
  err = clEnqueueReadBuffer(queue, x_traj_buffer, CL_TRUE, 0,
                            sizeof(cl_uint) * x_traj_length,
                            (void *)x_traj.data(), 0, NULL, NULL);
  return {v_traj, x_traj};
}
