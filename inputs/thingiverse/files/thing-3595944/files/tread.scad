// All measurements in mm
tread_width = 16; // width of the tread along the wheels' axis
wheel_radius = 25.4; // minimum radius of the wheels holding the treads
treads_per_half_wheel = 4; // number of treads to wrap around a half a wheel
join_inset = 4; // amount of tread to have on the outside of the rails
rail_thickness = 4; // thickness of a combined rail

// See here for hole sizes to accomodate metric bolts:
// https://www.amesweb.info/Screws/Metric-Clearance-Hole-Chart.aspx
peg_and_hole = true; // true for a tapered peg and a hole; false for a pair of holes.
hole_diameter = 2.4; // Size of the peg / hole

tread_thickness = 2.4; // thickness of the tread, including pattern
chevron_depth = 0.333; // depth to cut the pattern into the tread, in tread_thicknesses
tread_pitch = 2; // length from one tread to the next
chevron_direction = 1; // should the tread point towards the hole (positive) or the peg (negative)
tread_gap = 0.75; // gap between treads, in rail_heights  Could be zero, but I wouldn't recommend it.


// Advanced settings
rail_height = 2 * hole_diameter; // height of the rails
curve_quality = 0.25; // Out of 360, how many sides?
tolerance = 0.9; // How close a fit?  Doesn't work right!  Please fix!
tread_length = wheel_radius * PI / treads_per_half_wheel; // Override if you'd rather specify this
peg_length = rail_thickness / 4; // Overridable if you want longer or shorter pegs


module rail() {
    difference() {
        union() {
            // holed cylinder
            translate([0, -tread_gap * rail_height / 2, 0]) {
                cylinder(h = rail_thickness / 2 * sqrt(tolerance), r = rail_height / 2, $fn=curve_quality * 360);
            }
            // pegged cylinder
            translate([0, tread_length + tread_gap * rail_height / 2, rail_thickness - rail_thickness / 2  * sqrt(tolerance)]) {
                cylinder(h = rail_thickness / 2 * sqrt(tolerance), r = rail_height / 2, $fn=curve_quality * 360);
            }
            // bottom rail
            translate([-rail_height / 2, -tread_gap * rail_height / 2, 0]) {
                cube([rail_height, tread_length / 2 + tread_gap * rail_height / 2, rail_thickness / 2 * sqrt(tolerance)]);
            }
            // top rail
            translate([-rail_height / 2, tread_length / 2, rail_thickness - rail_thickness / 2  * sqrt(tolerance)]) {
                cube([rail_height, tread_length / 2 + tread_gap * rail_height / 2, rail_thickness / 2  * sqrt(tolerance)]);
            }
            // connection
            translate([0, tread_length / 2, rail_thickness / 2]) {
              translate([0, rail_thickness * -1.5 * (1 - tolerance), rail_thickness * (1-tolerance)]) {
                rotate(45, [1, 0, 0]) {
                    cube([
                        rail_height, 
                        sqrt(2)*rail_thickness/2 / tolerance, 
                        sqrt(2)*rail_thickness/4
                    ], true);
                }
              }
              translate([0, rail_thickness * 1.5 * (1 - tolerance), -rail_thickness * (1-tolerance)]) {
                rotate(45, [1, 0, 0]) {
                    cube([
                        rail_height, 
                        sqrt(2)*rail_thickness/2 / tolerance, 
                        sqrt(2)*rail_thickness/4
                    ], true);
                }
              }
            }
            // peg
			if (peg_and_hole) {
				translate([0, tread_length + tread_gap * rail_height / 2, rail_thickness / 2 - peg_length]) {
					cylinder(
						h = peg_length / tolerance, 
						r = hole_diameter / 3,
						r2 = hole_diameter / 2,
						$fn = curve_quality * 360
					);
				}
			}
        }
        // hole
        translate([0, -tread_gap * rail_height / 2, -rail_height / 4 * (1 - sqrt(tolerance))]) {
            cylinder(h = rail_thickness / 2, r = hole_diameter / 2, $fn = curve_quality * 360);
        }
		if (!peg_and_hole) {
			translate([0, tread_length + tread_gap * rail_height / 2, rail_thickness / 2]) {
				cylinder(
					h = rail_thickness / 2 / tolerance, 
					r = hole_diameter / 2,
					$fn = curve_quality * 360
				);
			}
		}
    }
}

module chevrons() {
    for (i = [-tread_length * 2 : tread_pitch : tread_length * 2]) {
        translate([ tread_width / 2, 0, -tread_thickness * (1 - tolerance) ]) {
            rotate(chevron_direction > 0 ? 45 : -135, [ 0, 0, 1]) {
                translate([i, i, 0]) {
                    union() {
                        cube([ tread_pitch / 2, tread_width * sqrt(2), tread_thickness * chevron_depth / tolerance ]);
                        cube([ tread_width * sqrt(2), tread_pitch / 2, tread_thickness * chevron_depth / tolerance ]);
                    }
                }
            }
        }
    }
}

union() {
   difference() {
    cube([tread_width, tread_length, tread_thickness]);
    chevrons();
    translate([tread_width / 2 - tread_pitch / 4, -tread_length * (1 - tolerance), -tread_thickness * (1 - tolerance)]) {
        cube([tread_pitch / 2, tread_length / tolerance, tread_thickness * chevron_depth / tolerance]);
    }
   }
   translate([join_inset, 0, tread_thickness + rail_height / 2]) {
     rotate(90, [ 0, 1, 0 ]) {
         rail();
     }
   }
   translate([tread_width - join_inset, 0, tread_thickness + rail_height / 2]) {
       rotate(180, [0, 1, 0]) {
         rotate(90, [ 0, 1, 0 ]) {
             rail();
         }
      }
   }
}
