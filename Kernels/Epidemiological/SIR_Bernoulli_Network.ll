; ModuleID = '/home/deb/Documents/OpenCL-Graph/Kernels/Epidemiological/SIR_Bernoulli_Network.clcpp'
source_filename = "/home/deb/Documents/OpenCL-Graph/Kernels/Epidemiological/SIR_Bernoulli_Network.clcpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.isaac_state = type { [256 x i32], [256 x i32], i32, i32, i32, i32 }
%struct.kiss99_state = type { i32, i32, i32, i32 }
%struct.lfib_state = type { [17 x i64], i8, i8 }
%struct.mrg31k3p_state = type { i32, i32, i32, i32, i32, i32 }
%struct.mrg63k3a_state = type { i64, i64, i64, i64, i64, i64 }
%struct.msws_state = type { %union.anon, i64 }
%union.anon = type { i64 }
%struct.mt19937_state = type { [624 x i32], i32 }
%struct.anon = type { i32, i32 }
%struct.ran2_state = type { i32, i32, i32, [32 x i32] }
%struct.TINYMT32WP_T = type { i32, i32, i32, i32, i32, i32, i32 }
%struct.anon.1 = type { i32, i32, i32, i32 }
%struct.well512_state = type { [16 x i32], i32 }

@__const._Z18_mt19937_loop_uintPU9CLgeneric13mt19937_state.mag01 = private unnamed_addr constant [2 x i32] [i32 0, i32 -1727483681], align 4
@tinymt32_mask = dso_local local_unnamed_addr constant i32 2147483647, align 4
@tinymt32_float_mask = dso_local local_unnamed_addr constant i32 1065353216, align 4
@.str = private unnamed_addr constant [27 x i8] c"t: %u, x_traj: %u, %u, %u\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%u\0A\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable
define dso_local void @_Z13isaac_advancePU9CLgeneric11isaac_state(ptr noundef %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 1
  %3 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 2
  %4 = load i32, ptr %3, align 4, !tbaa !7
  %5 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 3
  %6 = load i32, ptr %5, align 4, !tbaa !12
  %7 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 4
  %8 = load i32, ptr %7, align 4, !tbaa !13
  %9 = add i32 %8, 1
  store i32 %9, ptr %7, align 4, !tbaa !13
  %10 = add i32 %9, %6
  %11 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 1, i64 128
  br label %12

12:                                               ; preds = %1, %12
  %13 = phi i32 [ %4, %1 ], [ %83, %12 ]
  %14 = phi ptr [ %0, %1 ], [ %97, %12 ]
  %15 = phi ptr [ %11, %1 ], [ %81, %12 ]
  %16 = phi ptr [ %2, %1 ], [ %90, %12 ]
  %17 = phi i32 [ %10, %1 ], [ %96, %12 ]
  %18 = load i32, ptr %16, align 4, !tbaa !14
  %19 = shl i32 %13, 13
  %20 = xor i32 %19, %13
  %21 = getelementptr inbounds i32, ptr %15, i64 1
  %22 = load i32, ptr %15, align 4, !tbaa !14
  %23 = add i32 %22, %20
  %24 = and i32 %18, 1020
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds i8, ptr %2, i64 %25
  %27 = load i32, ptr %26, align 4, !tbaa !14
  %28 = add i32 %23, %17
  %29 = add i32 %28, %27
  %30 = getelementptr inbounds i32, ptr %16, i64 1
  store i32 %29, ptr %16, align 4, !tbaa !14
  %31 = lshr i32 %29, 8
  %32 = and i32 %31, 1020
  %33 = zext i32 %32 to i64
  %34 = getelementptr inbounds i8, ptr %2, i64 %33
  %35 = load i32, ptr %34, align 4, !tbaa !14
  %36 = add i32 %35, %18
  %37 = getelementptr inbounds i32, ptr %14, i64 1
  store i32 %36, ptr %14, align 4, !tbaa !14
  %38 = load i32, ptr %30, align 4, !tbaa !14
  %39 = lshr i32 %23, 6
  %40 = xor i32 %39, %23
  %41 = getelementptr inbounds i32, ptr %15, i64 2
  %42 = load i32, ptr %21, align 4, !tbaa !14
  %43 = add i32 %42, %40
  %44 = and i32 %38, 1020
  %45 = zext i32 %44 to i64
  %46 = getelementptr inbounds i8, ptr %2, i64 %45
  %47 = load i32, ptr %46, align 4, !tbaa !14
  %48 = add i32 %43, %36
  %49 = add i32 %48, %47
  %50 = getelementptr inbounds i32, ptr %16, i64 2
  store i32 %49, ptr %30, align 4, !tbaa !14
  %51 = lshr i32 %49, 8
  %52 = and i32 %51, 1020
  %53 = zext i32 %52 to i64
  %54 = getelementptr inbounds i8, ptr %2, i64 %53
  %55 = load i32, ptr %54, align 4, !tbaa !14
  %56 = add i32 %55, %38
  %57 = getelementptr inbounds i32, ptr %14, i64 2
  store i32 %56, ptr %37, align 4, !tbaa !14
  %58 = load i32, ptr %50, align 4, !tbaa !14
  %59 = shl i32 %43, 2
  %60 = xor i32 %59, %43
  %61 = getelementptr inbounds i32, ptr %15, i64 3
  %62 = load i32, ptr %41, align 4, !tbaa !14
  %63 = add i32 %62, %60
  %64 = and i32 %58, 1020
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds i8, ptr %2, i64 %65
  %67 = load i32, ptr %66, align 4, !tbaa !14
  %68 = add i32 %63, %56
  %69 = add i32 %68, %67
  %70 = getelementptr inbounds i32, ptr %16, i64 3
  store i32 %69, ptr %50, align 4, !tbaa !14
  %71 = lshr i32 %69, 8
  %72 = and i32 %71, 1020
  %73 = zext i32 %72 to i64
  %74 = getelementptr inbounds i8, ptr %2, i64 %73
  %75 = load i32, ptr %74, align 4, !tbaa !14
  %76 = add i32 %75, %58
  %77 = getelementptr inbounds i32, ptr %14, i64 3
  store i32 %76, ptr %57, align 4, !tbaa !14
  %78 = load i32, ptr %70, align 4, !tbaa !14
  %79 = lshr i32 %63, 16
  %80 = xor i32 %79, %63
  %81 = getelementptr inbounds i32, ptr %15, i64 4
  %82 = load i32, ptr %61, align 4, !tbaa !14
  %83 = add i32 %82, %80
  %84 = and i32 %78, 1020
  %85 = zext i32 %84 to i64
  %86 = getelementptr inbounds i8, ptr %2, i64 %85
  %87 = load i32, ptr %86, align 4, !tbaa !14
  %88 = add i32 %83, %76
  %89 = add i32 %88, %87
  %90 = getelementptr inbounds i32, ptr %16, i64 4
  store i32 %89, ptr %70, align 4, !tbaa !14
  %91 = lshr i32 %89, 8
  %92 = and i32 %91, 1020
  %93 = zext i32 %92 to i64
  %94 = getelementptr inbounds i8, ptr %2, i64 %93
  %95 = load i32, ptr %94, align 4, !tbaa !14
  %96 = add i32 %95, %78
  %97 = getelementptr inbounds i32, ptr %14, i64 4
  store i32 %96, ptr %77, align 4, !tbaa !14
  %98 = icmp ult ptr %90, %11
  br i1 %98, label %12, label %99, !llvm.loop !15

99:                                               ; preds = %12, %99
  %100 = phi i32 [ %170, %99 ], [ %83, %12 ]
  %101 = phi ptr [ %184, %99 ], [ %97, %12 ]
  %102 = phi ptr [ %168, %99 ], [ %2, %12 ]
  %103 = phi ptr [ %177, %99 ], [ %90, %12 ]
  %104 = phi i32 [ %183, %99 ], [ %96, %12 ]
  %105 = load i32, ptr %103, align 4, !tbaa !14
  %106 = shl i32 %100, 13
  %107 = xor i32 %106, %100
  %108 = getelementptr inbounds i32, ptr %102, i64 1
  %109 = load i32, ptr %102, align 4, !tbaa !14
  %110 = add i32 %109, %107
  %111 = and i32 %105, 1020
  %112 = zext i32 %111 to i64
  %113 = getelementptr inbounds i8, ptr %2, i64 %112
  %114 = load i32, ptr %113, align 4, !tbaa !14
  %115 = add i32 %110, %104
  %116 = add i32 %115, %114
  %117 = getelementptr inbounds i32, ptr %103, i64 1
  store i32 %116, ptr %103, align 4, !tbaa !14
  %118 = lshr i32 %116, 8
  %119 = and i32 %118, 1020
  %120 = zext i32 %119 to i64
  %121 = getelementptr inbounds i8, ptr %2, i64 %120
  %122 = load i32, ptr %121, align 4, !tbaa !14
  %123 = add i32 %122, %105
  %124 = getelementptr inbounds i32, ptr %101, i64 1
  store i32 %123, ptr %101, align 4, !tbaa !14
  %125 = load i32, ptr %117, align 4, !tbaa !14
  %126 = lshr i32 %110, 6
  %127 = xor i32 %126, %110
  %128 = getelementptr inbounds i32, ptr %102, i64 2
  %129 = load i32, ptr %108, align 4, !tbaa !14
  %130 = add i32 %129, %127
  %131 = and i32 %125, 1020
  %132 = zext i32 %131 to i64
  %133 = getelementptr inbounds i8, ptr %2, i64 %132
  %134 = load i32, ptr %133, align 4, !tbaa !14
  %135 = add i32 %130, %123
  %136 = add i32 %135, %134
  %137 = getelementptr inbounds i32, ptr %103, i64 2
  store i32 %136, ptr %117, align 4, !tbaa !14
  %138 = lshr i32 %136, 8
  %139 = and i32 %138, 1020
  %140 = zext i32 %139 to i64
  %141 = getelementptr inbounds i8, ptr %2, i64 %140
  %142 = load i32, ptr %141, align 4, !tbaa !14
  %143 = add i32 %142, %125
  %144 = getelementptr inbounds i32, ptr %101, i64 2
  store i32 %143, ptr %124, align 4, !tbaa !14
  %145 = load i32, ptr %137, align 4, !tbaa !14
  %146 = shl i32 %130, 2
  %147 = xor i32 %146, %130
  %148 = getelementptr inbounds i32, ptr %102, i64 3
  %149 = load i32, ptr %128, align 4, !tbaa !14
  %150 = add i32 %149, %147
  %151 = and i32 %145, 1020
  %152 = zext i32 %151 to i64
  %153 = getelementptr inbounds i8, ptr %2, i64 %152
  %154 = load i32, ptr %153, align 4, !tbaa !14
  %155 = add i32 %150, %143
  %156 = add i32 %155, %154
  %157 = getelementptr inbounds i32, ptr %103, i64 3
  store i32 %156, ptr %137, align 4, !tbaa !14
  %158 = lshr i32 %156, 8
  %159 = and i32 %158, 1020
  %160 = zext i32 %159 to i64
  %161 = getelementptr inbounds i8, ptr %2, i64 %160
  %162 = load i32, ptr %161, align 4, !tbaa !14
  %163 = add i32 %162, %145
  %164 = getelementptr inbounds i32, ptr %101, i64 3
  store i32 %163, ptr %144, align 4, !tbaa !14
  %165 = load i32, ptr %157, align 4, !tbaa !14
  %166 = lshr i32 %150, 16
  %167 = xor i32 %166, %150
  %168 = getelementptr inbounds i32, ptr %102, i64 4
  %169 = load i32, ptr %148, align 4, !tbaa !14
  %170 = add i32 %169, %167
  %171 = and i32 %165, 1020
  %172 = zext i32 %171 to i64
  %173 = getelementptr inbounds i8, ptr %2, i64 %172
  %174 = load i32, ptr %173, align 4, !tbaa !14
  %175 = add i32 %170, %163
  %176 = add i32 %175, %174
  %177 = getelementptr inbounds i32, ptr %103, i64 4
  store i32 %176, ptr %157, align 4, !tbaa !14
  %178 = lshr i32 %176, 8
  %179 = and i32 %178, 1020
  %180 = zext i32 %179 to i64
  %181 = getelementptr inbounds i8, ptr %2, i64 %180
  %182 = load i32, ptr %181, align 4, !tbaa !14
  %183 = add i32 %182, %165
  %184 = getelementptr inbounds i32, ptr %101, i64 4
  store i32 %183, ptr %164, align 4, !tbaa !14
  %185 = icmp ult ptr %168, %11
  br i1 %185, label %99, label %186, !llvm.loop !17

186:                                              ; preds = %99
  store i32 %183, ptr %5, align 4, !tbaa !12
  store i32 %170, ptr %3, align 4, !tbaa !7
  ret void
}

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: convergent mustprogress nofree norecurse nosync nounwind uwtable
define dso_local noundef i32 @_Z11_isaac_uintPU9CLgeneric11isaac_state(ptr noundef %0) local_unnamed_addr #2 {
  %2 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 5
  %3 = load i32, ptr %2, align 4, !tbaa !18
  %4 = icmp eq i32 %3, 256
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  tail call void @_Z13isaac_advancePU9CLgeneric11isaac_state(ptr noundef nonnull %0)
  br label %6

