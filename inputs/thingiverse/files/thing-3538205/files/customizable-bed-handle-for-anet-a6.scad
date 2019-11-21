// Customizable Bed Handle for Anet A6
// Copyright: Olle Wreede 2019
// License: CC BY-SA

//CUSTOMIZER VARIABLES

/* [Bed mount] */

// Width in mm of bed mount
bed_mount_width = 150; // [140:200]

// Depth in mm of bed mount
bed_mount_depth = 25; // [10:50]

// Thickness in mm on each side of slit on bed mount
bed_mount_thickness = 2; // [1:0.1:5]

// Height in mm of slit
bed_mount_slit_height = 3; // [2.5:0.1:3.5]

// Distance in mm between plates on bed
bed_mount_plate_distance = 122; // [100:150]

/* [Handle] */

// Type of handle
handle_type = "Round"; // [Square, Half disc, GoPro, Round]

// Width in mm of handle
handle_width = 60; // [30:100]

// Thickness in mm of handle
handle_thickness = 12; // [4:15]

// Height in mm of handle
handle_height = 5; // [3:0.5:10]

// Depth in mm of handle
handle_depth = 40; // [20:50]

// Length in mm of GoPro mount arm
gopro_arm_length = 6; // [2:15]

//CUSTOMIZER VARIABLES END

/* [Hidden] */

bed_mount_slit_width = (bed_mount_width - bed_mount_plate_distance) / 2;
bed_mount_height = bed_mount_slit_height + bed_mount_thickness*2;
gopro_height = 15;

$fn=120;

/*
 * GoPro Mount
 * by DMCShep, licensed under the BSD License license.
 * https://www.thingiverse.com/thing:3088912
 */

module nut_hole()
{
	rotate([0, 90, 0]) // (Un)comment to rotate nut hole
	rotate([90, 0, 0])
		for(i = [0:(360 / 3):359])
		{
			rotate([0, 0, i]) cube([4.6765, 8.1, 5], center = true);
		}
}

module flap(width, depth = 0)
{
	rotate([90, 0, 0])
	union()
	{
		translate([3.5, -7.5, 0]) cube([4 + depth, 15, width]);
		translate([0, -7.5, 0]) cube([7.5 + depth, 4, width]);
		translate([0, 3.5, 0]) cube([7.5 + depth, 4, width]);

		difference()
		{
			cylinder(h = width, d = 15);
			translate([0, 0, -1]) cylinder(h = width + 2, d = 6);
		}
	}
}

module mount2(depth = 0)
{
	union()
	{
		translate([0, 4, 0]) flap(3, depth);
		translate([0, 10.5, 0]) flap(3, depth);
	}
}

module mount3(depth = 0)
{
	union()
	{
		difference()
		{
			translate([0, -2.5, 0]) flap(8, depth);
			translate([0, -8.5, 0]) nut_hole();
		}

		mount2(depth);
	}
}

/* End of GoPro mount */

/* Bed Mount */

module handle(width, thickness, height, depth) {
    if (handle_type == "Square") {
        handle_square(width, thickness, height, depth);
    } else if (handle_type == "Half disc") {
        handle_half_disc(width, thickness, height, depth);
    } else if (handle_type == "GoPro") {
        handle_gopro(width, thickness, height, depth);
    } else {
        handle_round(width, thickness, height, depth);
    }
}

module handle_square(width, thickness, height, depth) {
    scale([1, depth / width, 1])
    difference() {
        cylinder(h=height, d=width, center = true);

        cylinder(h=height, d=width-thickness, center = true);

        translate([0, width / 4, 0])
        cube([width, width / 2, height], center = true);
    }
}

module handle_half_disc(width, thickness, height, depth) {
    scale([1, depth / width, 1])
    difference() {
        cylinder(d = width, h = height, center = true);
        
        translate([0, width / 4, 0])
        cube([width, width / 2, height], center = true);
        
        groove_width = width / 2 - thickness;
        scale([1, 1, height / groove_width])
        translate([0, -width / 4, groove_width / 2])
        sphere(d = groove_width);
    }
}

module handle_gopro(width, thickness, height, depth) {
    union() {
        translate([2.5, -7.5 - gopro_arm_length, 7.5 - bed_mount_height / 2])
        rotate([0, 0, 90])
        mount3();

        translate([-8, 0, -bed_mount_height / 2])
        gopro_arm(3);
        translate([-1.5, 0, -bed_mount_height / 2])
        gopro_arm(3);
        translate([5, 0, -bed_mount_height / 2])
        gopro_arm(8);
    }
}

module gopro_arm(width) {
    polyhedron(points=[
        [0, 0, 0], // 0 B UL
        [width, 0, 0], // 1 B UR
        [width, -gopro_arm_length, 0], // 2 B LR
        [0, -gopro_arm_length, 0], // 3 B LL
        [0, 0, bed_mount_height], // 4 T UL
        [width, 0, bed_mount_height], // 5 T UR
        [width, -gopro_arm_length, gopro_height], // 6 T LR
        [0, -gopro_arm_length, gopro_height] // 7 T LL
    ],
    faces=[
        [0, 3, 2, 1], // Bottom
        [4, 5, 6, 7], // Top
        [0, 1, 5, 4], // Back
        [3, 7, 6, 2], // Front
        [0, 4, 7, 3], // Left
        [2, 6, 5, 1], // Right
    ]);
}

module handle_round(width, thickness, height, depth) {
    scale([1, depth / width, 1])
    rotate_extrude(angle = 180, convexity = 10)
    translate([-width / 2, 0, 0])
    circle(r = height / 2);
}

module diagonal_braces(width, depth, height, thickness) {
    brace_length = sqrt(width * width + depth * depth);
    brace_angle = atan(depth / width);

    translate([width / 2 + thickness * 2, 0, thickness / 2])
    rotate([0, 0, brace_angle])
    cube([brace_length, thickness, height], center = true);

    translate([-width / 2 - thickness * 2, 0, thickness / 2])
    rotate([0, 0, -brace_angle])
    cube([brace_length, thickness, height], center = true);
}

module bed_mount(width, depth, height, slit_width=20, slit_height=3, thickness=2) {
    cutout_width = width / 2 - slit_width - thickness * 4;
    cutout_depth = depth - thickness * 2;
    difference() {
        cube([width, depth, height], center=true);
        
        // Distance between plates: 121.8, height: 3
        
        // Mount slits
        translate([width / 2 - slit_width / 2, thickness / 2, 0])
        cube([slit_width, depth - thickness, slit_height], center=true);
        translate([slit_width / 2 - width / 2, thickness / 2, 0])
        cube([slit_width, depth - thickness, slit_height], center=true);
        
        // Cutouts to decrease plastic usage
        translate([cutout_width / 2 + thickness * 2, 0, thickness])
        cube([cutout_width, cutout_depth, height - thickness], center=true);
        cutout_width = width / 2 - slit_width - thickness * 4;
        translate([-cutout_width / 2 - thickness * 2, 0, thickness])
        cube([cutout_width, cutout_depth, height - thickness], center=true);
    }
    
    // Diagonal braces for strength
    diagonal_braces(cutout_width, cutout_depth, height - thickness, thickness);
}

module bed_handle() {
    union() {
        bed_mount(bed_mount_width, bed_mount_depth, bed_mount_height, bed_mount_slit_width, bed_mount_slit_height, bed_mount_thickness);
    
        translate([0, -bed_mount_depth / 2, 0])
        handle(handle_width, handle_thickness, handle_height, handle_depth);
    }
}

bed_handle();
