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

set +e
grep -q sztimeout $in1
timeout1="$?"
grep -q sztimeout $in2
timeout2="$?"
set -e

case "$timeout1$timeout2" in
    "11")
        echo "in 11: all good"
        haus=$(run out/compare_mesh $in1 $in2 $hausdorff_samples)
        vol1=$(run out/compare_mesh $in1)
        vol2=$(run out/compare_mesh $in2)
        vol_diff=$(run out/compare_mesh $in1 $in2)
    ;;
    "10")
        echo "in 10"
        haus='"unknown"'
        vol1=$(run out/compare_mesh $in1)
        vol2='"unknown"'
        vol_diff='"unknown"'
    ;;
    "01")
        echo "in 01"
        haus='"unknown"'
        vol1='"unknown"'
        vol2=$(run out/compare_mesh $in2)
        vol_diff='"unknown"'
    ;;
    "00")
        echo "in 00"
        haus='"unknown"'
        vol1='"unknown"'
        vol2='"unknown"'
        vol_diff='"unknown"'
    ;;
    *)
        echo "Unexpected result: $timeout1 $timeout2"
        exit 1
        ;;
esac

echo -e '{"hausdorff_distance": ' $haus ', "volume_difference" :' $vol_diff ', "volume1" :' $vol1', "volume2" :' $vol2 '}' > $out
