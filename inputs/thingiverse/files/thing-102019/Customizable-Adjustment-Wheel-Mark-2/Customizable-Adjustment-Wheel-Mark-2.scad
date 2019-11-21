//Nut depth in mm.
nut_depth = 15;

//Nut diameter in mm, from cornor to opposing corner.
nut_diameter = 30;

//Nut chamber wall thickness in mm.
wall_thickness = 5;

//Diameter of wheel in mm.
wheel_diameter = 80;

//Depth of wheel in mm.
wheel_depth = 7;

//Number of notches in the wheel.
notch_count = 25;

//Diameter of the notches in mm.
notch_diameter = 7;

/* [Hidden] */
wheel_radius = wheel_diameter/2;
nut_radius = nut_diameter/2;
notch_radius = notch_diameter/2;

include <MCAD/regular_shapes.scad>;

difference() {
	union() {
		cylinder(h = wheel_depth, r = wheel_radius);
		cylinder(h = nut_depth, r = nut_radius + wall_thickness); 
	}

	linear_extrude(height = nut_depth) hexagon(nut_radius); /*nut cutout*/
	
	/*notches*/
	for (i = [0: notch_count - 1]) {
		rotate(v = [0,0,1], a = i*360/notch_count)
		translate([0,wheel_radius,0])
		cylinder(h = wheel_depth, r = notch_radius);
	}
}