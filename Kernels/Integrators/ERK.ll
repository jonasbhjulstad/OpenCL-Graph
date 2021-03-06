; ModuleID = 'kernel.cpp'
source_filename = "kernel.cpp"
target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spirv32"

; Function Attrs: convergent mustprogress noinline norecurse nounwind optnone
define spir_kernel void @foo(float addrspace(1)* noundef align 4 %0) #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 !kernel_arg_name !8 {
  %2 = alloca float addrspace(1)*, align 4
  %3 = alloca i32, align 4
  store float addrspace(1)* %0, float addrspace(1)** %2, align 4
  store i32 0, i32* %3, align 4
  ret void
}

attributes #0 = { convergent mustprogress noinline norecurse nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "uniform-work-group-size"="true" }

!llvm.module.flags = !{!0, !1}
!opencl.ocl.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"frame-pointer", i32 2}
!2 = !{i32 3, i32 0}
!3 = !{!"clang version 15.0.0 (https://github.com/llvm/llvm-project.git f6366ef7f4f3cf1182fd70e0c50a9fa54374b612)"}
!4 = !{i32 1}
!5 = !{!"none"}
!6 = !{!"float*"}
!7 = !{!""}
!8 = !{!"x0"}
