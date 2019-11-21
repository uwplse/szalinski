////////////////////////////////////////////////////////////////////////////////////////////////////
//													//
//					    Configuration						//
//													//
////////////////////////////////////////////////////////////////////////////////////////////////////

head_width = 18;
head_height = 22;
head_length = 45;
shaft_diamater = 8;
shaft_height = 2;
lid_height = 10;
box_wall_thickness = 1.5;
round_radius = 2;
lid_slop = 0.5;

print_object_spacing = 5;

// increase this to smooth the round parts
$fs = 0.05;

test = false;

print();



////////////////////////////////////////////////////////////////////////////////////////////////////
//													//
//						Models						//
//													//
////////////////////////////////////////////////////////////////////////////////////////////////////

module print() {
	box();
	translate([head_width + box_wall_thickness + print_object_spacing, 0, 0]) {
		lid();
	}
}

module testFit() {
	box();
	translate([-(box_wall_thickness + lid_slop), -(box_wall_thickness + lid_slop), 0]) {
		lid();
	}
}

module closed() {
	box();
	color([0.5, 0.5, 0.5, 0.5]) {
		translate([-(box_wall_thickness + lid_slop), -(box_wall_thickness + lid_slop), head_height + box_wall_thickness * 3]) {
			mirror([0, 0, 1]) {
				lid();
			}
		}
	}
}



////////////////////////////////////////////////////////////////////////////////////////////////////
//													//
//						Parts							//
//													//
////////////////////////////////////////////////////////////////////////////////////////////////////

module box() {
	difference() {
		roundedBox(head_width, head_length, head_height, box_wall_thickness, 5);
		translate([head_width / 2 + box_wall_thickness, box_wall_thickness + 0.01, shaft_height + box_wall_thickness + shaft_diamater / 2]) {
			rotate([90, 0, 0]) {
				cylinder(r = shaft_diamater / 2, h = box_wall_thickness + 0.02);
			}
			translate([-shaft_diamater / 2, -box_wall_thickness - 0.02, 0]) {
				cube([shaft_diamater, box_wall_thickness + 0.02, head_height]);
			}
		}
	}
}

module lid() {
	lid_extra_dimen = (box_wall_thickness + lid_slop) * 2;
	roundedBox(head_width + lid_extra_dimen, head_length + lid_extra_dimen, lid_height, box_wall_thickness, 5);
}



////////////////////////////////////////////////////////////////////////////////////////////////////
//													//
//						Bits							//
//													//
////////////////////////////////////////////////////////////////////////////////////////////////////

module roundedBox(inside_width, inside_length, inside_height, wall_thickness, radius) {
	difference() {
		roundedCube(inside_width + wall_thickness * 2, inside_length + wall_thickness * 2, inside_height + wall_thickness * 2 + radius, radius);

		// cut out the inside
		translate([wall_thickness, wall_thickness, wall_thickness]) {
			roundedCube(inside_width, inside_length, inside_height + radius, radius - wall_thickness);
		}

		//cut off the top
		translate([-0.01, -0.01, inside_height + wall_thickness * 2]) {
			cube([inside_width + wall_thickness * 2 + 0.02, inside_length + wall_thickness * 2 + 0.02, radius + wall_thickness + 0.01]);
		}
	}
}

module roundedCube(width, length, height, radius) {
	difference() {
		cube([width, length, height]);
		if (!test) {
			// round the edges
			roundEdges(width, length, height, radius);
			rotate([90, 0, 90]) {
				roundEdges(length, height, width, radius);
				rotate([90, 0, 90]) {
					roundEdges(height, width, length, radius);
				}
			}
	
			// round the corners
			roundCorners(width, length, height, radius);
			translate([0, 0, height]) {
				mirror([0, 0, 1]) {
					roundCorners(width, length, height, radius);
				}
			}
		}
	}
}

module roundCorners(width, length, height, radius) {
		translate([-0.01, -0.01, -0.01]) { 
			roundCorner(radius);
			translate([width + 0.02, 0, 0]) {
				rotate([0, 0, 90]) {
					roundCorner(radius);
				}
			}
			translate([width + 0.02, length + 0.02, 0]) {
				rotate([0, 0, 180]) {
					roundCorner(radius);
				}
			}
			translate([0, length + 0.02, 0]) {
				rotate([0, 0, 270]) {
					roundCorner(radius);
				}
			}
		}
}

module roundCorner(radius) {
	translate([-0.01, -0.01, -0.01]) {
		difference() {
			cube(radius);
			translate([radius - 0.01, radius - 0.01, radius - 0.01]) {
				sphere(radius);
			}
		}
	}
}

module roundEdges(width, length, height, radius) {
		translate([-0.01, -0.01, -0.01]) { 
			roundExtrusion(radius, height + 0.02);
			translate([width + 0.02, 0, 0]) {
				rotate([0, 0, 90]) {
					roundExtrusion(radius, height + 0.02);
				}
			}
			translate([width + 0.02, length + 0.02, 0]) {
				rotate([0, 0, 180]) {
					roundExtrusion(radius, height + 0.02);
				}
			}
			translate([0, length + 0.02, 0]) {
				rotate([0, 0, 270]) {
					roundExtrusion(radius, height + 0.02);
				}
			}
		}
}

module roundExtrusion(radius, length) {
		linear_extrude(height = length, convexity = 10) {
		roundProfile(radius);
	}
}

module roundProfile(radius) {
	translate([0, radius, 0]) {
		rotate([0, 0, -90]) {
			difference() {
				square([radius, radius]);
				translate([0.01, radius - 0.01, 0]) {
					circle(r = radius);
				}
			}
		}
	}
}