# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/jonas/Documents/OpenCL-Graph/build/_deps/randomcl_repo-src"
  "C:/Users/jonas/Documents/OpenCL-Graph/build/_deps/randomcl_repo-build"
  "C:/Users/jonas/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix"
  "C:/Users/jonas/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/tmp"
  "C:/Users/jonas/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/src/randomcl_repo-populate-stamp"
  "C:/Users/jonas/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/src"
  "C:/Users/jonas/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/src/randomcl_repo-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/jonas/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/src/randomcl_repo-populate-stamp/${subDir}")
endforeach()
