/*
 * nexus4-orb-cradle.scad
 *
 * Holds up a Nexus 4 lying vertically on its Qi wireless charging
 * sphere, so that it does not slide off the sphere and stop charging.
 *
 * Mark Shroyer <code@markshroyer.com>
 * March 7, 2013
 */

/*** PARAMETERS ***************************************************************/

// Angle between the orb's face and the base
orb_face_angle = 34; // degrees

// Radius of the orb's face
orb_face_r = 75 / 2; // mm

// Extra space between the holder and the orb, to allow for poor tolerances
orb_tolerance = 1; // mm

// Radius of the orb's base
orb_base_r = 39 / 2; // mm

// Offset between the orb's USB socket and the base
socket_height = 9; // mm

// Socket dimensions
socket_x = 13; // mm
socket_z = 10; // mm

// Phone dimensions
phone_x = 67; // mm
phone_y = 134; // mm
phone_z = 9; // mm

// Offset of the phone from center of the orb's face
phone_orb_offset = 12; // mm

// Holder's thickness
thickness = 6; // mm

$fa = 3;
$fs = 0.5;

/*** END PARAMETERS ***********************************************************/

orb_r = orb_face_r + orb_tolerance;
orb_h = sqrt(pow(orb_face_r, 2) - pow(orb_base_r, 2));
cradle_r = orb_r + thickness;

module orb_clipping() {
	intersection() {
		translate([0,0,2*orb_r]) {
			cube(size=[4*orb_r,4*orb_r,4*orb_r], center=true);
		}
		rotate(a=orb_face_angle, v=[1,0,0]) {
			translate([0,0,orb_h-orb_r]) {
				cube(size=[4*orb_r,4*orb_r,2*orb_r], center=true);
			}
		}
	}
}

module orb() {
	intersection() {
		translate([0, 0, orb_h]) {
			sphere(orb_r);
		}
		orb_clipping();
	}
}

module plug(stacked=1) {
	plug_length = orb_r;
	translate([0, orb_r, socket_height + socket_z * stacked / 2]) {
		cube([socket_x, plug_length, socket_z * stacked], true);
	}
}

module phone(stacked=1) {
	rotate(a=orb_face_angle, v=[1, 0, 0]) {
		translate([0,
		           phone_orb_offset + tan(orb_face_angle) * orb_h,
		           phone_z * stacked / 2 + orb_h]) {
			cube([phone_x, phone_y, phone_z * stacked], true);
		}
	}
}

module phone_face(stacked=1) {
	rotate(a=orb_face_angle, v=[1, 0, 0]) {
		translate([0, 0, (1+stacked) * phone_z + orb_h]) {
			cube([phone_x, phone_y, 2*stacked*phone_z], true);
		}
	}
}

module cradle() {
	cradle_width = 0.75 * phone_x;
	ring_r = sqrt(pow(cradle_r, 2) - pow(orb_h-thickness, 2));
	front_length = (phone_y/2 - phone_orb_offset) * cos(orb_face_angle)
		+ phone_z * sin(orb_face_angle)	+ thickness;

	difference() {

		// Components
		union() {

			// Bottom ring
			cylinder(h=thickness, r=ring_r);

			// Cradle back
			intersection() {
				translate([0, 0, orb_h]) {
					sphere(orb_r + thickness);
				}
				translate([0, orb_r, 0]) {
					cube([cradle_width, 2*orb_r, 2*orb_r], true);
				}
				orb_clipping();
			}

			// Cradle front
			translate([0, -front_length/2, orb_r/4]) {
				difference() {
					cube([cradle_width, front_length, orb_r/2], true);
					cube([cradle_width/2, front_length, orb_r/2], true);
				}
			}
		}

		// Mask
		union() {
			orb();
			plug(4);
			phone(4);
			phone_face(4);
		}
	}
}

module pillar(h=10) {
	cylinder(h=h, r=8);
}

module pillars() {
	translate([-cradle_r, -cradle_r, 0]) pillar();
	translate([cradle_r, -cradle_r, 0]) pillar();
	translate([-cradle_r, cradle_r, 0]) pillar();
	translate([cradle_r, cradle_r, 0]) pillar();
}

//orb();
//plug();
//phone();
cradle();
//pillars();