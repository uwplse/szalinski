// Copyright (C) 2016-2017 - Olivier Podevin <hillheaven@free.fr>
//
// Content: A customizable pencil holder for boards.
//
// The script below has the following parameters:
//      - pencil diameter
//      - holder board thickness
//      - scissors upper width
//      - scissors lower width
//      - scissors thickness
//      - magnets diameter
//      - magnets thickness
//
// Advice on parameters' value: while measuring your pencil,
//     provide some space to the pencil to to not been to tight in the holder.
//
// This file is an OpenSCAD script, see <http://www.openscad.org/> for details
//
// This work is licensed under the Creative Commons Attribution 4.0
// International license. To view a copy of this license, visit
// <http://creativecommons.org/licenses/by/4.0/>.

// Parameters in millimeters
pencil_diameter = 10; // Recommended values: {5, 20} 
board_thickness=2;    // Recommended values: {1, 3} 

module flat_holder(diameter, thickness) {
    out_thickness = thickness+3;
    out_diameter = diameter+2;
    offset_saignee=3+diameter/6.28 + thickness;
    length_support=12+thickness*2;
    difference() {
        union() {
            cylinder(d=out_diameter, h=40, $fn=128);
            translate([out_diameter/2-out_thickness,0,-.5])
                cube([out_thickness,length_support,41]);
        }
        translate([0,0,-1])
            cylinder(d=diameter, h=42, $fn=64);
        rotate([0,0,90])
            translate([-3,2,-1])
                cube([6,14,42]);
        translate([1.5+out_diameter/2-out_thickness,offset_saignee,-.75])
            cube([thickness,20,41.5]);
    }
    support_print(diameter, thickness, out_thickness, out_diameter, length_support, 0);
    support_print(diameter, thickness, out_thickness, out_diameter, length_support, 10);
    support_print(diameter, thickness, out_thickness, out_diameter, length_support, 20);
    support_print(diameter, thickness, out_thickness, out_diameter, length_support, 30);
    support_print(diameter, thickness, out_thickness, out_diameter, length_support, 40);
}

module support_print(diameter, thickness, out_thickness, out_diameter, length_support, offset) {
    diam_pointe=0.25;
    diameter_support_print=.75;
    translate([1.5+out_diameter/2-out_thickness,length_support-diameter_support_print/2,offset])
        rotate([0,90,0]) {
            cylinder(d1=diam_pointe, d2=diameter_support_print, h=0.5, $fn=32);
            translate([0,0,0.5])
                cylinder(d=diameter_support_print, h=thickness-1, $fn=32);
            translate([0,0,thickness-.5])
                cylinder(d1=diameter_support_print, d2=diam_pointe, h=0.5, $fn=32);
        }
}

module main() {
    // diameter = {5, 20}
    // thickness = {1,3}
    rotate([0,90,0])
        flat_holder(pencil_diameter, board_thickness);
}

main();