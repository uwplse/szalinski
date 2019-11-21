//  RLazure's modification of
//
// DieKatzchen code for Crank Handle Thing:101313
//
//   to hold a screw and a nut in a recess which allows threads to protrude
//
//  Nov 11, 2013
//

/* [Fastener] */
// Diameter of nut in mm
nut_diameter = 7; // [2:14]

// nut height
nut_height = 3;  // [2:10]

// screw diameter in mm
screw_diameter= 5; // [2:14]

// screw head to nut distance
screw_hd2nut= 5; // [3:10]

/* [Arm and Handle] */
// Side wall thickness for nut chamber in mm
side_wall_thickness = 5;  // [4,5,6,7[

// Length of arm in mm, from center of bolt to center of handle
arm_length = 45;  // [20:150]

// Length of handle in mm, the length protruding from the crank
handle_length = 25; // [10:100]

// Diameter of handle in mm
handle_diameter = 17; // [10:50]


/* Hidden */
// adding clearance to nut diameter
nut_radius = (nut_diameter +2) / 2;
handle_radius = handle_diameter / 2;
nut_cyl_radius =  nut_radius + side_wall_thickness;
screw_radius = screw_diameter/2;


include <MCAD/regular_shapes.scad>;

difference() {
	union() {
		cylinder(h = screw_hd2nut+nut_height, r = nut_cyl_radius);
		translate([arm_length,0,0])
			cylinder(h = handle_length + nut_height+screw_hd2nut, r = handle_radius );
		linear_extrude( height = nut_height+screw_hd2nut)
			polygon(points =[ [0,-nut_cyl_radius],[arm_length,-handle_radius],[arm_length,handle_radius],[0,nut_cyl_radius]]);
	}
 union(){
	linear_extrude(height = nut_height) 
		hexagon(nut_radius);
		cylinder(h= screw_hd2nut+nut_height, r = screw_radius,$fn=16);
	}
}

