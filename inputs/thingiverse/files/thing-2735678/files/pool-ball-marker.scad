$fs = 1/1;
$fa = 1/1;

ballDiameter = 57.2;

difference() {
	translate([-ballDiameter/2, 0, 0]) {
		cube([ballDiameter, ballDiameter/2, ballDiameter/3]);
	}
	translate([0, -ballDiameter/5, ballDiameter/2]) {
		sphere(ballDiameter/2);
	}
}
