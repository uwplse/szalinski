// ########### Parameters ###########
/* [Block Dimensions] */
//In mm, how wide should the block be?
block_width = 33.5; //[1:0.5:100]

//In mm, how long should the block be?
block_length = 95; //[1:0.5:100]

//In mm, how tall should the block be?
block_height = 20; //[1:0.5:100]

/* [Dice Tray Dimensions] */
//In mm, how wide should the dice tray be?
tray_width = 17; //[1:0.5:100]

//In mm, how long should the dice tray be?
tray_length = 48; //[1:0.5:100]

//In mm, how thick should the dice tray floor be?
tray_floor = 1.5; //[1:0.1:50]

/* [Finger Cutouts] */
//Generate finger cutouts at the end of the dice tray?
finger_cutouts = "Yes"; //[Yes, No]

//In mm, how wide should the finger cutouts be?
finger_width = 17; //[1:0.5:100]

//In mm, how deep should the finger cutouts be?
finger_depth = 11; //[1:0.5:100]

/* [Hidden] */
// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

// ########## Project Space #########
f_offset = tray_length / 2;

translate([block_width / 2, block_length / 2, block_height / 2]) difference() {
	cube([block_width, block_length, block_height], center = true);
	translate([0, 0, tray_floor]) db_tray(tray_width, tray_length, block_height, 1);
	if (finger_cutouts == "Yes") {
		translate([0, 0, block_height / 2]){
			translate([0, f_offset, 0]) db_finger(finger_width, finger_depth);
			translate([0, -f_offset, 0]) db_finger(finger_width, finger_depth);
		}
	}
}

*db_tray(tray_width, tray_length, block_height, 1);

// ############ Modules #############
module db_finger(diameter, depth){
	rad = diameter / 2;

	translate([0, 0, rad - depth]){
		sphere(d = diameter);
		cylinder(depth - rad + 1, d = diameter);
	}
}

module db_tray(width, length, height, size) {
	linear_extrude(height, center = true, scale = [size, 1]) square([width, length], center = true);
}