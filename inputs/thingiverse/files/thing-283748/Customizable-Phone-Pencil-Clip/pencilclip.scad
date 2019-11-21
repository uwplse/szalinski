// Customizable Phone Pencil Clip
// preview[view:south, tilt:top];

use <MCAD/regular_shapes.scad>;

/* [Phone] */

phone_width = 59.5;

phone_thickness = 9;

// Radius of phone cross section curvature from sides to face. Set to 0 for square corners.
phone_face_radius = 1;

// Radius of phone cross section curvature from sides to back. Set to 0 for square corners.
phone_back_radius = 3;

/* [Pencil] */

// Determines shape of pencil socket in clip.
pencil_shape = 6; // [0:Circular, 6:Hexagonal]

// For hexagonal pencils, measure the diameter from flat side to side, not from corner to corner. 
pencil_diameter = 7;

// Adjust orientation of pencil socket. Doesn't really matter for circular pencils.
pencil_rotation = 30; // [0:360]

/* [Clip] */

// Width of clip grips on front face of phone, not counting rounded ends. Recommended values >= phone face radius.
clip_inset = 1;

// Minimum thickness of clip walls, including separation between phone and pencil socket.
clip_walls = 2;

// Alternatively, just scale Z dimension to desired height in your print software.
clip_height = 15;

/* [Hidden] */

$fn = 60;

// radius from apothem (distance from center to midpoint of reg polygon flat sides)
function rfa(sides, apothem) = apothem / cos(180 / sides);

pencil_radius = (pencil_shape == 0 ? pencil_diameter / 2 : rfa(pencil_shape, pencil_diameter / 2));

linear_extrude(height=clip_height) Clip();

module Clip() {

	union() {

		// 4. Subtract part holes and clip face opening from clip outline.
		difference() {
		
			// 3. ...and roll it around the parts outline to inflate it to clip outline
			minkowski() {
				
				// 2. We take a circle with radius equal to clip thickness...
				circle(r=clip_walls);
				
				// 1. The convex hull of Parts is the smallest shape containing
				//    both the phone and pencil holder within its outline.
				hull() Parts();
			}
			
			union() Parts();
			Face();
		}

		// only add round nubbins if inset > front_radius)
		if (clip_inset >= phone_face_radius) {
			translate([clip_inset, phone_thickness + (clip_walls/2), 0]) circle(r=clip_walls/2);
			translate([phone_width - clip_inset, phone_thickness + (clip_walls/2), 0]) circle(r=clip_walls/2);
		}
	}
}

module Face() {
	// triple height face to ensure clean cut through front of clip
	translate([clip_inset, phone_thickness - clip_walls, 0])
	square([phone_width - (clip_inset * 2), clip_walls * 3]);
}

// Phone and holder cross sections positioned together
module Parts() {
	Phone();

	translate([phone_width + pencil_radius + clip_walls, phone_thickness - pencil_radius, 0]) Holder();
}

module Phone() {
	// Convex hull of the corners is the shape of the phone cross section
	hull() {

		// Corners from sides to front face
		if (phone_face_radius == 0) {
			translate([0, phone_thickness-1, 0]) square(1);
			translate([phone_width-1, phone_thickness-1, 0]) square(1);
		}
		else {
			translate([phone_face_radius, phone_thickness-phone_face_radius, 0]) circle(r = phone_face_radius);
			translate([phone_width-phone_face_radius, phone_thickness-phone_face_radius, 0]) circle(r=phone_face_radius);
		}
		
		// Corners from back surface to sides
		if (phone_back_radius == 0) {
			translate([0, 0, 0]) square(1);
			translate([phone_width-1, 0, 0]) square(1);
		}
		else {
			translate([phone_width-phone_back_radius, phone_back_radius, 0]) circle(r=phone_back_radius);
			translate([phone_back_radius, phone_back_radius, 0]) circle(r=phone_back_radius);
		}
	}
}

module Holder() {
	if (pencil_shape == 0) {
		circle(r=pencil_radius);
	}
	else {
		// circle(r=pencil_radius, $fn=pencil_shape) will work as a vanilla way to make a reg_polygon.
		rotate([0, 0, pencil_rotation]) reg_polygon(sides=pencil_shape, radius=pencil_radius);
	}
}