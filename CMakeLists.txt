cmake_minimum_required(VERSION 3.23)
project(OpenCL_Graph)
add_compile_options("-fopenmp")
include(FetchContent)
find_package(OpenCL REQUIRED)
find_package(OpenCLHeaders REQUIRED)
if(UNIX)
find_package(OpenCLICDLoader REQUIRED)
set(SPIRV_COMPILER "/usr/local/bin/clang-14")
endif()
if(WIN32)
endif()

find_package(LAPACK REQUIRED)
find_package(igraph REQUIRED)

set(CMAKE_CXX_STANDARD_REQUIRED 17)
set(CMAKE_CXX_STANDARD 17)

find_package(CLCPP_PRNG REQUIRED HINTS "/home/deb/Documents/CLCPP_PRNG/build/pkg/")



set(CLG_KERNEL_DIR "${CMAKE_SOURCE_DIR}/Kernels/")
set(CLG_DATA_DIR "${CMAKE_BINARY_DIR}/data/")
set(CLG_TEST_DIR "${CMAKE_BINARY_DIR}/test/")
file(MAKE_DIRECTORY ${CLG_DATA_DIR})
add_subdirectory(Kernels)
add_subdirectory(Utils)
add_subdirectory(Graph)
add_subdirectory(Examples)
add_subdirectory(test)


# Create and install package configuration and version files.
configure_file(
   ${OpenCL_Graph_SOURCE_DIR}/pkg/opencl_graph-config.cmake.in
   ${OpenCL_Graph_BINARY_DIR}/pkg/opencl_graph-config.cmake @ONLY)

configure_file(
    ${OpenCL_Graph_SOURCE_DIR}/pkg/clg_utils-config.cmake.in
    ${OpenCL_Graph_BINARY_DIR}/pkg/clg_utils-config.cmake @ONLY)

configure_file(
   ${OpenCL_Graph_SOURCE_DIR}/opencl_graph-config-version.cmake.in
   ${OpenCL_Graph_BINARY_DIR}/opencl_graph-config-version.cmake @ONLY)

install(FILES ${OpenCL_Graph_BINARY_DIR}/pkg/opencl_graph-config.cmake
         ${OpenCL_Graph_BINARY_DIR}/opencl_graph-config-version.cmake
         DESTINATION lib/OpenCL_Graph-${version})