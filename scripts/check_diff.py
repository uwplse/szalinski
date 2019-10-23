#!/usr/bin/env python3

hausdorff = float(input())
volume_diff = float(input())
if hausdorff > 0.01 and volume_diff > 0.01:
    raise ValueError("hausdorff = {}\nvolume_diff= {}".format(hausdorff, volume_diff))
