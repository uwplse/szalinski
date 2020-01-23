#!/usr/bin/env python3

import re
import sys

regex = re.compile(r'(\$fn *= *)(\d+)')

def replace(match):
    fn, n = match.group(1, 2)
    n = int(n)
    n2 = min(n, 25)
    # if n != n2:
    #     print("{} -> {}".format(n, n2))
    print(match.group(1) + str(n2))
    return match.group(1) + str(n2)

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, 'r') as f:
    s = f.read()
    s2, n = regex.subn(replace, s)

with open(outfile, 'w') as w:
    w.write(s2)
