// Single Tower Casette Tape Holder
// by Nathan Wittstock <nate@fardog.io>

// preview[view:south east, tilt:top diagonal]

/* [Cassette] */
number_of_cassettes = 10; //[5:15]
x_tolerance = 1.5; //[1.0:3.0]
y_tolerance = 1.0; //[1.0:3.0]

/* [Hidden] */
case_height = 109.0 + x_tolerance;
case_width = 17.0 + y_tolerance;
case_depth = 70.0;
case_padding = 6;
foot_height = 5;

wall_thickness_min = 2;

case_pocket_height = case_depth - (case_depth / 2);
case_pocket_gap = wall_thickness_min;

base_height = case_pocket_height + wall_thickness_min;
base_depth = (case_width + case_pocket_gap) * number_of_cassettes + case_pocket_gap + foot_height;
base_width = case_height + (case_padding * 2);

module base() {
	cube([base_width, base_depth, base_height]);
}

module foot() {
	cube([base_width, foot_height, case_depth]);
}

module case_slots() {
	union() {
		for (i = [0:number_of_cassettes - 1]) {
			current_y = case_pocket_gap + ((case_width + case_pocket_gap) * i);
			translate([case_padding, current_y, base_height - case_pocket_height])
			cube([case_height, case_width, case_pocket_height + 1]);
		}
	}
}

module depth_cutout() {
	union() {
		translate([case_padding, case_padding, base_height - case_padding])
			cube([base_width - (case_padding * 2), base_depth - (case_padding * 2) - wall_thickness_min, case_padding * 2]);
		translate([base_width / 4, wall_thickness_min, 0])
			cube([base_width / 2, base_depth - foot_height - (wall_thickness_min * 2), case_pocket_height]);
	}
}

difference() {
	union() {
		foot();
		base();
	}
	translate([0, foot_height, 0]) {
		union() {
			case_slots();
			depth_cutout();
		}
	}
}
