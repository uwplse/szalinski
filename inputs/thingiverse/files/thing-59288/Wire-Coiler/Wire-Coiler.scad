// How big you want your coiler to be
cylinderRadius = 15;

module outer() {
	translate([0, 0, -1]) cylinder(r = cylinderRadius + 3, h = 1);
	translate([0, 0, 5]) cylinder(r = cylinderRadius + 3, h = 1);
}

module inner() {
	cylinder(r = cylinderRadius, h = 5);
}

difference() {
	union() {
		outer();
		inner();
	}
	translate([0, 0, -3]) cylinder(r = cylinderRadius - 4, h = 10);
}