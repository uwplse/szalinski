//: $fn, facttes resolution 
detail = 90; // [8:90]

// include <ear.scad>;

//: radius of warp preventing ears. A value of 0 disables ears
ear_radius = 0; // [0:20]

//: platelet height:
platelet_height = 30;  // [20:120]

//: platelet width:
platelet_width = 50;  // [30:180]

//: radius of corners, also width of frame:
corner_radius = 2; // [0:9]

module ear(x, y, r)  {			// radius of 0 disables ears.  a circle with radius 0 should have
	if(r) {				// same effect, but I didn't test. Conditionally makes certain that
		linear_extrude(0.2)  {	// radius 0 means no ears and no artefacts.
			translate([x, y])
			circle(r);
		}
	}
}


module Trennplatte(l, t, h, r)  {
// ears
	for(x=[r:l-2*r:l], y=[r:t-2*r:t])		ear(x, y, ear_radius);

// base plate
	linear_extrude(h)	translate([r,   r])	square([l-2*r, t-2*r]);

// frame and corners
	linear_extrude(1.4)  {
		for(x=[r:l-2*r:l], y=[r:t-2*r:t])	translate([x, y]) circle(r, $fn=detail);
		for(x=[0,l-r,l-r]) translate([x, r])	square([r, t-2*r]);
		for(y=[0,t-r,t-r]) translate([r, y])	square([l-2*r, r]);
	}
}

Trennplatte(platelet_width, platelet_height, 0.8, corner_radius);
