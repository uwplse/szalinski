/* [INGA Type] */
part = "top"; // [top:INGA with power connector on top,bottom:INGA with power connector on bottom,custom:INGA with custom size]

/* [INGA Power on Top] */
// Thickness of the circuit board in mm
top_inga_depth_board = 1.8;
// Overhead on top of the circuit board in mm
top_inga_depth_top = 6;
// Overhead on bottom of the circuit board in mm
top_inga_depth_bottom = 1.8;

/* [INGA Power on Bottom] */
// Thickness of the circuit board in mm
bottom_inga_depth_board = 2;
// Overhead on top of the circuit board in mm
bottom_inga_depth_top = 4;
// Overhead on bottom of the circuit board in mm
bottom_inga_depth_bottom = 4.03;

/* [INGA Custom Size] */
// Thickness of the circuit board in mm
custom_inga_depth_board = 2;
// Overhead on top of the circuit board in mm
custom_inga_depth_top = 4;
// Overhead on bottom of the circuit board in mm
custom_inga_depth_bottom = 4.03;

inga_depth_board = (part == "top") ? top_inga_depth_board : (part == "bottom") ? bottom_inga_depth_board : custom_inga_depth_board;
inga_depth_top = (part == "top") ? top_inga_depth_top : (part == "bottom") ? bottom_inga_depth_top : custom_inga_depth_top;
inga_depth_bottom = (part == "top") ? top_inga_depth_bottom : (part == "bottom") ? bottom_inga_depth_bottom : custom_inga_depth_bottom;

/* [Component Sizes] */
// Width of INGA in mm
inga_width_raw = 50.4;
// Height of INGA in mm
inga_height_raw = 39.81;

// Width of Battery in mm
battery_width_raw = 49.6;
// Height of Battery in mm
battery_height_raw = 33.37;
// Depth of Battery in mm
battery_depth_raw = 6.22;

// Safety margin arround all components in mm
margin = 1;

/* [Geometric Offsets] */
// X Offset of top part in mm
inga_offset_x = 0;
// Y Offset of top part in mm
inga_offset_y = 70;
inga_width = inga_width_raw + margin;
inga_height = inga_height_raw + margin;

inga_depth = inga_depth_top + inga_depth_board + inga_depth_bottom + margin;

// X Offset of bottom part in mm
battery_offset_x = 0;
// Y Offset of bottom part in mm
battery_offset_y = 0;
battery_width = battery_width_raw + margin;
battery_height = battery_height_raw + margin;
battery_depth = battery_depth_raw + margin;

// X Offset of button relative to top part in mm
button_x = 45;
// Y Offset of button relative to top part in mm
button_y = 32;
button_height = inga_depth_top;
// How far shall the button be pressable in mm?
button_pressing = 2;
// Diameter of button im mm
button_diameter = 2.5;
// Distance to button-holder in mm
button_distance = .6;
// Thickness of button-holder walls in mm
button_walls = 1;
// Initial position of button in mm (should be 0 for printing!)
button_pos = 0;

/* [Enclosure Parameters] */
// Thickness of walls of enclosure in mm
enclosure_walls = 1;
// Minimum wall thickness of enclosure in mm
enclosure_min_walls = 0.75;
// Minimum wall thickness of enclosure in mm
enclosure_distance = 0.35;
enclosure_width = enclosure_walls + max(inga_width, battery_width) + enclosure_walls;
enclosure_height = enclosure_walls + max(inga_height, battery_height + 2) + enclosure_walls;
enclosure_depth = enclosure_walls + inga_height + battery_height + enclosure_walls;
// Radius of the rounded edges in mm
enclosure_radius = 1.5;

// Diameter of the closing pin (paperclip works)
closer_diameter = 1.5;
// Wall thickness for the closing mechanism
closer_walls = 2;

light_guide_1_x = enclosure_walls + inga_width - 8.8;
light_guide_1_y = enclosure_walls + inga_height - 4.2;
light_guide_2_x = enclosure_walls + inga_width - 8.8;
light_guide_2_y = enclosure_walls + 21.8;
light_guide_3_x = enclosure_walls + 8;
light_guide_3_y = enclosure_walls + 22;

$fn = 35;

