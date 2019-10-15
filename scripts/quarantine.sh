#!/usr/bin/env bash
# set -e

patterns='minkowski\|polygon\|extrude\|points\|color('
bad=$(grep -il "$patterns" -r out/csgs/)

for f in $bad; do
    sub=${f#out/csgs/}
    scad=inputs/scads/${sub%.csg}.scad
    echo Quarantining $scad
    rm $f
    mv $scad $scad.feature-fail
done
