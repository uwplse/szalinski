height = 6;
wedge_length = 40;
// be generous; it's just hanging so slop is fine
knob_diameter = 35;
cut_out_center = "yes"; // [yes,no]
meat = 4;

/* [Hidden] */
$fa = 0.01;
wedge_low_side = height - 5;
wedge_high_side = height + 5;

union() {
	wedge();
	hook();
}

module wedge() {
	translate([-knob_diameter/2-meat, -wedge_length, 0]) {
		difference() {
			cube([knob_diameter+meat*2, wedge_length, wedge_high_side]);
			// cut wedge
			translate([-1, 0, wedge_low_side])
				rotate([atan2(wedge_high_side - wedge_low_side, wedge_length), 0, 0])
					cube([knob_diameter+meat*2+2, wedge_length*2, wedge_high_side]);
			if(cut_out_center=="yes") {
				// cut out center to save material
				translate([meat, meat, -.1])
					cube([knob_diameter, wedge_length-meat*2, wedge_high_side+meat]);
			}
		}
	}
}

module hook() {
	translate([0, knob_diameter+meat-.1, 0]) {
		difference() {
			union() {
				cylinder(r = knob_diameter/2+meat, h = meat);
				translate([-knob_diameter/2-meat, -knob_diameter-meat, 0])
					cube([knob_diameter+meat*2, knob_diameter+meat*2, meat]);
			}
			translate([0, 0, -.1]) {
				cylinder(r=knob_diameter/2, h=meat+1);
				translate([-knob_diameter/2-meat-1, -knob_diameter-meat, 0])
					cube([knob_diameter+2, knob_diameter, meat+1]);
			}
		}
	}
}