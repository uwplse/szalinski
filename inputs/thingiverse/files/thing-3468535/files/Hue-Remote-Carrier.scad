/***************************************************
 *                                                 *
 *          Carrier for Philips Hue Remote         *
 *                                                 *
 * Designed by: https://www.thingiverse.com/smorgo *
 *                                                 *
 * Probably not much use on its own, but if you    *
 * want to fix a Philips Hue Dimmer Remote to      *
 * something, this may be just the thing you need. *
 *                                                 *
 ***************************************************/
 
// You may want to take the quality down whilst fettling:
$fn=60; // 15 might be better until you're ready to print

// There's a 20mm x 3mm magnet embedded in the carrier for the Hue remote (at the bottom).
// I used a filament change command (M600) to pause the printer so that I could pop the magnet in.

// Alternatively, you can change embed_magnet and glue yours in from behind

embed_magnet = true; /* set to false if you're going to glue it in from behind */
magnet_diameter = 20.4;
magnet_depth = 3.1;
magnetY=-36; // My magnet sits at the bottom, because I'm knocking out a hole in the middle. You can set to 0 if you're not doing that

// The dimensions of the Hue remote
hue_height = 92;
hue_width = 35.1;
hue_depth = 11;
hue_corner_radius = 3;
hue_notch_length = 26;
hue_notch_width = 4.2;
hue_notch_depth = 1.8;
hue_notch_inset = 6.7;

// Dimensions for the supporting frame
hue_locator_height = 1.6;
hue_locator_width = 2;
hue_clearance = 0.4;
hue_base_depth = 8;
hue_base_corner_radius = 1;

// Dimensions for Hue carrier
ow = hue_width + hue_clearance + hue_locator_width *2;
oh = hue_height + hue_clearance + hue_locator_width *2;
od = hue_base_depth + hue_locator_height;
hw = hue_width + hue_clearance;
hh = hue_height + hue_clearance;
hd = hue_locator_height + 0.1;
nw = hue_notch_length + hue_clearance;
nh = hue_notch_width + hue_clearance;
nd = hue_notch_depth*2 + hue_clearance;

// Where to put the magnet, vertically
magnetZ=-1.6;

// The roundedcube function, shamelessy lifted from:
// https://danielupshaw.com/openscad-rounded-corners/
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

module hueCarrier() {

    { 
        {
            difference() {
                roundedcube([ow, oh, od], center = true, radius = hue_corner_radius, apply_to="z");
                translate([0,0,hue_base_depth]) {
                    roundedcube([hw,hh,hd], center=true, radius=hue_corner_radius+hue_clearance, apply_to="z");
                }
                translate([0,hue_height / 2 - hue_notch_inset,(hue_base_depth-hue_notch_depth)/2]) {
                    roundedcube([nw,nh,nd], center=true, radius = hue_notch_width/2);
                }
                magnet();
            }
        }
    }
}

// Knockout a hole for the magnet
module magnet() {
    if(embed_magnet) {
        translate([0, magnetY, magnetZ]) {
            cylinder(d = magnet_diameter, h=magnet_depth);
        }
    } else {
        translate([0, magnetY, magnetZ-50]) {
            cylinder(d = magnet_diameter, h=magnet_depth+50);
        }
    }
}

// Handy if you want to see where the Hue sits
module hue() {
    color("white",0.5) {
        roundedcube([hue_width, hue_height, hue_depth], center=true, radius=hue_corner_radius, apply_to="z");
    }
}

hueCarrier();
