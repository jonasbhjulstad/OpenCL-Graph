file(MAKE_DIRECTORY "${CLG_DATA_DIR}/Bernoulli_Network")
add_executable(SIR_Bernoulli SIR_Bernoulli.cpp)
target_link_libraries(SIR_Bernoulli PUBLIC CLG_Utils OpenCL::OpenCL OpenCL::Headers igraph LAPACK::LAPACK CLG_Epidemiological_Kernel_Headers CLG_graph_connect)
target_include_directories(SIR_Bernoulli PUBLIC ${CLCPP_PRNG_INCLUDE_DIR})