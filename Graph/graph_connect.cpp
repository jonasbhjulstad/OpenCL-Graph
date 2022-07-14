#include <graph_connect.hpp>

void connect_clusters(igraph_t* g1, igraph_t* g2, igraph_t* res, float p)
{
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(0, 1);
    igraph_vit_t vit;
    igraph_vit_create(g1, igraph_vss_all(), &vit);
    igraph_vit_t vit2;
    igraph_vit_create(g2, igraph_vss_all(), &vit2);

    
    //create edge vector
    igraph_vector_t edges;
    igraph_vector_init(&edges, 0);
    igraph_vector_reserve(&edges, (int)igraph_vcount(g1) * igraph_vcount(g2)*p);
    // igraph_heap_reserve(&heap, (int)igraph_vcount(g1) * igraph_vcount(g2)*p);
    int N_edges = 0;
    while (!IGRAPH_VIT_END(vit))
    {
        //iterate over nodes of g2
        while (!IGRAPH_VIT_END(vit2))
        {
            //add edge between g1 and g2
            if (dis(gen) < p)
            {
                N_edges++;
                //add edge to edges
                igraph_vector_push_back(&edges, IGRAPH_VIT_GET(vit));
                igraph_vector_push_back(&edges, IGRAPH_VIT_GET(vit2));
            }
            IGRAPH_VIT_NEXT(vit2);
        }
        IGRAPH_VIT_NEXT(vit);
        IGRAPH_VIT_RESET(vit2);
    }
    igraph_vit_destroy(&vit);
    igraph_vit_destroy(&vit2);
    if (N_edges)
    {
        igraph_add_edges(res, &edges, 0);
    }
    igraph_vector_destroy(&edges);

}