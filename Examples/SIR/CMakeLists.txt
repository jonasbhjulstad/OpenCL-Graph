file(MAKE_DIRECTORY "${CLG_DATA_DIR}/SIR_Stochastic")
add_executable(SIR_Example SIR_Example.cpp)
target_link_libraries(SIR_Example PUBLIC OpenCL::OpenCL OpenCL::Headers Utils SPIRV_Compiler)