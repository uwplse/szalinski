#!/usr/bin/env python3

import csv
import json
import statistics
from operator import itemgetter

from util import load_json

def rules_time(j):
    return sum(
        it['search_time'] + it['apply_time'] + it['rebuild_time']
        for it in j['iterations']
    )

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', metavar='OUTFILE', type=str)
    parser.add_argument('jsons', metavar='JSON', type=str, nargs='+')
    args = parser.parse_args()

    # args.jsons = args.jsons[:1000]

    paths_jsons = [(path, load_json(path)) for path in args.jsons]
    jsons = []
    for (path, j) in paths_jsons:
        if j is None:
            print("WARNING: couldn't open diff for {}".format(path))
        else:
            jsons.append(j)

    hmean = statistics.harmonic_mean(j['improvement'] for j in jsons)
    print(f'Harmonic mean: {hmean}')

    most = min(jsons, key=itemgetter('improvement'))
    least = max(jsons, key=itemgetter('improvement'))
    print("Most improved ({}): {}".format(most['improvement'], most['name']))
    print("Least improved ({}): {}".format(least['improvement'], least['name']))

    has_distance = 0
    only_volume = 0
    only_haus = 0
    for j in jsons:
        got_a_dist = False

        try:
            haus = int(j['hausdorff_distance'])
            got_a_dist = True
        except ValueError:
            haus = None

        try:
            diff = int(j['volume_difference'])
            got_a_dist = True
        except ValueError:
            diff = None

        has_distance += int(got_a_dist)

        if diff is not None and haus is None:
            only_volume += 1
        if haus is not None and diff is None:
            only_haus += 1

        if diff is not None and diff > 0.05:
            print('Bad d={}, h={}, {}'.format(diff, haus, j['name']))
        if haus is not None and haus > 0.05:
            print('Bad d={}, h={}, {}'.format(diff, haus, j['name']))

        if diff is None and haus is None:
            print('{}, {}, {}, {}, {}'.format(
                j['hausdorff_distance'],
                j['volume_difference'],
                j['volume1'],
                j['volume2'],
                j['name'],
            ))


    print('Has distance: {}'.format(has_distance))
    print('No distance: {}'.format(len(jsons) - has_distance))
    print('Only diff: {}'.format(only_volume))
    print('Only haus: {}'.format(only_haus))

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
            'depth_under_mapis',
            'n_mapis',
            'ast_size',
            'ast_depth',
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
