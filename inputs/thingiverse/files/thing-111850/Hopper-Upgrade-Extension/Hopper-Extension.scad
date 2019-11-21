coupling_inner_dimension = 34.5; // [30:40]

difference() {
	union() {
		difference() {
			translate([0,0,-10])
			import("Hopper-funnel-v2.stl");
			translate([0,0,-12])
			cylinder(r=40, h=22);
		}
		cylinder(r=coupling_inner_dimension, h=10.1);
	}
	translate([0,0,-12])
	cylinder(r=32, h=42);
}