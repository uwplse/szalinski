/**
** @author robert Schrenk
** @licence cc-by
**/
// Print the plate solid ("yes"), as a mesh ("no") or a solid base layer with a mesh ("mix")
mesh = "yes"; // [yes, no, mix]
// Height of wall (mm)
height = 150;
// Length of wall (mm)
length = 155;
// Thickness of wall (mm)
thickness = 3;
// Offset of clasp from front (mm)
clasp_front = 30;
// Offset of clasp from back (mm)
clasp_back = 30;
// Diameter of shaft (mm)
diameter = 12;
// Amount of holes per length (only if mesh = true or mix)
holes = 5;

base_plate();
translate([0,clasp_back,diameter/2+thickness]) {
    rotate([-90,0,0]) {
        difference(){
            union() {
                cylinder(d=diameter+2*thickness,h=length-clasp_back-clasp_front);
                translate([-3*thickness,0,0]) {
                    cube([3*thickness,(2*thickness+diameter)/2,length-clasp_back-clasp_front]);
                }
                translate([-3*thickness,2*thickness,-clasp_front])
                    cube([3*thickness,thickness,clasp_front]);
                translate([-3*thickness,2*thickness,length-2*clasp_back])
                    cube([3*thickness,thickness,clasp_back]);
            }
            translate([thickness/2,0,-1])
                cylinder(d=diameter,h=length);
            translate([0,-diameter/2-thickness,-1]) {
                cube([height,2*diameter+thickness,length]);
            }
        }
    }
}


module base_plate(){
    if (mesh == "no") {
        cube([height,length,thickness]);
    }
    if (mesh == "mix") {
        cube([height,length,0.4]);
    }
    if (mesh == "yes" || mesh == "mix") {
        mesh(thickness,holes,height,length);
    }
}

module mesh(border=2,holes=10,h,l){
    diag = (l - border) / holes; //
    piece_l = sqrt(diag*diag/2);
    difference(){
        cube([h,l,border]);
        for (a = [ 0 : diag : l-2*border]) {
            for (b = [ 0 : diag : h-2*border-diag]) {
                translate([diag/2+b+2*border,border+a,-1])
                    rotate([0,0,45])
                        cube([piece_l-2,piece_l-2,border+2]);
            }
        }
        for (a = [ 0 : diag : l-2*border-diag]) {
            for (b = [ 0 : diag : h-2*border-diag]) {
                translate([diag/2+diag/2+b+2*border,border+a+diag/2,-1])
                    rotate([0,0,45])
                        cube([piece_l-2,piece_l-2,border+2]);
            }
        }
    }
    
}
