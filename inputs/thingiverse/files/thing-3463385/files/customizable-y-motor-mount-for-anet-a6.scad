// Customizable Y Motor Mount for Anet A6
// Copyright: Olle Wreede 2019
// License: CC BY-SA

//CUSTOMIZER VARIABLES

// Thickness in mm of backplate
backplate_thickness = 6; // [4:10]

// Height in mm of cutout of bottom
bottom_cutout_height = 8.5; // [6:0.5:10]

// Distance in mm that motor is lowered from default height
motor_lowered_by = 2; // [0:0.1:4]

// Width in mm of hole for back frame brace
width_of_opening_for_back_frame_brace = 10.5; // [0:15]

// Use round or teardrop mount holes
type_of_mount_hole = "Teardrop"; // [Teardrop, Round]

// Diameter in mm of mount hole
mount_hole_diameter = 3; // [2:0.1:4]

// Length in mm of mount hole
mount_hole_length = 12; // [8:0.1:14]

// Depth in mm of hole for trapped nut
depth_of_trapped_nut_hole = 2.6; // [2:0.1:4]

// Width in mm of hole for trapped nut
width_of_trapped_nut_hole = 7.5; // [6:0.1:10]

// Height in mm of hole for trapped nut
height_of_trapped_nut_hole = 5.6; // [4:0.1:8]

//CUSTOMIZER VARIABLES END

/* [Hidden] */

height_of_base = 15 - motor_lowered_by;

$fn=120;


/* From http://www.thingiverse.com/thing:3457
   © 2010 whosawhatsis */
module teardrop(radius, length, angle) {
	rotate([0, angle, 0]) union() {
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			circle(r = radius, center = true, $fn = 30);
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			projection(cut = false) rotate([0, -angle, 0]) translate([0, 0, radius * sin(45) * 1.5]) cylinder(h = radius * sin(45), r1 = radius * sin(45), r2 = 0, center = true, $fn = 30);
    }
}

module cylinder_outer(diameter, height, fn) {
   fudge = 1 / cos(180 / fn);
   cylinder(h=height, r=diameter / 2 * fudge, $fn=fn, center=true);
}

module mount_hole(diameter, length) {
    if (type_of_mount_hole == "Teardrop") {
        rotate([0, 270, 0])
        teardrop(diameter/2, length, 90);
    } else {
        cylinder_outer(diameter, length, $fn);
    }
}

module motor_mount_plate() {
    translate([51/2, 47 - 8/2, 56/2])
    difference() {
        cube([51, 8, 56], center=true);
        // Maybe decrease 0.1mm to add clearance for back frame brace
        
        // Motor shaft hole
        translate([6/3, 0, height_of_base/2])
        rotate([90, 0, 0])
        cylinder_outer(23, 8 + 0.1, $fn);
        
        // Motor mount holes
        translate([6/3 - 31/2, 0, height_of_base/2 + 31/2])
        rotate([90, 90, 0])
        mount_hole(mount_hole_diameter, 8 + 0.1, $fn);
        
        translate([6/3 - 31/2, 0, height_of_base/2 - 31/2])
        rotate([90, 90, 0])
        mount_hole(mount_hole_diameter, 8 + 0.1, $fn);
        
        translate([6/3 + 31/2, 0, height_of_base/2 + 31/2])
        rotate([90, 90, 0])
        mount_hole(mount_hole_diameter, 8 + 0.1, $fn);
 
        translate([6/3 + 31/2, 0, height_of_base/2 - 31/2])
        rotate([90, 90, 0])
        mount_hole(mount_hole_diameter, 8 + 0.1, $fn);
   }    
}

module bottom_plate() {
    translate([51/2, 47/2, height_of_base/2])
    difference() {
        cube([51, 47, height_of_base], center=true);
        // Optionally increase with 6mm to support dampener
        // Add holes in bottom to decrease plastic usage

        translate([0, 0, bottom_cutout_height/2 - height_of_base/2])
        cube([51, 31, bottom_cutout_height], center=true);

        // Leave opening for back frame brace
        if (width_of_opening_for_back_frame_brace > 0) {
            translate([51/2 - width_of_opening_for_back_frame_brace/2, 8/2 - 47/2, bottom_cutout_height/2 - height_of_base/2])
            cube([width_of_opening_for_back_frame_brace, 8, bottom_cutout_height], center=true);
        }
    }
}

module back_plate() {
    translate([3, 47/2, 43/2])
    cube([backplate_thickness, 47, 43], center=true);
    
    translate([-4, 47 - 8/2, 16.5 + 15/2])
    cube([8, 8, 15], center=true);
    
    translate([-4, 8/2, 16.5 + 15/2])
    cube([8, 8, 15], center=true);
}

module backplate_mount_holes() {
    translate([mount_hole_length/2 - 0.1, 4, 10])
    rotate([0, 90, 0])
    mount_hole(mount_hole_diameter, mount_hole_length);
    
    // Trapped nut hole
    translate([backplate_thickness, width_of_trapped_nut_hole/2, 10])
    cube([depth_of_trapped_nut_hole, width_of_trapped_nut_hole, height_of_trapped_nut_hole], center=true);

    translate([mount_hole_length/2 - 0.1, 47-4, 10])
    rotate([0, 90, 0])
    mount_hole(mount_hole_diameter, mount_hole_length);

    // Trapped nut hole
    translate([backplate_thickness, 47 - width_of_trapped_nut_hole/2, 10])
    cube([depth_of_trapped_nut_hole, width_of_trapped_nut_hole, height_of_trapped_nut_hole], center=true);

    translate([mount_hole_length/2 - 0.1, 47-4, 39])
    rotate([0, 90, 0])
    mount_hole(mount_hole_diameter, mount_hole_length);
    
    // Trapped nut hole
    translate([backplate_thickness, 47 - width_of_trapped_nut_hole/2, 39])
    cube([depth_of_trapped_nut_hole, width_of_trapped_nut_hole, height_of_trapped_nut_hole], center=true);
}

module motor_mount() {
    difference() {
        union() {
            bottom_plate();
            back_plate();
            motor_mount_plate();
        }
        
        backplate_mount_holes();
    }
}

motor_mount();