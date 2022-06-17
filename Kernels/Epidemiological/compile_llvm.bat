clear
clang -c -target spirv64 -cl-kernel-arg-info -cl-std=clc++2021 SIR_Bernoulli_Network.clcpp -I"../Distributions" -I "C:\Users\jonas\Documents\OpenCL-Graph\build\_deps\randomcl_repo-src\generators"  -DN_NETWORK_TIMESTEPS=100 -DN_NETWORK_VERTICES=100 -DN_NETWORK_EDGES=1000 -emit-llvm -o SIR_Bernoulli_Network.bc
clang -c -target spirv64 -cl-kernel-arg-info -cl-std=clc++2021 SIR_Compute_Stochastic.clcpp -I"../Distributions" -I"C:\Users\jonas\Documents\OpenCL-Graph\build\_deps\randomcl_repo-src\generators" -I"$(pwd)" -emit-llvm -o SIR_Compute_Stochastic.bc
