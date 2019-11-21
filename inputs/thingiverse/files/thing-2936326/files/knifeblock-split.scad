
//customizable options

// Round or square edges
round_edges = 1; // [0:Square Edges, 1:Rounded Edges]

// Split the block into 2 parts to make it fit on smaller printer beds
split_block = 1; // [0:Single Piece, 1:Two Pieces]


// Specify parameters in millimeters or inches. Export will always be in mm
millimeters_or_inches = 25.4; // [1:mm, 25.4:inches]

// Number of blade slots
blade_count = 2;
// Length of the blade slots
blade_length = 9;
// Width of the blade slots
blade_width = 0.125;

// Length of the handle portion
handle_length = 5.5;
// Width of the knife block
width = 2.5;
// Height of the knife block
height = 1;

// Scale of connector tabs (for split block only)
tab_scale = 0.95;

// hidden options
scaled_length = (blade_length + handle_length) * millimeters_or_inches;
scaled_width = width * millimeters_or_inches;
scaled_height = height * millimeters_or_inches;
scaled_blade_length = blade_length * millimeters_or_inches;
scaled_blade_width = blade_width * millimeters_or_inches;
$fs = 0.01*1;
buffer = 0.2*height;



module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}

module knife_block() {
    difference() {
        if (round_edges < 1) {
            cube([scaled_width,scaled_length,scaled_height]);
        }
        else {
            roundedcube([scaled_width,scaled_length,scaled_height], radius = 0.2 * scaled_height, apply_to="zmax");
        }
        union() {
            translate([- buffer / 2, scaled_blade_length, scaled_height * 0.8]) {
                rotate([0, 90, 0]) {
                    cylinder(scaled_width + buffer, scaled_height/2, scaled_height/2, $fn = 64);
                }
            }
            translate([- buffer / 2, scaled_blade_length + 0.46 * scaled_height, scaled_height]) {
                rotate([115, 0, 0]) {
                    cube([scaled_width + buffer,scaled_length,scaled_height]);
                }
            }
            translate([- buffer / 2, scaled_blade_length, scaled_height * 0.3]) {
                rotate([10, 0, 0]) {
                    cube([scaled_width + buffer,scaled_length,scaled_height]);
                }
            }

            translate([- buffer / 2, scaled_blade_length, scaled_height / 2]) {
                rotate([2, 0, 0]) {
                    cube([scaled_width + buffer,scaled_length,scaled_height]);
                }
            }
            for (i = [1:blade_count]) {
                translate([(scaled_width * i) / (blade_count + 1) - scaled_blade_width/2, -buffer, scaled_height * 0.35]) {
                    cube([scaled_blade_width,scaled_blade_length + buffer, scaled_height]);
                }
            }
        }
    }
}

module tab(cylinder_radius, cylinder_height, length) {
    tab_height = cylinder_height / 2;
    translate([0, -length/2, 0]) {
        union() {
            cylinder(cylinder_height, cylinder_radius, cylinder_radius, $fn = 64);
            translate([0, length, 0]) {
                cylinder(cylinder_height, cylinder_radius, cylinder_radius, $fn = 64);
            }
            translate([-cylinder_radius / 2, 0, 0]) {
            cube([cylinder_radius, length, tab_height]);
            }
        }
    }
}

if (split_block <= 0) {
    knife_block();
} else {
    split_point = scaled_blade_length * 0.8;
    tab_length = scaled_length / 20;
    tab_radius = 0.25 * scaled_width / (blade_count + 1);
    translate([0, -split_point, 0]) {
        difference() {
            knife_block();
            translate([-buffer / 2, -buffer, -buffer / 2]) {
                cube([scaled_width + buffer, split_point + buffer, scaled_height + buffer]);
            }
            translate([scaled_width / (blade_count +1) / 2, split_point, 0]) {
                #tab(tab_radius, scaled_height * 0.3, tab_length);
            }
            translate([scaled_width - scaled_width / (blade_count +1) / 2, split_point, 0]) {
                #tab(tab_radius, scaled_height * 0.3, tab_length);
            }
        }
    }

    translate([scaled_width * 1.2, 0, 0]) {
         difference() {
            knife_block();
            translate([-buffer / 2, split_point, -buffer / 2]) {
                cube([scaled_width + buffer, scaled_length - split_point + buffer, scaled_height + buffer]);
            }
            translate([scaled_width / (blade_count +1) / 2, split_point, 0]) {
                #tab(tab_radius, scaled_height * 0.3, tab_length);
            }
            translate([scaled_width - scaled_width / (blade_count +1) / 2, split_point, 0]) {
                #tab(tab_radius, scaled_height * 0.3, tab_length);
            }
        }
    }
    
    translate([scaled_width * 2.4, tab_length, 0]) {
        tab(tab_radius * tab_scale, scaled_height * 0.3, tab_length);
    }

    translate([scaled_width * 2.4, 3 * (tab_radius + tab_length), 0]) {
        tab(tab_radius * tab_scale, scaled_height * 0.3, tab_length);
    }

}