module block(height, width, depth) {
	hull() {
		// Block
		translate([enclosure_radius, enclosure_radius, enclosure_radius]) {
			cube([width - 2 * enclosure_radius, height - 2 * enclosure_radius, depth - enclosure_radius]);
		}

		// Round Corners
		translate([enclosure_radius, enclosure_radius, enclosure_radius]) {
			cylinder(depth - enclosure_radius, enclosure_radius, enclosure_radius);
		}
		translate([width - enclosure_radius, height - enclosure_radius, enclosure_radius]) {
			cylinder(depth - enclosure_radius, enclosure_radius, enclosure_radius);
		}
		translate([enclosure_radius, height - enclosure_radius, enclosure_radius]) {
			cylinder(depth - enclosure_radius, enclosure_radius, enclosure_radius);
		}
		translate([width - enclosure_radius, enclosure_radius, enclosure_radius]) {
			cylinder(depth - enclosure_radius, enclosure_radius, enclosure_radius);
		}

		// Round lower edges
		translate([enclosure_radius, enclosure_radius, enclosure_radius]) {
			rotate([0, 90, 0]) {
				cylinder(width - 2 * enclosure_radius, enclosure_radius, enclosure_radius);
			}
		}

		translate([enclosure_radius, height - enclosure_radius, enclosure_radius]) {
			rotate([0, 90, 0]) {
				cylinder(width - 2 * enclosure_radius, enclosure_radius, enclosure_radius);
			}
		}

		translate([enclosure_radius, enclosure_radius, enclosure_radius]) {
			rotate([-90, 0, 0]) {
				cylinder(height - 2 * enclosure_radius, enclosure_radius, enclosure_radius);
			}
		}

		translate([width - enclosure_radius, enclosure_radius, enclosure_radius]) {
			rotate([-90, 0, 0]) {
				cylinder(height - 2 * enclosure_radius, enclosure_radius, enclosure_radius);
			}
		}
	}
}

module light_guide(height, width, depth) {
	difference() {
		cube([height, width, depth]);
	
		translate([enclosure_distance, enclosure_distance, -enclosure_walls / 2]) {
			cube([height - 2 * enclosure_distance, width - 2 * enclosure_distance, depth + 1]);
		}
	}
}

module mounter(height, length, diameter) {
	bore = diameter / 2;
	width = 2 * bore + closer_walls * 2;

	rotate(a=[0, 90, 0]) {
		difference() {
			union() {
				translate([-height, closer_walls + bore, 0]) {
					cylinder(length, bore + closer_walls, bore + closer_walls);
				}

				rotate(a=[0, -90, 0]) {
					polyhedron(points = [
							[0, -1, 0], [0, -1, height], [0, width, height],
							[length, -1, 0], [length, -1, height], [length, width, height],
						], triangles = [
							[2, 1, 0], [5, 3, 4], 
							[0, 3, 2], [2, 3, 5],
							[3, 0, 1], [3, 1, 4], 
							[1, 2, 4], [4, 2, 5],
						]
					);
				}
			}
		
			translate([-height, closer_walls + bore, -1]) {
				cylinder(length + 2, bore, bore);
			}
		}
	}
}

module closer(height, width, depth) {
	length = width - enclosure_distance;

	translate([0, enclosure_walls, 0]) {
		mirror([0, 1, 0]) {
			polyhedron(points = [
					[0, -0.2, 0], [0, -0.2, depth], [0, enclosure_walls * 2, depth],
					[length, -0.2, 0], [length, -0.2, depth], [length, enclosure_walls * 2, depth],
				], triangles = [
					[2, 1, 0], [5, 3, 4], 
					[0, 3, 2], [2, 3, 5],
					[3, 0, 1], [3, 1, 4], 
					[1, 2, 4], [4, 2, 5],
				]
			);
		}
	}

	translate([0, - enclosure_walls, depth]) {
		cube([length, enclosure_walls * 2, height]);
	}

	translate([0, enclosure_walls, depth + height - 1]) {
		cube([length, enclosure_distance / 2, 1]);
	}

	translate([- enclosure_distance, 0, depth + height - 2]) {
		cube([enclosure_distance, enclosure_walls, 1]);
	}

	translate([length, 0, depth + height - 2]) {
		cube([enclosure_distance, enclosure_walls, 1]);
	}
}