6:                                                ; preds = %5, %1
  %7 = phi i32 [ 0, %5 ], [ %3, %1 ]
  %8 = add i32 %7, 1
  store i32 %8, ptr %2, align 4, !tbaa !18
  %9 = zext i32 %7 to i64
  %10 = getelementptr inbounds [256 x i32], ptr %0, i64 0, i64 %9
  %11 = load i32, ptr %10, align 4, !tbaa !14
  ret i32 %11
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind writeonly uwtable
define dso_local void @_Z10isaac_seedPU9CLgeneric11isaac_statem(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #3 {
  %3 = trunc i64 %1 to i32
  %4 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 2
  store i32 %3, ptr %4, align 4, !tbaa !7
  %5 = xor i32 %3, 123456789
  %6 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 3
  store i32 %5, ptr %6, align 4, !tbaa !12
  %7 = add i32 %3, 123456789
  %8 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 4
  store i32 %7, ptr %8, align 4, !tbaa !13
  %9 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 5
  store i32 256, ptr %9, align 4, !tbaa !18
  br label %11

10:                                               ; preds = %11
  ret void

11:                                               ; preds = %11, %2
  %12 = phi i64 [ 0, %2 ], [ %33, %11 ]
  %13 = phi i64 [ %1, %2 ], [ %30, %11 ]
  %14 = mul i64 %13, 6906969069
  %15 = add i64 %14, 1234567
  %16 = trunc i64 %15 to i32
  %17 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 1, i64 %12
  store i32 %16, ptr %17, align 4, !tbaa !14
  %18 = or i64 %12, 1
  %19 = mul i64 %15, 6906969069
  %20 = add i64 %19, 1234567
  %21 = trunc i64 %20 to i32
  %22 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 1, i64 %18
  store i32 %21, ptr %22, align 4, !tbaa !14
  %23 = or i64 %12, 2
  %24 = mul i64 %20, 6906969069
  %25 = add i64 %24, 1234567
  %26 = trunc i64 %25 to i32
  %27 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 1, i64 %23
  store i32 %26, ptr %27, align 4, !tbaa !14
  %28 = or i64 %12, 3
  %29 = mul i64 %25, 6906969069
  %30 = add i64 %29, 1234567
  %31 = trunc i64 %30 to i32
  %32 = getelementptr inbounds %struct.isaac_state, ptr %0, i64 0, i32 1, i64 %28
  store i32 %31, ptr %32, align 4, !tbaa !14
  %33 = add nuw nsw i64 %12, 4
  %34 = icmp eq i64 %33, 256
  br i1 %34, label %10, label %11, !llvm.loop !19
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i32 @_Z12_kiss99_uintPU9CLgeneric12kiss99_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i32, ptr %0, align 4, !tbaa !20
  %3 = and i32 %2, 65535
  %4 = mul nuw i32 %3, 36969
  %5 = lshr i32 %2, 16
  %6 = add nuw i32 %4, %5
  store i32 %6, ptr %0, align 4, !tbaa !20
  %7 = getelementptr inbounds %struct.kiss99_state, ptr %0, i64 0, i32 1
  %8 = load i32, ptr %7, align 4, !tbaa !22
  %9 = and i32 %8, 65535
  %10 = mul nuw nsw i32 %9, 18000
  %11 = lshr i32 %8, 16
  %12 = add nuw nsw i32 %10, %11
  store i32 %12, ptr %7, align 4, !tbaa !22
  %13 = getelementptr inbounds %struct.kiss99_state, ptr %0, i64 0, i32 2
  %14 = load i32, ptr %13, align 4, !tbaa !23
  %15 = shl i32 %14, 17
  %16 = xor i32 %15, %14
  %17 = lshr i32 %16, 13
  %18 = xor i32 %17, %16
  %19 = shl i32 %18, 5
  %20 = xor i32 %19, %18
  store i32 %20, ptr %13, align 4, !tbaa !23
  %21 = getelementptr inbounds %struct.kiss99_state, ptr %0, i64 0, i32 3
  %22 = load i32, ptr %21, align 4, !tbaa !24
  %23 = mul i32 %22, 69069
  %24 = add i32 %23, 1234567
  store i32 %24, ptr %21, align 4, !tbaa !24
  %25 = shl i32 %6, 16
  %26 = add i32 %12, %25
  %27 = xor i32 %24, %26
  %28 = add i32 %20, %27
  ret i32 %28
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly uwtable
define dso_local void @_Z11kiss99_seedPU9CLgeneric12kiss99_statem(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #5 {
  %3 = trunc i64 %1 to i32
  %4 = xor i32 %3, 362436069
  %5 = icmp eq i32 %4, 0
  %6 = select i1 %5, i32 1, i32 %4
  store i32 %6, ptr %0, align 4, !tbaa !20
  %7 = lshr i64 %1, 32
  %8 = trunc i64 %7 to i32
  %9 = xor i32 %8, 521288629
  %10 = getelementptr inbounds %struct.kiss99_state, ptr %0, i64 0, i32 1
  %11 = icmp eq i32 %9, 0
  %12 = select i1 %11, i32 1, i32 %9
  store i32 %12, ptr %10, align 4, !tbaa !22
  %13 = xor i32 %3, 123456789
  %14 = icmp eq i32 %13, 0
  %15 = select i1 %14, i32 1, i32 %13
  %16 = getelementptr inbounds %struct.kiss99_state, ptr %0, i64 0, i32 2
  store i32 %15, ptr %16, align 4, !tbaa !23
  %17 = xor i32 %8, 380116160
  %18 = getelementptr inbounds %struct.kiss99_state, ptr %0, i64 0, i32 3
  store i32 %17, ptr %18, align 4, !tbaa !24
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i32 @_Z13_lcg6432_uintPU9CLgenericm(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i64, ptr %0, align 8, !tbaa !25
  %3 = mul i64 %2, 6364136223846793005
  %4 = add i64 %3, -2720673578348880933
  store i64 %4, ptr %0, align 8, !tbaa !25
  %5 = lshr i64 %4, 32
  %6 = trunc i64 %5 to i32
  ret i32 %6
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly uwtable
define dso_local void @_Z12lcg6432_seedPU9CLgenericmm(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #5 {
  store i64 %1, ptr %0, align 8, !tbaa !25
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z19_lfib_ternary_ulongPU9CLgeneric10lfib_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.lfib_state, ptr %0, i64 0, i32 1
  %3 = load i8, ptr %2, align 8, !tbaa !27
  %4 = add i8 %3, -1
  %5 = icmp sgt i8 %4, -1
  %6 = select i1 %5, i8 %4, i8 16
  store i8 %6, ptr %2, align 8, !tbaa !27
  %7 = getelementptr inbounds %struct.lfib_state, ptr %0, i64 0, i32 2
  %8 = load i8, ptr %7, align 1, !tbaa !29
  %9 = add i8 %8, -1
  %10 = icmp sgt i8 %9, -1
  %11 = select i1 %10, i8 %9, i8 16
  store i8 %11, ptr %7, align 1, !tbaa !29
  %12 = zext i8 %11 to i64
  %13 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 %12
  %14 = load i64, ptr %13, align 8, !tbaa !25
  %15 = zext i8 %6 to i64
  %16 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 %15
  %17 = load i64, ptr %16, align 8, !tbaa !25
  %18 = mul i64 %17, %14
  store i64 %18, ptr %16, align 8, !tbaa !25
  ret i64 %18
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z11_lfib_ulongPU9CLgeneric10lfib_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.lfib_state, ptr %0, i64 0, i32 1
  %3 = load i8, ptr %2, align 8, !tbaa !27
  %4 = add i8 %3, -1
  %5 = icmp slt i8 %4, 0
  %6 = select i1 %5, i8 16, i8 %4
  store i8 %6, ptr %2, align 8, !tbaa !27
  %7 = getelementptr inbounds %struct.lfib_state, ptr %0, i64 0, i32 2
  %8 = load i8, ptr %7, align 1, !tbaa !29
  %9 = add i8 %8, -1
  %10 = icmp slt i8 %9, 0
  %11 = select i1 %10, i8 16, i8 %9
  store i8 %11, ptr %7, align 1, !tbaa !29
  %12 = zext i8 %11 to i64
  %13 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 %12
  %14 = load i64, ptr %13, align 8, !tbaa !25
  %15 = zext i8 %6 to i64
  %16 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 %15
  %17 = load i64, ptr %16, align 8, !tbaa !25
  %18 = mul i64 %17, %14
  store i64 %18, ptr %16, align 8, !tbaa !25
  ret i64 %18
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z15_lfib_inc_ulongPU9CLgeneric10lfib_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.lfib_state, ptr %0, i64 0, i32 1
  %3 = load i8, ptr %2, align 8, !tbaa !27
  %4 = add i8 %3, 1
  %5 = srem i8 %4, 17
  store i8 %5, ptr %2, align 8, !tbaa !27
  %6 = getelementptr inbounds %struct.lfib_state, ptr %0, i64 0, i32 2
  %7 = load i8, ptr %6, align 1, !tbaa !29
  %8 = add i8 %7, 1
  %9 = srem i8 %8, 5
  store i8 %9, ptr %6, align 1, !tbaa !29
  %10 = sext i8 %9 to i64
  %11 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 %10
  %12 = load i64, ptr %11, align 8, !tbaa !25
  %13 = sext i8 %5 to i64
  %14 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 %13
  %15 = load i64, ptr %14, align 8, !tbaa !25
  %16 = mul i64 %15, %12
  store i64 %16, ptr %14, align 8, !tbaa !25
  ret i64 %16
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind writeonly uwtable
define dso_local void @_Z9lfib_seedPU9CLgeneric10lfib_statem(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #3 {
  %3 = getelementptr inbounds %struct.lfib_state, ptr %0, i64 0, i32 1
  store i8 17, ptr %3, align 8, !tbaa !27
  %4 = getelementptr inbounds %struct.lfib_state, ptr %0, i64 0, i32 2
  store i8 5, ptr %4, align 1, !tbaa !29
  %5 = mul i64 %1, 6906969069
  %6 = add i64 %5, 1234567
  %7 = or i64 %6, 1
  store i64 %7, ptr %0, align 8, !tbaa !25
  %8 = mul i64 %6, 6906969069
  %9 = add i64 %8, 1234567
  %10 = or i64 %9, 1
  %11 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 1
  store i64 %10, ptr %11, align 8, !tbaa !25
  %12 = mul i64 %9, 6906969069
  %13 = add i64 %12, 1234567
  %14 = or i64 %13, 1
  %15 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 2
  store i64 %14, ptr %15, align 8, !tbaa !25
  %16 = mul i64 %13, 6906969069
  %17 = add i64 %16, 1234567
  %18 = or i64 %17, 1
  %19 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 3
  store i64 %18, ptr %19, align 8, !tbaa !25
  %20 = mul i64 %17, 6906969069
  %21 = add i64 %20, 1234567
  %22 = or i64 %21, 1
  %23 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 4
  store i64 %22, ptr %23, align 8, !tbaa !25
  %24 = mul i64 %21, 6906969069
  %25 = add i64 %24, 1234567
  %26 = or i64 %25, 1
  %27 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 5
  store i64 %26, ptr %27, align 8, !tbaa !25
  %28 = mul i64 %25, 6906969069
  %29 = add i64 %28, 1234567
  %30 = or i64 %29, 1
  %31 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 6
  store i64 %30, ptr %31, align 8, !tbaa !25
  %32 = mul i64 %29, 6906969069
  %33 = add i64 %32, 1234567
  %34 = or i64 %33, 1
  %35 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 7
  store i64 %34, ptr %35, align 8, !tbaa !25
  %36 = mul i64 %33, 6906969069
  %37 = add i64 %36, 1234567
  %38 = or i64 %37, 1
  %39 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 8
  store i64 %38, ptr %39, align 8, !tbaa !25
  %40 = mul i64 %37, 6906969069
  %41 = add i64 %40, 1234567
  %42 = or i64 %41, 1
  %43 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 9
  store i64 %42, ptr %43, align 8, !tbaa !25
  %44 = mul i64 %41, 6906969069
  %45 = add i64 %44, 1234567
  %46 = or i64 %45, 1
  %47 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 10
  store i64 %46, ptr %47, align 8, !tbaa !25
  %48 = mul i64 %45, 6906969069
  %49 = add i64 %48, 1234567
  %50 = or i64 %49, 1
  %51 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 11
  store i64 %50, ptr %51, align 8, !tbaa !25
  %52 = mul i64 %49, 6906969069
  %53 = add i64 %52, 1234567
  %54 = or i64 %53, 1
  %55 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 12
  store i64 %54, ptr %55, align 8, !tbaa !25
  %56 = mul i64 %53, 6906969069
  %57 = add i64 %56, 1234567
  %58 = or i64 %57, 1
  %59 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 13
  store i64 %58, ptr %59, align 8, !tbaa !25
  %60 = mul i64 %57, 6906969069
  %61 = add i64 %60, 1234567
  %62 = or i64 %61, 1
  %63 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 14
  store i64 %62, ptr %63, align 8, !tbaa !25
  %64 = mul i64 %61, 6906969069
  %65 = add i64 %64, 1234567
  %66 = or i64 %65, 1
  %67 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 15
  store i64 %66, ptr %67, align 8, !tbaa !25
  %68 = mul i64 %65, 6906969069
  %69 = add i64 %68, 1234567
  %70 = or i64 %69, 1
  %71 = getelementptr inbounds [17 x i64], ptr %0, i64 0, i64 16
  store i64 %70, ptr %71, align 8, !tbaa !25
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i32 @_Z14_mrg31k3p_uintPU9CLgeneric14mrg31k3p_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 1
  %3 = load i32, ptr %2, align 4, !tbaa !30
  %4 = shl i32 %3, 22
  %5 = and i32 %4, 2143289344
  %6 = lshr i32 %3, 9
  %7 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 2
  %8 = load i32, ptr %7, align 4, !tbaa !32
  %9 = shl i32 %8, 7
  %10 = and i32 %9, 2147483520
  %11 = lshr i32 %8, 24
  %12 = add nuw i32 %5, %6
  %13 = add nuw i32 %12, %11
  %14 = add i32 %13, %10
  %15 = icmp slt i32 %14, 0
  %16 = add i32 %14, -2147483647
  %17 = select i1 %15, i32 %16, i32 %14
  %18 = add i32 %17, %8
  %19 = icmp slt i32 %18, 0
  %20 = add i32 %18, -2147483647
  %21 = select i1 %19, i32 %20, i32 %18
  store i32 %3, ptr %7, align 4, !tbaa !32
  %22 = load i32, ptr %0, align 4, !tbaa !33
  store i32 %22, ptr %2, align 4, !tbaa !30
  store i32 %21, ptr %0, align 4, !tbaa !33
  %23 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 3
  %24 = load i32, ptr %23, align 4, !tbaa !34
  %25 = shl i32 %24, 15
  %26 = and i32 %25, 2147450880
  %27 = lshr i32 %24, 16
  %28 = mul nuw nsw i32 %27, 21069
  %29 = add nuw i32 %26, %28
  %30 = icmp ugt i32 %29, 2147462579
  %31 = add i32 %29, -2147462579
  %32 = select i1 %30, i32 %31, i32 %29
  %33 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 5
  %34 = load i32, ptr %33, align 4, !tbaa !35
  %35 = shl i32 %34, 15
  %36 = and i32 %35, 2147450880
  %37 = lshr i32 %34, 16
  %38 = mul nuw nsw i32 %37, 21069
  %39 = add nuw i32 %36, %38
  %40 = icmp ugt i32 %39, 2147462579
  %41 = add i32 %39, -2147462579
  %42 = select i1 %40, i32 %41, i32 %39
  %43 = add i32 %42, %34
  %44 = icmp ugt i32 %43, 2147462579
  %45 = add i32 %43, -2147462579
  %46 = select i1 %44, i32 %45, i32 %43
  %47 = add nuw i32 %46, %32
  %48 = icmp ugt i32 %47, 2147462579
  %49 = add i32 %47, -2147462579
  %50 = select i1 %48, i32 %49, i32 %47
  %51 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 4
  %52 = load i32, ptr %51, align 4, !tbaa !36
  store i32 %52, ptr %33, align 4, !tbaa !35
  store i32 %24, ptr %51, align 4, !tbaa !36
  store i32 %50, ptr %23, align 4, !tbaa !34
  %53 = icmp ugt i32 %21, %50
  %54 = sub i32 %21, %50
  %55 = add i32 %54, 2147483647
  %56 = select i1 %53, i32 %54, i32 %55
  ret i32 %56
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local void @_Z13mrg31k3p_seedPU9CLgeneric14mrg31k3p_statem(ptr nocapture noundef %0, i64 noundef %1) local_unnamed_addr #4 {
  %3 = trunc i64 %1 to i32
  store i32 %3, ptr %0, align 4, !tbaa !33
  %4 = lshr i32 %3, 5
  %5 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 1
  store i32 %4, ptr %5, align 4, !tbaa !30
  %6 = lshr i32 %3, 11
  %7 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 2
  store i32 %6, ptr %7, align 4, !tbaa !32
  %8 = lshr i32 %3, 22
  %9 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 3
  store i32 %8, ptr %9, align 4, !tbaa !34
  %10 = lshr i32 %3, 30
  %11 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 4
  store i32 %10, ptr %11, align 4, !tbaa !36
  %12 = lshr i32 %3, 1
  %13 = getelementptr inbounds %struct.mrg31k3p_state, ptr %0, i64 0, i32 5
  store i32 %12, ptr %13, align 4, !tbaa !35
  %14 = icmp eq i64 %1, 0
  br i1 %14, label %15, label %18

15:                                               ; preds = %2
  %16 = add nuw nsw i32 %3, 1
  store i32 %16, ptr %0, align 4, !tbaa !33
  %17 = add nuw nsw i32 %10, 1
  store i32 %17, ptr %11, align 4, !tbaa !36
  br label %28

18:                                               ; preds = %2
  %19 = icmp slt i32 %3, 0
  br i1 %19, label %20, label %28

20:                                               ; preds = %18
  %21 = add i32 %3, -2147483647
  store i32 %21, ptr %0, align 4, !tbaa !33
  %22 = icmp ugt i32 %3, -42137
  br i1 %22, label %23, label %28

23:                                               ; preds = %20
  %24 = add nsw i32 %12, -2147462579
  store i32 %24, ptr %13, align 4, !tbaa !35
  %25 = icmp slt i32 %21, 0
  br i1 %25, label %26, label %28

26:                                               ; preds = %23
  %27 = add i32 %3, 2
  store i32 %27, ptr %0, align 4, !tbaa !33
  br label %28

28:                                               ; preds = %18, %15, %20, %26, %23
  %29 = phi i32 [ %24, %26 ], [ %24, %23 ], [ %12, %20 ], [ %12, %15 ], [ %12, %18 ]
  %30 = icmp ugt i32 %29, 2147462579
  br i1 %30, label %31, label %33

31:                                               ; preds = %28
  %32 = add i32 %29, -2147462579
  store i32 %32, ptr %13, align 4, !tbaa !35
  br label %33

33:                                               ; preds = %31, %28
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z16mrg63k3a_advancePU9CLgeneric14mrg63k3a_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i64, ptr %0, align 8, !tbaa !37
  %3 = sdiv i64 %2, 2898513661
  %4 = mul nsw i64 %3, -2898513661
  %5 = add i64 %4, %2
  %6 = mul nsw i64 %5, 3182104042
  %7 = mul nsw i64 %3, -394451401
  %8 = add i64 %6, %7
  %9 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 1
  %10 = load i64, ptr %9, align 8, !tbaa !39
  %11 = sdiv i64 %10, 5256471877
  %12 = mul nsw i64 %11, -5256471877
  %13 = add i64 %12, %10
  %14 = mul nsw i64 %13, 1754669720
  %15 = mul nsw i64 %11, -251304723
  %16 = add i64 %14, %15
  %17 = icmp slt i64 %8, 0
  %18 = add nsw i64 %8, 9223372036854769163
  %19 = select i1 %17, i64 %18, i64 %8
  %20 = icmp slt i64 %16, 0
  %21 = select i1 %20, i64 9223372036854769163, i64 0
  %22 = sub i64 %21, %19
  %23 = add i64 %22, %16
  %24 = icmp slt i64 %23, 0
  %25 = add nsw i64 %23, 9223372036854769163
  %26 = select i1 %24, i64 %25, i64 %23
  store i64 %10, ptr %0, align 8, !tbaa !37
  %27 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 2
  %28 = load i64, ptr %27, align 8, !tbaa !40
  store i64 %28, ptr %9, align 8, !tbaa !39
  store i64 %26, ptr %27, align 8, !tbaa !40
  %29 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 3
  %30 = load i64, ptr %29, align 8, !tbaa !41
  %31 = sdiv i64 %30, 1487847900
  %32 = mul nsw i64 %31, -1487847900
  %33 = add i64 %32, %30
  %34 = mul nsw i64 %33, 6199136374
  %35 = mul nsw i64 %31, -985240079
  %36 = add i64 %34, %35
  %37 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 5
  %38 = load i64, ptr %37, align 8, !tbaa !42
  %39 = sdiv i64 %38, 293855150
  %40 = mul nsw i64 %39, -293855150
  %41 = add i64 %40, %38
  %42 = mul nsw i64 %41, 31387477935
  %43 = mul nsw i64 %39, -143639429
  %44 = add i64 %42, %43
  %45 = icmp slt i64 %36, 0
  %46 = add nsw i64 %36, 9223372036854754679
  %47 = select i1 %45, i64 %46, i64 %36
  %48 = icmp slt i64 %44, 0
  %49 = select i1 %48, i64 9223372036854754679, i64 0
  %50 = sub i64 %49, %47
  %51 = add i64 %50, %44
  %52 = icmp slt i64 %51, 0
  %53 = add nsw i64 %51, 9223372036854754679
  %54 = select i1 %52, i64 %53, i64 %51
  %55 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 4
  %56 = load i64, ptr %55, align 8, !tbaa !43
  store i64 %56, ptr %29, align 8, !tbaa !41
  store i64 %38, ptr %55, align 8, !tbaa !43
  store i64 %54, ptr %37, align 8, !tbaa !42
  %57 = icmp sgt i64 %26, %54
  %58 = sub nsw i64 %26, %54
  %59 = add nsw i64 %58, 9223372036854769163
  %60 = select i1 %57, i64 %58, i64 %59
  ret i64 %60
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z15_mrg63k3a_ulongPU9CLgeneric14mrg63k3a_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i64, ptr %0, align 8, !tbaa !37
  %3 = sdiv i64 %2, 2898513661
  %4 = mul nsw i64 %3, -2898513661
  %5 = add i64 %4, %2
  %6 = mul nsw i64 %5, 3182104042
  %7 = mul nsw i64 %3, -394451401
  %8 = add i64 %6, %7
  %9 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 1
  %10 = load i64, ptr %9, align 8, !tbaa !39
  %11 = sdiv i64 %10, 5256471877
  %12 = mul nsw i64 %11, -5256471877
  %13 = add i64 %12, %10
  %14 = mul nsw i64 %13, 1754669720
  %15 = mul nsw i64 %11, -251304723
  %16 = add i64 %14, %15
  %17 = icmp slt i64 %8, 0
  %18 = add nsw i64 %8, 9223372036854769163
  %19 = select i1 %17, i64 %18, i64 %8
  %20 = icmp slt i64 %16, 0
  %21 = select i1 %20, i64 9223372036854769163, i64 0
  %22 = sub i64 %21, %19
  %23 = add i64 %22, %16
  %24 = icmp slt i64 %23, 0
  %25 = add nsw i64 %23, 9223372036854769163
  %26 = select i1 %24, i64 %25, i64 %23
  store i64 %10, ptr %0, align 8, !tbaa !37
  %27 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 2
  %28 = load i64, ptr %27, align 8, !tbaa !40
  store i64 %28, ptr %9, align 8, !tbaa !39
  store i64 %26, ptr %27, align 8, !tbaa !40
  %29 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 3
  %30 = load i64, ptr %29, align 8, !tbaa !41
  %31 = sdiv i64 %30, 1487847900
  %32 = mul nsw i64 %31, -1487847900
  %33 = add i64 %32, %30
  %34 = mul nsw i64 %33, 6199136374
  %35 = mul nsw i64 %31, -985240079
  %36 = add i64 %34, %35
  %37 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 5
  %38 = load i64, ptr %37, align 8, !tbaa !42
  %39 = sdiv i64 %38, 293855150
  %40 = mul nsw i64 %39, -293855150
  %41 = add i64 %40, %38
  %42 = mul nsw i64 %41, 31387477935
  %43 = mul nsw i64 %39, -143639429
  %44 = add i64 %42, %43
  %45 = icmp slt i64 %36, 0
  %46 = add nsw i64 %36, 9223372036854754679
  %47 = select i1 %45, i64 %46, i64 %36
  %48 = icmp slt i64 %44, 0
  %49 = select i1 %48, i64 9223372036854754679, i64 0
  %50 = sub i64 %49, %47
  %51 = add i64 %50, %44
  %52 = icmp slt i64 %51, 0
  %53 = add nsw i64 %51, 9223372036854754679
  %54 = select i1 %52, i64 %53, i64 %51
  %55 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 4
  %56 = load i64, ptr %55, align 8, !tbaa !43
  store i64 %56, ptr %29, align 8, !tbaa !41
  store i64 %38, ptr %55, align 8, !tbaa !43
  store i64 %54, ptr %37, align 8, !tbaa !42
  %57 = icmp sgt i64 %26, %54
  %58 = sub nsw i64 %26, %54
  %59 = shl i64 %58, 1
  %60 = add i64 %59, -13290
  %61 = select i1 %57, i64 %59, i64 %60
  ret i64 %61
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local void @_Z13mrg63k3a_seedPU9CLgeneric14mrg63k3a_statem(ptr nocapture noundef %0, i64 noundef %1) local_unnamed_addr #4 {
  store i64 %1, ptr %0, align 8, !tbaa !37
  %3 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 1
  store i64 %1, ptr %3, align 8, !tbaa !39
  %4 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 2
  store i64 %1, ptr %4, align 8, !tbaa !40
  %5 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 3
  store i64 %1, ptr %5, align 8, !tbaa !41
  %6 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 4
  store i64 %1, ptr %6, align 8, !tbaa !43
  %7 = getelementptr inbounds %struct.mrg63k3a_state, ptr %0, i64 0, i32 5
  store i64 %1, ptr %7, align 8, !tbaa !42
  %8 = icmp eq i64 %1, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  store i64 1, ptr %0, align 8, !tbaa !37
  store i64 1, ptr %6, align 8, !tbaa !43
  br label %10

10:                                               ; preds = %9, %2
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z11_msws_ulongPU9CLgeneric10msws_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i64, ptr %0, align 8, !tbaa !44
  %3 = mul i64 %2, %2
  %4 = getelementptr inbounds %struct.msws_state, ptr %0, i64 0, i32 1
  %5 = load i64, ptr %4, align 8, !tbaa !45
  %6 = add i64 %5, -5355537731544096087
  store i64 %6, ptr %4, align 8, !tbaa !45
  %7 = add i64 %6, %3
  %8 = tail call i64 @llvm.fshl.i64(i64 %7, i64 %7, i64 32)
  store i64 %8, ptr %0, align 8, !tbaa !44
  ret i64 %8
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z16_msws_swap_ulongPU9CLgeneric10msws_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i64, ptr %0, align 8, !tbaa !44
  %3 = mul i64 %2, %2
  %4 = getelementptr inbounds %struct.msws_state, ptr %0, i64 0, i32 1
  %5 = load i64, ptr %4, align 8, !tbaa !45
  %6 = add i64 %5, -5355537731544096087
  store i64 %6, ptr %4, align 8, !tbaa !45
  %7 = add i64 %6, %3
  %8 = bitcast i64 %7 to <2 x i32>
  %9 = shufflevector <2 x i32> %8, <2 x i32> poison, <2 x i32> <i32 1, i32 0>
  store <2 x i32> %9, ptr %0, align 8, !tbaa !44
  %10 = bitcast <2 x i32> %9 to i64
  ret i64 %10
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z17_msws_swap2_ulongPU9CLgeneric10msws_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i64, ptr %0, align 8, !tbaa !44
  %3 = mul i64 %2, %2
  %4 = getelementptr inbounds %struct.msws_state, ptr %0, i64 0, i32 1
  %5 = load i64, ptr %4, align 8, !tbaa !45
  %6 = add i64 %5, -5355537731544096087
  store i64 %6, ptr %4, align 8, !tbaa !45
  %7 = add i64 %6, %3
  %8 = trunc i64 %7 to i32
  %9 = lshr i64 %7, 32
  %10 = trunc i64 %9 to i32
  %11 = insertelement <2 x i32> poison, i32 %10, i64 0
  %12 = insertelement <2 x i32> %11, i32 %8, i64 1
  store <2 x i32> %12, ptr %0, align 8
  %13 = bitcast <2 x i32> %12 to i64
  ret i64 %13
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly uwtable
define dso_local void @_Z9msws_seedPU9CLgeneric10msws_statem(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #5 {
  store i64 %1, ptr %0, align 8, !tbaa !44
  %3 = getelementptr inbounds %struct.msws_state, ptr %0, i64 0, i32 1
  store i64 %1, ptr %3, align 8, !tbaa !45
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i32 @_Z13_mt19937_uintPU9CLgeneric13mt19937_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.mt19937_state, ptr %0, i64 0, i32 1
  %3 = load i32, ptr %2, align 4, !tbaa !47
  %4 = icmp slt i32 %3, 227
  br i1 %4, label %5, label %27

5:                                                ; preds = %1
  %6 = sext i32 %3 to i64
  %7 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %6
  %8 = load i32, ptr %7, align 4, !tbaa !14
  %9 = and i32 %8, -2147483648
  %10 = add nsw i32 %3, 1
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %11
  %13 = load i32, ptr %12, align 4, !tbaa !14
  %14 = and i32 %13, 2147483646
  %15 = or i32 %14, %9
  %16 = add nsw i32 %3, 397
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %17
  %19 = load i32, ptr %18, align 4, !tbaa !14
  %20 = lshr exact i32 %15, 1
  %21 = and i32 %13, 1
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds [2 x i32], ptr @__const._Z18_mt19937_loop_uintPU9CLgeneric13mt19937_state.mag01, i64 0, i64 %22
  %24 = load i32, ptr %23, align 4, !tbaa !14
  %25 = xor i32 %24, %19
  %26 = xor i32 %25, %20
  store i32 %26, ptr %7, align 4, !tbaa !14
  br label %67

27:                                               ; preds = %1
  %28 = icmp ult i32 %3, 623
  br i1 %28, label %29, label %51

29:                                               ; preds = %27
  %30 = zext i32 %3 to i64
  %31 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %30
  %32 = load i32, ptr %31, align 4, !tbaa !14
  %33 = and i32 %32, -2147483648
  %34 = add nuw nsw i32 %3, 1
  %35 = zext i32 %34 to i64
  %36 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %35
  %37 = load i32, ptr %36, align 4, !tbaa !14
  %38 = and i32 %37, 2147483646
  %39 = or i32 %38, %33
  %40 = add nsw i32 %3, -227
  %41 = zext i32 %40 to i64
  %42 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %41
  %43 = load i32, ptr %42, align 4, !tbaa !14
  %44 = lshr exact i32 %39, 1
  %45 = and i32 %37, 1
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds [2 x i32], ptr @__const._Z18_mt19937_loop_uintPU9CLgeneric13mt19937_state.mag01, i64 0, i64 %46
  %48 = load i32, ptr %47, align 4, !tbaa !14
  %49 = xor i32 %48, %43
  %50 = xor i32 %49, %44
  store i32 %50, ptr %31, align 4, !tbaa !14
  br label %67

51:                                               ; preds = %27
  %52 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 623
  %53 = load i32, ptr %52, align 4, !tbaa !14
  %54 = and i32 %53, -2147483648
  %55 = load i32, ptr %0, align 4, !tbaa !14
  %56 = and i32 %55, 2147483646
  %57 = or i32 %56, %54
  %58 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 396
  %59 = load i32, ptr %58, align 4, !tbaa !14
  %60 = lshr exact i32 %57, 1
  %61 = and i32 %55, 1
  %62 = zext i32 %61 to i64
  %63 = getelementptr inbounds [2 x i32], ptr @__const._Z18_mt19937_loop_uintPU9CLgeneric13mt19937_state.mag01, i64 0, i64 %62
  %64 = load i32, ptr %63, align 4, !tbaa !14
  %65 = xor i32 %64, %59
  %66 = xor i32 %65, %60
  store i32 %66, ptr %52, align 4, !tbaa !14
  store i32 0, ptr %2, align 4, !tbaa !47
  br label %67

67:                                               ; preds = %29, %51, %5
  %68 = load i32, ptr %2, align 4, !tbaa !47
  %69 = add nsw i32 %68, 1
  store i32 %69, ptr %2, align 4, !tbaa !47
  %70 = sext i32 %68 to i64
  %71 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %70
  %72 = load i32, ptr %71, align 4, !tbaa !14
  %73 = lshr i32 %72, 11
  %74 = xor i32 %73, %72
  %75 = shl i32 %74, 7
  %76 = and i32 %75, -1658038656
  %77 = xor i32 %76, %74
  %78 = shl i32 %77, 15
  %79 = and i32 %78, -272236544
  %80 = xor i32 %79, %77
  %81 = lshr i32 %80, 18
  %82 = xor i32 %81, %80
  ret i32 %82
}

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind uwtable
define dso_local noundef i32 @_Z18_mt19937_loop_uintPU9CLgeneric13mt19937_state(ptr nocapture noundef %0) local_unnamed_addr #7 {
  %2 = getelementptr inbounds %struct.mt19937_state, ptr %0, i64 0, i32 1
  %3 = load i32, ptr %2, align 4, !tbaa !47
  %4 = icmp sgt i32 %3, 623
  br i1 %4, label %5, label %68

5:                                                ; preds = %1
  %6 = load i32, ptr %0, align 4, !tbaa !14
  br label %10

7:                                                ; preds = %10
  %8 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 227
  %9 = load i32, ptr %8, align 4, !tbaa !14
  br label %31

10:                                               ; preds = %5, %10
  %11 = phi i32 [ %6, %5 ], [ %17, %10 ]
  %12 = phi i64 [ 0, %5 ], [ %15, %10 ]
  %13 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %12
  %14 = and i32 %11, -2147483648
  %15 = add nuw nsw i64 %12, 1
  %16 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %15
  %17 = load i32, ptr %16, align 4, !tbaa !14
  %18 = and i32 %17, 2147483646
  %19 = or i32 %18, %14
  %20 = add nuw nsw i64 %12, 397
  %21 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %20
  %22 = load i32, ptr %21, align 4, !tbaa !14
  %23 = lshr exact i32 %19, 1
  %24 = and i32 %17, 1
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds [2 x i32], ptr @__const._Z18_mt19937_loop_uintPU9CLgeneric13mt19937_state.mag01, i64 0, i64 %25
  %27 = load i32, ptr %26, align 4, !tbaa !14
  %28 = xor i32 %27, %22
  %29 = xor i32 %28, %23
  store i32 %29, ptr %13, align 4, !tbaa !14
  %30 = icmp eq i64 %15, 227
  br i1 %30, label %7, label %10, !llvm.loop !49

31:                                               ; preds = %7, %31
  %32 = phi i32 [ %9, %7 ], [ %38, %31 ]
  %33 = phi i64 [ 227, %7 ], [ %36, %31 ]
  %34 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %33
  %35 = and i32 %32, -2147483648
  %36 = add nuw nsw i64 %33, 1
  %37 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %36
  %38 = load i32, ptr %37, align 4, !tbaa !14
  %39 = and i32 %38, 2147483646
  %40 = or i32 %39, %35
  %41 = add nsw i64 %33, -227
  %42 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %41
  %43 = load i32, ptr %42, align 4, !tbaa !14
  %44 = lshr exact i32 %40, 1
  %45 = and i32 %38, 1
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds [2 x i32], ptr @__const._Z18_mt19937_loop_uintPU9CLgeneric13mt19937_state.mag01, i64 0, i64 %46
  %48 = load i32, ptr %47, align 4, !tbaa !14
  %49 = xor i32 %48, %43
  %50 = xor i32 %49, %44
  store i32 %50, ptr %34, align 4, !tbaa !14
  %51 = icmp eq i64 %36, 623
  br i1 %51, label %52, label %31, !llvm.loop !50

52:                                               ; preds = %31
  %53 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 623
  %54 = load i32, ptr %53, align 4, !tbaa !14
  %55 = and i32 %54, -2147483648
  %56 = load i32, ptr %0, align 4, !tbaa !14
  %57 = and i32 %56, 2147483646
  %58 = or i32 %57, %55
  %59 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 396
  %60 = load i32, ptr %59, align 4, !tbaa !14
  %61 = lshr exact i32 %58, 1
  %62 = and i32 %56, 1
  %63 = zext i32 %62 to i64
  %64 = getelementptr inbounds [2 x i32], ptr @__const._Z18_mt19937_loop_uintPU9CLgeneric13mt19937_state.mag01, i64 0, i64 %63
  %65 = load i32, ptr %64, align 4, !tbaa !14
  %66 = xor i32 %65, %60
  %67 = xor i32 %66, %61
  store i32 %67, ptr %53, align 4, !tbaa !14
  br label %68

68:                                               ; preds = %52, %1
  %69 = phi i32 [ 0, %52 ], [ %3, %1 ]
  %70 = add nsw i32 %69, 1
  store i32 %70, ptr %2, align 4, !tbaa !47
  %71 = sext i32 %69 to i64
  %72 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %71
  %73 = load i32, ptr %72, align 4, !tbaa !14
  %74 = lshr i32 %73, 11
  %75 = xor i32 %74, %73
  %76 = shl i32 %75, 7
  %77 = and i32 %76, -1658038656
  %78 = xor i32 %77, %75
  %79 = shl i32 %78, 15
  %80 = and i32 %79, -272236544
  %81 = xor i32 %80, %78
  %82 = lshr i32 %81, 18
  %83 = xor i32 %82, %81
  ret i32 %83
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind uwtable
define dso_local void @_Z12mt19937_seedPU9CLgeneric13mt19937_statej(ptr nocapture noundef %0, i32 noundef %1) local_unnamed_addr #7 {
  store i32 %1, ptr %0, align 4, !tbaa !14
  br label %3

3:                                                ; preds = %14, %2
  %4 = phi i32 [ %1, %2 ], [ %19, %14 ]
  %5 = phi i64 [ 1, %2 ], [ %21, %14 ]
  %6 = lshr i32 %4, 30
  %7 = xor i32 %6, %4
  %8 = mul i32 %7, 1812433253
  %9 = trunc i64 %5 to i32
  %10 = add i32 %8, %9
  %11 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %5
  store i32 %10, ptr %11, align 4, !tbaa !14
  %12 = add nuw nsw i64 %5, 1
  %13 = icmp eq i64 %12, 624
  br i1 %13, label %22, label %14, !llvm.loop !51

14:                                               ; preds = %3
  %15 = lshr i32 %10, 30
  %16 = xor i32 %15, %10
  %17 = mul i32 %16, 1812433253
  %18 = trunc i64 %12 to i32
  %19 = add i32 %17, %18
  %20 = getelementptr inbounds [624 x i32], ptr %0, i64 0, i64 %12
  store i32 %19, ptr %20, align 4, !tbaa !14
  %21 = add nuw nsw i64 %5, 2
  br label %3

22:                                               ; preds = %3
  %23 = getelementptr inbounds %struct.mt19937_state, ptr %0, i64 0, i32 1
  store i32 624, ptr %23, align 4, !tbaa !47
  ret void
}

; Function Attrs: argmemonly convergent mustprogress nofree norecurse nounwind willreturn uwtable
define dso_local noundef i32 @_Z12_mwc64x_uintPU9CLgeneric12mwc64x_state(ptr nocapture noundef %0) local_unnamed_addr #8 {
  %2 = load i32, ptr %0, align 8, !tbaa !44
  %3 = getelementptr inbounds %struct.anon, ptr %0, i64 0, i32 1
  %4 = load i32, ptr %3, align 4, !tbaa !44
  %5 = xor i32 %4, %2
  %6 = mul i32 %2, -83941
  %7 = add i32 %6, %4
  %8 = icmp ult i32 %7, %4
  %9 = zext i1 %8 to i32
  %10 = tail call noundef i32 @_Z6mad_hijjj(i32 noundef -83941, i32 noundef %2, i32 noundef %9) #16
  store i32 %7, ptr %0, align 8, !tbaa !44
  store i32 %10, ptr %3, align 4, !tbaa !44
  ret i32 %5
}

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare noundef i32 @_Z6mad_hijjj(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly uwtable
define dso_local void @_Z11mwc64x_seedPU9CLgeneric12mwc64x_statem(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #5 {
  store i64 %1, ptr %0, align 8, !tbaa !44
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i32 @_Z13_pcg6432_uintPU9CLgenericm(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i64, ptr %0, align 8, !tbaa !25
  %3 = mul i64 %2, 6364136223846793005
  %4 = add i64 %3, -2720673578348880933
  store i64 %4, ptr %0, align 8, !tbaa !25
  %5 = lshr i64 %2, 45
  %6 = lshr i64 %2, 27
  %7 = xor i64 %5, %6
  %8 = trunc i64 %7 to i32
  %9 = lshr i64 %2, 59
  %10 = trunc i64 %9 to i32
  %11 = lshr i32 %8, %10
  %12 = sub nsw i32 0, %10
  %13 = and i32 %12, 31
  %14 = shl i32 %8, %13
  %15 = or i32 %11, %14
  ret i32 %15
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly uwtable
define dso_local void @_Z12pcg6432_seedPU9CLgenericmm(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #5 {
  store i64 %1, ptr %0, align 8, !tbaa !25
  ret void
}

; Function Attrs: convergent mustprogress nofree norecurse nounwind readnone willreturn uwtable
define dso_local noundef i64 @_Z13philox2x32_1019philox2x32_10_statej(i64 %0, i32 noundef %1) local_unnamed_addr #10 {
  %3 = trunc i64 %0 to i32
  %4 = lshr i64 %0, 32
  %5 = trunc i64 %4 to i32
  %6 = mul i32 %5, -766062189
  %7 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %5, i32 noundef -766062189) #16
  %8 = xor i32 %3, %1
  %9 = xor i32 %8, %7
  %10 = add i32 %1, -1640531527
  %11 = mul i32 %9, -766062189
  %12 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %9, i32 noundef -766062189) #16
  %13 = xor i32 %6, %10
  %14 = xor i32 %13, %12
  %15 = add i32 %1, 1013904242
  %16 = mul i32 %14, -766062189
  %17 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %14, i32 noundef -766062189) #16
  %18 = xor i32 %11, %15
  %19 = xor i32 %18, %17
  %20 = add i32 %1, -626627285
  %21 = mul i32 %19, -766062189
  %22 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %19, i32 noundef -766062189) #16
  %23 = xor i32 %16, %20
  %24 = xor i32 %23, %22
  %25 = add i32 %1, 2027808484
  %26 = mul i32 %24, -766062189
  %27 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %24, i32 noundef -766062189) #16
  %28 = xor i32 %21, %25
  %29 = xor i32 %28, %27
  %30 = add i32 %1, 387276957
  %31 = mul i32 %29, -766062189
  %32 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %29, i32 noundef -766062189) #16
  %33 = xor i32 %26, %30
  %34 = xor i32 %33, %32
  %35 = add i32 %1, -1253254570
  %36 = mul i32 %34, -766062189
  %37 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %34, i32 noundef -766062189) #16
  %38 = xor i32 %31, %35
  %39 = xor i32 %38, %37
  %40 = add i32 %1, 1401181199
  %41 = mul i32 %39, -766062189
  %42 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %39, i32 noundef -766062189) #16
  %43 = xor i32 %36, %40
  %44 = xor i32 %43, %42
  %45 = add i32 %1, -239350328
  %46 = mul i32 %44, -766062189
  %47 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %44, i32 noundef -766062189) #16
  %48 = xor i32 %41, %45
  %49 = xor i32 %48, %47
  %50 = add i32 %1, -1879881855
  %51 = mul i32 %49, -766062189
  %52 = tail call noundef i32 @_Z6mul_hijj(i32 noundef %49, i32 noundef -766062189) #16
  %53 = xor i32 %46, %50
  %54 = xor i32 %53, %52
  %55 = zext i32 %54 to i64
  %56 = shl nuw i64 %55, 32
  %57 = zext i32 %51 to i64
  %58 = or i64 %56, %57
  ret i64 %58
}

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare noundef i32 @_Z6mul_hijj(i32 noundef, i32 noundef) local_unnamed_addr #9

