// file: dropcam_holder.scad
// date: 2013-11-22
// author: clayb.rpi@gmail.com
// units: mm
//
// desciption: A mount to hold a Dropcam Pro onto a window. Two pads of
// double sided tape are used to make it stick. Note that after printing,
// the top will likely need to be sanded smooth for good tape grip.
//
// https://www.dropcam.com/

// Rendering resolution.
$fn=128;

// The amount of airspace to leave around the dropcam (low values may cause mount to be in the field of view)
AIRSPACE_WIDTH = 5;

// How thick/sturdy the mount walls should be.
WALL_THICKNESS = 2;

// The diameter of the smaller shaft of the dropcam
DROPCAM_SHAFT_DIAMETER = 48;

// The depth of the smaller shaft of the dropcam
DROPCAM_SHAFT_DEPTH = 25;

// How thick the connector ring should be.
DROPCAM_CONNECTOR_DEPTH = 2.5;

// The length of the double sided tape you will use.
TAPE_LENGTH = 10;

// The width of the double sided tape you will use.
TAPE_WIDTH = 20;

// The angle the camera should be to the window (degrees)
WINDOW_ANGLE = 15;

// The height of the corner-protection tabs (to prevent warping)
CORNER_PROTECTION_H = 0.25;

// The radius of the corner-protection tabs (to prevent warping)
CORNER_PROTECTION_R = 5;


//--------------------------
// Intermediate variables.
//--------------------------
PLANE_SIZE = 2 * (DROPCAM_SHAFT_DIAMETER + AIRSPACE_WIDTH + WALL_THICKNESS);
DROPCAM_SHAFT_R = DROPCAM_SHAFT_DIAMETER / 2;
WINDOW_COMPENSATION_DEPTH = sin(WINDOW_ANGLE) * (
	DROPCAM_SHAFT_DIAMETER + 2 * (WALL_THICKNESS + AIRSPACE_WIDTH));

// Dropcam mount
difference() {
	// basic shape
	union() {
		cylinder(r=DROPCAM_SHAFT_R + WALL_THICKNESS + AIRSPACE_WIDTH,
			     h=DROPCAM_SHAFT_DEPTH + WINDOW_COMPENSATION_DEPTH);

		// pads for connecting to the window.
		assign(width=DROPCAM_SHAFT_DIAMETER + 2 * (AIRSPACE_WIDTH + TAPE_LENGTH),
		       depth=TAPE_WIDTH) {
			translate([-width / 2, -depth / 2, 0])
			cube([width, depth, DROPCAM_SHAFT_DEPTH + WINDOW_COMPENSATION_DEPTH]);
		}

		// mouse ears to help prevent warping.
		assign(x=DROPCAM_SHAFT_R + AIRSPACE_WIDTH + TAPE_LENGTH,
		       y=TAPE_WIDTH / 2, h=CORNER_PROTECTION_H, r=CORNER_PROTECTION_R) {
			translate([-x, -y, 0]) cylinder(h=h, r=r);
			translate([x, -y, 0]) cylinder(h=h, r=r);
			translate([-x, y, 0]) cylinder(h=h, r=r);
			translate([x, y, 0]) cylinder(h=h, r=r);
		}
	}

	// cut out the airspace.
	translate([0, 0, DROPCAM_CONNECTOR_DEPTH])
	cylinder(r=DROPCAM_SHAFT_R + AIRSPACE_WIDTH,
		     h=DROPCAM_SHAFT_DEPTH + WINDOW_COMPENSATION_DEPTH);

	// cut out a hole to snap the dropcam into.
	translate([0, 0, -WALL_THICKNESS])
	cylinder(r=DROPCAM_SHAFT_R,
		     h=DROPCAM_CONNECTOR_DEPTH + 2 * WALL_THICKNESS);

	// slice the model for the desired angle
	translate([0, 0, DROPCAM_SHAFT_DEPTH + WINDOW_COMPENSATION_DEPTH / 2])
	rotate([WINDOW_ANGLE, 0, 0])
	translate([0, 0, PLANE_SIZE / 2])
	cube([PLANE_SIZE, PLANE_SIZE, PLANE_SIZE], center=true);
}
