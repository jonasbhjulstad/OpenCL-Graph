#ifndef graph_CONNECT_HPP
#define graph_CONNECT_HPP
#include <random>
#include <igraph/igraph.h>

void connect_clusters(igraph_t* g1, igraph_t* g2, igraph_t* res, float p);


#endif