; Function Attrs: argmemonly convergent mustprogress nofree norecurse nounwind willreturn uwtable
define dso_local noundef i64 @_Z20_philox2x32_10_ulongPU9CLgeneric19philox2x32_10_state(ptr nocapture noundef %0) local_unnamed_addr #8 {
  %2 = load i64, ptr %0, align 8, !tbaa !44
  %3 = add i64 %2, 1
  store i64 %3, ptr %0, align 8, !tbaa !44
  %4 = tail call noundef i64 @_Z13philox2x32_1019philox2x32_10_statej(i64 %3, i32 noundef 12345) #17
  ret i64 %4
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly uwtable
define dso_local void @_Z18philox2x32_10_seedPU9CLgeneric19philox2x32_10_statem(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #5 {
  store i64 %1, ptr %0, align 8, !tbaa !44
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i64 @_Z10_ran2_uintPU9CLgeneric10ran2_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = load i32, ptr %0, align 4, !tbaa !52
  %3 = sdiv i32 %2, 53668
  %4 = mul nsw i32 %3, -53668
  %5 = add i32 %4, %2
  %6 = mul nsw i32 %5, 40014
  %7 = mul nsw i32 %3, -12211
  %8 = add i32 %6, %7
  %9 = icmp slt i32 %8, 0
  %10 = add nsw i32 %8, 2147483563
  %11 = select i1 %9, i32 %10, i32 %8
  store i32 %11, ptr %0, align 4, !tbaa !52
  %12 = getelementptr inbounds %struct.ran2_state, ptr %0, i64 0, i32 1
  %13 = load i32, ptr %12, align 4, !tbaa !54
  %14 = sdiv i32 %13, 52774
  %15 = mul nsw i32 %14, -52774
  %16 = add i32 %15, %13
  %17 = mul nsw i32 %16, 40692
  %18 = mul nsw i32 %14, -3791
  %19 = add i32 %17, %18
  %20 = icmp slt i32 %19, 0
  %21 = add nsw i32 %19, 2147483399
  %22 = select i1 %20, i32 %21, i32 %19
  store i32 %22, ptr %12, align 4, !tbaa !54
  %23 = getelementptr inbounds %struct.ran2_state, ptr %0, i64 0, i32 2
  %24 = load i32, ptr %23, align 4, !tbaa !55
  %25 = sdiv i32 %24, 67108862
  %26 = zext i32 %25 to i64
  %27 = shl i64 %26, 48
  %28 = ashr exact i64 %27, 48
  %29 = getelementptr inbounds %struct.ran2_state, ptr %0, i64 0, i32 3, i64 %28
  %30 = load i32, ptr %29, align 4, !tbaa !14
  %31 = sub nsw i32 %30, %22
  store i32 %31, ptr %23, align 4, !tbaa !55
  store i32 %11, ptr %29, align 4, !tbaa !14
  %32 = load i32, ptr %23, align 4, !tbaa !55
  %33 = icmp slt i32 %32, 1
  br i1 %33, label %34, label %36

34:                                               ; preds = %1
  %35 = add nsw i32 %32, 2147483562
  store i32 %35, ptr %23, align 4, !tbaa !55
  br label %36

36:                                               ; preds = %34, %1
  %37 = phi i32 [ %35, %34 ], [ %32, %1 ]
  %38 = sext i32 %37 to i64
  ret i64 %38
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind uwtable
define dso_local void @_Z9ran2_seedPU9CLgeneric10ran2_statem(ptr nocapture noundef %0, i64 noundef %1) local_unnamed_addr #7 {
  %3 = icmp eq i64 %1, 0
  %4 = select i1 %3, i64 1, i64 %1
  %5 = trunc i64 %4 to i32
  %6 = lshr i64 %4, 32
  %7 = trunc i64 %6 to i32
  %8 = getelementptr inbounds %struct.ran2_state, ptr %0, i64 0, i32 1
  store i32 %7, ptr %8, align 4, !tbaa !54
  br label %13

9:                                                ; preds = %31
  %10 = getelementptr inbounds %struct.ran2_state, ptr %0, i64 0, i32 3
  %11 = load i32, ptr %10, align 4, !tbaa !14
  %12 = getelementptr inbounds %struct.ran2_state, ptr %0, i64 0, i32 2
  store i32 %11, ptr %12, align 4, !tbaa !55
  ret void

13:                                               ; preds = %2, %31
  %14 = phi i32 [ %5, %2 ], [ %32, %31 ]
  %15 = phi i64 [ 39, %2 ], [ %33, %31 ]
  %16 = sdiv i32 %14, 53668
  %17 = shl i32 %16, 16
  %18 = ashr exact i32 %17, 16
  %19 = mul nsw i32 %18, -53668
  %20 = add i32 %19, %14
  %21 = mul nsw i32 %20, 40014
  %22 = mul nsw i32 %18, -12211
  %23 = add i32 %21, %22
  %24 = icmp slt i32 %23, 0
  %25 = add nsw i32 %23, 2147483563
  %26 = select i1 %24, i32 %25, i32 %23
  store i32 %26, ptr %0, align 4, !tbaa !52
  %27 = icmp ult i64 %15, 32
  br i1 %27, label %28, label %31

28:                                               ; preds = %13
  %29 = getelementptr inbounds %struct.ran2_state, ptr %0, i64 0, i32 3, i64 %15
  store i32 %26, ptr %29, align 4, !tbaa !14
  %30 = load i32, ptr %0, align 4, !tbaa !52
  br label %31

31:                                               ; preds = %28, %13
  %32 = phi i32 [ %30, %28 ], [ %26, %13 ]
  %33 = add nsw i64 %15, -1
  %34 = icmp eq i64 %15, 0
  br i1 %34, label %9, label %13, !llvm.loop !56
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local void @_Z13tinymt32_seedPU9CLgeneric12TINYMT32WP_Tm(ptr nocapture noundef %0, i64 noundef %1) local_unnamed_addr #4 {
  %3 = getelementptr inbounds %struct.TINYMT32WP_T, ptr %0, i64 0, i32 4
  store i32 -1888480786, ptr %3, align 4, !tbaa !57
  %4 = getelementptr inbounds %struct.TINYMT32WP_T, ptr %0, i64 0, i32 5
  store i32 -59179233, ptr %4, align 4, !tbaa !59
  %5 = getelementptr inbounds %struct.TINYMT32WP_T, ptr %0, i64 0, i32 6
  store i32 932445695, ptr %5, align 4, !tbaa !60
  %6 = trunc i64 %1 to i32
  %7 = lshr i32 %6, 30
  %8 = xor i32 %7, %6
  %9 = mul i32 %8, 1812433253
  %10 = add i32 %9, 1
  %11 = xor i32 %10, -1888480786
  %12 = lshr i32 %11, 30
  %13 = xor i32 %12, %11
  %14 = mul i32 %13, 1812433253
  %15 = add i32 %14, 2
  %16 = xor i32 %15, -59179233
  %17 = lshr i32 %16, 30
  %18 = xor i32 %17, %16
  %19 = mul i32 %18, 1812433253
  %20 = add i32 %19, 3
  %21 = xor i32 %20, 932445695
  %22 = lshr i32 %20, 30
  %23 = xor i32 %22, %21
  %24 = mul i32 %23, 1812433253
  %25 = add i32 %24, 4
  %26 = xor i32 %25, %6
  %27 = lshr i32 %26, 30
  %28 = xor i32 %27, %26
  %29 = mul i32 %28, 1812433253
  %30 = add i32 %29, 5
  %31 = xor i32 %30, %11
  %32 = lshr i32 %31, 30
  %33 = xor i32 %32, %31
  %34 = mul i32 %33, 1812433253
  %35 = add i32 %34, 6
  %36 = xor i32 %35, %16
  %37 = lshr i32 %36, 30
  %38 = xor i32 %37, %36
  %39 = mul i32 %38, 1812433253
  %40 = add i32 %39, 7
  %41 = xor i32 %40, %21
  %42 = and i32 %26, 2147483647
  %43 = icmp eq i32 %42, 0
  %44 = icmp eq i32 %31, 0
  %45 = select i1 %43, i1 %44, i1 false
  %46 = icmp eq i32 %36, 0
  %47 = select i1 %45, i1 %46, i1 false
  %48 = icmp eq i32 %41, 0
  %49 = select i1 %47, i1 %48, i1 false
  br i1 %49, label %50, label %51

50:                                               ; preds = %2
  br label %51

51:                                               ; preds = %2, %50
  %52 = phi i32 [ %41, %2 ], [ 89, %50 ]
  %53 = phi i32 [ %36, %2 ], [ 78, %50 ]
  %54 = phi i32 [ %31, %2 ], [ 73, %50 ]
  %55 = phi i32 [ %26, %2 ], [ 84, %50 ]
  %56 = getelementptr inbounds %struct.TINYMT32WP_T, ptr %0, i64 0, i32 3
  %57 = getelementptr inbounds %struct.TINYMT32WP_T, ptr %0, i64 0, i32 2
  %58 = getelementptr inbounds %struct.TINYMT32WP_T, ptr %0, i64 0, i32 1
  %59 = and i32 %55, 2147483647
  %60 = xor i32 %54, %53
  %61 = xor i32 %60, %59
  %62 = shl i32 %61, 1
  %63 = xor i32 %62, %61
  %64 = lshr i32 %52, 1
  %65 = xor i32 %64, %52
  %66 = xor i32 %65, %63
  %67 = shl i32 %66, 10
  %68 = xor i32 %67, %63
  %69 = and i32 %66, 1
  %70 = icmp eq i32 %69, 0
  %71 = select i1 %70, i32 0, i32 -59179233
  %72 = xor i32 %68, %71
  %73 = select i1 %70, i32 0, i32 -1888480786
  %74 = xor i32 %73, %53
  %75 = and i32 %54, 2147483647
  %76 = xor i32 %74, %75
  %77 = xor i32 %76, %72
  %78 = shl i32 %77, 1
  %79 = xor i32 %78, %77
  %80 = lshr i32 %66, 1
  %81 = xor i32 %80, %66
  %82 = xor i32 %81, %79
  %83 = shl i32 %82, 10
  %84 = xor i32 %83, %79
  %85 = and i32 %82, 1
  %86 = icmp eq i32 %85, 0
  %87 = select i1 %86, i32 0, i32 -59179233
  %88 = xor i32 %84, %87
  %89 = select i1 %86, i32 0, i32 -1888480786
  %90 = xor i32 %89, %72
  %91 = and i32 %74, 2147483647
  %92 = xor i32 %90, %91
  %93 = xor i32 %92, %88
  %94 = shl i32 %93, 1
  %95 = xor i32 %94, %93
  %96 = lshr i32 %82, 1
  %97 = xor i32 %96, %82
  %98 = xor i32 %97, %95
  %99 = shl i32 %98, 10
  %100 = xor i32 %99, %95
  %101 = and i32 %98, 1
  %102 = icmp eq i32 %101, 0
  %103 = select i1 %102, i32 0, i32 -59179233
  %104 = xor i32 %100, %103
  %105 = select i1 %102, i32 0, i32 -1888480786
  %106 = xor i32 %105, %88
  %107 = and i32 %90, 2147483647
  %108 = xor i32 %106, %107
  %109 = xor i32 %108, %104
  %110 = shl i32 %109, 1
  %111 = xor i32 %110, %109
  %112 = lshr i32 %98, 1
  %113 = xor i32 %112, %98
  %114 = xor i32 %113, %111
  %115 = shl i32 %114, 10
  %116 = xor i32 %115, %111
  %117 = and i32 %114, 1
  %118 = icmp eq i32 %117, 0
  %119 = select i1 %118, i32 0, i32 -59179233
  %120 = xor i32 %116, %119
  %121 = select i1 %118, i32 0, i32 -1888480786
  %122 = xor i32 %121, %104
  %123 = and i32 %106, 2147483647
  %124 = xor i32 %122, %123
  %125 = xor i32 %124, %120
  %126 = shl i32 %125, 1
  %127 = xor i32 %126, %125
  %128 = lshr i32 %114, 1
  %129 = xor i32 %128, %114
  %130 = xor i32 %129, %127
  %131 = shl i32 %130, 10
  %132 = xor i32 %131, %127
  %133 = and i32 %130, 1
  %134 = icmp eq i32 %133, 0
  %135 = select i1 %134, i32 0, i32 -59179233
  %136 = xor i32 %132, %135
  %137 = select i1 %134, i32 0, i32 -1888480786
  %138 = xor i32 %137, %120
  %139 = and i32 %122, 2147483647
  %140 = xor i32 %138, %139
  %141 = xor i32 %140, %136
  %142 = shl i32 %141, 1
  %143 = xor i32 %142, %141
  %144 = lshr i32 %130, 1
  %145 = xor i32 %144, %130
  %146 = xor i32 %145, %143
  %147 = shl i32 %146, 10
  %148 = xor i32 %147, %143
  %149 = and i32 %146, 1
  %150 = icmp eq i32 %149, 0
  %151 = select i1 %150, i32 0, i32 -59179233
  %152 = xor i32 %148, %151
  %153 = select i1 %150, i32 0, i32 -1888480786
  %154 = xor i32 %153, %136
  %155 = and i32 %138, 2147483647
  %156 = xor i32 %154, %155
  %157 = xor i32 %156, %152
  %158 = shl i32 %157, 1
  %159 = xor i32 %158, %157
  %160 = lshr i32 %146, 1
  %161 = xor i32 %160, %146
  %162 = xor i32 %161, %159
  %163 = shl i32 %162, 10
  %164 = xor i32 %163, %159
  %165 = and i32 %162, 1
  %166 = icmp eq i32 %165, 0
  %167 = select i1 %166, i32 0, i32 -59179233
  %168 = xor i32 %164, %167
  %169 = select i1 %166, i32 0, i32 -1888480786
  %170 = xor i32 %169, %152
  %171 = and i32 %154, 2147483647
  %172 = xor i32 %170, %171
  %173 = xor i32 %172, %168
  %174 = shl i32 %173, 1
  %175 = xor i32 %174, %173
  %176 = lshr i32 %162, 1
  %177 = xor i32 %176, %162
  %178 = xor i32 %177, %175
  %179 = shl i32 %178, 10
  %180 = xor i32 %179, %175
  %181 = and i32 %178, 1
  %182 = icmp eq i32 %181, 0
  %183 = select i1 %182, i32 0, i32 -59179233
  %184 = xor i32 %180, %183
  %185 = select i1 %182, i32 0, i32 -1888480786
  %186 = xor i32 %185, %168
  store i32 %170, ptr %0, align 4, !tbaa !61
  store i32 %186, ptr %58, align 4, !tbaa !62
  store i32 %184, ptr %57, align 4, !tbaa !63
  store i32 %178, ptr %56, align 4, !tbaa !64
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local void @_Z13tyche_advancePU9CLgeneric11tyche_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.anon.1, ptr %0, i64 0, i32 1
  %3 = load i32, ptr %2, align 4, !tbaa !44
  %4 = load i32, ptr %0, align 8, !tbaa !44
  %5 = add i32 %4, %3
  %6 = getelementptr inbounds %struct.anon.1, ptr %0, i64 0, i32 3
  %7 = load i32, ptr %6, align 4, !tbaa !44
  %8 = xor i32 %7, %5
  %9 = tail call i32 @llvm.fshl.i32(i32 %8, i32 %8, i32 16)
  %10 = getelementptr inbounds %struct.anon.1, ptr %0, i64 0, i32 2
  %11 = load i32, ptr %10, align 8, !tbaa !44
  %12 = add i32 %11, %9
  %13 = xor i32 %12, %3
  %14 = tail call i32 @llvm.fshl.i32(i32 %13, i32 %13, i32 12)
  %15 = add i32 %14, %5
  store i32 %15, ptr %0, align 8, !tbaa !44
  %16 = xor i32 %15, %9
  %17 = tail call i32 @llvm.fshl.i32(i32 %16, i32 %16, i32 8)
  store i32 %17, ptr %6, align 4, !tbaa !44
  %18 = add i32 %17, %12
  store i32 %18, ptr %10, align 8, !tbaa !44
  %19 = xor i32 %18, %14
  %20 = tail call i32 @llvm.fshl.i32(i32 %19, i32 %19, i32 7)
  store i32 %20, ptr %2, align 4, !tbaa !44
  ret void
}

