/**
 *  Interlocking SMD trays
 *
 *  Elliot Buller
 *  2015
 */

/* Dovetail for interlocking parts
 *
 * Elliot Buller
 * 2015
 */
use <write/Write.scad>

/* [Hidden] */
// Curve smoothness fn
$fn = 60;

// Ensure model is watertight
q = 0.1;

/* [Global] */
part = "compartment"; // [compartment:Compartment,wall_n:Wall Negative,wall_p:Wall Positive,lid:Lid]

// Rows
rows = 2;
columns = 4;

// Text on lid
lid_text = "Project Name";

// Compartment (mm per side)
comp_w = 20; // [10:40]

// Compartment depth
comp_z = 5; //  [5:15]

// Wall thickness
wall = 1;  // [0.5,1,1.5,2]

// Adjust this based on printer to get tight fit
fit = 0.3;

// Lid thickness
lid_th = 2; // [1,1.5,2,2.5]

module interlock_p (h) {
	// Create polygon to extrude
	linear_extrude (height = h)
	polygon ([[0, 3], [0, -3], [1, -4], [2, -4], [2, 4], [1, 4]]);
}

module _interlock_n (h) {
	// Create polygon to extrude
	linear_extrude (height = h)
	polygon ([[0, 3 + fit], [0, -3 - fit], [1, -4 - fit], [2 + fit, -4 - fit], 
				[2 + fit, 4 + fit], [1, 4 + fit]]);
}

module interlock_n (width, height) {
	difference () {
		translate ([-3, -width / 2, 0])
		cube ([3, width, height]);

		// Remove interlock
		translate ([-3, 0, 0])
		_interlock_n (height);
	}
}



// Rounded cutout for easier pickup
module cutout (x, y) {
	union () {
		translate ([-x/2, 0, y * 0.5]) 
		rotate ([0, 90, 0])
		cylinder (h = x, r = y * 0.5);

		translate ([0, 0, y])
		cube ([x, y, y], center = true);
	}
}

// Compartment
module compartment (comp_x, comp_y, comp_z, wall) {
	difference () {
		translate ([0, 0, (comp_z / 2) + 0.5 * wall])
		cube ([comp_x + 2 * wall, comp_y + 2 * wall, comp_z + wall], center = true);

		// Empty space
		translate ([0, 0, wall])
		cutout (comp_x, comp_y);
	}

	// right interlock
	translate ([comp_x / 2 + wall - q, 0, 0])
	interlock_p (comp_z + wall);

	// Top interlock
	translate ([0, comp_y / 2 + wall - q, 0])
	rotate ([0, 0, 90])
	interlock_p (comp_z + wall);

	// left interlock
	translate ([-comp_x / 2 - wall + q, 0, 0])
	interlock_n (comp_y + 2 * wall, comp_z + wall);

	// bottom interlock
	translate ([0, -comp_y / 2 - wall + q, 0])
	rotate ([0, 0, 90])
	interlock_n (comp_y + 2 * wall, comp_z + wall);
}

module wall_p (width, h) {
	difference () {
		union () {
			translate ([0, -width / 2, 0])
			cube ([wall, width, h + lid_th + 3 * wall]);

			// Add interlock
			translate ([wall - q, 0, wall])
			interlock_p (h + lid_th + 2 * wall);

			// Add stop at bottom
			translate ([0, -width / 2, 0])
			cube ([wall + 2, width, wall]);
		}

		// Cut a groove for the top
		translate ([wall, -width / 2, h + wall])
		cube ([2, width, lid_th]);
	}
}

module wall_n (width, h) {

	difference () {
		union () {
			// interlock groove
			translate ([0, 0, wall])
			interlock_n (width, h + lid_th + 2 * wall); 

			// Bottom stop
			translate ([-2 - wall, -width / 2, 0])
			cube ([2 + wall, width, wall]);
		}

		// Cut a groove for the top
		translate ([-2 - wall, -width / 2, h + wall])
		cube ([2, width, lid_th]);
	}
}

module lid (rows, columns, x, y) {
	translate([0, 0, (lid_th - fit) / 2])
	cube ([(rows * (x + (2 * wall) + 2)) + 3.5,
			(columns * (y + (2 * wall) + 2)) + 3.5, lid_th - fit], center = true);
	rotate ([0, 0, 90])
	translate ([0, 0, lid_th - q])
	writecube(text=lid_text, face="top", font="orbitron.dxf");
}

// Print all parts out
module print_part () {
	if (part == "compartment") {
		compartment (comp_w, comp_w, comp_z, wall);
	}
	else if (part == "wall_n") {
		rotate ([0, 90, 180])
		wall_n (comp_w, comp_z);
	}
	else if (part == "wall_p") {
		rotate ([0, -90, 0])
		wall_p (comp_w, comp_z);
	}
	else if (part == "lid") {
		lid (rows, columns, comp_w, comp_w);
	}
	// Print them all out
	else {
		compartment (comp_w, comp_w, comp_z, wall);
		translate ([comp_w / 2 + 4, 0, 0])
		wall_n (comp_w, comp_z);
		translate ([-comp_w / 2 - 4, 0, 0])
		wall_p (comp_w, comp_z);
	}
}

print_part ();
