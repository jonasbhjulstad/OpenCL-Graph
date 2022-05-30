
// template <uint N>
// void assignVec_g(global float* a, float* b)
// {
//     for (int i = 0; i < N; i++)
//     {
//         a[i] = b[i];
//     }
// }


// void addVec(float* a, const float*b, const int Nx)
// {
//     for (int i = 0; i < Nx; i++)
//     {
//         a[i] += b[i];
//     }
// }

// template <int Nstage_ERK, class f_ODE>
// struct impl_ERK {

//     constexpr static int NX = f_ODE::NX;
//     impl_ERK(const float* _A, const float* _b, const float* _c): p_A(_A), p_b(_b), p_c(_c){}
//     void solve(global float* xk, float* xk_1, float t, float dt, const float* P) 
//     {
//         float K[Nstage_ERK * NX];
//         float xk_stage[NX];
//         for (int j = 0; j < NX; j++)
//         {
//             xk_stage[j] = xk[j];
//         }
//         f_ODE::solve(t, xk_stage, K, P);

//         for (int i = 1; i < Nstage_ERK; i++) {
//             float* k_i = &K[i * NX];
//             float c_i = p_c[i];

//             float ak_sum[NX];
//             for (int j = 0; j < NX; j++) {
//                 ak_sum[j] = xk[j];
//             }
//             for (int j = 0; j < i; j++) {
//                 ak_sum[j] += p_A[i * Nstage_ERK + j] * K[j * NX];
//                 xk_stage[j] = xk[j] + dt*ak_sum[j];
//             }
            

//             f_ODE::solve(t + c_i * dt, xk_stage, k_i,  P);

//             for (int j = 0; j < NX; j++) {
//                 xk_1[j] += dt * p_b[i] * k_i[j];
//             }
//         }
//     }
//     private:
//     const float* p_A; 
//     const float* p_b;
//     const float* p_c;
// };


// template <class f_ODE>
// struct ERK4 : public impl_ERK<4,f_ODE> 
// {
//     ERK4(const float* _A, const float* _b, const float* _c) : impl_ERK<4,f_ODE>(_A, _b, _c){}
// };


// struct f_ODE_1
// {
//     constexpr static int NX = 3;
//     constexpr static int NP = 3;
//     static void solve(const float t, const float* xk, float* xdot, const float* P)
//     {
//         float alpha = P[0];
//         float beta = P[1];
//         float N_pop = P[2];

//         xdot[0] = -beta*xk[0]*xk[1]/N_pop;
//         xdot[1] = beta*xk[0]*xk[1]/N_pop - alpha*xk[1];
//         xdot[2] = alpha*xk[1];
//     }`
// };

// // Example that uses find_min in a kernel with array of int4.
// __kernel void compute(global float* x0, global float* x1) 
// {
//     const float A[4*4] = {.0f,.0f,.0f,.0f,
//     .5f,.0f,.0f,.0f,
//     .0f,.5f,.0f,.0f,
//     .0f,.0f,1.f,.0f};
//     const float b[4] = {1.f/6, 1.f/3, 1.f/3, 1.f/6};
//     const float c[4] = {.0f,.5f,.5f,1.f};
//     const float dt = .5f;
//     const float t = .0f;
//     const float R0 = 1.2;
//     const float alpha = .9;
//     const float beta = R0*alpha;
//     const float N_pop = 1e6;
//     const float P[f_ODE_1::NP] = {alpha, beta, N_pop};
//     float res[3];
//     ERK4<f_ODE_1> integrator(A, b, c);
//     integrator.solve(x0, res, t, dt, P);
//     assignVec_g<3>(x1, res);
// }

__kernel void foo(global float* x0)
{
    int a = 0;
}