; Function Attrs: argmemonly convergent mustprogress nofree norecurse nounwind uwtable
define dso_local void @_Z10tyche_seedPU9CLgeneric11tyche_statem(ptr nocapture noundef %0, i64 noundef %1) local_unnamed_addr #11 {
  %3 = lshr i64 %1, 32
  %4 = trunc i64 %3 to i32
  %5 = trunc i64 %1 to i32
  %6 = tail call noundef i64 @_Z13get_global_idj(i32 noundef 0) #16
  %7 = tail call noundef i64 @_Z15get_global_sizej(i32 noundef 0) #16
  %8 = tail call noundef i64 @_Z13get_global_idj(i32 noundef 1) #16
  %9 = tail call noundef i64 @_Z15get_global_sizej(i32 noundef 1) #16
  %10 = tail call noundef i64 @_Z13get_global_idj(i32 noundef 2) #16
  %11 = mul i64 %10, %9
  %12 = add i64 %11, %8
  %13 = mul i64 %12, %7
  %14 = add i64 %13, %6
  %15 = trunc i64 %14 to i32
  %16 = xor i32 %15, 1367130551
  br label %21

17:                                               ; preds = %21
  %18 = getelementptr inbounds %struct.anon.1, ptr %0, i64 0, i32 3
  %19 = getelementptr inbounds %struct.anon.1, ptr %0, i64 0, i32 2
  %20 = getelementptr inbounds %struct.anon.1, ptr %0, i64 0, i32 1
  store i32 %50, ptr %20, align 4, !tbaa !44
  store i32 %45, ptr %0, align 8, !tbaa !44
  store i32 %47, ptr %18, align 4, !tbaa !44
  store i32 %48, ptr %19, align 8, !tbaa !44
  ret void

