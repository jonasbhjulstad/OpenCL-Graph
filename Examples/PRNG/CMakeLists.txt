file(MAKE_DIRECTORY ${CLG_DATA_DIR}/PRNG)
add_executable(PRNG_Example PRNG_Example.cpp)
target_link_libraries(PRNG_Example PUBLIC OpenCL::OpenCL OpenCL::Headers Utils)