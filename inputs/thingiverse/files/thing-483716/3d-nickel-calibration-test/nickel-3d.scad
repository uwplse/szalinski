// coin calibration thing

// remixed from "A Better Nickel Calibration Test" by "John" of thingiverse


// diameter of cdn nickel(21.2), USA(21.21), original test(2.2)
coin = 21.2;

// thickness of cdn nickel(1.76), USA(1.95)
th = 1.76;

// tolerance : use zero if you wish it may not be best for your system.
tolerance = 0.8;

// derived value(s)
// this is like the original nickel test

hole = coin + tolerance;

module plate() {
	linear_extrude(height=th) {
		difference() {
			intersection() {
				circle(r = coin * 2.1);
				square(coin * 1.75);
			}
			translate([coin, coin])
				circle(r = hole / 2);
			translate([coin / 5, coin / 2])
				square([th * 2, hole]);
			translate([coin / 2, coin / 5])
				square([hole, th * 2]);
		}
	}
}

$fs = 0.5;
$fa = 3;

// add notch on bottom plate in X direction
difference() {
	plate();
	translate([coin * 1.73, th * 4, th / 2])
		cylinder(r = coin / 10, h = th);
}
translate([0, th]) rotate([90, 0, 0]) plate();
translate([th, 0]) rotate([0, -90, 0]) plate();

// Make a slug to measure with your calipers.
// You do have calipers don't you?
// or just match it up to your coin
// added small notch in front X axis edge.
translate([0, -1.5 * coin, 0])
	difference() {
		cylinder(r = coin / 2, h = th);
		translate([coin * 0.45, 0, th / 2])
			cylinder(r = coin / 10, h = th);
	}


// original
//translate([0, 40, 0])
//	import("XYZ_nickel_Calibration_2.stl");