21:                                               ; preds = %21, %2
  %22 = phi i32 [ 0, %2 ], [ %51, %21 ]
  %23 = phi i32 [ %5, %2 ], [ %50, %21 ]
  %24 = phi i32 [ %4, %2 ], [ %45, %21 ]
  %25 = phi i32 [ %16, %2 ], [ %47, %21 ]
  %26 = phi i32 [ -1640531527, %2 ], [ %48, %21 ]
  %27 = add i32 %24, %23
  %28 = xor i32 %25, %27
  %29 = tail call i32 @llvm.fshl.i32(i32 %28, i32 %28, i32 16) #18
  %30 = add i32 %29, %26
  %31 = xor i32 %30, %23
  %32 = tail call i32 @llvm.fshl.i32(i32 %31, i32 %31, i32 12) #18
  %33 = add i32 %32, %27
  %34 = xor i32 %33, %29
  %35 = tail call i32 @llvm.fshl.i32(i32 %34, i32 %34, i32 8) #18
  %36 = add i32 %35, %30
  %37 = xor i32 %36, %32
  %38 = tail call i32 @llvm.fshl.i32(i32 %37, i32 %37, i32 7) #18
  %39 = add i32 %33, %38
  %40 = xor i32 %35, %39
  %41 = tail call i32 @llvm.fshl.i32(i32 %40, i32 %40, i32 16) #18
  %42 = add i32 %41, %36
  %43 = xor i32 %42, %38
  %44 = tail call i32 @llvm.fshl.i32(i32 %43, i32 %43, i32 12) #18
  %45 = add i32 %44, %39
  %46 = xor i32 %45, %41
  %47 = tail call i32 @llvm.fshl.i32(i32 %46, i32 %46, i32 8) #18
  %48 = add i32 %47, %42
  %49 = xor i32 %48, %44
  %50 = tail call i32 @llvm.fshl.i32(i32 %49, i32 %49, i32 7) #18
  %51 = add nuw nsw i32 %22, 2
  %52 = icmp eq i32 %51, 20
  br i1 %52, label %17, label %21, !llvm.loop !65
}

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare noundef i64 @_Z13get_global_idj(i32 noundef) local_unnamed_addr #9

