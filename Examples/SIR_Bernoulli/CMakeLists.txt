file(MAKE_DIRECTORY "${CLG_DATA_DIR}/Bernoulli_Network")
add_executable(SIR_Bernoulli SIR_Bernoulli.cpp)
target_link_libraries(SIR_Bernoulli PUBLIC OpenCL::OpenCL OpenCL::Headers igraph LAPACK::LAPACK CLG_Epidemiological_Kernel_Headers graph_connect SPIRV_Compiler)
configure_file(params.txt ${CLG_DATA_DIR}/Bernoulli_Network/params.txt)