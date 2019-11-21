//pi_front_with_fan_v2.scad by MegaSaturnv

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
//Diameter of the fan screw holes
FAN_SCREW_HOLE_DIAMETER = 4;
//Width of the fan screw holes mount. Should be a few mm larger than the diameter of the fan screw holes
FAN_SCREW_MOUNT_WIDTH = 8;
//Create extended screw holes for larger fans
EXTEND_SCREW_HOLES = true;
//Length of the extended screw holes
EXTEND_SCREW_HOLES_LENGTH = 26;

/* [Advanced] */

BUMPER_MIN_X = -2;
BUMPER_MIN_Y = -6;
BUMPER_MAX_X = 58;
BUMPER_MAX_Y = 55;
BUMPER_THICKNESS_Z = 4;
PEG_POS_X = 58;
PEG_POS_Y = 49;
FAN_HOLE_DIAMETER = 55;
FAN_SCREW_MOUNT_THICKNESS = BUMPER_THICKNESS_Z/2;
FAN_SCREW_MOUNT_ANGLE_ADJUSTMENT = 0;
FAN_SCREW_MOUNT_EXTENDED_ANGLE_ADJUSTMENT = 50;

/////////////
// Modules //
/////////////
module longFanScrewHole(length, width, thickness, screwWidth) {
	difference() {
		union() {
			cylinder(r=width/2, h=thickness);
			translate([0, -width/2, 0]) cube([length, width, thickness]);

			translate([length, 0, 0]) cylinder(r=width/2, h=thickness);
			//translate([length, -width/2, 0]) cube([width/2, width, thickness]);
		}
		translate([0, 0, -0.1]) cylinder(r=screwWidth/2, h=thickness+0.2);
		translate([0, -screwWidth/2, -0.1]) cube([length, screwWidth, thickness+0.2]);
		translate([length, 0, -0.1]) cylinder(r=screwWidth/2, h=thickness+0.2);
	}
}


////////////////
// Main Model //
////////////////

//Use $fn = 24 if it's a preview. $fn = 96 for the render
$fn = $preview ? 24 : 96;

union() {
	difference() {
		union() {
			import("pi_front.stl");
			translate([BUMPER_MIN_X,BUMPER_MIN_Y,0])
			cube([BUMPER_MAX_X-BUMPER_MIN_X, BUMPER_MAX_Y-BUMPER_MIN_Y, BUMPER_THICKNESS_Z]);
		}
		translate([PEG_POS_X/2, PEG_POS_Y/2, -0.1])
		cylinder(r=FAN_HOLE_DIAMETER/2, h=BUMPER_THICKNESS_Z+0.2);

		if (EXTEND_SCREW_HOLES) {
			for (i = [45, 135, 225, 315]) {
				translate([PEG_POS_X/2, PEG_POS_Y/2, -0.1]) //Translate to centre
				rotate([0, 0, i + FAN_SCREW_MOUNT_ANGLE_ADJUSTMENT]) //Rotate to each 45 degree position
				translate([FAN_HOLE_DIAMETER/2.15, 0, 0]) //Move away from centre along 45 degree angle
				rotate([0, 0, FAN_SCREW_MOUNT_EXTENDED_ANGLE_ADJUSTMENT]) //Adjust the angle at the destination
				translate([-FAN_SCREW_MOUNT_WIDTH/2, -FAN_SCREW_MOUNT_WIDTH/2, 0]) //Translate half a cube width in x and y
				cube([EXTEND_SCREW_HOLES_LENGTH + FAN_SCREW_MOUNT_WIDTH, FAN_SCREW_MOUNT_WIDTH, BUMPER_THICKNESS_Z+0.2]);
			}
		}
	}
	for (i = [45, 135, 225, 315]) {
		if (EXTEND_SCREW_HOLES) {
			difference() {
				union() {
					translate([PEG_POS_X/2, PEG_POS_Y/2, 0])
					rotate([0, 0, i + FAN_SCREW_MOUNT_ANGLE_ADJUSTMENT])
		longFanScrewHole(FAN_HOLE_DIAMETER/2.15, FAN_SCREW_MOUNT_WIDTH, FAN_SCREW_MOUNT_THICKNESS, FAN_SCREW_HOLE_DIAMETER);

					translate([PEG_POS_X/2, PEG_POS_Y/2, 0])
					rotate([0, 0, i + FAN_SCREW_MOUNT_ANGLE_ADJUSTMENT])
					translate([FAN_HOLE_DIAMETER/2.15, 0, 0])
					rotate([0, 0, FAN_SCREW_MOUNT_EXTENDED_ANGLE_ADJUSTMENT])
					longFanScrewHole(EXTEND_SCREW_HOLES_LENGTH, FAN_SCREW_MOUNT_WIDTH, FAN_SCREW_MOUNT_THICKNESS, FAN_SCREW_HOLE_DIAMETER);
				}
				translate([PEG_POS_X/2, PEG_POS_Y/2, -0.1])
				rotate([0, 0, i + FAN_SCREW_MOUNT_ANGLE_ADJUSTMENT])
				translate([FAN_HOLE_DIAMETER/2.15 - FAN_SCREW_MOUNT_WIDTH/2, -FAN_SCREW_HOLE_DIAMETER/2, 0])
				cube([FAN_SCREW_HOLE_DIAMETER*1.5, FAN_SCREW_HOLE_DIAMETER,FAN_SCREW_MOUNT_THICKNESS+0.2]);

				translate([PEG_POS_X/2, PEG_POS_Y/2, -0.1])
				rotate([0, 0, i + FAN_SCREW_MOUNT_ANGLE_ADJUSTMENT])
				translate([FAN_HOLE_DIAMETER/2.15, 0, 0])
				rotate([0, 0, FAN_SCREW_MOUNT_EXTENDED_ANGLE_ADJUSTMENT])
				translate([0, -FAN_SCREW_HOLE_DIAMETER/2, 0])
				cube([FAN_SCREW_HOLE_DIAMETER*1.5, FAN_SCREW_HOLE_DIAMETER,FAN_SCREW_MOUNT_THICKNESS+0.2]);
			}
		} else {
				translate([PEG_POS_X/2, PEG_POS_Y/2, 0])
		rotate([0, 0, i + FAN_SCREW_MOUNT_ANGLE_ADJUSTMENT])
		longFanScrewHole(FAN_HOLE_DIAMETER/2.15, FAN_SCREW_MOUNT_WIDTH, FAN_SCREW_MOUNT_THICKNESS, FAN_SCREW_HOLE_DIAMETER);
		}
	}
}