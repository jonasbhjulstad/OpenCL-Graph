
# add_executable(Vertex_Integrator_Generator_test "Vertex_Integrator_Generator.cpp")
# target_link_libraries(Vertex_Integrator_Generator_test PUBLIC CLG_Utils OpenCL::OpenCL OpenCL::Headers)
# add_test(NAME Vertex_Integrator_Generator_test COMMAND Vertex_Integrator_Generator_test)


# add_executable(Template_Integrator_Generator_test "Template_Integrator_Generator.cpp")
# target_link_libraries(Template_Integrator_Generator_test PUBLIC CLG_Utils OpenCL::OpenCL OpenCL::Headers)
# add_test(NAME Template_Integrator_Generator_test COMMAND Template_Integrator_Generator_test)
add_executable(ERK4_test ERK4_test.cpp)
target_link_libraries(ERK4_test PUBLIC CLG_Utils OpenCL::OpenCL OpenCL::Headers)

# add_dependencies(ERK4_test ERK_target)
# add_test(NAME ERK4_test COMMAND ERK4_test)