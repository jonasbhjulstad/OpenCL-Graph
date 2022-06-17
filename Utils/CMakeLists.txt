configure_file(CLG_FilePaths.hpp.in CLG_FilePaths.hpp)
add_library(CLG_Utils INTERFACE)
target_include_directories(CLG_Utils INTERFACE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})

install(TARGETS CLG_Utils EXPORT Utils
INCLUDES DESTINATION include)

export(EXPORT Utils
FILE "${CMAKE_CURRENT_BINARY_DIR}/clg_utils-targets.cmake")