// Lower Part
translate([battery_offset_x, battery_offset_y, 0]) {
	difference() {
		union() {
			difference() {
				block(enclosure_height, enclosure_width, enclosure_walls + battery_depth);
				
				// Battery
				translate([enclosure_walls, enclosure_walls, enclosure_walls]) {
					cube([battery_width, battery_height, battery_depth + 1]);
				}
			}
		
			// Battery holders
			translate([enclosure_walls + battery_width - 1, enclosure_walls + battery_height - 5, enclosure_walls + battery_depth - 2]) {
				cube([1, 5, 2]);
			}
		
			translate([enclosure_walls + battery_width - 1, enclosure_walls, enclosure_walls + battery_depth - 2]) {
				cube([1, 5, 2]);
			}
		
			// Klappmechanismus
			translate([enclosure_width / 4 * 1 + enclosure_distance, enclosure_height + 0.5, enclosure_radius]) {
				mounter(enclosure_walls + battery_depth - enclosure_radius, enclosure_width / 2 - enclosure_distance * 2, closer_diameter);
			}
		
			// Schließmechanismus
			translate([enclosure_width / 2 - 10, -enclosure_walls, enclosure_radius]) {
				closer(6 - enclosure_radius, 10, enclosure_walls + battery_depth - 2);
			}
		
			// Inga Antenna Support
			translate([enclosure_walls + 3, enclosure_walls + battery_height, enclosure_walls + battery_depth]) {
				cube([battery_width - 10, enclosure_height - battery_height - enclosure_walls * 2 - 1, inga_depth - inga_depth_top - inga_depth_board - enclosure_distance]);
			}
		}

		// Battery cables
		translate([enclosure_walls + 5, enclosure_walls + battery_height - 1, enclosure_walls]) {
			cube([11, 3, battery_depth + inga_depth]);
		}
	}
}


