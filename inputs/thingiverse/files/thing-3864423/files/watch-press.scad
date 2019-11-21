/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   24 January 2018
 * =====================================
 *
 * Press Watch
 * Intended to be used with a vice
 * or a large locking pliers (vice grip).
 *
 * Inspired from:
 *     https://www.thingiverse.com/thing:2943455
 *
 * Unit: millimetres.
 */

$fn = 80;

view = "Both"; // [Both, Face, Back]

/* [Face] */
face_dia = 27;
face_hole_depth = 3;
face_hole_chamfer_angle = 30;
face_crystal_dia = 20; // with generous clearance

/* [Back] */
back_dia = 25;

/* [Advanced] */
back_thickness = 4;
face_bottom_thickness = 3;

/* [Hidden] */
face_thickness = face_hole_depth + face_bottom_thickness;



if (view == "Face") {
	face();
} else if (view == "Back") {
	back();
} else {
	translate([-(face_dia/2 + 5), 0, 0]) face();
	translate([back_dia/2 + 5, 0, 0]) back();
}



module back() {
	cylinder(d = back_dia, h = back_thickness);
}

module face() {
	difference() {
		cylinder(d = face_dia, h = face_thickness);
		cylinder(d = face_crystal_dia, h = face_thickness);

		// Chamfer
		chamfer_height = tan(face_hole_chamfer_angle) * face_dia/2;
		translate([0, 0, face_thickness - chamfer_height + 0.01]) {
			cylinder(d1 = 0, d2 = face_dia, h = chamfer_height);
		}
	}

	// Add bottom
	cylinder(d = face_dia, h = face_bottom_thickness);
}
