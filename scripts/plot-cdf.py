#!/usr/bin/env python3

import csv
import numpy as np
import matplotlib.pyplot as plt

def gray(i):
    i = i ** 0.5
    return (i, i, i)

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('data', metavar='DATA', type=str)
    args = parser.parse_args()

    with open(args.data) as f:
        data = list(csv.DictReader(f))

    imps = [((float(r['improvement'])) * 100, float(r['initial_cost'])) for r in data]
    bounds = list([0, 10_000, 30_000, 100_000, 300_000])
    n = len(bounds)
    # bounds = [(3000, 'inf'), (1000, 3000), (300, 1000), (100, 300), (0, 100)]
    for i in range(n):
        upper = bounds[n - i] if i > 0 else float('inf')
        lower = bounds[n - (i + 1)]
        print(lower, upper)
        d = [imp for (imp, init) in imps if lower < init <= upper]
        plt.hist(
            d,
            # bins=100,
            label="{} < initial cost ≤ {}".format(lower, upper),
            color=gray(i / len(bounds)),
            cumulative=1,
            density=1,
        )
    plt.legend()
    plt.xlabel('Shrunk to % or smaller')
    plt.ylabel('Fraction')
    plt.savefig('plot.png')
    plt.show()
