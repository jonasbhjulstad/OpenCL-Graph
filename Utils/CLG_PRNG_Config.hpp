#ifndef CLG_PRNG_CONFIG_HPP
#define CLG_PRNG_CONFIG_HPP
#include <map>
#include <string>
#include <algorithm>
enum CLG_PRNG_TYPE
{
    CLG_PRNG_TYPE_ISAAC,
    CLG_PRNG_TYPE_KISS99,
    CLG_PRNG_TYPE_LCG6432,
    CLG_PRNG_TYPE_LFIB,
    CLG_PRNG_TYPE_MRG31K3P,
    CLG_PRNG_TYPE_MRG63K3A,
    CLG_PRNG_TYPE_MSWS,
    CLG_PRNG_TYPE_MT19937,
    CLG_PRNG_TYPE_MWC64X,
    CLG_PRNG_TYPE_PCG6432,
    CLG_PRNG_TYPE_PHILOX2X32_10,
    CLG_PRNG_TYPE_RAN2,
    CLG_PRNG_TYPE_TINYMT,
    CLG_PRNG_TYPE_TINYMT32,
    CLG_PRNG_TYPE_TINYMT64,
    CLG_PRNG_TYPE_TYCHE,
    CLG_PRNG_TYPE_WELL512,
    CLG_PRNG_TYPE_XORSHIFT6432STAR
};

const std::map <CLG_PRNG_TYPE, std::string> CLG_PRNG_strmap = {{CLG_PRNG_TYPE_ISAAC,"isaac"},
    {CLG_PRNG_TYPE_KISS99,"kiss99"},
    {CLG_PRNG_TYPE_LCG6432,"lcg6432"},
    {CLG_PRNG_TYPE_LFIB,"lfib"},
    {CLG_PRNG_TYPE_MRG31K3P,"mrg31k3p"},
    {CLG_PRNG_TYPE_MRG63K3A,"mrg63k3a"},
    {CLG_PRNG_TYPE_MSWS,"msws"},
    {CLG_PRNG_TYPE_MT19937,"mt19937"},
    {CLG_PRNG_TYPE_MWC64X,"mwc64x"},
    {CLG_PRNG_TYPE_PCG6432,"pcg6432"},
    {CLG_PRNG_TYPE_PHILOX2X32_10,"philox2x32_10"},
    {CLG_PRNG_TYPE_RAN2,"ran2"},
    {CLG_PRNG_TYPE_TINYMT32,"tinymt32"},
    {CLG_PRNG_TYPE_TINYMT64,"tinymt64"},
    {CLG_PRNG_TYPE_TYCHE,"tyche"},
    {CLG_PRNG_TYPE_WELL512,"well512"},
    {CLG_PRNG_TYPE_XORSHIFT6432STAR,"xorshift6432star"}};

const std::map <CLG_PRNG_TYPE, std::string> CLG_PRNG_class_strmap = {{CLG_PRNG_TYPE_ISAAC,"PRNG_ISAAC"},
    {CLG_PRNG_TYPE_KISS99,"PRNG_KISS99"},
    {CLG_PRNG_TYPE_LCG6432,"PRNG_LCG6432"},
    {CLG_PRNG_TYPE_LFIB,"PRNG_LFIB"},
    {CLG_PRNG_TYPE_MRG31K3P,"PRNG_MRG31K3P"},
    {CLG_PRNG_TYPE_MRG63K3A,"PRNG_MRG63K3A"},
    {CLG_PRNG_TYPE_MSWS,"PRNG_MSWS"},
    {CLG_PRNG_TYPE_MT19937,"PRNG_MT19937"},
    {CLG_PRNG_TYPE_MWC64X,"PRNG_MWC64X"},
    {CLG_PRNG_TYPE_PCG6432,"pcg6432"},
    {CLG_PRNG_TYPE_PHILOX2X32_10,"PRNG_PHILOX2X32_10"},
    {CLG_PRNG_TYPE_RAN2,"PRNG_RAN2"},
    {CLG_PRNG_TYPE_TINYMT32,"PRNG_TINYMT32"},
    {CLG_PRNG_TYPE_TINYMT64,"PRNG_TINYMT64"},
    {CLG_PRNG_TYPE_TYCHE,"PRNG_TYCHE"},
    {CLG_PRNG_TYPE_WELL512,"PRNG_WELL512"},
    {CLG_PRNG_TYPE_XORSHIFT6432STAR,"PRNG_XORSHIFT6432STAR"}};

std::string CLG_Configure_Generator(CLG_PRNG_TYPE generator_type)
{
    std::string generator_name = CLG_PRNG_strmap.at(generator_type);
    std::string generator_name_upper = generator_name;
    for (auto& c: generator_name_upper) c = std::toupper(c);

    std::string PRNG_state = "#define PRNG_STATE " + generator_name + "_state\n";

    std::string PRNG_seed_fn;
    std::string PRNG_float_fn;
    std::string PRNG_include_file = "#include <" + generator_name + ".cl>\n";
    PRNG_seed_fn = "#define PRNG_SEED_FN " + generator_name + "_seed\n";
    PRNG_float_fn = "#define PRNG_FLOAT_FN " + generator_name + "_float\n";
    return PRNG_state + PRNG_seed_fn + PRNG_float_fn + PRNG_include_file + "#include <Distributions.cl>\n";
}

#endif