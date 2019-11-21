//
// Card organizer for Android: Netrunner LCG
//
// Copyright 2014 Magnus Kvevlander <magu@me.com>
//
// Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)
// http://creativecommons.org/licenses/by-nc/3.0/
//

// Size of hole on the x axis
x = 97;
// Ditto on the y axis
y = 22;
// Height of the part
z = 40;

// Material thickness (1.5 sliced with 0.5 perimiters works perfect)
thk = 1.5;
// Length of gripping ledges (set to <= 0 for an edge piece without ledges altogether)
grip = 10;
// Tolerance of grip (0.15 gives a lean, but not to snug, fit; YMMV)
tol = 0.15;


// Measures of the fattest stack in the
// base game (with standard sleeves): 67x95x20 mm
// Default variables with a 1 mm gap around the
// stack for ease of insertion and extraction.

// Material thickness of 1.5 mm prints with perfect
// stability with perimiters of 0.5 mm.

// Default grip length and tolerance makes for a
// lean, but not deformingly snug, fit.

// Centering translation
translate ([-(thk + x / 2), -(thk + (y - grip) / 2), 0])
difference () {
	union () {
// Body boundary
		cube ([x + 2 * thk, y + 2 * thk, z]);
// Grip boundary
		if (grip > 0)
			translate ([-(thk + tol), -grip, 0])
				cube ([x + 4 * thk + 2 * tol, grip + thk, z]);
	}
// Cavity cutout
	translate ([thk, thk, -thk])
		cube ([x, y, z + 2 * thk]);
// Grip cutout
	translate ([-tol, -(grip + thk), -thk])
		cube ([x + 2 * thk + 2 * tol, grip + thk, z + 2 * thk]);
}