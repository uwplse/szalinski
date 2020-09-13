import json
import os

def mk_json_from_inputs(input_dir):
    progs = dict()
    with open("../inputs.js", 'w') as f:
        f.write("var progs = { ")
        for fnm in os.listdir(input_dir):
            if fnm.endswith(".scad"):
                with open("../inputs/"+fnm, 'r') as g:
                    nm = fnm.split(".")[0]
                    prog = g.read().replace("\n", "\\n")
                    f.write(nm + ":" + "\"" + prog + "\", \n");
                g.close()
        f.write("};")
    f.close()

mk_json_from_inputs("../inputs/")

