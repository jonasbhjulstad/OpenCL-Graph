add_executable(SIR_Network_Example SIR_Network_Example.cpp)
target_link_libraries(SIR_Network_Example PUBLIC CLG_Utils OpenCL::OpenCL OpenCL::Headers igraph::igraph)