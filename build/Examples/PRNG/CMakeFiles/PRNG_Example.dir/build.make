# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.23

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = C:\msys64\mingw64\bin\cmake.exe

# The command to remove a file.
RM = C:\msys64\mingw64\bin\cmake.exe -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:\Users\jonas\Documents\OpenCL-Graph

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = C:\Users\jonas\Documents\OpenCL-Graph\build

# Include any dependencies generated for this target.
include Examples/PRNG/CMakeFiles/PRNG_Example.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include Examples/PRNG/CMakeFiles/PRNG_Example.dir/compiler_depend.make

# Include the progress variables for this target.
include Examples/PRNG/CMakeFiles/PRNG_Example.dir/progress.make

# Include the compile flags for this target's objects.
include Examples/PRNG/CMakeFiles/PRNG_Example.dir/flags.make

Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.obj: Examples/PRNG/CMakeFiles/PRNG_Example.dir/flags.make
Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.obj: Examples/PRNG/CMakeFiles/PRNG_Example.dir/includes_CXX.rsp
Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.obj: ../Examples/PRNG/PRNG_Example.cpp
Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.obj: Examples/PRNG/CMakeFiles/PRNG_Example.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=C:\Users\jonas\Documents\OpenCL-Graph\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.obj"
	cd /d C:\Users\jonas\Documents\OpenCL-Graph\build\Examples\PRNG && C:\msys64\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.obj -MF CMakeFiles\PRNG_Example.dir\PRNG_Example.cpp.obj.d -o CMakeFiles\PRNG_Example.dir\PRNG_Example.cpp.obj -c C:\Users\jonas\Documents\OpenCL-Graph\Examples\PRNG\PRNG_Example.cpp

Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.i"
	cd /d C:\Users\jonas\Documents\OpenCL-Graph\build\Examples\PRNG && C:\msys64\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\jonas\Documents\OpenCL-Graph\Examples\PRNG\PRNG_Example.cpp > CMakeFiles\PRNG_Example.dir\PRNG_Example.cpp.i

Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.s"
	cd /d C:\Users\jonas\Documents\OpenCL-Graph\build\Examples\PRNG && C:\msys64\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\jonas\Documents\OpenCL-Graph\Examples\PRNG\PRNG_Example.cpp -o CMakeFiles\PRNG_Example.dir\PRNG_Example.cpp.s

# Object files for target PRNG_Example
PRNG_Example_OBJECTS = \
"CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.obj"

# External object files for target PRNG_Example
PRNG_Example_EXTERNAL_OBJECTS =

Examples/PRNG/PRNG_Example.exe: Examples/PRNG/CMakeFiles/PRNG_Example.dir/PRNG_Example.cpp.obj
Examples/PRNG/PRNG_Example.exe: Examples/PRNG/CMakeFiles/PRNG_Example.dir/build.make
Examples/PRNG/PRNG_Example.exe: C:/Program\ Files/NVIDIA\ GPU\ Computing\ Toolkit/CUDA/v11.6/lib/x64/OpenCL.lib
Examples/PRNG/PRNG_Example.exe: Examples/PRNG/CMakeFiles/PRNG_Example.dir/linklibs.rsp
Examples/PRNG/PRNG_Example.exe: Examples/PRNG/CMakeFiles/PRNG_Example.dir/objects1.rsp
Examples/PRNG/PRNG_Example.exe: Examples/PRNG/CMakeFiles/PRNG_Example.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=C:\Users\jonas\Documents\OpenCL-Graph\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable PRNG_Example.exe"
	cd /d C:\Users\jonas\Documents\OpenCL-Graph\build\Examples\PRNG && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\PRNG_Example.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
Examples/PRNG/CMakeFiles/PRNG_Example.dir/build: Examples/PRNG/PRNG_Example.exe
.PHONY : Examples/PRNG/CMakeFiles/PRNG_Example.dir/build

Examples/PRNG/CMakeFiles/PRNG_Example.dir/clean:
	cd /d C:\Users\jonas\Documents\OpenCL-Graph\build\Examples\PRNG && $(CMAKE_COMMAND) -P CMakeFiles\PRNG_Example.dir\cmake_clean.cmake
.PHONY : Examples/PRNG/CMakeFiles/PRNG_Example.dir/clean

Examples/PRNG/CMakeFiles/PRNG_Example.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" C:\Users\jonas\Documents\OpenCL-Graph C:\Users\jonas\Documents\OpenCL-Graph\Examples\PRNG C:\Users\jonas\Documents\OpenCL-Graph\build C:\Users\jonas\Documents\OpenCL-Graph\build\Examples\PRNG C:\Users\jonas\Documents\OpenCL-Graph\build\Examples\PRNG\CMakeFiles\PRNG_Example.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : Examples/PRNG/CMakeFiles/PRNG_Example.dir/depend

