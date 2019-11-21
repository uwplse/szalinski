// Parametric Stepper Motor Feed Wheel
// Based on original design by Jeff Latham:
// http://www.thingiverse.com/thing:413527

// Radius of stepper motor shaft. (mm)
motor_shaft_radius = 2.75;

// Width of flat on stepper motor shaft. (mm)
motor_shaft_flat = 3.16;
// 3.16

// Depth of socket for stepper motor shaft. (mm)
motor_shaft_depth = 6;

// Radius of handle shaft. (mm)
shaft_radius = 5;

// Length of shaft from knob to stepper motor. (mm)
shaft_depth = 10;

// Radius of central part of knob. (mm)
knob_radius = 10;

// Thickness of central part of knob. (mm)
knob_depth = 5;

// Depth of knob fillet along shaft. (mm)
knob_fillet_depth = 4;

// Number of handles on knob.
handle_count = 3;

// Length of handle from tip to knob. (mm)
handle_length = 20;

// Width of handle at knob. (mm)
handle_inner_radius = 4;

// Width of handle at tip. (mm)
handle_outer_radius = 1;

// Curve resolution (facets per circle)
$fn = 60;

translate([0, 0, shaft_depth + knob_depth]) rotate([180, 0, 0])
difference() {
	union() {
		Knob();
		Handles();
		Fillet();
		HandleShaft();
	}
	MotorShaft();
}

MotorShaft();

module Handles() {
	for (i = [0:handle_count-1]) {
		rotate([0, 0, i * (360 / handle_count)]) translate([knob_radius - handle_inner_radius, 0, 0]) Handle();
	}
}

module Handle() {
	translate([0, 0, shaft_depth]) rotate([0, 0, 0]) hull() {
		cylinder(h = knob_depth, r = handle_inner_radius);
		translate([handle_length + handle_inner_radius - handle_outer_radius, 0, 0]) cylinder(h = knob_depth, r = handle_outer_radius);
	}
}

module Fillet() {
	assign(w = knob_radius - shaft_radius, h = knob_fillet_depth) {
		translate([0, 0, shaft_depth]) rotate_extrude() translate([0, -h])
		difference() {
			square([knob_radius, h]);
			translate([knob_radius, 0]) scale([w, h]) circle(r = 1);
		}
	}
}

module Knob() {
	translate([0, 0, shaft_depth]) cylinder(h = knob_depth, r = knob_radius);
}

module HandleShaft() {
	cylinder(h = shaft_depth, r = shaft_radius);
}

module MotorShaft() {
	linear_extrude(height = motor_shaft_depth) difference() {
		circle(r = motor_shaft_radius);
		translate([-(motor_shaft_flat+1)/2, sqrt(pow(motor_shaft_radius, 2) - pow(motor_shaft_flat/2, 2))]) square(motor_shaft_flat + 1);
	}
}
