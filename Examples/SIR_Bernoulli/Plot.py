import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


data_path = "/home/deb/Documents/OpenCL-Graph/build/data/SIR_Bernoulli_Network/"

dfs = [pd.read_csv(data_path + "SIR_Bernoulli_Network_" + str(i) + ".csv") for i in range(0, 100)]

x_traj_csv = np.genfromtxt(data_path + "x_traj.csv", delimiter=", ")

params = pd.read_csv(data_path + "param.csv")
print(params.columns)

x_trajs = np.split(x_traj_csv, params['N_trajectories'][0], axis=0)
S = [x[:,0] for x in x_trajs]
I = [x[:,1] for x in x_trajs]
R = [x[:,2] for x in x_trajs]

x_grouped = [S, I, R]
t = np.genfromtxt(data_path + "tvec.csv")

x = np.linspace(0, 10, 200)
all_curves = np.array([np.sin(x * np.random.normal(1, 0.1)) * np.random.normal(1, 0.1) for _ in range(1000)])

confidence_interval1 = 95
confidence_interval2 = 80
confidence_interval3 = 50

fig, ax = plt.subplots(3,1)



print("Number of trajectories:", len(x_trajs))
for ci in np.arange(95, 10, -5):
    for (i, x) in enumerate(x_grouped):
        low = np.percentile(x, 50 - ci / 2, axis=0)
        high = np.percentile(x, 50 + ci / 2, axis=0)
        ax[i].fill_between(t[:-1], low, high, color='r', alpha= np.exp(-.01*ci*5))
ax[0].set_title("Susceptible")
ax[1].set_title("Infected")
ax[2].set_title("Recovered")
_ = [x.grid() for x in ax]
plt.show()



# Nt = params['Nt'][0]
# print(len(x_trajs))
# for x_traj in x_trajs:
#     if (np.all(x_traj == x_trajs[-1])):
#         plt.plot(t[:-1], x_traj[:,0], color='b', label='Susceptible')
#         plt.plot(t[1:], x_traj[:,1], color='r', label='Infected')
#         plt.plot(t[1:], x_traj[:,2], color='g', label='Recovered')
#     else:
#         plt.plot(t[1:], x_traj[:,0], color='b')
#         plt.plot(t[1:], x_traj[:,1], color='r')
#         plt.plot(t[1:], x_traj[:,2], color='g')
# plt.legend()
# plt.show()




import numpy as np
import matplotlib.pyplot as plt; plt.close('all')
import networkx as nx
from matplotlib.animation import FuncAnimation

def animate_nodes(G, node_colors, pos=None, *args, **kwargs):

    # define graph layout if None given
    if pos is None:
        pos = nx.spring_layout(G)

    # draw graph
    nodes = nx.draw_networkx_nodes(G, pos, *args, **kwargs)
    edges = nx.draw_networkx_edges(G, pos, *args, **kwargs)
    plt.axis('off')

    def update(ii):
        # nodes are just markers returned by plt.scatter;
        # node color can hence be changed in the same way like marker colors
        nodes.set_array(node_colors[ii])
        return nodes,

    fig = plt.gcf()
    animation = FuncAnimation(fig, update, interval=50, frames=len(node_colors), blit=True)
    return animation

total_nodes = 10
graph = nx.complete_graph(total_nodes)
time_steps = 20
node_colors = np.random.randint(0, 100, size=(time_steps, total_nodes))

animation = animate_nodes(graph, node_colors)
animation.save('test.gif', writer='imagemagick', savefig_kwargs={'facecolor':'white'}, fps=0.5)
