// Diameter of nut in mm
nut_diameter = 30;

// Depth of nut in mm
nut_depth = 15;

// Side wall thickness for nut chamber in mm
side_wall_thickness = 5;

// Length of arm in mm, from center of bolt to center of handle
arm_length = 100;

// Length of handle in mm, the length protruding from the crank
handle_length = 50;

// Diameter of handle in mm
handle_diameter = 20;


/* Hidden */
handle_radius = handle_diameter / 2;
nut_radius = nut_diameter / 2;
nut_cyl_radius =  nut_radius + side_wall_thickness;

include <MCAD/regular_shapes.scad>;

difference() {
	union() {
		cylinder(h = nut_depth, r = nut_cyl_radius);
		translate([arm_length,0,0])
			cylinder(h = handle_length + nut_depth, r = handle_radius );
		linear_extrude( height = nut_depth)
			polygon(points =[ [0,-nut_cyl_radius],[arm_length,-handle_radius],[arm_length,handle_radius],[0,nut_cyl_radius]]);
	}
	linear_extrude(height = nut_depth) {
		hexagon(nut_radius);
	}
}
