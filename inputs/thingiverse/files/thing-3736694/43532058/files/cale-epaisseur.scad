shim_thickness=3;

difference() {
    forme();
    texte();
}

module forme() {
    linear_extrude(height = shim_thickness)
    polygon([[15,0], [15,20], [0,20], [0,90], [15,90], [15,40], [35,40], [35,90], [50,90], [50,20], [35,20], [35,0]]);
}

module texte() {
    color([1,0,0])
    translate([25,25,shim_thickness-1])
    linear_extrude(height = 1)
    text(str(shim_thickness, " mm"), font = "Consolas:style=Bold", halign="center");
}
