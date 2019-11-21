//pi_front_with_fan.scad by MegaSaturnv

/////////////////////////////
// Customizable Parameters //
/////////////////////////////

/* [Basic] */
//Distance between the fan screw holes. Typically 24.0, 28.8, 31.8 and 40.8 for 30mm, 35mm, 40mm and 50mm fans
FAN_SIZE = 31.8;
//Diameter of the fan screw holes
FAN_SCREW_DIAMETER = 4;
//Offset the fan in the Y-axis. May be needed for fans larger than 50mm
FAN_Y_OFFSET = 0;

/* [Advanced] */
BUMPER_MIN_X = -2;
BUMPER_MIN_Y = -6;
BUMPER_MAX_X = 58;
BUMPER_MAX_Y = 55;
BUMPER_THICKNESS_Z = 4;
SCREW_POS_X = 58;
SCREW_POS_Y = 49;
FAN_DIAMETER = FAN_SIZE + FAN_SCREW_DIAMETER;

////////////////
// Main Model //
////////////////

//Use $fn = 24 if it's a preview. $fn = 96 for the render
$fn = $preview ? 24 : 96;

difference() {
	union() {
		import("pi_front.stl");
		translate([BUMPER_MIN_X,BUMPER_MIN_Y,0])
		cube([BUMPER_MAX_X-BUMPER_MIN_X, BUMPER_MAX_Y-BUMPER_MIN_Y, BUMPER_THICKNESS_Z]);
	}




	translate([SCREW_POS_X/2, SCREW_POS_Y/2 + FAN_Y_OFFSET, -0.1])
	cylinder(r=FAN_DIAMETER/2, h=BUMPER_THICKNESS_Z+0.2);


	translate([SCREW_POS_X/2 - FAN_SIZE/2, SCREW_POS_Y/2 - FAN_SIZE/2 + FAN_Y_OFFSET, -0.1])
	cylinder(r=FAN_SCREW_DIAMETER/2, h=BUMPER_THICKNESS_Z+0.2);

	translate([SCREW_POS_X/2 + FAN_SIZE/2, SCREW_POS_Y/2 - FAN_SIZE/2 + FAN_Y_OFFSET, -0.1])
	cylinder(r=FAN_SCREW_DIAMETER/2, h=BUMPER_THICKNESS_Z+0.2);

	translate([SCREW_POS_X/2 - FAN_SIZE/2, SCREW_POS_Y/2 + FAN_SIZE/2 + FAN_Y_OFFSET, -0.1])
	cylinder(r=FAN_SCREW_DIAMETER/2, h=BUMPER_THICKNESS_Z+0.2);

	translate([SCREW_POS_X/2 + FAN_SIZE/2, SCREW_POS_Y/2 + FAN_SIZE/2 + FAN_Y_OFFSET, -0.1])
	cylinder(r=FAN_SCREW_DIAMETER/2, h=BUMPER_THICKNESS_Z+0.2);
}

