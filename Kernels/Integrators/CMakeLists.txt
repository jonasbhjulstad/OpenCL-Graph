# add_custom_command(
#     OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/ERK.ll"
#     COMMAND "clang -cc1 -cl-std=clc++2021 ${CMAKE_CURRENT_SOURCE_DIR}/ERK.clcpp -emit-llvm -o ${CMAKE_CURRENT_BINARY_DIR}/ERK.ll"
# )

# target_add_compile_options()


# add_executable(ERK_Kernel ${CMAKE_CURRENT_SOURCE_DIR}/ERK.cpp)


# set_target_properties(ERK_Kernel PROPERTIES LINKER_LANGUAGE CXX)

# target_compile_options(ERK_Kernel PUBLIC "-cc1 -cl-std=clc++2021 -emit-llvm -o ERK.bc")