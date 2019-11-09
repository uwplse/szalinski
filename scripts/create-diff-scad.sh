#!/usr/bin/env bash

set -e

initial=`cat $1 | sed 's/^/  /'`
optimized=`cat $2 | sed 's/^/  /'`
out=$3

echo "
module initial_scad() {
  $initial
}

module optimized_scad() {
  $optimized
}

difference () {
  initial_scad();
  optimized_scad();
}
" > $out
