clang -c -target spirv32 -cl-kernel-arg-info -Xclang -no-opaque-pointers  -cl-std=clc++2021 -emit-llvm ERK.cpp -o ERK.ll
llvm-spirv --spirv-text ERK.ll -o ERK.rspv