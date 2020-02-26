#!/usr/bin/env python3

import os
import json

def main():
    fig15_dir = "out/aec-fig15/"
    for fnm in os.listdir(fig15_dir):
        if fnm.endswith('.normal.diff'):
            with open(fig15_dir+fnm) as f:
                js = json.load(f)
                print (fnm + " : " + str(js["hausdorff_distance"]))
        else:
            continue

if __name__ == "__main__":
    main()