; Function Attrs: convergent mustprogress nofree nounwind readnone willreturn
declare noundef i64 @_Z15get_global_sizej(i32 noundef) local_unnamed_addr #9

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable
define dso_local noundef i32 @_Z13_well512_uintPU9CLgeneric13well512_state(ptr nocapture noundef %0) local_unnamed_addr #4 {
  %2 = getelementptr inbounds %struct.well512_state, ptr %0, i64 0, i32 1
  %3 = load i32, ptr %2, align 4, !tbaa !66
  %4 = add i32 %3, 15
  %5 = and i32 %4, 15
  %6 = zext i32 %5 to i64
  %7 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 %6
  %8 = load i32, ptr %7, align 4, !tbaa !14
  %9 = zext i32 %3 to i64
  %10 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 %9
  %11 = load i32, ptr %10, align 4, !tbaa !14
  %12 = shl i32 %11, 16
  %13 = add i32 %3, 13
  %14 = and i32 %13, 15
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 %15
  %17 = load i32, ptr %16, align 4, !tbaa !14
  %18 = shl i32 %17, 15
  %19 = xor i32 %12, %11
  %20 = xor i32 %19, %17
  %21 = xor i32 %20, %18
  %22 = add i32 %3, 9
  %23 = and i32 %22, 15
  %24 = zext i32 %23 to i64
  %25 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 %24
  %26 = load i32, ptr %25, align 4, !tbaa !14
  %27 = lshr i32 %26, 11
  %28 = xor i32 %27, %26
  %29 = xor i32 %28, %21
  store i32 %29, ptr %10, align 4, !tbaa !14
  %30 = shl i32 %8, 2
  %31 = shl i32 %20, 18
  %32 = shl i32 %28, 28
  %33 = load i32, ptr %2, align 4, !tbaa !66
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 %34
  %36 = load i32, ptr %35, align 4, !tbaa !14
  %37 = shl i32 %36, 5
  %38 = and i32 %37, -633066208
  %39 = xor i32 %30, %8
  %40 = xor i32 %39, %21
  %41 = xor i32 %40, %31
  %42 = xor i32 %41, %32
  %43 = xor i32 %42, %36
  %44 = xor i32 %43, %38
  %45 = add i32 %33, 15
  %46 = and i32 %45, 15
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 %47
  store i32 %44, ptr %48, align 4, !tbaa !14
  store i32 %46, ptr %2, align 4, !tbaa !66
  ret i32 %44
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind writeonly uwtable
define dso_local void @_Z12well512_seedPU9CLgeneric13well512_statem(ptr nocapture noundef writeonly %0, i64 noundef %1) local_unnamed_addr #3 {
  %3 = getelementptr inbounds %struct.well512_state, ptr %0, i64 0, i32 1
  store i32 0, ptr %3, align 4, !tbaa !66
  %4 = mul i64 %1, 6906969069
  %5 = add i64 %4, 1234567
  %6 = trunc i64 %5 to i32
  store i32 %6, ptr %0, align 4, !tbaa !14
  %7 = lshr i64 %5, 32
  %8 = trunc i64 %7 to i32
  %9 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 1
  store i32 %8, ptr %9, align 4, !tbaa !14
  %10 = mul i64 %5, 6906969069
  %11 = add i64 %10, 1234567
  %12 = trunc i64 %11 to i32
  %13 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 2
  store i32 %12, ptr %13, align 4, !tbaa !14
  %14 = lshr i64 %11, 32
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 3
  store i32 %15, ptr %16, align 4, !tbaa !14
  %17 = mul i64 %11, 6906969069
  %18 = add i64 %17, 1234567
  %19 = trunc i64 %18 to i32
  %20 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 4
  store i32 %19, ptr %20, align 4, !tbaa !14
  %21 = lshr i64 %18, 32
  %22 = trunc i64 %21 to i32
  %23 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 5
  store i32 %22, ptr %23, align 4, !tbaa !14
  %24 = mul i64 %18, 6906969069
  %25 = add i64 %24, 1234567
  %26 = trunc i64 %25 to i32
  %27 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 6
  store i32 %26, ptr %27, align 4, !tbaa !14
  %28 = lshr i64 %25, 32
  %29 = trunc i64 %28 to i32
  %30 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 7
  store i32 %29, ptr %30, align 4, !tbaa !14
  %31 = mul i64 %25, 6906969069
  %32 = add i64 %31, 1234567
  %33 = trunc i64 %32 to i32
  %34 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 8
  store i32 %33, ptr %34, align 4, !tbaa !14
  %35 = lshr i64 %32, 32
  %36 = trunc i64 %35 to i32
  %37 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 9
  store i32 %36, ptr %37, align 4, !tbaa !14
  %38 = mul i64 %32, 6906969069
  %39 = add i64 %38, 1234567
  %40 = trunc i64 %39 to i32
  %41 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 10
  store i32 %40, ptr %41, align 4, !tbaa !14
  %42 = lshr i64 %39, 32
  %43 = trunc i64 %42 to i32
  %44 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 11
  store i32 %43, ptr %44, align 4, !tbaa !14
  %45 = mul i64 %39, 6906969069
  %46 = add i64 %45, 1234567
  %47 = trunc i64 %46 to i32
  %48 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 12
  store i32 %47, ptr %48, align 4, !tbaa !14
  %49 = lshr i64 %46, 32
  %50 = trunc i64 %49 to i32
  %51 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 13
  store i32 %50, ptr %51, align 4, !tbaa !14
  %52 = mul i64 %46, 6906969069
  %53 = add i64 %52, 1234567
  %54 = trunc i64 %53 to i32
  %55 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 14
  store i32 %54, ptr %55, align 4, !tbaa !14
  %56 = lshr i64 %53, 32
  %57 = trunc i64 %56 to i32
  %58 = getelementptr inbounds [16 x i32], ptr %0, i64 0, i64 15
  store i32 %57, ptr %58, align 4, !tbaa !14
  ret void
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind uwtable
define dso_local void @_Z15countPopulationPU9CLgenericjS0_j(ptr nocapture noundef %0, ptr nocapture noundef readonly %1, i32 noundef %2) local_unnamed_addr #7 {
  %4 = mul i32 %2, 3
  %5 = add i32 %4, 2
  %6 = zext i32 %5 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  %8 = add i32 %4, 1
  %9 = zext i32 %8 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  %11 = zext i32 %4 to i64
  %12 = getelementptr inbounds i32, ptr %0, i64 %11
  br label %14

