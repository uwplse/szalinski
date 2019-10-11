#!/usr/bin/env python3

import pprint
from lark import Lark, Transformer

parser = Lark(r"""
    program: instr*

    ?instr:
         | "group()" _scope -> group
         | "union()" _scope -> union
         | "difference()" _scope -> diff
         | "intersection()" _scope -> inter
         | "multmatrix(" mat ")" _scope -> matrix
         | "cylinder(" args ");" -> cylinder
         | "cube("     args ");" -> cube
         | "sphere("   args ");" -> sphere

    _scope: "{" instr* "}" | ";"

    num: NUMBER
    ?ident: /\$?[a-z][a-zA-Z0-9]*/

    vec4: "[" num "," num "," num "," num "]"
    mat:  "[" vec4 "," vec4 "," vec4 "," vec4 "]"

    vec3: "[" num "," num "," num "]"
    ?value: num | vec3 | bool
    bool: "true" | "false"

    arg: ident "=" value
    args: [arg ("," arg)*]

    %import common.WS
    %import common.SIGNED_NUMBER    -> NUMBER
    %ignore WS

    """, start='program', debug=True)

def debug(*args, **kwargs):
    print(*args, **kwargs, file=sys.stderr)
    pass

def foldup(op, args):
    debug('foldup', op, args)
    if len(args) == 0:
        return []
    if len(args) == 1:
        return args[0]
    if len(args) == 2:
        return [op, args[0], args[1]]
    return [op, args[0], foldup(op, args[1:])]

def get_scale(m):
    for i, row in enumerate(m):
        for j, elem in enumerate(row):
            if i != j and elem != 0:
                return None
    assert m[3][3] == 1
    return ['Scale', m[0][0], m[1][1], m[2][2]]

def get_trans(m):
    for i, row in enumerate(m):
        for j, elem in enumerate(row):
            if i == j and elem != 1:
                return None
            if i != j and j != 3 and elem != 0:
                return None
    return ['Trans', m[0][3], m[1][3], m[2][3]]

class SexpTransformer(Transformer):

    def program(self, args):
        debug('program', args)
        nonempty = [group for group in args if group]
        return foldup('Union', nonempty)

    def arg  (self, args): return list(args)
    def args (self, args): print('args', args); return dict(args)
    def vec3 (self, args): return list(args)
    def vec4 (self, args): return list(args)
    def mat  (self, args): return list(args)
    def num  (self, args): return float(args[0])

    def group(self, args): return foldup('Union', args)
    def union(self, args): return foldup('Union', args)
    def inter(self, args): return foldup('Intersection', args)
    def diff (self, args): return foldup('Diff',  args)

    def matrix(self, args):
        debug('matrix', args)
        mat, *args = args
        op = get_trans(mat) or get_scale(mat) or ['Matrix']
        if len(args) == 1:
            return op + args
        else:
            return foldup('Union', [op + [a] for a in args])

    def sphere(self, args):
        r = args[0]['r']
        return 'Sphere' if r == 1.0 else ['Scale', r, r, r, 'Sphere']
    def cube(self, args):
        x, y, z = args[0]['size']
        return 'Cube' if (x, y, z) == (1, 1, 1) else ['Scale', x, y, z, 'Cube']
    def cylinder(self, args):
        h, r1, r2 = args[0]['h'], args[0]['r1'], args[0]['r2']
        assert r1 == r2
        return 'Cylinder' if (h, r1, r2) == (1, 1, 1) else ['Scale', h, r1, r2, 'Cylinder']

def pretty_print(sexp, indent=2):
    return pprint.pformat(sexp, indent=indent) \
                 .replace(',', '')  \
                 .replace('[', '(') \
                 .replace(']', ')') \
                 .replace("'", '')

if __name__ == "__main__":
    import sys
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument('-o', '--output')
    ap.add_argument('input')
    args = ap.parse_args()

    with open(args.input) as f:
        s = f.read()

    tree = parser.parse(s)
    debug(tree.pretty())
    sexp = SexpTransformer().transform(tree)
    debug('done')
    debug(sexp)

    pp = pretty_print(sexp)
    if args.output:
        with open(args.output, 'wt') as f:
            f.write(pp)
    else:
        print(pp)
