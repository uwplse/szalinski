height = 13;
inner_radius = 2;
outer_radius = 3;

difference() {
	cylinder(height, outer_radius, outer_radius, $fn=32);
	translate([0,0,-5]) cylinder(height + 10, inner_radius, inner_radius, $fn=32);
}