13:                                               ; preds = %34
  ret void

14:                                               ; preds = %34, %3
  %15 = phi i64 [ 0, %3 ], [ %35, %34 ]
  %16 = getelementptr inbounds i32, ptr %1, i64 %15
  %17 = load i32, ptr %16, align 4, !tbaa !14
  switch i32 %17, label %24 [
    i32 1, label %20
    i32 2, label %18
    i32 3, label %19
  ]

18:                                               ; preds = %14
  br label %20

19:                                               ; preds = %14
  br label %20

20:                                               ; preds = %14, %18, %19
  %21 = phi ptr [ %7, %19 ], [ %10, %18 ], [ %12, %14 ]
  %22 = load i32, ptr %21, align 4, !tbaa !14
  %23 = add i32 %22, 1
  store i32 %23, ptr %21, align 4, !tbaa !14
  br label %24

24:                                               ; preds = %20, %14
  %25 = or i64 %15, 1
  %26 = getelementptr inbounds i32, ptr %1, i64 %25
  %27 = load i32, ptr %26, align 4, !tbaa !14
  switch i32 %27, label %34 [
    i32 1, label %30
    i32 2, label %29
    i32 3, label %28
  ]

28:                                               ; preds = %24
  br label %30

29:                                               ; preds = %24
  br label %30

30:                                               ; preds = %29, %28, %24
  %31 = phi ptr [ %7, %28 ], [ %10, %29 ], [ %12, %24 ]
  %32 = load i32, ptr %31, align 4, !tbaa !14
  %33 = add i32 %32, 1
  store i32 %33, ptr %31, align 4, !tbaa !14
  br label %34

34:                                               ; preds = %30, %24
  %35 = add nuw nsw i64 %15, 2
  %36 = icmp eq i64 %35, 200
  br i1 %36, label %13, label %14, !llvm.loop !68
}

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @SIR_Compute_Network(ptr nocapture noundef readonly align 4 %0, ptr nocapture noundef readonly align 4 %1, ptr nocapture noundef readonly align 4 %2, float noundef %3, float noundef %4, ptr nocapture noundef readonly align 8 %5, ptr nocapture noundef writeonly align 4 %6, ptr nocapture noundef writeonly align 4 %7) local_unnamed_addr #12 !kernel_arg_addr_space !69 !kernel_arg_access_qual !70 !kernel_arg_type !71 !kernel_arg_base_type !71 !kernel_arg_type_qual !72 {
  %9 = alloca [300 x i32], align 16
  %10 = alloca [20200 x i32], align 16
  %11 = tail call noundef i64 @_Z13get_global_idj(i32 noundef 0) #16
  %12 = and i64 %11, 4294967295
  %13 = getelementptr inbounds i64, ptr %5, i64 %12
  %14 = load i64, ptr %13, align 8, !tbaa !25
  call void @llvm.lifetime.start.p0(i64 1200, ptr nonnull %9) #18
  call void @llvm.lifetime.start.p0(i64 80800, ptr nonnull %10) #18
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(800) %10, ptr noundef nonnull align 4 dereferenceable(800) %0, i64 800, i1 false), !tbaa !14
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(1200) %9, i8 0, i64 1200, i1 false), !tbaa !14
  %15 = trunc i64 %11 to i32
  %16 = icmp eq i32 %15, 1
  br label %25

17:                                               ; preds = %134
  %18 = mul i64 %11, 300
  %19 = and i64 %18, 4294967292
  %20 = getelementptr inbounds i32, ptr %7, i64 %19
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(1200) %20, ptr noundef nonnull align 16 dereferenceable(1200) %9, i64 1200, i1 false), !tbaa !14
  %21 = mul i64 %11, 20000
  %22 = and i64 %21, 4294967264
  %23 = getelementptr inbounds i32, ptr %6, i64 %22
  %24 = getelementptr inbounds [20200 x i32], ptr %10, i64 0, i64 200
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(80000) %23, ptr noundef nonnull align 16 dereferenceable(80000) %24, i64 80000, i1 false), !tbaa !14
  call void @llvm.lifetime.end.p0(i64 80800, ptr nonnull %10) #18
  call void @llvm.lifetime.end.p0(i64 1200, ptr nonnull %9) #18
  ret void

25:                                               ; preds = %8, %134
  %26 = phi i64 [ 0, %8 ], [ %30, %134 ]
  %27 = phi i64 [ %14, %8 ], [ %125, %134 ]
  %28 = mul nuw nsw i64 %26, 200
  %29 = getelementptr inbounds [20200 x i32], ptr %10, i64 0, i64 %28
  %30 = add nuw nsw i64 %26, 1
  %31 = mul nuw nsw i64 %30, 200
  %32 = getelementptr inbounds [20200 x i32], ptr %10, i64 0, i64 %31
  br label %33

