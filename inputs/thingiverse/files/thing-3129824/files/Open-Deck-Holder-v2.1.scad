/* [Dimensions] */
//In mm, how wide should the holder be??
holder_width = 95; //[1:200]

//In mm, how long should the holder be??
holder_length = 65; //[1:200]

//In mm, how tall should the holder be??
holder_height = 51; //[1:100]

/* [Advanced] */
//In mm, how thick should the walls be?
thickness_of_walls = 1.5; //[1:0.1:5]

//In mm, how thick should the floor be at it's thinnest? (back of holder)
floor_thickness_low = 1.5; //[1:0.25:10]

//In mm, how far should the floor rise? (front of holder)
floor_thickness_high = 6; //[1:0.25:10]

//How much of a curve should there be at the front?
size_of_curve = "Half"; //[None, Half, Full]

/* [Finger Cutout] */
//Create a cutout for your finger at the front of the holder floor?
finger_cutout = "Yes"; //[Yes, No]

//As a percentage of the floor width, how large should the finger cutout be?
finger_size = 65; //[1:200] 
f_size = (finger_size * 0.01) * holder_width;

//In mm, how deep should the finger cutout be?
finger_depth = 25; //[1:200]

//How curved should the corners of the finger cutout be?
finger_curve = 8; //[0:100]

/* [Negative Space] */
//Create a negative space in the holder floor?
negative_space = "Yes"; //[Yes, No]

//As a percentage of the floor width, how wide should the negative space be?
negative_width = 80; //[1:100] 
n_width = (negative_width * 0.01) * holder_width;

//As a percentage of the floor length, how long should the negative space be?
negative_length = 50; //[1:100]
n_length = (negative_length * 0.01) * holder_length;

//In mm, how offset towards the back of the holder should the negative space be?
negative_offset = 5; //[0:100]

//As a percentage of the negative width, how wide should the negative curve be?
negative_circle_size = 100; //[1:200] 
n_size = (negative_circle_size * 0.01) * n_width;

//In mm, how deep should the negative curve be?
negative_circle_depth = 15; //[1:200]

//How curved should the corners of the negative be?
negative_curve = 5; //[0:100]

/* [Hidden] */
// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

// ########## Project Space #########

difference() {	
	union() {
		dh_walls(holder_width, holder_length, holder_height, thickness_of_walls);
		dh_floor(holder_width, holder_length, floor_thickness_low, floor_thickness_high);
	}
	
	if(finger_cutout == "Yes") translate([holder_width / 2, 0, 0]) dh_finger(f_size, finger_depth, finger_curve, floor_thickness_high);

	if(negative_space == "Yes"){
		translate([(holder_width - n_width) / 2, (holder_length - n_length) / 2 + negative_offset, 0]){
			dh_negative(n_width, n_length, floor_thickness_high, n_size, negative_circle_depth, negative_curve);
		}
	}

	if (size_of_curve == "Full") dh_curve_full(holder_width, holder_height);
	else if (size_of_curve == "Half") dh_curve_half(holder_width, holder_height);
}

// ############ Modules #############
module dh_walls (width, length, height, walls) {
	difference() {
		cube([holder_width, holder_length, holder_height]);
		translate([walls, - 1, -1 ])
			cube([holder_width - (walls * 2), holder_length - walls + 1, holder_height + 2]);
	}
}

module dh_floor(width, length, low, high) {
	hull() {
		translate([0, length - 0.1, 0]) cube([width, 0.1, low]);
		cube([width, 0.1, high]);
	}
}

module dh_curve_half(width, height) {
	difference(){
		translate([-1, -1, height / 2]) cube([width + 2, height / 2, height / 2 + 1]);
		translate([-2, height / 2, height / 2]) rotate([0, 90, 0]) cylinder(h = width + 4, d = height);
	}
}

module dh_curve_full(width, height) {
	difference(){
		translate([-1, -1, -1]) cube([width + 2, height, height + 2]);
		translate([-2, height, 0]) rotate([0, 90, 0]) cylinder(h = width + 4, r = height);
	}
}

module dh_negative(width, length, height, size, depth, radius) {
	half = size / 2 + radius;
	r_offset = radius * 2;

	translate([radius, radius, -1]) linear_extrude(height + 2) offset(r = radius) difference() {
		square([width - r_offset, length - r_offset]);
		translate([width / 2 - radius, depth - half, 0]) circle(d = size + r_offset);
		translate([size / 2 - radius, 0, 0])square([size + r_offset, depth - half]);
	}
}

module dh_finger(size, depth, radius, height) {
	half = size / 2 + radius;
	r_offset = radius * 2;

	translate([-r_offset - half, 0, -1]) linear_extrude(height + 2) difference() {
		translate([r_offset, -1, 0]) square([size + r_offset, depth * 1.5]);

		translate([radius, radius, 0]) offset(r = radius) difference() {
			square([size + (r_offset * 2), depth * 1.5]);
			translate([half + radius, depth - half, 0]) circle(d = size + r_offset);
			translate([radius, 0, 0]) square([size + r_offset, depth - half]);
		}
	}
}