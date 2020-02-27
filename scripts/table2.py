#!/usr/bin/env python3

import os
import json
import re

def get_scad_loc(nm):
    fnm = "data/aec-table2-orig-scad-progs/" + nm + ".scad"
    count = 0
    with open(fnm, 'r') as f:
        for l in f:
            count += 1
    return str(count)

mesh_faces_re = re.compile(r'(OFF)?[ \n]*(\d+)[ \n]+(\d+)')
def get_mesh_loc(nm):
    fnm = "inputs/aec-table2/tri-mesh/" + nm + ".off"
    with open(fnm, 'r') as f:
        text = f.read()

    return mesh_faces_re.match(text).group(3)

def get_c_in(nm):
    fnm = "out/aec-table2/" + nm + ".normal.json"
    with open(fnm) as f:
        js = json.load(f)
    return str(js["initial_cost"])

def get_c_out(nm):
    fnm = "out/aec-table2/" + nm + ".normal.json"
    with open(fnm) as f:
        js = json.load(f)
    return str(js["final_cost"])

def get_no_cad(nm):
    fnm = "out/aec-table2/" + nm + ".normal-nocad.json"
    with open(fnm) as f:
        js = json.load(f)
    return str(js["final_cost"])

def get_no_inv(nm):
    fnm = "out/aec-table2/" + nm + ".normal-noinv.json"
    with open(fnm) as f:
        js = json.load(f)
    return str(js["final_cost"])

def main():
    tab2_dir = "out/aec-table2/"
    nms = []
    for f in os.listdir(tab2_dir):
        if f.endswith('.normal.json'):
            print(f)
            n = f.split('.')[0]
            nms.append(n)
        else:
            continue
    data = {}
    for n in nms:
        data.update({n: (get_scad_loc(n), get_mesh_loc(n), get_c_in(n), get_c_out(n), get_no_cad(n), get_no_inv(n))})
    res = open("out/aec-table2/table2.csv", "w")
    res.write("Id, SCAD, #Tri, c_in, c_out, No CAD, No Inv\n")
    res.write("TackleBox" + "," +
            data["TackleBox"][0] + "," +
            data["TackleBox"][1] + "," +
            data["TackleBox"][2] + "," +
            data["TackleBox"][3] + "," +
            data["TackleBox"][4] + "," +
            data["TackleBox"][5] + "\n")
    res.write("SDCardRack" + "," +
            data["SDCardRack"][0] + "," +
            data["SDCardRack"][1] + "," +
            data["SDCardRack"][2] + "," +
            data["SDCardRack"][3] + "," +
            data["SDCardRack"][4] + "," +
            data["SDCardRack"][5] + "\n")
    res.write("SingleRowHolder" + "," +
            data["SingleRowHolder"][0] + "," +
            data["SingleRowHolder"][1] + "," +
            data["SingleRowHolder"][2] + "," +
            data["SingleRowHolder"][3] + "," +
            data["SingleRowHolder"][4] + "," +
            data["SingleRowHolder"][5] + "\n")
    res.write("CircleCell" + "," +
            data["CircleCell"][0] + "," +
            data["CircleCell"][1] + "," +
            data["CircleCell"][2] + "," +
            data["CircleCell"][3] + "," +
            data["CircleCell"][4] + "," +
            data["CircleCell"][5] + "\n")
    res.write("CNCBitCase" + "," +
            data["CNCBitCase"][0] + "," +
            data["CNCBitCase"][1] + "," +
            data["CNCBitCase"][2] + "," +
            data["CNCBitCase"][3] + "," +
            data["CNCBitCase"][4] + "," +
            data["CNCBitCase"][5] + "\n")
    res.write("CassetteStorage" + "," +
            data["CassetteStorage"][0] + "," +
            data["CassetteStorage"][1] + "," +
            data["CassetteStorage"][2] + "," +
            data["CassetteStorage"][3] + "," +
            data["CassetteStorage"][4] + "," +
            data["CassetteStorage"][5] + "\n")
    res.write("RaspberryPiCover" + "," +
            data["RaspberryPiCover"][0] + "," +
            data["RaspberryPiCover"][1] + "," +
            data["RaspberryPiCover"][2] + "," +
            data["RaspberryPiCover"][3] + "," +
            data["RaspberryPiCover"][4] + "," +
            data["RaspberryPiCover"][5] + "\n")
    res.write("ChargingStation" + "," +
            data["ChargingStation"][0] + "," +
            data["ChargingStation"][1] + "," +
            data["ChargingStation"][2] + "," +
            data["ChargingStation"][3] + "," +
            data["ChargingStation"][4] + "," +
            data["ChargingStation"][5] + "\n")
    res.write("CardFramer" + "," +
            data["CardFramer"][0] + "," +
            data["CardFramer"][1] + "," +
            data["CardFramer"][2] + "," +
            data["CardFramer"][3] + "," +
            data["CardFramer"][4] + "," +
            data["CardFramer"][5] + "\n")
    res.write("HexWrenchHolder" + "," +
            data["HexWrenchHolder"][0] + "," +
            data["HexWrenchHolder"][1] + "," +
            data["HexWrenchHolder"][2] + "," +
            data["HexWrenchHolder"][3] + "," +
            data["HexWrenchHolder"][4] + "," +
            data["HexWrenchHolder"][5] + "\n")

    res.close()

if __name__ == "__main__":
    main()
