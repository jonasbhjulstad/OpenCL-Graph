add_library(SPIRV_Compiler SHARED CFE_SPIRV_Compiler.cpp SIR_Bernoulli_Network.cpp)

file(GLOB USED_CLANG_HEADERS ${CLANG_INCLUDE_DIRS}/clang/Basic/*.h ${CLANG_INCLUDE_DIRS}/clang/Driver/*.h ${CLANG_INCLUDE_DIRS}/clang/Frontend/*.h)
file(GLOB USED_LLVM_HEADERS ${LLVM_INCLUDE_DIRS}/llvm/Support/*.h)
target_compile_options(SPIRV_Compiler PUBLIC ${LLVM_CXX_FLAGS} "-fno-rtti")
set(CLANG_LIBS clangBasic clangDriver clangFrontend)
target_include_directories(SPIRV_Compiler INTERFACE ${CLCPP_PRNG_INCLUDE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(SPIRV_Compiler PUBLIC  ${CLANG_LIBS} LLVMSupport Utils)