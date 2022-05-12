//Requires
//#define PRNG_N_SAMPLES

__kernel void PRNG_Generate(constant uint* seeds, global float* PRNG_result)
{
    const int id = get_global_id(0);
    PRNG_STATE state;
    PRNG_SEED_FN(&state, seeds[id]);
    // printf("seed: %u\n", seeds[id]);

    float result[PRNG_N_SAMPLES];

    UniformSample(&state, 0, 1, PRNG_N_SAMPLES, result);
    for (int i = 0; i < PRNG_N_SAMPLES; i++)
    {
        PRNG_result[id * PRNG_N_SAMPLES + i] = result[i];
    }
}
