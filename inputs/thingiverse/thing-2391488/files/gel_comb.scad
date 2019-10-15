/* [Teeth] */

// Width reserved on either end of comb to be free of teeth.
tooth_margin = 8.25;

// Spacing between teeth.
front_tooth_gap = 1.7;
rear_tooth_gap = 1.7;

// Number of teeth. Tooth width is calculated from tooth count, gap, and available space.
front_tooth_count = 8;
rear_tooth_count = 15;

// Length of teeth, measured perpendicular from comb.
tooth_length = 12.2;

// Thickness of teeth.
front_tooth_height = 1.0;
rear_tooth_height = 1.0;

/* [Core] */

// Width of lower section of comb core.
comb_x = 79.3;

// Length (narrow dimension) or lower section of comb core, not counting teeth.
comb_y = 13.7;

// Height of lower section of comb core (from base).
comb_z = 3.0;

// Width of raised section of comb core (centered in lower section).
raised_x = 68.8;

// Length (narrow dimension) of raised section of comb core (centered in lower section).
raised_y = 9.3;

// Height of raised section of comb core (from base).
raised_z = 7.25;

/* [Hidden] */

// Width available for teeth (comb width minus margins).
tooth_span = comb_x - (2 * tooth_margin);

// Individual tooth width (maximum to fill span with count teeth with gap betwen each).
front_tooth_width = (tooth_span - (front_tooth_count - 1) * front_tooth_gap) / front_tooth_count;
rear_tooth_width = (tooth_span - (rear_tooth_count - 1) * rear_tooth_gap) / rear_tooth_count;

echo(front_tooth_width);
echo(rear_tooth_width);

union() {
	Core();
	Teeth(rear_tooth_count, rear_tooth_width, rear_tooth_gap, rear_tooth_height);
	rotate([0, 0, 180]) Teeth(front_tooth_count, front_tooth_width, front_tooth_gap, front_tooth_height);
}

module Core() {
	union() {
		translate([0, 0, comb_z/2]) cube([comb_x, comb_y, comb_z], center=true);
		translate([0, 0, raised_z/2]) cube([raised_x, raised_y, raised_z], center=true);
	}
}

module Teeth(count, width, gap, height) {
	translate([-tooth_span/2 + width/2, comb_y/2, 0]) union() {
		for(i = [0:count-1]) {
			translate([i * (width + gap), 0, 0]) Tooth(width, tooth_length, height);
		}
	}
}

module Tooth(width, length, height) {
	translate([0, length/2, height/2]) cube([width, length, height], center=true);
}