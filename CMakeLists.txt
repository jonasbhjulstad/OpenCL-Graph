cmake_minimum_required(VERSION 3.23)
project(OpenCL-Graph)
add_compile_options("-fopenmp")
include(FetchContent)
find_package(OpenCL REQUIRED)
find_package(OpenCLHeaders REQUIRED)
if(UNIX)
find_package(OpenCLICDLoader REQUIRED)
endif()
if(WIN32)
endif()

message(STATUS ${OpenMP_DIR})
# set(OpenMP_CXX_FLAGS "-fopenmp=libomp -Wno-unused-command-line-argument" CACHE STRING "" FORCE)
# set(OpenMP_CXX_LIB_NAMES "libomp" "libgomp" "libiomp5" CACHE STRING "" FORCE)
# set(OpenMP_libomp_LIBRARY ${OpenMP_CXX_LIB_NAMES} CACHE STRING "" FORCE)
# set(OpenMP_libgomp_LIBRARY ${OpenMP_CXX_LIB_NAMES} CACHE STRING "" FORCE)
# set(OpenMP_libiomp5_LIBRARY ${OpenMP_CXX_LIB_NAMES} CACHE STRING "" FORCE)
find_package(LAPACK REQUIRED)
find_package(igraph REQUIRED)

set(CMAKE_CXX_STANDARD_REQUIRED 17)
set(CMAKE_CXX_STANDARD 17)
enable_testing()
FetchContent_Declare(randomCL_repo
GIT_REPOSITORY https://github.com/bstatcomp/RandomCL.git
)
FetchContent_MakeAvailable(randomCL_repo)

# FetchContent_Declare(llvm_ir_cmake_utils_repo
# GIT_REPOSITORY https://github.com/compor/llvm-ir-cmake-utils.git)

# FetchContent_MakeAvailable(llvm_ir_cmake_utils_repo)



list(APPEND CMAKE_MODULE_PATH "${llvm_ir_cmake_utils_repo_SOURCE_DIR}/cmake")
# include(LLVMIRUtil)

set(CLG_GENERATOR_DIR "${randomcl_repo_SOURCE_DIR}/generators/")
set(CLG_KERNEL_DIR "${CMAKE_SOURCE_DIR}/Kernels/")
set(CLG_DATA_DIR "${CMAKE_BINARY_DIR}/data/")
set(CLG_TEST_DIR "${CMAKE_BINARY_DIR}/test/")
file(MAKE_DIRECTORY ${CLG_DATA_DIR})
add_subdirectory(Kernels)
add_subdirectory(Utils)
add_subdirectory(Graph)
add_subdirectory(Examples)
add_subdirectory(test)