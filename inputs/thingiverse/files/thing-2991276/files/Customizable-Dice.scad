// Arrays with displayed text, scale, and rotation
// In order, sides are top, front, right, back, left, bottom

side1 = "side1";
side1_scale = [0.75, 1, 1];

side2 = "side2";
side2_scale = [0.75, 1, 1];

side3 = "side3";
side3_scale = [0.75, 1, 1];

side4 = "side4";
side4_scale = [0.75, 1, 1];

side5 = "side5";
side5_scale = [0.75, 1, 1];

side6 = "side6";
side6_scale = [0.75, 1, 1];

depth = 2;

dicefont = "Franklin Gothic Medium Cond";

sides = [
	[side1, side1_scale, [0,0,0]],
	[side2, side2_scale, [90,0,0]],
	[side3, side3_scale, [90,0,90]],
	[side4, side4_scale, [90,0,180]],
	[side5, side5_scale, [90,0,270]],
	[side6, side6_scale, [180,0,0]]
];

difference() {
	dicecube();
	
	for (s = sides) {
		rotate(s[2]) translate([0,0,15-depth+0.1]) linear_extrude(depth+0.1) scale(s[1])
		text(s[0], halign="center", valign="center", font=dicefont);
	}
}

module dicecube() {
	color("red")
	difference() {
		sphere(20.6, $fn=100);
		difference() {
			translate([-25,-25,-25]) cube([50,50,50]);
			translate([-15,-15,-15]) cube([30,30,30]);
		}
	}
}