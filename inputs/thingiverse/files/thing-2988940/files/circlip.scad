module circlip(D = 11, d = 7, h = 1, H = 2, o = 0.75) {
	linear_extrude(h) {
		difference() {
			union() {
				circle(d = D);
			}
			circle(d = d);
			translate([D / 2, 0]) square(center = true, [D, d * o]);
		}
	}
	linear_extrude(H) {
		difference() {
			translate([-H, 0]) circle(d = D);
			circle(d = D);
		}
	}
}
circlip();
