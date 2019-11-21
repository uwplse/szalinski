type = 2;
width = 25;
height = 130;
length = 145;
thickness = 8;
hole_size = 2.5;
bar_size = 32;
bar_radius = 20;
bar_length = 110; // 110 for most spools
hook_size = bar_size + thickness * 2;

if (type == 0 || type == 1) {
rotate([0,-90,0]) {
translate([0, -20, 0])
{
	difference() {
		// upright
		cube([width, height, thickness]);

		// screw holes
		translate([width / 2, width / 2, -.1])
			cylinder(h = thickness + .2, r = hole_size, $fn = 10);
		translate([width / 2, height - width / 2, -.1])
			cylinder(h = thickness + .2, r = hole_size, $fn = 10);
	}
}
// lower bar
translate([0, 0, thickness])
	if (type == 0)
	rotate([-28, 0, 0])
		cube([width, thickness, length - hook_size + 44]);
	else
	rotate([-35, 0, 0])
		cube([width, thickness, length - hook_size + 17]);

// upper bar
translate([0, height - 40 - thickness, 0])
	cube([width, thickness, length - hook_size]);
// hook
translate([0, height - 65, length - hook_size])
{
	union()
	{
		if (type == 0) {
		difference() {
			cube([width, 25, hook_size]);
			translate([-.1, thickness, thickness - 1])
				cube([width + .2, 20, bar_size + 2]);
		}
		translate([0,thickness,0])
			linear_extrude(height = hook_size)
				polygon([[0,0],[10,0],[0,10]]);
		translate([width, thickness, 0])
			linear_extrude(height = hook_size)
				polygon([[0,0],[-10,0],[0,10]]);
		}
		else {
		difference() {
			cube([width, 25, hook_size]);
			translate([-.1, -.1, thickness - 1])
				cube([width + .2, 20, bar_size + 2]);
		}
		translate([0,20,0])
			linear_extrude(height = hook_size)
				polygon([[0,0],[10,0],[0,-10]]);
		translate([width, 20, 0])
			linear_extrude(height = hook_size)
				polygon([[0,0],[-10,0],[0,-10]]);
		}
	}
}
}
}
else {
	difference() {
	rotate([0, -90, 0])
		intersection() {
			cylinder(h = bar_length, r = bar_radius);
			translate([0, - bar_size / 2, 0])
				cube([bar_size, bar_size, bar_length]);
	}
	translate([-11, bar_size / 2 + .1, -.1])
		rotate([90, 0, 0])
			linear_extrude(height = bar_size + .2)
				polygon([[0,0],[10,0],[0,10]]);
	
	translate([-bar_length + 11, bar_size / 2 + .1, -.1])
		rotate([90, 0, 0])
			linear_extrude(height = bar_size + .2)
				polygon([[0, 0], [-10, 0], [0, 10]]);
	}
}