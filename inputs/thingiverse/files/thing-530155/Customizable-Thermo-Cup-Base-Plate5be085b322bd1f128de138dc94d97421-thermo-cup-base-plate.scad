outer_radius = 30;
inner_radius = 1;
thickness = 2;
height = 10;
torus_height = 2;
base_thickness = 2;
base_height = -2;

difference () {

	cylinder(h=height, r=outer_radius, center=true, $fn=128);
	cylinder(h=height+2, r=outer_radius-thickness, center=true, $fn=128);

	translate([0, 0, torus_height])
		rotate_extrude(convexity = 10, $fn = 256)
			translate([outer_radius-thickness, 0, 0])
				circle(r = inner_radius, $fn = 256);
}

translate([0, 0, base_height])
	cylinder(h=base_thickness, r=outer_radius, center=true);