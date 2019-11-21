// Customizable Flag Banner
// Copyright: Olle Johansson 2018
// License: CC BY-SA

//CUSTOMIZER VARIABLES

// Height in mm of flag
height_of_flag = 150; // [100:5:200]

// Length in mm of flag
length_of_flag = 200; // [100:5:250]

// Diameter in mm of pole hole
diameter_of_hole = 7.5; // [4:0.5:16]

// Thickness in mm of flag
thickness = 2; // [2:0.1:6]

//CUSTOMIZER VARIABLES END

/* [Hidden] */

$fn = 100;

module pole() {
    difference() {
        cylinder(h = height_of_flag, d = diameter_of_hole + thickness * 2, center = true);
        translate([0, 0, -thickness])
        cylinder(h = height_of_flag - thickness, d = diameter_of_hole, center = true);
    }
}

module banner() {
    translate([diameter_of_hole / 2 + thickness / 2, 0, - height_of_flag / 2])
    rotate([90, 0, 0])
    linear_extrude(height = thickness, center = true)
    polygon(points = [
        [0, 0],
        [length_of_flag, height_of_flag / 2],
        [0, height_of_flag]
    ]);
}

module flag() {
    pole();
    banner();
}

flag();