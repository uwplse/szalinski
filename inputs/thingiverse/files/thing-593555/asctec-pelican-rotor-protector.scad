$fn = 50*1;

// Width of the beams
thickness = 5;

// z-Height of the part
height = 5;

// Radius of the outer circle
outer_radius = 150;

// Diameter of the holes for the screws
hole_diameter = 3.3;

// Diagonal distance between the holes
hole_distance = 19;

module outer_quarter_circle() {

	difference() {

		linear_extrude(height = height)
		circle(r = outer_radius);
		
		translate([-outer_radius/2,-outer_radius/2])
		linear_extrude(height = height)
		square([outer_radius,outer_radius], center = true);

		translate([outer_radius/2,-outer_radius/2])
		linear_extrude(height = height)
		square([outer_radius,outer_radius], center = true);

		translate([-outer_radius/2,outer_radius/2])
		linear_extrude(height = height)
		square([outer_radius,outer_radius], center = true);

	}

}

module inner_quarter_circle() {

	difference() {

		linear_extrude(height = height)
		circle(r = outer_radius-thickness);
		
		translate([-outer_radius/2,-outer_radius/2])
		linear_extrude(height = height)
		square([outer_radius+2*thickness,outer_radius+2*thickness], center = true);

		translate([outer_radius/2,-outer_radius/2])
		linear_extrude(height = height)
		square([outer_radius+2*thickness,outer_radius+2*thickness], center = true);

		translate([-outer_radius/2,outer_radius/2])
		linear_extrude(height = height)
		square([outer_radius+2*thickness,outer_radius+2*thickness], center = true);

	}

}

module Hole(diameter, depth, placement=[0, 0, 0]) {

	placement_offset=depth < 0? [0, 0, depth] : [0, 0, 0];
	translate(placement+placement_offset)
	linear_extrude(height=abs(depth))
	circle(r=diameter/2);

}

difference() {

	union() {
	
		difference() {
			outer_quarter_circle();
			inner_quarter_circle();
		}
	
		linear_extrude(height = height)
		circle(r = hole_distance/2+hole_diameter/2+thickness);
		
		rotate([0,0,-45]) {
		translate([0,outer_radius/2,0])
		linear_extrude(height = height)
		square([thickness,outer_radius-thickness/2], center = true);
		}
	
	}

	Hole(hole_diameter, height, [hole_distance/2, 0, 0]);

	Hole(hole_diameter, height, [0, hole_distance/2, 0]);

	Hole(hole_diameter, height, [-hole_distance/2, 0, 0]);

	Hole(hole_diameter, height, [0, -hole_distance/2, 0]);

}
