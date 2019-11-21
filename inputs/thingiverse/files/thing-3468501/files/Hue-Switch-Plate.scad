/***************************************************
 *                                                 *
 *    UK Switch Cover for Philips Hue Remote       *
 *                                                 *
 * Designed by: https://www.thingiverse.com/smorgo *
 *                                                 *
 * Originally inspired by this design:             *
 *     https://www.thingiverse.com/thing:2566908   *
 *                                                 *
 * I needed to adjust some dimensions (the depth   *
 * of the faceplate, primarily) but since I work   *
 * mostly in OpenSCAD, I decided to go back to     *
 * square one and create it from scratch.          *
 *                                                 *
 ***************************************************/
 
// You may want to take the quality down whilst fettling:
$fn=60; // 15 might be better until you're ready to print

// The fixing screws. I couldn't find out what the official spacing
// is for a UK light switch. I measured 60.4mm and it seems to fit OK!
screw_spacing = 60.4;
screw_diameter = 3.6;    // Screws are 3.5mm, but we need a little clearance
screw_head_diameter = 7; // We're going to counterbore the holes
screw_head_depth = 3;    // And countersink them

// The sizes of the original switch plate. They do seem to vary a little
switch_depth = 7.8;
switch_height = 86;
switch_width = 86;
switch_clearance = 0.5; // A little breathing space
rocker_height = 5.6;    // We're covering the original rocker, so we need space for it

// Cut a hole si that you can reach the original switch, once the Hue remote is removed.
// This may be big enough for a double switch; I haven't checked.
// For a triple, you may need to do a little more work to clear the rockers
// but still leave some faceplate!
switch_cutout_width =  34; 
switch_cutout_height = 34;

// There's a 20mm x 3mm magnet embedded in the carrier for the Hue remote (at the bottom).
// I used a filament change command (M600) to pause the printer so that I could pop the magnet in.

// Alternatively, you can change embed_magnet and glue yours in from behind

embed_magnet = true; /* set to false if you're going to glue it in from behind */
magnet_diameter = 20.4;
magnet_depth = 3.1;
magnetY=-36;

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
hue_base_depth = 5;
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

// I wanted the carrier to sit quite low, but you may prefer to tweak this
hue_z = rocker_height + switch_clearance + hd/2;

// Where to put the magnet, vertically
magnetZ=hue_z - magnet_depth - 1.4;

// Calculating the overall dimensions of the main cover (without the Hue carrier)    
height = hue_height + hue_clearance + hue_locator_width * 2.6;
width = switch_width + 6;
depth = switch_depth + 10;

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

// Initially taken from:
// https://gist.github.com/Stemer114/af8ef63b8d10287c825f
// However, I tweaked it slightly to allow for a counterbore.
module screw_countersunk(
        l=20,   //length
        dh = 6,   //head dia
        lh = 3,   //head length
        ds = 3.2,  //shaft dia
        recess = 0
        )
{
    rotate([180,0,0])
    union() {
        if(recess > 0) {
            cylinder(h=recess, d=dh);
        }
        translate([0,0,recess]) {
            cylinder(h=lh, r1=dh/2, r2=ds/2);
            cylinder(h=l, d=ds);
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
                translate([0,hue_height / 2 - hue_notch_inset,-hue_notch_depth/2]) {
                    roundedcube([nw,nh,nd], center=true, radius = hue_notch_width/2);
                }
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

module faceplate() {
    difference() {
        roundedcube([width, height, depth], center=true, radius = 3, apply_to = "zmax");
        translate([-screw_spacing/2,0,depth/2 + 0.1])
            screw_countersunk(dh = screw_head_diameter, lh = screw_head_depth, ds = screw_diameter, recess = 1);
        translate([screw_spacing/2,0,depth/2 + 0.1])
            screw_countersunk(dh = screw_head_diameter, lh = screw_head_depth, ds = screw_diameter, recess = 1);
    }
}

module main() {
    difference() {
        union() {
            difference() {
                faceplate();
                    translate([0,0,hue_z]) {
                        roundedcube([ow, oh, od], center = true, radius = hue_corner_radius, apply_to="z");
                    }
            }
            translate([0,0,hue_z]) {
                hueCarrier();
            }
        }
    
        cube([switch_cutout_width, switch_cutout_height, depth*2+0.2], center=true);
    
        translate([0,0,-(depth-switch_depth+switch_clearance)/2]) {
            cube([switch_width+switch_clearance, switch_height+switch_clearance, switch_depth+switch_clearance], center=true);
        }

        magnet();
    }
}

main();
