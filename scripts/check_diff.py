#!/usr/bin/env python3

x = float(input())
if x > 0.01:
    raise ValueError(f"x = {x}")
