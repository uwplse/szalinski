#!/usr/bin/env bash

set -e

n=100
seed=1234567890

files=$(find out/thingiverse/ -name "*.opt.scad" | shuf -n $n --random-source=<(yes $seed))
    # # paste -d'\n' - <(yes 'foo') |
    # # xargs -n1
    # xargs -n1 -P6 \time -f"time: %e" timeout 30s openscad -o /tmp/test.off 2>&1 |
    # # xargs -n1 -P6 \time -f"time: %e" timeout 30s echo sadfasdfasdfasdf |
    # grep 'time: '
    # #  |
    # # sed 's/time//'


for f in $files; do
    (\time -f"%e" timeout 30s openscad -o /tmp/test.off $f 2>&1 | tail -n1) &
done
