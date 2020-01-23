#!/usr/bin/env python3

import sys
import multiprocessing

import gzip
import json

from util import load_json

pool = multiprocessing.Pool()
jsons = pool.map(load_json, sys.argv[2:])

data = {
    j['name']: j for j in jsons if j is not None
}

with gzip.open(sys.argv[1], 'wt', encoding='utf-8') as outfile:
    json.dump(data, outfile, indent=2)