33:                                               ; preds = %25, %55
  %34 = phi i64 [ 0, %25 ], [ %59, %55 ]
  %35 = phi i64 [ %27, %25 ], [ %57, %55 ]
  %36 = getelementptr inbounds i32, ptr %29, i64 %34
  %37 = load i32, ptr %36, align 4, !tbaa !14
  %38 = icmp eq i32 %37, 2
  br i1 %38, label %39, label %53

39:                                               ; preds = %33
  %40 = mul i64 %35, 6364136223846793005
  %41 = add i64 %40, -2720673578348880933
  %42 = lshr i64 %41, 32
  %43 = trunc i64 %42 to i32
  %44 = tail call noundef i32 (ptr, ...) @_Z6printfPU10CLconstantKcz(ptr noundef nonnull @.str.1, i32 noundef %43) #19
  %45 = mul i64 %41, 6364136223846793005
  %46 = add i64 %45, -2720673578348880933
  %47 = lshr i64 %46, 32
  %48 = trunc i64 %47 to i32
  %49 = uitofp i32 %48 to float
  %50 = fmul float %49, 0x3DF0000000000000
  %51 = fmul float %50, 0x3E00000000000000
  %52 = fcmp olt float %51, %4
  br i1 %52, label %55, label %53

53:                                               ; preds = %39, %33
  %54 = phi i64 [ %46, %39 ], [ %35, %33 ]
  br label %55

55:                                               ; preds = %39, %53
  %56 = phi i32 [ %37, %53 ], [ 3, %39 ]
  %57 = phi i64 [ %54, %53 ], [ %46, %39 ]
  %58 = getelementptr inbounds i32, ptr %32, i64 %34
  store i32 %56, ptr %58, align 4, !tbaa !14
  %59 = add nuw nsw i64 %34, 1
  %60 = icmp eq i64 %59, 200
  br i1 %60, label %92, label %33, !llvm.loop !73

61:                                               ; preds = %124
  %62 = mul nuw nsw i64 %26, 3
  %63 = add nuw nsw i64 %62, 2
  %64 = getelementptr inbounds i32, ptr %9, i64 %63
  %65 = add nuw nsw i64 %62, 1
  %66 = getelementptr inbounds i32, ptr %9, i64 %65
  %67 = getelementptr inbounds i32, ptr %9, i64 %62
  br label %68

68:                                               ; preds = %88, %61
  %69 = phi i64 [ 0, %61 ], [ %89, %88 ]
  %70 = getelementptr inbounds i32, ptr %32, i64 %69
  %71 = load i32, ptr %70, align 8, !tbaa !14
  switch i32 %71, label %78 [
    i32 1, label %74
    i32 2, label %72
    i32 3, label %73
  ]

72:                                               ; preds = %68
  br label %74

73:                                               ; preds = %68
  br label %74

74:                                               ; preds = %73, %72, %68
  %75 = phi ptr [ %64, %73 ], [ %66, %72 ], [ %67, %68 ]
  %76 = load i32, ptr %75, align 4, !tbaa !14
  %77 = add i32 %76, 1
  store i32 %77, ptr %75, align 4, !tbaa !14
  br label %78

78:                                               ; preds = %74, %68
  %79 = or i64 %69, 1
  %80 = getelementptr inbounds i32, ptr %32, i64 %79
  %81 = load i32, ptr %80, align 4, !tbaa !14
  switch i32 %81, label %88 [
    i32 1, label %84
    i32 2, label %83
    i32 3, label %82
  ]

82:                                               ; preds = %78
  br label %84

83:                                               ; preds = %78
  br label %84

84:                                               ; preds = %83, %82, %78
  %85 = phi ptr [ %64, %82 ], [ %66, %83 ], [ %67, %78 ]
  %86 = load i32, ptr %85, align 4, !tbaa !14
  %87 = add i32 %86, 1
  store i32 %87, ptr %85, align 4, !tbaa !14
  br label %88

88:                                               ; preds = %84, %78
  %89 = add nuw nsw i64 %69, 2
  %90 = icmp eq i64 %89, 200
  br i1 %90, label %91, label %68, !llvm.loop !68

91:                                               ; preds = %88
  br i1 %16, label %128, label %134

92:                                               ; preds = %55, %124
  %93 = phi i64 [ %126, %124 ], [ 0, %55 ]
  %94 = phi i64 [ %125, %124 ], [ %57, %55 ]
  %95 = getelementptr inbounds i32, ptr %1, i64 %93
  %96 = load i32, ptr %95, align 4, !tbaa !14
  %97 = zext i32 %96 to i64
  %98 = getelementptr inbounds i32, ptr %29, i64 %97
  %99 = getelementptr inbounds i32, ptr %2, i64 %93
  %100 = load i32, ptr %99, align 4, !tbaa !14
  %101 = zext i32 %100 to i64
  %102 = getelementptr inbounds i32, ptr %32, i64 %101
  %103 = load i32, ptr %98, align 4, !tbaa !14
  %104 = icmp eq i32 %103, 2
  br i1 %104, label %105, label %124

105:                                              ; preds = %92
  %106 = getelementptr inbounds i32, ptr %29, i64 %101
  %107 = load i32, ptr %106, align 4, !tbaa !14
  %108 = icmp eq i32 %107, 1
  br i1 %108, label %109, label %124

109:                                              ; preds = %105
  %110 = mul i64 %94, 6364136223846793005
  %111 = add i64 %110, -2720673578348880933
  %112 = lshr i64 %111, 32
  %113 = trunc i64 %112 to i32
  %114 = tail call noundef i32 (ptr, ...) @_Z6printfPU10CLconstantKcz(ptr noundef nonnull @.str.1, i32 noundef %113) #19
  %115 = mul i64 %111, 6364136223846793005
  %116 = add i64 %115, -2720673578348880933
  %117 = lshr i64 %116, 32
  %118 = trunc i64 %117 to i32
  %119 = uitofp i32 %118 to float
  %120 = fmul float %119, 0x3DF0000000000000
  %121 = fmul float %120, 0x3E00000000000000
  %122 = fcmp olt float %121, %3
  br i1 %122, label %123, label %124

123:                                              ; preds = %109
  store i32 2, ptr %102, align 4, !tbaa !14
  br label %124

124:                                              ; preds = %109, %123, %105, %92
  %125 = phi i64 [ %116, %123 ], [ %116, %109 ], [ %94, %105 ], [ %94, %92 ]
  %126 = add nuw nsw i64 %93, 1
  %127 = icmp eq i64 %126, 79600
  br i1 %127, label %61, label %92, !llvm.loop !74

128:                                              ; preds = %91
  %129 = load i32, ptr %67, align 4, !tbaa !14
  %130 = load i32, ptr %66, align 4, !tbaa !14
  %131 = load i32, ptr %64, align 4, !tbaa !14
  %132 = trunc i64 %26 to i32
  %133 = tail call noundef i32 (ptr, ...) @_Z6printfPU10CLconstantKcz(ptr noundef nonnull @.str, i32 noundef %132, i32 noundef %129, i32 noundef %130, i32 noundef %131) #19
  br label %134

134:                                              ; preds = %128, %91
  %135 = icmp eq i64 %30, 100
  br i1 %135, label %17, label %25, !llvm.loop !75
}

; Function Attrs: convergent
declare noundef i32 @_Z6printfPU10CLconstantKcz(ptr noundef, ...) local_unnamed_addr #13

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.fshl.i64(i64, i64, i64) #14

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.fshl.i32(i32, i32, i32) #14

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #15

attributes #0 = { mustprogress nofree norecurse nosync nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #2 = { convergent mustprogress nofree norecurse nosync nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly mustprogress nofree norecurse nosync nounwind writeonly uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly mustprogress nofree norecurse nosync nounwind willreturn uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { argmemonly mustprogress nofree norecurse nosync nounwind willreturn writeonly uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { argmemonly mustprogress nofree nounwind willreturn }
attributes #7 = { argmemonly mustprogress nofree norecurse nosync nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { argmemonly convergent mustprogress nofree norecurse nounwind willreturn uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { convergent mustprogress nofree nounwind readnone willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { convergent mustprogress nofree norecurse nounwind readnone willreturn uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { argmemonly convergent mustprogress nofree norecurse nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { convergent norecurse nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "uniform-work-group-size"="true" }
attributes #13 = { convergent "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #14 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #15 = { argmemonly nofree nounwind willreturn writeonly }
attributes #16 = { convergent nounwind readnone willreturn }
attributes #17 = { convergent }
attributes #18 = { nounwind }
attributes #19 = { convergent nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!opencl.ocl.version = !{!5}
!llvm.ident = !{!6}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{i32 3, i32 0}
!6 = !{!"clang version 15.0.0 (https://github.com/llvm/llvm-project.git f6366ef7f4f3cf1182fd70e0c50a9fa54374b612)"}
!7 = !{!8, !11, i64 2048}
!8 = !{!"_ZTS11isaac_state", !9, i64 0, !9, i64 1024, !11, i64 2048, !11, i64 2052, !11, i64 2056, !11, i64 2060}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C++ TBAA"}
!11 = !{!"int", !9, i64 0}
!12 = !{!8, !11, i64 2052}
!13 = !{!8, !11, i64 2056}
!14 = !{!11, !11, i64 0}
!15 = distinct !{!15, !16}
!16 = !{!"llvm.loop.mustprogress"}
!17 = distinct !{!17, !16}
!18 = !{!8, !11, i64 2060}
!19 = distinct !{!19, !16}
!20 = !{!21, !11, i64 0}
!21 = !{!"_ZTS12kiss99_state", !11, i64 0, !11, i64 4, !11, i64 8, !11, i64 12}
!22 = !{!21, !11, i64 4}
!23 = !{!21, !11, i64 8}
!24 = !{!21, !11, i64 12}
!25 = !{!26, !26, i64 0}
!26 = !{!"long", !9, i64 0}
!27 = !{!28, !9, i64 136}
!28 = !{!"_ZTS10lfib_state", !9, i64 0, !9, i64 136, !9, i64 137}
!29 = !{!28, !9, i64 137}
!30 = !{!31, !11, i64 4}
!31 = !{!"_ZTS14mrg31k3p_state", !11, i64 0, !11, i64 4, !11, i64 8, !11, i64 12, !11, i64 16, !11, i64 20}
!32 = !{!31, !11, i64 8}
!33 = !{!31, !11, i64 0}
!34 = !{!31, !11, i64 12}
!35 = !{!31, !11, i64 20}
!36 = !{!31, !11, i64 16}
!37 = !{!38, !26, i64 0}
!38 = !{!"_ZTS14mrg63k3a_state", !26, i64 0, !26, i64 8, !26, i64 16, !26, i64 24, !26, i64 32, !26, i64 40}
!39 = !{!38, !26, i64 8}
!40 = !{!38, !26, i64 16}
!41 = !{!38, !26, i64 24}
!42 = !{!38, !26, i64 40}
!43 = !{!38, !26, i64 32}
!44 = !{!9, !9, i64 0}
!45 = !{!46, !26, i64 8}
!46 = !{!"_ZTS10msws_state", !9, i64 0, !26, i64 8}
!47 = !{!48, !11, i64 2496}
!48 = !{!"_ZTS13mt19937_state", !9, i64 0, !11, i64 2496}
!49 = distinct !{!49, !16}
!50 = distinct !{!50, !16}
!51 = distinct !{!51, !16}
!52 = !{!53, !11, i64 0}
!53 = !{!"_ZTS10ran2_state", !11, i64 0, !11, i64 4, !11, i64 8, !9, i64 12}
!54 = !{!53, !11, i64 4}
!55 = !{!53, !11, i64 8}
!56 = distinct !{!56, !16}
!57 = !{!58, !11, i64 16}
!58 = !{!"_ZTS12TINYMT32WP_T", !11, i64 0, !11, i64 4, !11, i64 8, !11, i64 12, !11, i64 16, !11, i64 20, !11, i64 24}
!59 = !{!58, !11, i64 20}
!60 = !{!58, !11, i64 24}
!61 = !{!58, !11, i64 0}
!62 = !{!58, !11, i64 4}
!63 = !{!58, !11, i64 8}
!64 = !{!58, !11, i64 12}
!65 = distinct !{!65, !16}
!66 = !{!67, !11, i64 64}
!67 = !{!"_ZTS13well512_state", !9, i64 0, !11, i64 64}
!68 = distinct !{!68, !16}
!69 = !{i32 2, i32 2, i32 2, i32 0, i32 0, i32 2, i32 1, i32 1}
!70 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!71 = !{!"uint*", !"uint*", !"uint*", !"float", !"float", !"ulong*", !"uint*", !"uint*"}
!72 = !{!"const", !"const", !"const", !"", !"", !"const", !"", !""}
!73 = distinct !{!73, !16}
!74 = distinct !{!74, !16}
!75 = distinct !{!75, !16}
