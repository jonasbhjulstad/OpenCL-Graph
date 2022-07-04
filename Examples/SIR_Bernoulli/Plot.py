import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
data_path = "/home/arch/Documents/OpenCL-Graph/build/data/Bernoulli_Network/"

# x_traj_csv = np.genfromtxt(data_path + "x_traj.csv", delimiter=", ")
x_fnames = []
for file in os.listdir(data_path):
    if file.startswith("x_traj"):
        x_fnames.append(data_path + file)

x_trajs = [np.genfromtxt(fname, delimiter=',') for fname in x_fnames]

S = [x[:,0] for x in x_trajs]
I = [x[:,1] for x in x_trajs]
R = [x[:,2] for x in x_trajs]

x_grouped = [S, I, R]

x = np.linspace(0, 10, 200)
all_curves = np.array([np.sin(x * np.random.normal(1, 0.1)) * np.random.normal(1, 0.1) for _ in range(1000)])

confidence_interval1 = 95
confidence_interval2 = 80
confidence_interval3 = 50

fig, ax = plt.subplots(3,1)
t = np.arange(0, x_trajs[0].shape[0] + 1)


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





