
add_executable(ERK4_test ERK4_test.cpp)
target_link_libraries(ERK4_test PUBLIC Utils OpenCL::OpenCL OpenCL::Headers Utils)