#!/usr/bin/env python3

import sys
import csv
import glob
import numpy as np
import matplotlib.pyplot as plt
import multiprocessing

import util

import json


def gray(i):
    i = i**0.5
    return (i, i, i)


def improvement_before(j, secs):
    init = j["initial_cost"]
    cost = init
    time = 0
    for it in j["iterations"]:
        time += it["search_time"] + it["apply_time"] + it["rebuild_time"]
        if time > secs:
            return cost / init
        cost = it["data"]["best_cost"]
    return j["final_cost"] / init


if __name__ == "__main__":
    names = {
        "Slightly Perturbed": "/**/*.normal.json",
        # 'Slightly Perturbed\n1 second timeout': '/**/*.normal.json',
        "Perturbed": "/**/*.perturb.json",
        # 'Perturbed\nNo InvTrans': '/**/*.perturb-noinv.json',
        # 'Perturbed\nNo CAD': '/**/*.perturb-nocad.json',
    }

    all_data = {}

    with multiprocessing.Pool() as pool:
        for name, pattern in names.items():
            files = glob.glob("out/thingiverse/" + pattern, recursive=True)
            all_data[name] = pool.map(util.load_json, files)

    for name, data in all_data.items():
        print("Found", len(data), "for", name.replace("\n", " "))

    plt.rc("xtick", labelsize=9)
    plt.rc("ytick", labelsize=9)
    fig, axes = plt.subplots(ncols=len(names), sharey=True, figsize=(14, 5))
    fig.subplots_adjust(wspace=0.1)

    SIZES = [0, 30, 100, 300]

    for ax, (name, data) in zip(axes, all_data.items()):
        print(len(data))
        xs = []
        for i, lower in enumerate(SIZES):
            upper = SIZES[i + 1] if i + 1 < len(SIZES) else float("inf")

            def imp(j):
                if "1 second" in name:
                    return improvement_before(j, 1)
                else:
                    return j["improvement"]

            x = [100 - imp(j) * 100 for j in data if lower <= j["initial_cost"] < upper]
            print("{} n{} {} {}".format(name, len(x), lower, upper))
            xs.append(x)
        # ax.violinplot(xs)
        ax.boxplot(xs, showfliers=False)
        ax.xaxis.label.set_size(12)
        ax.yaxis.label.set_size(12)
        ax.set(xticklabels=["Tiny", "Small", "Med", "Large"], xlabel=name)

    gap = 1
    positions = [
        (i * len(names)) + i * gap + j
        for i in range(len(SIZES))
        for j in range(len(names))
    ]
    print(positions)

    axes[0].set(ylabel="% shrunk (higher is better)")

    filename = sys.argv[1]
    plt.savefig(filename, bbox_inches="tight", dpi=500)
    print("Saved plot to", filename)
    # plt.show()
