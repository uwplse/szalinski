//////
// Tooth-paste/Paint Tube Key
//
// http://www.thingiverse.com/thing:21410
// By: Alan Yates <thingiverse@alanyates.com>
//////

// geometry
barrel_diameter = 9.0;
barrel_flats = 8.0;
slot_width = 2.5;
slot_length = 50.0;
key_width = 35.0;
key_height = 15.0;
hole_diameter = 8;

// tolerances
overlap = 1;
$fn = 50;

translate([0, 0, barrel_flats/2])
	rotate(-90, [0, 0, 1]) rotate(-90, [1, 0, 0])
		tube_key(barrel_diameter, barrel_flats, slot_width, slot_length, key_width, key_height, hole_diameter);

module tube_key(bd, bf, sw, sl, kw, kh, hd) {
	union() {
		translate([0, 0, kh/2])
			rotate(90, [1, 0, 0]) {
				difference() {
					hull() {
						translate([kw/2 - kh/2, 0, 0])
							cylinder(r = kh/2, h = bf, center = true);
						translate([- kw/2 + kh/2, 0, 0])
							cylinder(r = kh/2, h = bf, center = true);
					}
#					translate([-kh/2, 0, -bf/2-overlap])
						cylinder(r = hd/2, h = bf + 2*overlap);
#					translate([kh/2, 0, -bf/2-overlap])
						cylinder(r = hd/2, h = bf + 2*overlap);
#					translate([0, -4*kh/5, -bf/2-overlap])
						cylinder(r = kh/2, h = bf + 2*overlap);
				}
			}
		translate([0, 0, kh - overlap])
			difference() {
				cylinder(r = bd/2, h = sl + bd);
		
#				translate([-sw/2, -bd/2 - overlap, bd/2])
					cube([sw, bd + 2*overlap, sl]);
#				translate([-bd/2 - overlap, bf/2, -overlap])
					cube([bd + 2*overlap, bd/2, sl + bd + 2*overlap]);
#				translate([-bd/2 - overlap, -bf/2 - bd/2, -overlap])
					cube([bd + 2*overlap, bd/2, sl + bd + 2*overlap]);
			}
	}
}