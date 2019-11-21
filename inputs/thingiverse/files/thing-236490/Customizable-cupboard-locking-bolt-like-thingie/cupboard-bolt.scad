//
// Customizable cupboard locking bolt like thingie
// Print lying down for better sturdiness
//
// Copyright 2014 Magnus Kvevlander <magu@me.com>
//
// Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)
// http://creativecommons.org/licenses/by-nc/3.0/
//


//
// Base variables
//

// Material thickness in mm. Don't make it too thin.
thk = 12;

// Distance between centers of holes in mm.
hdist = 69;

// Hole diameter in mm.
hdia = 15;

// Width of gap in mm.
gap = 13;


/* [Hidden] */

//
// Rendering magick
//

$fa = 0.01;	// Minimum fragment angle
$fs = 0.5;	// Minimum fragment size
$fn = 0;		// Number of corners in a full circle (shan't be used)

// Hole radius
hrad = hdia / 2;
// Angle of gap cutout
gap_angle = asin ((gap / 2) / hrad);
// Base of cutout triangle
gap_slice_base = (hrad + 1.5 * thk) * tan (gap_angle);
// Offset of compensational cut of bridge part
bridge_cut_offset = (hrad + thk) * sin (90 - gap_angle);

// Render
half_piece ();
mirror ([1,0,0])
	half_piece ();

module half_piece () {
	translate ([0, - hrad - thk, 0])
		difference () {
			// Base shape
			union () {
				// Cuboid
				cube ([hdist / 2, 2 * (hrad + thk), thk]);
				// Rounded edges
				translate ([hdist / 2, hrad + thk, 0])
					cylinder (h = thk, r = hrad + thk);
			}
		
			// Knob hole
			translate ([hdist / 2, hrad + thk, - thk / 2])
				cylinder (h = 2 * thk, r = hrad);

			// Gap
			translate ([0, 0, - thk / 2])
				union () {
					// Triangle
					linear_extrude (height = 2 * thk)
						polygon(points = [[hdist / 2, hrad + thk], [hdist / 2 - gap_slice_base, - thk / 2], [hdist / 2 + gap_slice_base, - thk / 2]]);

					// Bridge cut
						translate ([- thk / 2, - thk / 2, 0])
							cube ([hdist / 2 + thk, hrad + 1.5 * thk - bridge_cut_offset, 2 * thk]);
				}
		}
}