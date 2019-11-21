// Customizable Shower Head Holder Mount
// Copyright: Olle Johansson 2018
// License: CC BY-SA

//CUSTOMIZER VARIABLES

/* [Mount] */

// Choose mounting option
type_of_mount = 5; // [1:Spool, 2:Cylinder, 3:Wall mount, 4:Round wall mount, 5:Rod screw mount, 6:Rod clipon mount]

/* [Holder] */

// Height in mm of shower head holder
holder_height = 30; // [15:40]

// Width in mm of holder wall
holder_wall_width = 7; // [4:12]

// Top inner diameter of holder in mm
holder_top_diameter = 24; // [18:30]

// Bottom inner diameter of holder in mm
holder_bottom_diameter = 21; // [16:30]

// Angle of holder
holder_angle = 10; // [0:25]

// Width in mm of hole in holder wall
holder_hole_width = 16; // [10:20]

/* [Mount sizes] */

// Width in mm of wall mount
width_of_mount = 50; // [45:60]

// Height in mm of wall mount
height_of_mount = 30; // [20:40]

// Depth in mm of wall mount
depth_of_mount = 10; // [8:15]

/* [Rounded edge] */

// Whether to have rounded edges on mount
use_rounded_edge = "yes"; // [yes,no]

// Width in mm of rounded edge
width_of_rounded_edge = 15; // [10:20]

/* [Mount holes] */

// Should screw holes be added to mount?
use_mount_holes = "yes"; // [yes,no]

// Diameter in mm of mount screw hole
diameter_of_mount_holes = 7; // [4:10]

/* [Rod Screw Mount] */

// Diameter in mm of rod to mount on
diameter_of_rod = 18; // [15:25]

/* [Spool/Cylinder] */

// Width in mm of spool/cylinder
width_of_spool = 31; // [20:40]

// Diameter in mm of hole in spool/cylinder
spool_bolt_hole = 7; // [6:10]

// Diameter in mm of spool/cylinder
diameter_of_spool = 30; // [25:40]

// Thickness in mm of disks on spool
thickness_of_disks = 4; // [3:8]

// Diameter in mm of middle of spool
diameter_of_cylinder = 16; // [11:24]

/* [Cutout] */

// Add a cutout notch in the side of the spool/cylinder
cutout_type = 1; // [0:None, 1:Left side, 2:Right side]

// Depth in mm of cutout in mount
depth_of_cutout = 2.4; // [1:4]

// Angle of cutout slice
angle_of_cutout = 75; // [30:90]

// Rotation in degrees of cutout
rotation_of_cutout = 215; // [0:360]

//CUSTOMIZER VARIABLES END

/* [Hidden] */

$fn=100;

module slice(r = 10, deg = 30) {
    degn = (deg % 360 > 0) ? deg % 360 : deg % 360 + 360;
    difference() {
        circle(r);

        if (degn > 180)
            intersection_for(a = [0, 180 - degn])
                rotate(a)
                translate([-r, 0, 0])
                square(r * 2);
        else
            union()
                for(a = [0, 180 - degn])
                    rotate(a)
                    translate([-r, 0, 0])
                    square(r * 2);
    }
}

module spool_cutout(left_or_right) {
    position = (width_of_spool / 2 - depth_of_cutout / 2);
    mirror([0, 0, left_or_right]) 
    rotate([0, 0, rotation_of_cutout])
    translate([0, 0, position])
    linear_extrude(height = depth_of_cutout, center = true)
    slice(r = diameter_of_spool / 2 + 1, deg = angle_of_cutout);
}

module spool() {
    difference() {
        cylinder(h = width_of_spool, d = diameter_of_spool, center = true);

        // Remove middle part of cylinder
        cylinder(h = width_of_spool - thickness_of_disks * 2, d = diameter_of_spool, center = true);

        // Add a cutout notch in the side of the spool
        if (cutout_type != 0) spool_cutout(cutout_type - 1);
    }

    // Thin center cylinder
    cylinder(h = width_of_spool, d = diameter_of_cylinder, center = true);
}

module spool_mount() {
    translate([0 - diameter_of_spool / 2 + diameter_of_cylinder / 2, 0, 2])
    rotate([90, 0, 0])
    difference() {
        spool();
        cylinder(h = width_of_spool, d = spool_bolt_hole, center = true);
    }
}

module cylinder_mount() {
    translate([0 - diameter_of_spool / 2 + diameter_of_cylinder / 2, 0, 2])
    rotate([90, 0, 0])
    difference() {
        cylinder(h = width_of_spool, d = diameter_of_spool, center = true);
        cylinder(h = width_of_spool, d = spool_bolt_hole, center = true);

        // Add a cutout notch in the side of the spool
        if (cutout_type != 0) spool_cutout(cutout_type - 1);
    }
}

