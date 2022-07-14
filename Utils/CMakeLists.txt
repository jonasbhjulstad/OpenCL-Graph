configure_file(FilePaths.hpp.in FilePaths.hpp)
add_library(Utils INTERFACE FilePaths.hpp Debug.hpp CL_Instance.hpp)
target_include_directories(Utils INTERFACE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})

