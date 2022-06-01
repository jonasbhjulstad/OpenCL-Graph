# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-src"
  "/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-build"
  "/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix"
  "/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/tmp"
  "/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/src/randomcl_repo-populate-stamp"
  "/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/src"
  "/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/src/randomcl_repo-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-subbuild/randomcl_repo-populate-prefix/src/randomcl_repo-populate-stamp/${subDir}")
endforeach()
