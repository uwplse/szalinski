pole_diameter = 50; //[20, 30, 40, 50, 60]

module mounting_holes() {
// d=4 is too large, need something to hold or nuts
	translate([99.1/2, 87.5/2, 0]) children();
	translate([-99.1/2, 87.5/2, 0]) children();

	#translate([130/2, -87.5/2, 0]) children();
	translate([-130/2, -87.5/2, 0]) children();
}

debug = 0;

module mount(pole_diameter) {
	$fn=97;
	p=[99.1/2, 87.5/2];
	p1=[130/2, 87.5/2];
	difference () {
		union() {
			intersection() {
				l=70;
				cube([pole_diameter*.8, l, 25], center=true);
				cylinder(d1=l+15, d2=40, h=20);
			}

			arm_end_height = 5;
			// arm 1
			hull() {
				translate([p[0], p[1], 0])
				cylinder(d=12, h=arm_end_height);

				cube([20, 30, arm_end_height]);
			}
			// arm 2
			hull() {
				translate([-p[0], p[1], 0])
				cylinder(d=12, h=arm_end_height);

				translate([-20, 0, 0])
				cube([20, 30, arm_end_height]);
			}
			// arm 3
			hull() {
				translate([p1[0], -p1[1], 0])
				cylinder(d=12, h=arm_end_height);

				translate([0,-30,0])
				cube([20, 30, arm_end_height]);
			}
			// arm 4
			hull() {
				translate([-p1[0], -p1[1], 0])
				cylinder(d=12, h=arm_end_height);

				translate([-20,-30,0])
				cube([20, 30, arm_end_height]);
			}
		}

		// the pole itself
		translate([0,0,pole_diameter/2 + 4])
		rotate([90, 0, 0])
		cylinder(d=pole_diameter, h=90, center=true);

		// ziptie 1
		translate([0, 15, 5 + pole_diameter/2])
		rotate([90,0,0])
		difference () {
			cylinder(d=pole_diameter + 12, h=7, center=true);
			cylinder(d=pole_diameter + 7, h=7, center=true);
		}

		// ziptie 2
		translate([0, -15, 5 + pole_diameter/2])
		rotate([90,0,0])
		difference () {
			cylinder(d=pole_diameter + 12, h=7, center=true);
			cylinder(d=pole_diameter + 7, h=7, center=true);
		}

		mounting_holes() {
			cylinder(d=4.5, h=8, $fn=17);
			translate([0,0,4])
			cylinder(d=8, h=7, $fn=6);
		}
	}
}

mount(pole_diameter);

if (debug) {
	translate([0, 97.5/2, 0])
	#cube([1000, 0.1, 1000], center=true);

	translate([0, -97.5/2, 0])
	#cube([1000, 0.1, 1000], center=true);

	translate([-99.1/2, 0, 0])
	#cube([0.1, 1000, 1000], center=true);

	translate([-125.5/2, 0, 0])
	#cube([0.1, 1000, 1000], center=true);
}
