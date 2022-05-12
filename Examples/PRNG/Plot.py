import matplotlib.pyplot as plt
import numpy as np
import math
from os import listdir
from os.path import isfile, join
datadir = "/home/deb/Documents/OpenCL-Graph/build/data/PRNG/"
results = [join(datadir, f) for f in listdir(datadir) if isfile(join(datadir, f))]

N_images = len(results)

fig, ax = plt.subplots(math.ceil(N_images/4), 4)
for i, result_file in enumerate(results):
    rng_data = np.genfromtxt(result_file, delimiter=",")
    ax[math.floor(i/4), i % 4].imshow(rng_data, cmap='gray')
plt.show()
