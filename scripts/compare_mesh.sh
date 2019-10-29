#!/usr/bin/env bash

set -e

in1=$1
in2=$2
out=$3

timeout_duration=5s
hausdorff_samples=1000

function run() {
    { result=$(timeout $timeout_duration $@); err="$?"; } || true
    case "$err" in
        0) echo $result ;;
        124) echo \"timeout=$timeout_duration\" ;;
        *)   echo \"fail=$err\" ;;
    esac
}

haus=$(run out/compare_mesh $in1 $in2 $hausdorff_samples)
vol1=$(run out/compare_mesh $in1)
vol2=$(run out/compare_mesh $in2)
vol_diff=$(run out/compare_mesh $in1 $in2)

echo -e '{"hausdorff_distance": ' $haus ', "volume_difference" :' $vol_diff ', "volume1" :' $vol1', "volume2" :' $vol2 '}' > $out
