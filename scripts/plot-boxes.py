#!/usr/bin/env python3

import re
import csv
import numpy as np
import matplotlib.pyplot as plt
import multiprocessing

import util

import json

pool = multiprocessing.Pool()

def gray(i):
    i = i ** 0.5
    return (i, i, i)

keep = re.compile(r'"(hull|multmatrix)\(.*?\)"')

def improvement_before(j, secs):
    init = j['initial_cost']
    cost = init
    time = 0
    for it in j['iterations']:
        time += it['search_time'] + it['apply_time'] + it['rebuild_time']
        if time > secs:
            return cost / init
        cost = it['best_cost']
    return j['final_cost'] / init


dirs = {
    'Slightly Perturbed': '/mnt/hdd/scratch/sz-backup-2019-11-21-6pm/',
    'Slightly Perturbed\n1 second timeout': '/mnt/hdd/scratch/sz-backup-2019-11-21-6pm/',
    'Perturbed': '/mnt/hdd/scratch/sz-backup-2019-11-22-8am-perturb/',
    'Perturbed\nNo InvTrans': '/mnt/hdd/scratch/sz-backup-2019-11-22-8am-perturb-no-semtag/',
    'Perturbed\nNo CAD':'/mnt/hdd/scratch/sz-backup-2019-11-22-9am-perturb-no-cad/',
}

all_data = {}
keep = re.compile(r'"(hull|multmatrix)\(.*?\)"')

for name, directory in dirs.items():
    dir_data = []
    with open(directory + 'json_list') as json_list:
        lines = [(directory + path).strip() for path in json_list.readlines()[:]]
        js = pool.map(util.load_json, lines)
        for j in js:
            if j and '"' not in keep.sub('', j['initial_expr']):
                dir_data.append(j)
    all_data[name] = dir_data

plt.rc('xtick', labelsize=9)
plt.rc('ytick', labelsize=9)
fig, axes = plt.subplots(ncols=len(dirs), sharey=True, figsize=(14, 5))
fig.subplots_adjust(wspace=0.1)

SIZES=[0, 30, 100, 300]

for ax, (name, data) in zip(axes, all_data.items()):
    print(len(data))
    xs = []
    for i, lower in enumerate(SIZES):
        upper = SIZES[i + 1] if i + 1 < len(SIZES) else float('inf')
        def imp(j):
            if '1 second' in name:
                return improvement_before(j, 1)
            else:
                return j['improvement']

        x = [
            100 - imp(j) * 100
            for j in data
            if lower <= j['initial_cost'] < upper
        ]
        print('{} n{} {} {}'.format(name, len(x), lower, upper))
        xs.append(x)
    # ax.violinplot(xs)
    ax.boxplot(xs, showfliers=False)
    ax.xaxis.label.set_size(12)
    ax.yaxis.label.set_size(12)
    ax.set(xticklabels=['Tiny', 'Small', 'Med', 'Large'], xlabel=name)

gap = 1
positions = [
    (i * len(dirs)) + i * gap + j
    for i in range(len(SIZES))
    for j in range(len(dirs))
]
print(positions)

axes[0].set(ylabel='% shrunk')
plt.savefig('plot.pdf', bbox_inches='tight', dpi=500)
plt.show()



# for infile in files:
#     with open(infile) as f:
#         j = json.load(f)
#         print(len(j))
