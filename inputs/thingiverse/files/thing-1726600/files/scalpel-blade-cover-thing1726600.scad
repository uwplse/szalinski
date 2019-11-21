// Height of blade, in mm
blade_height	= 10;	// [1:200]
// Width of blade, in mm
blade_width		= 3;	// [1:200]
// Length of blade, in mm
blade_length	= 40;	// [1:200]
// Wall strength, in mm
wall = 1;	// [0.1:10]

inside_dim = [blade_height, blade_width, blade_length];

$fn=50; 

module footprint() {
	cube(inside_dim);
	translate([inside_dim[0]/2, 0, inside_dim[2]])
		rotate([-90,0,0])
		cylinder(h=inside_dim[1], r=inside_dim[0]/2);
}

difference() {
	minkowski() {
		footprint();
		sphere(r=wall);
	}
	footprint();
	translate([-wall, -wall, 0])
		mirror([0,0,1])
		cube(inside_dim + [2*wall, 2*wall, 0]);
}