// Upper Part
translate([inga_offset_x, inga_offset_y, 0]) {
	difference() {
		block(enclosure_height, enclosure_width, enclosure_walls + inga_depth);

		// INGA
		translate([enclosure_walls, enclosure_walls, enclosure_walls]) {
			cube([inga_width, inga_height, inga_depth + 1]);
		}
	
		// USB
		translate([- 1, enclosure_walls + 18, enclosure_walls + max(inga_depth_top - 4, 0)]) {
			cube([enclosure_walls + 2, 8.2, 5]);
		}
	
		// Switch
		translate([- 1, enclosure_walls + 30.5, enclosure_walls + max(inga_depth_top - 2, 0)]) {
			cube([enclosure_walls + 2, 5, 2.5]);
		}

		// Switch opening
		translate([-1, enclosure_walls + 28, enclosure_walls + max(inga_depth_top - 3.25, 0)]) {
			cube([min(enclosure_walls / 2, enclosure_walls - enclosure_min_walls) + 1, 10, 5]);
		}

		// SD Card Slot
		translate([enclosure_walls + 1, enclosure_walls + inga_height - 1, enclosure_walls + inga_depth_top + inga_depth_board - 0.2]) {
			cube([12.25 + margin, enclosure_walls + 2, 2]);
		}
	
		// INGA Button hole
		translate([button_x, button_y, -1]) {
			cylinder(enclosure_walls + 2, button_diameter + button_distance, button_diameter + button_distance);
		}

		// Cable Gap	
		translate([enclosure_walls + inga_width - 1, 18, enclosure_walls]) {
			cube([1 + min(enclosure_walls / 2, enclosure_walls - enclosure_min_walls), 5, inga_depth + 1]);
		}

		// Light Guide thinner case
		translate([light_guide_1_x + enclosure_distance, light_guide_1_y + enclosure_distance, enclosure_distance]) {
			cube([4.5 - 2 * enclosure_distance, 4 - 2 * enclosure_distance, enclosure_walls]);
		}
		translate([light_guide_2_x + enclosure_distance, light_guide_2_y + enclosure_distance, enclosure_distance]) {
			cube([4.5 - 2 * enclosure_distance, 4 - 2 * enclosure_distance, enclosure_walls]);
		}
		translate([light_guide_3_x + enclosure_distance, light_guide_3_y + enclosure_distance, enclosure_distance]) {
			cube([4.5 - 2 * enclosure_distance, 4 - 2 * enclosure_distance, enclosure_walls]);
		}
	}	

	// USB Support
	translate([enclosure_walls, enclosure_walls + 18, enclosure_walls]) {
		cube([enclosure_walls + 2, 9, max(inga_depth_top - 4, 0)]);
	}

	// Switch Support
	translate([enclosure_walls, enclosure_walls + 29.5, enclosure_walls]) {
		cube([3, 7, max(inga_depth_top - 1.5, 0)]);
	}

	// Klappmechanismus
	mirror([0, 1, 0]) {
		translate([enclosure_width / 4 * 0 + enclosure_radius, 0.5, enclosure_radius]) {
			mounter(enclosure_walls + inga_depth - enclosure_radius, enclosure_width / 4 - enclosure_radius, closer_diameter);
		}

		translate([enclosure_width / 4 * 3, 0.5, enclosure_radius]) {
			mounter(enclosure_walls + inga_depth - enclosure_radius, enclosure_width / 4 - enclosure_radius, closer_diameter);
		}
	}

	// Light Guides
	translate([light_guide_1_x, light_guide_1_y, enclosure_walls]) {
		light_guide(4.5, 4, inga_depth_top - 0.4);
	}
	translate([light_guide_2_x, light_guide_2_y, enclosure_walls]) {
		light_guide(4.5, 4, inga_depth_top - 0.4);
	}
	translate([light_guide_3_x, light_guide_3_y, enclosure_walls]) {
		light_guide(4.5, 4, inga_depth_top - 0.4);
	}

	union() {
		// Button
		translate([button_x, button_y, button_pos]) {
			cylinder(button_height + button_pressing - 1, button_diameter, button_diameter);
			cylinder(button_height + button_pressing, button_diameter, button_diameter / 2);
		}
		
		// Button Ring
		translate([button_x, button_y, button_pos + button_height + button_pressing - 2]) {
			cylinder(.75, button_diameter, button_diameter + button_distance + button_walls);
			translate([0, 0, 0.75]) {
				cylinder(0.25, button_diameter + button_distance + button_walls, button_diameter + button_distance + button_walls);
			}			
		}
	}
	
	// Button Holder
	difference() {
		translate([button_x, button_y, enclosure_walls]) {
			cylinder(inga_depth_top - 1 - 1 - 0.5 - 1, button_diameter + button_distance + button_walls, button_diameter + button_distance + button_walls);
		}
	
		translate([button_x, button_y, 0]) {
			cylinder(20, button_diameter + button_distance, button_diameter + button_distance);
		}
	}
	
	// INGA Antenna support
	translate([enclosure_walls, enclosure_walls, enclosure_walls]) {
		cube([10, 14, inga_depth_top]);
	}
	translate([enclosure_walls + inga_width - 10, enclosure_walls, enclosure_walls]) {
		cube([10, 14, inga_depth_top]);
	}

	// INGA Antenna Festklemmer
	translate([enclosure_walls + inga_width - 10, enclosure_walls, enclosure_walls + inga_depth_top]) {
		cube([10, margin * 0.75, inga_depth_board]);
	}
	translate([enclosure_walls + inga_width - margin * 0.5, enclosure_walls, enclosure_walls + inga_depth_top]) {
		cube([margin * 0.5, 14, inga_depth_board]);
	}

	// INGA Holder near USB
	translate([enclosure_walls, enclosure_walls, enclosure_walls + inga_depth_top + inga_depth_board + enclosure_distance]) {
		cube([0.75, 14, min(1, inga_depth_bottom)]);
	}
	translate([enclosure_walls, enclosure_walls + inga_height - 14, enclosure_walls + inga_depth_top + inga_depth_board + enclosure_distance]) {
		cube([0.75, 14, min(1, inga_depth_bottom)]);
	}

	// INGA Holder near LED
	translate([enclosure_walls + inga_width - 7, enclosure_walls + inga_height - 1, enclosure_walls + inga_depth_top + inga_depth_board + enclosure_distance]) {
		cube([4, 1, 1]);
	}

	// INGA Logo Support
	translate([enclosure_walls + 30, enclosure_walls + 30, enclosure_walls]) {
		cylinder(inga_depth_top, 3, 3);
	}

	// INGA Holding Pin
//	translate([enclosure_walls + 47.5, enclosure_walls + 13.5, enclosure_walls]) {
//		cylinder(inga_depth, 0.75, 0.75);
//	}

	// Schließmechanismus
	translate([enclosure_width / 2, enclosure_height + enclosure_walls, enclosure_radius]) {
		mirror([0, 1, 0]) {
			closer(6 - enclosure_radius, 10, enclosure_walls + inga_depth - 2);
		}
	}
}