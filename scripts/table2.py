import os
import json

def get_scad_loc(nm):
    fnm = "data/aec-table2-orig-scad-progs/" + nm + ".scad"
    count = 0
    with open(fnm, 'r') as f:
        for l in f:
            count += 1
    return str(count)

def get_mesh_loc(nm):
    fnm = "out/aec-table2/" + nm + ".in.off"
    l = ""
    with open(fnm, 'r') as f:
        for i, x in enumerate(f):
            if i == 1:
                l = l + x
            else:
                continue
    splts = l.split(' ')
    return splts[1]

def get_c_in(nm):
    fnm = "out/aec-table2/" + nm + ".normal.json"
    with open(fnm) as f:
        js = json.load(f)
    return str(js["initial_cost"])

def get_c_out(nm):
    fnm = "out/aec-table2/" + nm + ".normal.json"
    with open(fnm) as f:
        js = json.load(f)
    return str(js["ast_size"])

def get_no_cad(nm):
    fnm = "out/aec-table2/" + nm + ".normal-nocad.json"
    with open(fnm) as f:
        js = json.load(f)
    return str(js["ast_size"])

def get_no_inv(nm):
    fnm = "out/aec-table2/" + nm + ".normal-noinv.json"
    with open(fnm) as f:
        js = json.load(f)
    return str(js["ast_size"])

def main():
    tab2_dir = "out/aec-table2/"
    res = open("out/table2.csv", "w")
    res.write("Id, SCAD, #Tri, c_in, c_out, No CAD, No Inv \n")
    nms = []
    for f in os.listdir(tab2_dir):
        if f.endswith('.normal.csexp.opt'):
            n = f.split('.')[0]
            nms.append(n)
        else:
            continue
    for n in nms:
        res.write(n + "," + get_scad_loc(n) + "," + get_mesh_loc(n) + "," + get_c_in(n) + "," + get_c_out(n) + "," + get_no_cad(n) + "," + get_no_inv(n))
        res.write("\n")
    res.close()


if __name__ == "__main__":
    main()
