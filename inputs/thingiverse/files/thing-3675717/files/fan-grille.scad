$fs = 0.05;
$fa = 4;

fan_d = 135;
flange_thickness = 2.5;
flange_offset = 6;

thickness = 0.8;

grille_hole_width = 1.4;
grille_spoke_width = 0.4;

linear_extrude(thickness) {
	intersection() {
		union() {
			for (x = [-fan_d / 2 : grille_hole_width + grille_spoke_width : fan_d / 2]) {
				translate([x, 0]) square([grille_spoke_width, fan_d], center = true);
			}
			for (y = [-fan_d / 2 : grille_hole_width + grille_spoke_width : fan_d / 2]) {
				translate([0, y]) square([fan_d, grille_spoke_width], center = true);
			}
		}
		circle(d = fan_d - flange_offset * 2);
	}
	difference() {
		circle(d = fan_d + thickness * 2);
		circle(d = fan_d - flange_offset * 2 - 0.001);
	}
}
translate([0, 0, thickness]) {
	linear_extrude(flange_thickness + thickness) {
		difference() {
			circle(d = fan_d + thickness * 2);
			circle(d = fan_d);
			/*
			translate([-fan_d / 2 - thickness * 2, 0]) {
				square([fan_d * 2, fan_d * 2]);
			}
			*/
		}
	}
}
