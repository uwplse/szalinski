//Nut depth in mm.
nut_depth = 15;

//Nut diameter in mm, from cornor to opposing corner.
nut_diameter = 30;

//Nut chamber wall thickness in mm.
wall_thickness = 5;

//diameter of wheel in mm.
wheel_diameter = 80;

//Depth of wheel in mm.
wheel_depth = 7;

/* Hidden */
wheel_radius = wheel_diameter/2;
nut_radius = nut_diameter/2;

include <MCAD/regular_shapes.scad>;

difference() {
	union() {
		linear_extrude(height = wheel_depth) for (r = [0: 5: 115]) rotate([0,0,r]) triangle(wheel_radius);
		cylinder(h = nut_depth, r = nut_radius + wall_thickness); 
	}
	linear_extrude(height = nut_depth) hexagon(nut_radius);
}