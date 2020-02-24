#!/usr/bin/env bash

timeout=180s
in=$1
out=$2

timeout --foreground $timeout openscad -o $out $in 2>> out/openscad.log
case "$?" in
0) ;;
124) echo "sztimeout=$timeout" > $out ;;
*) exit 1 ;;
esac
