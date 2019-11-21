$fn=64;

/* parametric standard hinge
		* open position with no swag (unless configured)
		* printed in place
		* non-removable captured pin
		* pin is along y axis
		* reinforced knuckles extruded from leaf for improved strength
		* all values can be modified and have reasonable defaults

	PARAMETERS:

	knuckles			= number of knuckles, defaults to 7, if even pin will be exposed and unsupported on one end
							note: if knuckles is set to 2, the two leafs can be separated

	hinge_length		= y dimension of entire hinge starting at y=0, defaults to 8mm per kuckle

	hinge_width			= x dimension of entire hinge with center on x=0, defaults to 40mm

	knuckle_diameter	= diameter of knuckles around pin, defaults to 1/5 of hinge_width

	pin_center_height	= distance from bottom of hinge to center of pin, defaults to half of knuckle_diameter
							note: changing this to less than half of knuckle_diameter causes swag (knuckle below leaf) and may need supports

	pin_diameter		= diameter of pin inside knuckles, defaults to one half of knuckle diameter

	leaf_height			= thickness (z dimension) of the leafs, defaults to one quarter knuckle diameter (matches knuckle around pin)

	base_width			= distance between center pin and knuckle supports, defaults to knuckle diameter (~45 angle on knuckle support)
							note: reducing this from default weakens hinge strength

	gap					= distance in mm between all moving parts (around pin, between knuckles, etc.), defaults to 0.5
							note: changing this to be .4 or less may cause hinge parts to fuse together
*/

module standard_hinge(hinge_length, hinge_width, knuckles, 
                        knuckle_diameter, pin_center_height, pin_diameter, 
                        holes, bevel, hole_diameter, hole_offset,
                        base_width, leaf_height, gap, debug) {

	// set defaults
	knuckles=knuckles?knuckles:7;
	hinge_width=hinge_width?hinge_width:40;
	hinge_length=hinge_length?hinge_length:8*knuckles;
	knuckle_diameter=knuckle_diameter?knuckle_diameter:0.2*hinge_width;
	gap=gap?gap:0.5;
	leaf_height=leaf_height?leaf_height:knuckle_diameter/4;
	pin_center_height=pin_center_height!=undef?pin_center_height:knuckle_diameter/2;
	pin_diameter=pin_diameter?pin_diameter:knuckle_diameter/2;
	base_width=base_width?base_width:knuckle_diameter;

	// convenience calculations
	knuckle_pitch=(hinge_length+gap)/knuckles;
	knuckle_length=knuckle_pitch-gap;
	leaf_width=hinge_width/2;

	// set width of knuckle base supports to clear the pin
	clearance_z=pin_center_height-(leaf_height<pin_center_height?leaf_height:pin_center_height);
	clearance_a=knuckle_diameter/2+gap;
	clearance_x_calculated=sqrt(pow(clearance_a,2)-pow(clearance_z,2));
	clearance_x=clearance_x_calculated==clearance_x_calculated?clearance_x_calculated:gap/2;
	clearance_width=base_width-clearance_x;
	leaf_flat_width=leaf_width-clearance_x;

    // additional defaults
    leaf_center=(leaf_width-base_width)/2;
    hole_diameter=hole_diameter?hole_diameter:pin_diameter;
    hole_offset=hole_offset?hole_offset:leaf_flat_width/8;
    hole_diameter2=bevel?hole_diameter+leaf_height:hole_diameter;

	if (debug) {
		echo("knuckles", knuckles);
		echo("hinge_width", hinge_width);
		echo("hinge_lenth", hinge_length);
		echo("kuckle_diameter", knuckle_diameter);
		echo("leaf_height", leaf_height);
		echo("pin_center_height", pin_center_height);
		echo("pin_diameter", pin_diameter);
        echo("hole_diameter", hole_diameter);
		echo("base_width", base_width);
		echo("gap", gap);
		echo("knuckle_pitch", knuckle_pitch);
		echo("knuckle_length", knuckle_length);
		echo("leaf_width", leaf_width);
		echo("clearance_z", clearance_z);
		echo("clearance_a", clearance_a);
		echo("clearance_x", clearance_x);
		echo("clearance_width", clearance_width);
		echo("leaf_flat_width", leaf_flat_width);
	}

	union() {
		// pin side (-x) leaf
		translate([-leaf_width, 0, 0]) {
            difference() {
                cube([leaf_flat_width, hinge_length, leaf_height]);
                if (holes) {
                    for (i=[2:2:knuckles]) {
                        translate([leaf_center+(i%4?1:-1)*hole_offset, i*knuckle_pitch-knuckle_pitch/2, 0])
                            cylinder(d1=hole_diameter, d2=hole_diameter2, h=leaf_height);
                    }
                }
            }
        }

		// non-pin side (+x) base
		translate([clearance_x, 0, 0]) {
            difference() {
                cube([leaf_flat_width, hinge_length, leaf_height]);
                if (holes) {
                    for (i=[2:2:knuckles]) {
                        translate([leaf_flat_width-(leaf_center+(i%4?1:-1)*hole_offset), i*knuckle_pitch-knuckle_pitch/2, 0])
                            cylinder(d1=hole_diameter, d2=hole_diameter2, h=leaf_height);
                    }
                }
            }
        }

		// pin
		rotate([-90, 0, 0])
			translate([0, -pin_center_height, 0])
				cylinder(d=pin_diameter-gap, h=hinge_length);

		// knuckles
		for (i=[1:knuckles]) {
			if (i%2) {
				// knuckle with pin
				translate([0, i*knuckle_pitch-gap, 0]) rotate([90, 0, 0])
				hull() {
					translate([0, pin_center_height, 0]) {
						cylinder(d=knuckle_diameter, h=knuckle_length);
					}
					translate([-base_width, 0, 0]) {
						cube([clearance_width/2, leaf_height, knuckle_length]);
					}
				}
			} else {
				// knuckle without pin
				translate([0, i*knuckle_pitch-gap, 0]) rotate([90, 0, 0])
				difference() {
					hull() {
						translate([0, pin_center_height, 0]) {
							cylinder(d=knuckle_diameter, h=knuckle_length);
						}
						translate([(base_width)-clearance_width, 0, 0,]) {
							cube([clearance_width, leaf_height, knuckle_length]);
						}
					}
					translate([0, pin_center_height, 0]) {
						cylinder(d=pin_diameter+gap, h=knuckle_length);
					}
				}
			}
		}
	}
}

standard_hinge();

translate([50, 0, 0]) standard_hinge(holes=true, bevel=true);

/* vim: set ts=4 sw=4 sts=4 noet : */
