#!/usr/bin/env python3

import re
import csv
import numpy as np
import matplotlib.pyplot as plt
import multiprocessing

import util

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

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('data', metavar='DATA', type=str)
    args = parser.parse_args()

    with open(args.data) as f:
        data = list(csv.DictReader(f))

    jsons = pool.map(util.load_json, [r['name'] for r in data])
    jsons = [j for j in jsons if '"' not in keep.sub('', j['initial_expr'])]

    # data = [r for r in data if r['name'] not in exclude]

    # imps = [((float(r['improvement'])) * 100, float(r['initial_cost'])) for r in data]
    bounds = list([0, 30, 100, 300, ])
    n = len(bounds)
    # bounds = [(3000, 'inf'), (1000, 3000), (300, 1000), (100, 300), (0, 100)]
    for i in range(n):
        upper = bounds[n - i] if i > 0 else float('inf')
        lower = bounds[n - (i + 1)]
        print(lower, upper)
        d1 = [
            100 * improvement_before(j, 60)
            for j in jsons
            if lower < j['initial_cost'] <= upper
        ]
        d2 = [
            100 * improvement_before(j, 1)
            for j in jsons
            if lower < j['initial_cost'] <= upper
        ]
        plt.hist(
            (d1, d2),
            bins=100,
            label="({}) {} < initial cost ≤ {}".format(len(d1), lower, upper),
            color=(gray(i / len(bounds)), 'green'),
            cumulative=1,
            density=1,
            # stacked=1,
            histtype='step',
        )
    plt.legend()
    plt.xlabel('Shrunk to % or smaller')
    plt.ylabel('Fraction')
    plt.savefig('plot.png')
    plt.show()
