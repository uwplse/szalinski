//
// Customizable Spool Axle Adapter (by Robert Halter)
// Licensed: Creative Commons - Attribution - Non-Commercial - Share Alike (by-nc-sa)
// see: http://en.wikipedia.org/wiki/Creative_Commons
//
// Generates one adapter - print two of it to be symmetric
// I optimzed/reduced the used Material on the bigger diameter.
//
// Thanks to Emanresu.
// Original design and code by emanresu (http://www.thingiverse.com/Emanresu)
// Customizable Spool Adapter http://www.thingiverse.com/thing:82800
// Origianl Text from him: 
// Generates two symmetric spool bearings/axle adapters/what have you
// spacer can be used to center the spool on a specific axle,
// or to simply keep the bearing/axle adapter from sliding into the spool


// parametrizable user values - change if you want

/* [Diameter] */

// diameter of the axle hole [mm]
axle_hole_diameter = 19;

// diameter of spool hole [mm]
spool_hole_diameter = 27;

// diameter of spool hole [mm]
adapter_diameter = spool_hole_diameter + 5;

/* [Lengts] */

// length of spacer [mm] (useful for centering a spool) 
spacer_length = 20;

// distance bearing sticks into spool hole [mm]
spool_hole_depth = 8;



/* [Hidden] */

// set openSCAD resolution
$fa = 1;
$fs = 1;

// begin of form

// translate to x, y, z = 0
translate([adapter_diameter/2, adapter_diameter/2, 0]) {
	difference() {
		union() {
			// inner adapter
			cylinder(r = spool_hole_diameter/2, h = spacer_length + spool_hole_depth);
			// outer adapter cylinder
			translate([0, 0, spacer_length - (adapter_diameter - spool_hole_diameter)]) {
				cylinder(r2 = adapter_diameter/2, r1 = spool_hole_diameter/2, h = adapter_diameter - spool_hole_diameter);
			}
		}
		// axle hole
      // to be sure make the hole on each end 1 mm longer
		translate([0, 0, -1]) {
      	cylinder(r = axle_hole_diameter/2, h = spacer_length + spool_hole_depth + 2);
		} // translate
	} // difference
} // translate

// end of form