module rounded_edge(width, depth, height, edge_scale) {
    translate([width / 2, 0 - depth / 2, 0])
        scale([1, edge_scale, 1])
        cylinder(h = height, r = width_of_rounded_edge, center = true);
}

module mount_hole(width, depth) {
    rotate([90, 0, 0])
    //translate([width_of_mount / 2 - width_of_rounded_edge / 2, 0, 0]) {
    translate([width / 2 - diameter_of_mount_holes - 1, 0, 0]) {
        cylinder(h = depth, d = diameter_of_mount_holes, center = true);

        // Screw head shoulder
        translate([0, 0, depth / 4])
        cylinder(h = depth / 2, d = diameter_of_mount_holes * 2, center = true);
    }
}

module screw_holes() {
    if (use_mount_holes == "yes") {
        mount_hole(width_of_mount, depth_of_mount);
        mirror([1, 0, 0]) mount_hole(width_of_mount, depth_of_mount);
    }
}

module rounded_edges(height) {
    if (use_rounded_edge == "yes") {
        rounded_edge(width_of_mount, depth_of_mount, height, 0.25);
        mirror([1, 0, 0]) rounded_edge(width_of_mount, depth_of_mount, height, 0.25);
    }
}

module round_wall_mount() {
    translate([0 - depth_of_mount / 2 - 1, 0, 2])
    rotate([0, 0, 90])
    difference() {
        rotate([90, 0, 0])
        cylinder(d = width_of_mount, h = depth_of_mount, center = true);

        rounded_edges(width_of_mount);
        screw_holes();
    }
}

module wall_mount() {
    translate([0 - depth_of_mount / 2, 0, 2])
    rotate([0, 0, 90])
    difference() {
        cube([width_of_mount, depth_of_mount, height_of_mount], center = true);

        rounded_edges(height_of_mount);
        screw_holes();
    }
}

module rod_hole() {
    cylinder(h = height_of_mount, d = diameter_of_rod, center = true);
}

module rod_screw_plate() {
    translate([0 - depth_of_mount / 2, 0, 2])
    rotate([0, 0, 90])
    difference() {
        cube([width_of_mount, depth_of_mount, height_of_mount], center = true);

        rounded_edges(height_of_mount);
        screw_holes();
        translate([0, depth_of_mount / 2, 0])
        rod_hole();
    }
}

module rod_screw_mount() {
    rod_screw_plate();
    translate([0, 0, height_of_mount + 10])
        rod_screw_plate();
}

module rod_clipon_mount() {
    depth = diameter_of_rod + 10;
    translate([0 - depth / 2, 0, 2])
    rotate([0, 0, 90])
    difference() {
        translate([-2, 0, 0])
        cube([depth - 5, depth, height_of_mount], center = true);

        translate([depth / 4, 0, 0])
        cube([depth / 2, diameter_of_rod * 0.9, height_of_mount], center = true);
        rod_hole();
    }
}

module holder() {
    translate([holder_top_diameter / 2, 0, 0])
    rotate([0, holder_angle, 0])
    difference() {
        cylinder(h = holder_height, d1 = holder_bottom_diameter + holder_wall_width, d2 = holder_top_diameter + holder_wall_width, center = true);
        cylinder(h = holder_height, d1 = holder_bottom_diameter, d2 = holder_top_diameter, center = true);

        // Chamfer on top edge
        translate([holder_top_diameter / 2 + holder_wall_width / 2, 0, holder_height / 2])
        rotate([0, 40, 0])
        cube([holder_top_diameter, holder_top_diameter * 1.5, 10], center=true);

        // Chamfer on bottom edge
        translate([holder_top_diameter / 2 + holder_wall_width / 2, 0, 0 - holder_height / 2])
        rotate([0, -40, 0])
        cube([holder_top_diameter, holder_top_diameter * 1.5, 10], center=true);

        // Front hole
        translate([holder_top_diameter / 2.5, 0, 0])
            cube([holder_top_diameter / 2 + holder_wall_width, holder_hole_width, holder_height], center = true);
    }
}

module mount() {
    if (type_of_mount == 1) spool_mount();
    else if (type_of_mount == 2) cylinder_mount();
    else if (type_of_mount == 3) wall_mount();
    else if (type_of_mount == 4) round_wall_mount();
    else if (type_of_mount == 5) rod_screw_mount();
    else if (type_of_mount == 6) rod_clipon_mount();
}

module shower_holder() {
    difference() {
        mount();
        hull() holder();
    }
    holder();
}

shower_holder();
