cmake_minimum_required(VERSION 3.23)
project(OpenCL-Graph)
include(FetchContent)
find_package(OpenCL REQUIRED)
find_package(OpenCLHeaders REQUIRED)
find_package(OpenCLICDLoader REQUIRED)
find_package(igraph REQUIRED)

set(CMAKE_CXX_STANDARD_REQUIRED 17)
enable_testing()
FetchContent_Declare(randomCL_repo
GIT_REPOSITORY https://github.com/bstatcomp/RandomCL.git
)
FetchContent_MakeAvailable(randomCL_repo)


set(CLG_GENERATOR_DIR "${randomcl_repo_SOURCE_DIR}/generators/")
set(CLG_KERNEL_DIR "${CMAKE_SOURCE_DIR}/Kernels/")
set(CLG_DATA_DIR "${CMAKE_BINARY_DIR}/data/")
file(MAKE_DIRECTORY ${CLG_DATA_DIR})
add_subdirectory(Kernels)
add_subdirectory(Utils)
add_subdirectory(Examples)
add_subdirectory(test)