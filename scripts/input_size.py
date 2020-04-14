#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

freq = np.array([28, 127, 614, 786, 374, 125, 42, 16, 15])
x = np.array(['3', '10', '30', '100', '300', '1K', '3K', '10K', '30K'])

w = 3
nitems = len(freq)

x_axis = np.arange(0, nitems * w, w)

plt.xlabel("AST size", fontsize=18)
plt.ylabel("Number of models", fontsize=18)

plt.xlim(left=-2)
plt.ylim(0, 1000)

plt.bar(x_axis, freq, width=-w, color='white', linewidth=1.5, align='edge')
plt.xticks(x_axis, x, fontsize=18)
plt.yticks(fontsize=18)

for i, v in enumerate(freq):
    if i == 0:
        plt.text((w * i) - 1.5, v + 6, str(v), color='black', fontsize=16)
    else:
        plt.text((w * i) - 2.2, v + 6, str(v), color='black', fontsize=16)


plt.savefig('inputsize.pdf')

