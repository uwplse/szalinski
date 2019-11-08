#!/usr/bin/env python3

import csv
import json
import statistics
from operator import itemgetter

def rules_time(j):
    return sum(
        it['search_time'] + it['apply_time'] + it['rebuild_time']
        for it in j['iterations']
    )

# this adds on some derivative data to the json
def make_json(path):
    print("Loading {}...".format(path))
    j = json.load(open(path))
    iters = j['iterations']
    j['name'] = path
    j['rules_time'] = path
    j['set'] = path.split('/')[1]
    j['rules_time'] = rules_time(j)
    j['improvement'] = j['final_cost'] / j['initial_cost']
    j['iters'] = len(iters)
    j['nodes'] = iters[-1]['egraph_nodes']
    j['classes'] = iters[-1]['egraph_classes']

    # get the difference json
    base, ext = path[:-4], path[-4:]
    assert ext == 'json'
    j.update(json.load(open(base + 'diff')))

    return j

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', metavar='OUTFILE', type=str)
    parser.add_argument('jsons', metavar='JSON', type=str, nargs='+')
    args = parser.parse_args()

    jsons = [make_json(path) for path in args.jsons]

    hmean = statistics.harmonic_mean(j['improvement'] for j in jsons)
    print(f'Harmonic mean: {hmean}')

    most = min(jsons, key=itemgetter('improvement'))
    least = max(jsons, key=itemgetter('improvement'))
    print("Most improved ({}): {}".format(most['improvement'], most['name']))
    print("Least improved ({}): {}".format(least['improvement'], least['name']))

    with open(args.output, 'w') as f:
        fieldnames = [
            'name',
            'set',
            'rules_time',
            'stop_reason',
            'iters',
            'nodes',
            'classes',
            'initial_cost',
            'final_cost',
            'improvement',
            'extract_time',
            'hausdorff_distance',
            'volume_difference',
            'volume1',
            'volume2',
        ]

        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()

        for j in jsons:
            row = {k: j[k] for k in fieldnames}
            writer.writerow(row)
