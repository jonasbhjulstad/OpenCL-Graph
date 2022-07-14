import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import networkx as nx
from collections import Counter
N_simulations = 256
def rgb_conv(red, green, blue):
    r = int(red*255/N_simulations)
    g = int(green*255/N_simulations)
    b = int(blue*255/N_simulations)
    return (r, g, b)

def scale(x):
    return int(x*255/N_simulations)
def scalevec(x_vec):
    return (scale(x) for x in x_vec)
data_path = "/home/arch/Documents/OpenCL-Graph/build/data/Bernoulli_Network/"

v_trajs = [pd.read_csv(data_path + "v_traj_" + str(i) + ".csv") for i in range(N_simulations)]
N_nodes = v_trajs[0].shape[1]
Nt = v_trajs[0].shape[0]
node_trajs = [np.genfromtxt(data_path + "v_" + str(i) + ".csv", delimiter=',') for i in range(N_nodes)]
counts = [[np.count_nonzero(node == i, axis=1) for i in range(1,4)] for node in node_trajs]
x_trajs = [pd.read_csv(data_path + "x_traj_" + str(i) + ".csv") for i in range(N_simulations)]
node_colors = [[rgb_conv(count[0][i], count[1][i], count[2][i]) for i in range(Nt)] for count in counts]
graph_pos = pd.read_csv(data_path + "pos.csv")

G = nx.Graph()
G.add_nodes_from(range(N_nodes))
edges = np.genfromtxt(data_path + "edges.csv")
G.add_edges_from([(edge[0], edge[1]) for edge in edges])

from matplotlib.animation import FuncAnimation

# node_colors = np.random.randint(0, 100, size=(Nt, N_nodes))


def animate_nodes(G, node_colors, pos=None, *args, **kwargs):

    # define graph layout if None given
    if pos is None:
        pos = nx.spring_layout(G)

    plt.axis('off')        

    edges = nx.draw_networkx_edges(G, pos, alpha=0.5)
    nodes = nx.draw_networkx_nodes(G, pos, *args, **kwargs, node_color=['#%02x%02x%02x' % color[0] for color in node_colors])
    def update(ii):
        nodes.set_color(['#%02x%02x%02x' % color[ii] for color in node_colors])
        return nodes, edges

    fig = plt.gcf()
    animation = FuncAnimation(fig, update, interval=50, frames=Nt, blit=True)
    return animation

animation_time = 5

animation = animate_nodes(G, node_colors)
animation.save('test.gif', writer='imagemagick', savefig_kwargs={'facecolor':'white'}, fps=Nt/animation_time)


