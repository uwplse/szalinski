half_model = "yes"; // [yes,no]

radius = 100;
inner_height = 60.5;
wall_strength = 3;
groove_radius = 30.25;
axis_radius = 10;

height = inner_height + wall_strength *2;

translate([0, 0, height/2])
difference() {
	cylinder(h=height, r=radius, center=true, $fn = 64);

	rotate_extrude(convexity = 20, $fn = 64)
	translate([radius, 0, 0])
	scale([groove_radius, inner_height/2, 1])
	circle(r = 1, $fn = 64);

	cylinder(h=height*2, r=axis_radius, center=true, $fn = 64);

	if (half_model == "yes") {
		translate([0, 0, height/4+0.02])
		cube([radius*2, radius*2, height/2], center = true);
	}
}