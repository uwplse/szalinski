#!/usr/bin/env python3

import re
import sys

regex = re.compile(r'(\$fn *= *)(\d+)')

def replace(match):
    fn, n = match.group(1, 2)
    n = int(n)
    n2 = min(n, 50)
    # if n != n2:
    #     print("{} -> {}".format(n, n2))
    print(match.group(1) + str(n2))
    return match.group(1) + str(n2)

for path in sys.argv[1:]:
    print(path)
    with open(path, 'r') as f:
        s = f.read()
        s2, n = regex.subn(replace, s)
    if s != s2:
        print("updating", path)
        with open(path, 'w') as w:
            w.write(s2)
