clear
clang-14 -c -target spirv64 -cl-kernel-arg-info -cl-std=clc++2021 SIR_Bernoulli_Network.clcpp -I"../Distributions" -I"/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-src/generators" -o SIR_Bernoulli_Network.spv
clang-14 -c -target spirv64 -cl-kernel-arg-info -cl-std=clc++2021 SIR_Compute_Stochastic.clcpp -I"../Distributions" -I"/home/deb/Documents/OpenCL-Graph/build/_deps/randomcl_repo-src/generators" -I"$(pwd)" -o SIR_Compute_Stochastic.spv
