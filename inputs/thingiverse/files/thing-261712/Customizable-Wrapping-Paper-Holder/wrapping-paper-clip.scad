// Customizable Wrapping Paper Holder
// Created by Rob Ross, March 2014
//
// Inspired by "Wrapping Paper Holder" by Corey Brown
//   http://www.thingiverse.com/thing:36166
//
// Code for partial_rotate_extrude(), including pie_slice(), was written by CarryTheWhat:
// and licensed under the GNU - LGPL license. See:
//   http://carrythewhat.com/
//   https://www.thingiverse.com/thing:34027
//
// Customizable Wrapping Paper Holder is shared under GNU - LGPL license.

// preview[view:south east, tilt:top diagonal]

/* [Size] */
// Diameter of the roll to be held by the holder (cm)
roll_dia_cm = 4.7;

/* [Count] */
count = 1; // [1,2]

/* [Tweaks] */
// Thickness of the holder in the radial direction (mm)
holder_thickness_mm = 2.2;
// Height of the holder along the roll of paper (mm)
holder_height_mm = 10;
// Angle of cutout in holder (degrees)
holder_cut_angle = 50; // [35:80]

/* [Hidden] */
$fn=100;

holder();
if (count == 2) {
	translate([roll_dia_cm * 2.5, -1 * roll_dia_cm * 6.55, 0]) rotate([0,0,180]) holder();
}

// holder() -- create a complete holder
module holder() {
	// Create ring
	partial_rotate_extrude(angle = 360-holder_cut_angle, 
				    radius = roll_dia_cm * 5, convex=2)
				    square([holder_thickness_mm, holder_height_mm]);

	// Round the ends of the holder
	translate([roll_dia_cm * 5 + holder_thickness_mm / 2, 0, 0]) 
		cylinder(r=holder_thickness_mm, h=holder_height_mm);
	rotate([0,0,-1 * holder_cut_angle]) 
		translate([roll_dia_cm * 5 + holder_thickness_mm / 2, 0, 0]) 
			cylinder(r=holder_thickness_mm, h=holder_height_mm);
}

// Code below from CarryTheWhat Partial Rorate Extrude thing, licensed under LGPL:
//   https://www.thingiverse.com/thing:34027

module partial_rotate_extrude(angle, radius, convex) {
	intersection () {
		rotate_extrude(convexity=convex) translate([radius,0,0]) child(0);
		pie_slice(radius*2, angle, angle/5);
	}
}

module pie_slice(radius, angle, step) {
	for(theta = [0:step:angle-step]) {
		rotate([0,0,0])
		linear_extrude(height = radius*2, center=true)
		polygon(points = [
			  [0,0],
			  [radius * cos(theta+step) ,radius * sin(theta+step)],
			  [radius*cos(theta),radius*sin(theta)]
			 ] 
		);
	}
}
