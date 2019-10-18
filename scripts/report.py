#!/usr/bin/env python3

import json
import statistics

def improvement(data):
    return data['final_cost'] / data['initial_cost']

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('jsons', metavar='JSON', type=str, nargs='+')
    args = parser.parse_args()

    jsons = {path: json.load(open(path)) for path in args.jsons}

    hmean = statistics.harmonic_mean(improvement(j) for j in jsons.values())
    print(f'Harmonic mean: {hmean}')

    tups = [(improvement(v), k) for k,v in jsons.items()]
    most = min(tups)
    least = max(tups)
    print("Most improved ({}): {}".format(most[0], most[1]))
    print("Least improved ({}): {}".format(least[0], least[1]))
