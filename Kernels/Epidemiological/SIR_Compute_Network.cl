#define PRNG_STATE mt19937_state
#define PRNG_SEED_FN mt19937_seed
#define PRNG_FLOAT_FN mt19937_float
#include "../Distributions/Distributions.cl"

#define SIR_NETWORK_CONNECTION_BERNOULLI 1
#define SIR_NETWORK_CONNECTION_SIR_STOCHASTIC 2
#define SIR_NETWORK_CONNECTION_SIR_DETERMINISTIC 3
// Requires:
// #define N_NETWORK_TIMESTEPS
// #define N_NETWORK_VERTICES
// #define N_STATES_NETWORK

#define N_STATES_NETWORK_TRAJECTORY N_NETWORK_TIMESTEPS*N_STATES_NETWORK


void assignVec_g(global float* a, float* b, uint N)
{
    for (int i = 0; i < N; i++)
    {
        a[i] = b[i];
    }
}

void SIR_Network_Advance(float *x, constant uint *AdjMatrix, uint N_nodes, float *x_next,
                         float infection_p, float recovery_p, PRNG_STATE *rng) {
  for (int i = 0; i < N_nodes; i++) {
    for (int j = 0; j < N_nodes; i++) {
      if ((i != j)) {
        uint Infected = x[3 * i + 1];
        uint connectionType = AdjMatrix[i * N_nodes + j];
        if (Infected >= 1) {
          if ((connectionType == SIR_NETWORK_CONNECTION_BERNOULLI) &&
              BernoulliTrial(rng, infection_p)) {
            x[3 * i] -= 1;
            x[3 * i + 1] += 1;
          } 
          x[3*i + 1] -= BernoulliTrial(rng, recovery_p);  
        }
      }
    }
  }

}

__kernel void SIR_Compute_Network(constant float *v0,
                                  

  // Trajectory Initialization
  float v_traj[N_STATES_NETWORK_TRAJECTORY];
  for (int j = 0; j < N_STATES_NETWORK; j++) {
    v_traj[j] = v0[j];
  }

  for (uint t = 0; t < Nt; t++)
  {
    float* v_current = &v_traj[t*N_STATES_NETWORK];
    float v_next = &v_traj[(t+1)*N_STATES_NETWORK];
    //Advance discrete dynamics:
    

    //Advance deterministic ODE dynamics:


    //Advance stochastic ODE dynamics:


  }

  // // PRNG Initialization
  // PRNG_STATE state;
  // PRNG_SEED_FN(&state, seeds[get_global_id(0)]);

  // Trajectory Computation
  for (int t = 0; t < Nt; t++) {
    SIR_Network_Advance(&x_traj[t * N_NETWORK_NODES * 3], adjMatrix, N_nodes,
                        &x_traj[(t + 1) * N_NETWORK_NODES * 3], infection_p, recovery_p, &state);
    printf("t: %f\n", t);

  }
  assignVec_g(nodeTrajectory_g, x_traj, N_NETWORK_NODES * 3 * N_TRAJECTORY_ITERATIONS);
}