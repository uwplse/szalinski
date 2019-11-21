// Customizable Twisted Vase
// Copyright: Olle Wreede 2019
// License: CC BY-SA

//CUSTOMIZER VARIABLES

// Diameter of vase in mm
diameter_of_vase = 100; // [75:200]

// Height of vase in mm
height_of_vase = 200; // [50:300]

// Type of edge bumps for vase
type_of_bump = "Rounded"; // [None, Rounded, Triangle]

// Width of each bump in mm
width_of_bump = 20; // [10:30]

// Number of bumps around the edge
number_of_bumps = 20; // [4:100]

// Number of slices in twist
number_of_slices = 50; // [1:200]

// Degrees of twist
degrees_of_twist = 20; // [0:360]

// Scale of top of vase in percent
top_scale_x = 150; // [100:400]

// Scale of top of vase in percent
top_scale_y = 250; // [100:400]

//CUSTOMIZER VARIABLES END

/* [Hidden] */

$fn = 120;

/* ** Utility modules ** */

module circled_pattern(number) {
    rotation_angle = 360 / number;
    last_angle = 360 - rotation_angle;
    for(rotation = [0 : rotation_angle : last_angle])
        rotate([0, 0, rotation])
        children();
}

/* ** Vase ** */

module rounded_bump(diameter) {
    translate([diameter / 2 - width_of_bump / 8, 0, 0])
    scale([0.8,1,1])
    circle(d = width_of_bump, center = true);
}

module triangle_bump(diameter) {
    triangle_height = sqrt(3) / 2 * width_of_bump;
    translate([diameter / 2, 0, 0])
    circle(d = width_of_bump, $fn=3, center = true);
}

module bump(diameter) {
    if (type_of_bump == "Rounded") rounded_bump(diameter);
    else if (type_of_bump == "Triangle") triangle_bump(diameter);
}

module edge_bumps(diameter) {
    circled_pattern(number_of_bumps)
        bump(diameter);
}

module vase_base(diameter) {
    circle(d = diameter, center = true);
    if (type_of_bump != "None") edge_bumps(diameter);
}

/* ** Main object ** */

module twisted_vase(diameter, height) {
    linear_extrude(height = height, convexity = 1, twist = degrees_of_twist, slices = number_of_slices, scale=[top_scale_x / 100, top_scale_y / 100])
    vase_base(diameter);
}

module vase() {
    twisted_vase(diameter_of_vase, height_of_vase);
}

vase();
