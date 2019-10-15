//
// Customizable tray for small paint pots
// Print upside down
//
// Copyright 2014 Magnus Kvevlander <magu@me.com>
//
// Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)
// http://creativecommons.org/licenses/by-nc/3.0/
//


//
// Size variables
//

// Number of hole columns.
num_cols = 4; // [1:10]

// Number of hole rows.
num_rows = 2; // [1:10]

// Hole diameter in mm.
hole_diameter = 28;

// Material thickness in mm.
thickness = 5;

// Leg height in mm.
leg_height = 25;

// Flipped for easy printing?
flipped = false; // [false, true]


/* [Hidden] */


//
// Rendering magick
//

$fa = 0.01;	// Minimum fragment angle
$fs = 1;	// Minimum fragment size
$fn = 0;		// Number of corners in a full circle (shan't be used)

tray (num_cols, num_rows, hole_diameter / 2, thickness, leg_height);

module tray (cols = 4, rows = 2, hole_r = 10, thk = 5, leg_h = 15) {
	width = cols * (2 * hole_r + thk) + thk;
	height = rows * (2 * hole_r + thk) + thk;
	translate ([- width / 2, - height / 2, 0])
		difference () {
			union () {
				difference () {
		// base
					translate ([0, 0, flipped ? 0 : leg_height - thk])
						cube ([ width, height, thk]);
		
		// hole cutouts
					for ( i = [ 0 : cols - 1 ] )
						for ( j = [ 0 : rows - 1 ] )
							translate ([ hole_r + thk + i * (2 * hole_r + thk), hole_r + thk + j * (2 * hole_r + thk), flipped ? - thk : leg_height - 2 * thk])
								cylinder ( r = hole_r, h = 3 * thk);
				}
		
		// legs
		
				cube ([thk, 2 * thk, leg_h]);
				cube ([2 * thk, thk, leg_h]);
		
				translate ([width - 2 * thk, 0, 0])
					cube ([2 * thk, thk, leg_h]);
				translate ([width - thk, 0, 0])
					cube ([thk, 2 * thk, leg_h]);
		
				translate ([0, height - 2 *thk, 0])
					cube ([thk, 2 * thk, leg_h]);
				translate ([0, height - thk, 0])
					cube ([2 * thk, thk, leg_h]);
		
				translate ([width - 2 * thk, height - thk, 0])
					cube ([2 * thk, thk, leg_h]);
				translate ([width - thk, height - 2 * thk, 0])
					cube ([thk, 2 * thk, leg_h]);
			}
	
		// corner fillets
	
			translate ([-0.01, -0.01, -thk])
				rotate ([0, 0, 0])
					corner_cutout(thk, leg_h + 2 * thk);
	
			translate ([width + 0.01, -0.01, -thk])
				rotate ([0, 0, 90])
					corner_cutout(thk, leg_h + 2 * thk);
	
			translate ([width + 0.01, height + 0.01, -thk])
				rotate ([0, 0, 180])
					corner_cutout(thk, leg_h + 2 * thk);
	
			translate ([-0.01, height + 0.01, -thk])
				rotate ([0, 0, 270])
					corner_cutout(thk, leg_h + 2 * thk);
		}
}

module corner_cutout (fillet_r = 5, fillet_h = 15) {
	difference () {
		cube ([fillet_r, fillet_r, fillet_h]);

		translate ([fillet_r, fillet_r, -fillet_r])
			cylinder ( r = fillet_r, h = fillet_h + 2 * fillet_r);
	}
}
