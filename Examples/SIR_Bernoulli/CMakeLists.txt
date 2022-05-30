file(MAKE_DIRECTORY "${CLG_DATA_DIR}/Bernoulli_Network")
add_executable(SIR_Bernoulli_test SIR_Bernoulli_test.cpp)
target_link_libraries(SIR_Bernoulli_test PUBLIC CLG_Utils OpenCL::OpenCL OpenCL::Headers igraph LAPACK::LAPACK CLG_Epidemiological_Kernel_Headers)