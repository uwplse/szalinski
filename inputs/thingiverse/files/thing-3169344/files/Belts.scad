
// Drive Belt creator
// Author: Neon22 Oct 2018


// preview[view:south west, tilt:top diagonal]

/* [Parameters] */
// The belt's thickness.
Belt_thickness = 3;
// The larger diameter.
Belt_diameter = 10;
// Some numbers will lie flat on the printbed (4,9,12)
Cross_section_res = 12;  // [4:36]


/* [Hidden] */

//
cyl_res = 220;
	
//----------------------
module xsection(dia, res) {
	rotate([0,0,45]) // for squares
	circle(d=dia, $fn=res, center=true);
}

module belt(thick, dia) {
	translate([0,0,Belt_thickness/2])
	rotate_extrude(angle=360, $fn=cyl_res, convexity = 4)
	translate([dia,0,0])
		xsection(thick, Cross_section_res);
}

belt(Belt_thickness,Belt_diameter);