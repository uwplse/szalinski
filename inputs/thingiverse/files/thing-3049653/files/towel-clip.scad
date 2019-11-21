thickness = 5;
hanger_d = 40;
hanger_width = 6;
tolerance = 0.5;
jaws_length = 12;

$fs = 0.01;
$fa = 4;
hanger_id = hanger_d - hanger_width * 2;

module zigzag(n = 3, length = 1.5, width = 2) {
	for (i = [0:n - 1]) {
		offset = i * length;
		translate([offset, -(width + tolerance) / 2]) polygon([
			[0, 0], [length / 2, width], [length, 0],
			[length, tolerance], [length / 2, width + tolerance], [0, tolerance]
		]);
	}
}

linear_extrude(thickness) {
	difference() {
		union() {
			circle(d = hanger_d);
			translate([-hanger_width, hanger_id / 2]) square([hanger_width * 2, jaws_length]);
		}
		circle(d = hanger_id);
		translate([0, hanger_id / 2 - 1]) rotate([0, 0, 90]) {
			zigzag(width = hanger_width / 3 * 2, length = hanger_width / 3 * 2, n = jaws_length / hanger_width * 2 + 1);
		}
	}
}
