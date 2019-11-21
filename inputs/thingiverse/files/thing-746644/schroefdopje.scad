$fn = 30;
// HOLE RADIUS SIZE
HOLE_R = 2.5;
// TOTAL OUTER RADIUS
OUTER_R = 6;
// INNER RADIUS FOR SCREW
INNER_R = 5;

BASE_HEIGHT = 1;
TOTAL_HEIGHT = 2;

difference() {
	cylinder(r=OUTER_R, h=TOTAL_HEIGHT);
	translate([0,0,BASE_HEIGHT])
	cylinder(r=INNER_R, h=100);
	translate([0,0,-1])
	cylinder(r=HOLE_R, h=100);
}

