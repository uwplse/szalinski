/* [Tap Settings] */
// Tap square size in mm
tap_size = 12; // [0:0.01:100]

// Height of the "tap sleeve" in mm
tap_height = 12; // [0:0.1:50]

// Size of the small holes in the corners of the squares in mm
flex_hole_diameter = 1; // [0:0.1:10]

/* [Grip Settings] */

// in mm
grip_length = 50; // [0:1:200]

// in mm
grip_width = 12; // [0:0.1:50]

// in mm
grip_height = 8; // [0:0.1:50]

/* [General Settings] */

// Thickness at the flex holes in mm
material_thickness = 3; // [1:0.1:50]

// in mm, can be deactivated with <debug=true>
roundness = 2; // [0:0.1:10]

/* [Output Settings] */
// Round edges off?
debug = false; // [0:false, 1:true]

// Global $fn value
resolution = 20; // [8:2:100]

/* [Hidden] */

$fn = resolution;

tapWrench(
	tap_size,
	tap_height,
	flex_hole_diameter,
	grip_length,
	grip_width,
	grip_height,
	material_thickness,
	roundness,
	debug
);

module tapWrench(tap_size, tap_hegiht, flex_hole_diameter, grip_length, grip_width, grip_height, material_thickness, roundness, debug) {
	difference() {
		union() {
			solidTapWrenchCenter(tap_size, flex_hole_diameter, material_thickness, tap_height, debug, roundness);
			grip(tap_size, flex_hole_diameter, material_thickness, debug, roundness);
		}
		tapHole(tap_size, flex_hole_diameter, tap_height);
	}
}

module solidTapWrenchCenter(tap_size, flex_hole_diameter, material_thickness, tap_height, debug, roundness) {
	diameter = diameter(tap_size, flex_hole_diameter, material_thickness);

	if(debug || roundness==0) {
		cylinder(d=diameter, h=tap_height);
	} else {
		difference() {
			cylinder(d=diameter, h=tap_height);
			carveRoundCylinder(diameter, roundness);
			translate([0,0,tap_height]) {
				rotate([180,0,0]) {
					carveRoundCylinder(diameter, roundness);
				}
			}
		}
	}
}

module grip(tap_size, flex_hole_diameter, material_thickness) {
	diameter = diameter(tap_size, flex_hole_diameter, material_thickness);
	
	translate([-(diameter / 2 + grip_length),-grip_width/2,0]) {
		rcube([diameter + 2*grip_length, grip_width, grip_height], radius=roundness, debug=debug);
	}
}

module tapHole(tap_size, flex_hole_diameter, tap_height) {
	translate([-tap_size/2, -tap_size/2, -1]) {
		union() {
			cube([tap_size, tap_size, tap_height + 2]);
			cylinder(d=flex_hole_diameter, h=tap_height + 2);
			translate([tap_size,0,0]) {
				cylinder(d=flex_hole_diameter, h=tap_height + 2);
			}
			translate([tap_size,tap_size,0]) {
				cylinder(d=flex_hole_diameter, h=tap_height + 2);
			}
			translate([0,tap_size,0]) {
				cylinder(d=flex_hole_diameter, h=tap_height + 2);
			}
		}
	}
}

module carveRoundCylinder(diameter, roundness) {
	translate([0, 0, roundness]) {
		rotate_extrude() {
			translate([diameter/2-roundness, 0, 0]) {
				difference() {
					translate([(roundness + 1)/2, ((roundness - 1)/2) - roundness, 0]) {
						square([roundness + 1, roundness + 1], center = true);
					}
					circle(r = roundness);
				}
			}
		}
	}
}

function diameter(tap_size, flex_hole_diamter, material_thickness) = sqrt(2)*tap_size + 2*flex_hole_diameter + 2*material_thickness;


// Helper Modules
module rcube(size=[1,1,1], center=false, radius=1, debug=false) {
	
	module roundEdge(length, translation=[0,0,0], rotation=[0,0,0]) {
		translate(translation) {
			rotate(rotation) {
				difference() {
					translate([(radius)/2 + 1/4,(radius)/2 + 1/4,0]) {
						cube([radius + 1, radius + 1, length + 4], center=true);
					}
					cylinder(h=length + 2, r=radius, center=true);
				}
			}
		}
	}
	module roundFullCorner(translation=[0,0,0], rotation=[0,0,0]) {
		translate(translation) {
			rotate(rotation) {
				difference() {
					cube([radius + 1, radius + 1, radius + 1]);
					sphere(r=radius);
				}
			}
		}			
	}
	
	if(debug || radius==0) {
		cube(size=size, center=center);
	} else {
	
		translation = center ? [0,0,0] : size / 2;
	
		translate(translation) {
	
			difference() {
				cube(size=size, center=true);
		
				union() {
					x = size[0];
					y = size[1];
					z = size[2];
			
					// edges
					roundEdge(x,[0,-y/2 + radius,-z/2 + radius],[180,90,0]);
					roundEdge(y,[x/2 - radius,0,-z/2 + radius],[90,90,0]);
					roundEdge(x,[0,y/2 - radius,-z/2 + radius],[0,90,0]);
					roundEdge(y,[-x/2 + radius,0,-z/2 + radius],[90,180,0]);
					roundEdge(z,[-x/2 + radius,-y/2 + radius,0],[0,0,180]);
					roundEdge(z,[x/2 - radius,-y/2 + radius,0],[0,0,270]);
					roundEdge(z,[-x/2 + radius,y/2 - radius,0],[0,0,90]);
					roundEdge(z,[x/2 - radius,y/2 - radius,0],[0,0,0]);
					roundEdge(x,[0,-y/2 + radius,-z/2 + radius],[180,90,0]);
					roundEdge(x,[0,-y/2 + radius,z/2 - radius],[180,270,0]);
					roundEdge(y,[x/2 - radius,0,z/2 - radius],[270,270,0]);
					roundEdge(x,[0,y/2 - radius,z/2 - radius],[0,270,0]);
					roundEdge(y,[-x/2 + radius,0,z/2 - radius],[270,180,0]);

					// corners
					roundFullCorner([-x/2 + radius,-y/2 + radius,-z/2 + radius], [180,90,0]);
					roundFullCorner([x/2 - radius,-y/2 + radius,-z/2 + radius], [180,0,0]);
					roundFullCorner([x/2 - radius,y/2 - radius,-z/2 + radius], [0,90,0]);
					roundFullCorner([-x/2 + radius,y/2 - radius,-z/2 + radius], [0,180,0]);
					roundFullCorner([-x/2 + radius,-y/2 + radius,z/2 - radius], [0,0,180]);
					roundFullCorner([x/2 - radius,-y/2 + radius,z/2 - radius], [0,0,270]);
					roundFullCorner([x/2 - radius,y/2 - radius,z/2 - radius], [0,0,0]);
					roundFullCorner([-x/2 + radius,y/2 - radius,z/2 - radius], [0,0,90]);
				}
			}
		}
	}
}
