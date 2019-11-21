// Generalized Custom Signpost
// by Mike Carlton (http://carltons.us/mike/)
//
// Derivative of:
// Customizable Garden Sign v1.0
// by TheNewHobbyist 2013 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:78727
//
// Which is a derivative of paulhoover's (http://www.thingiverse.com/paulhoover)
// Vegetable garden signs (http://www.thingiverse.com/thing:78340).

/* [Sign] */

label_text = "Text";

font = "write/Letters.dxf"; // ["write/BlackRose.dxf":Black Rose,"write/knewave.dxf":Knewave,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]

font_height = 30;

// (vertical)
font_thickness = 4;

// (fixed width letters only, sorry)
letter_spacing = 1.0;

include_bar = "yes"; // [yes,no]

// (requires bar)
include_stakes = "yes"; // [yes,no]

stake_height = 35;

/* [Build plate] */

//For display only, not part of final model
build_plate_selector = 0; //[0:Replicator 2/2X,1: Replicator,2:Thingomatic,3:Manual]

// "Manual" build plate X dimension
build_plate_manual_x = 100; //[100:400]

// "Manual" build plate Y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);

// preview[view:south, tilt:top]

/* [Hidden] */

use <write/Write.scad>
use <utils/build_plate.scad>

char_width = 13 * (font_height / 19);
num_letters = len(label_text);
bar_size = 3;

function width(num_chars) = (num_chars * char_width * letter_spacing);

translate([width(num_letters)/(-2), 0, 0]) {
	difference() {
		union() {
			write(label_text, h=font_height, t=font_thickness, font=font, space=letter_spacing);
			if (include_bar == "yes") {
				translate([0, -1.5, 0]) cube([width(num_letters), bar_size, bar_size]);
				if (include_stakes == "yes") {
					translate([width(0.5), -stake_height, 0]) cube([2, stake_height, 3]);
					translate([width(num_letters-0.5), -stake_height, 0]) cube([2, stake_height, 3]);
				}
			}
		}
		if (include_bar == "yes" && include_stakes == "yes") {		// stake points
			translate([width(0.5), -stake_height, 0]) rotate([45,0,0]) cube([10, 10, 10]);
			translate([width(num_letters-0.5), -stake_height, 0]) rotate([45,0,0]) cube([10, 10, 10]);
		}
	}
}
