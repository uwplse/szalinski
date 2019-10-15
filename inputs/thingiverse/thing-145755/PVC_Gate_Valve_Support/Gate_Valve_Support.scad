// Stem Diameter
d = 6.3;
// Support Length
l = 70;
// Support Thickness
t = 2;

$fa = 0.1;
$fs = 0.1;

difference() {
	cube([l, d + (2 * t), d + t]);
	translate([t, t, t])
	cube([l - (2 * t), d, d + 0.1]);
	rotate([0, 90, 0])
	translate([-t - (d / 2), t + (d / 2), -0.1])
	cylinder(r = d / 2, h = l + 0.2);
	rotate([0, 90, 0])
	translate([-t - d - 1, t + (d / 2), -0.1])
	cylinder(r = d / 2, h = l + 0.2);
}