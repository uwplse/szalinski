//Resolution
RES = 200; // [100:Rough,200:Medium,400:Great, 5000:Bananas]
fn = RES;
// EPSilon (for previewing)
EPS = .001;
// 18650 diameter
18650_D = 18.3;
// 18650 height
18650_H = 65;
SPRING_H = 5;
// Unit outer diameter
OD = 26;
// Unit height
H = 85;
// Groove dimensions (Width, Depth)
GROOVE = [6, 3];
// Spring plate size (Width, Depth, Thickness)
SPRING = [18, 15, .5];

module spring_pad() {
	translate([-SPRING[0] / 2, -SPRING[1] / 2, (H - 18650_H - SPRING_H) / 2 - 1 - .7]) {
		cube([SPRING[0], SPRING[1] + OD / 2 - SPRING[1] / 2, 1 + EPS]);
		translate([2.5, 2, 1]) cube([SPRING[0] - 5, SPRING[1] - 2 + OD / 2 - SPRING[1] / 2, .7 + EPS]);
		translate([0, SPRING[1], 1]) cube([SPRING[0], (OD - SPRING[1]) / 2, .7 + EPS]);
		translate([(SPRING[0] - 3) / 2, -(OD - SPRING[1]) / 2, 0]) cube([3, (OD - SPRING[1]) / 2 + EPS, SPRING[2]]);
	}
}

rotate(a = 180, v = [0, 0, 1]) difference() {
	cylinder(r = OD / 2, h = H, $fn = fn);
	translate([0, 0, (H - 18650_H - SPRING_H) / 2]) union() {
		cylinder(r = 18650_D / 2, h = 18650_H + SPRING_H, $fn = fn);
		translate([-18650_D / 2, 0, 0]) cube([18650_D, OD / 2, 18650_H + SPRING_H]);
	}
	translate([-GROOVE[0] / 2 - EPS, -OD / 2, -EPS]) cube([GROOVE[0] + EPS * 2, GROOVE[1], H + EPS * 2]);
	spring_pad();
	translate([0, 0, H]) mirror([0, 0, 1]) spring_pad();
	rotate(a = 90, v = [0, 0, 1]) {
		translate([-OD / 2, 1, 2 - EPS]) cube([OD, (OD - 2) / 2, 2 + EPS]);
		translate([-OD / 2, -OD / 2, 2 - EPS]) cube([OD, (OD - 2) / 2, 2 + EPS]);
		translate([-OD / 2, 3, 0 - EPS]) cube([OD, (OD - 6) / 2, 2 + EPS]);
		translate([-OD / 2, -OD / 2, 0 - EPS]) cube([OD, (OD - 6) / 2, 2 + EPS]);
	}
	translate([-1.1, -OD / 2, H - 2]) cube([2.2, OD, 2 + EPS]);
	translate([-3.1, -OD / 2, H - 4]) cube([6.2, OD, 2.1]);
}