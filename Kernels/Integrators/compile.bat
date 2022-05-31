clang -c -target spirv32 -cl-kernel-arg-info -Xclang -no-opaque-pointers  -cl-std=clc++2021 ERK.cpp -o ERK.spv
