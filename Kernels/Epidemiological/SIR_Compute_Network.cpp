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

enum edgeType {NETWORK_EDGE_DODE, NETWORK_EDGE_SODE};

template <uint N>
void assignVec_g(global float* a, float* b)
{
    for (int i = 0; i < N; i++)
    {
        a[i] = b[i];
    }
}

__kernel void SIR_Compute_Network(constant float* v0,
constant uint* node_state_offsets,
constant uint* source_IDs,
constant uint* target_IDs,
constant uint* edge_types,
constant float* edge_params,
constant uint* edge_param_offsets,
float* v_traj_g)
{                   
  const uint N_STATES_NETWORK_TRAJECTORY = N_NETWORK_TIMESTEPS*N_STATES_NETWORK;
  // Trajectory Initialization
  float v_traj[N_STATES_NETWORK_TRAJECTORY];
  for (uint t = 0; t < Nt; t++)
  {
    float* v_current = &v_traj[t*N_STATES_NETWORK];
    float v_next = &v_traj[(t+1)*N_STATES_NETWORK];

    for (uint i = 0; i < N_EDGES; i++)
    {
      uint source_ID = source_IDs[i];
      uint target_ID = target_IDs[i];
      uint edge_type = edge_types[i];
      float* v_source = &v0[node_state_offsets[source_ID]];
      float* v_target = &v0[node_state_offsets[target_ID]];
      float* edge_param = &edge_params[edge_param_offsets[i]];
      float* v_source_next = &v0[i*N_STATES_NETWORK + node_state_offsets[source_ID]];
      float* v_target_next = &v0[i*N_STATES_NETWORK + node_state_offsets[target_ID]];

      f_integrate<edge_type>(v_source, v_target, v_source_next, v_target_next, edge_param);
    }
  }
  assignVec_g<N_STATES_NETWORK_TRAJECTORY>(v_traj_g, v_traj);
}