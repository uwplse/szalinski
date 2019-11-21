difference () {
	union() {
		cube([40,75,7]);
		translate([20,75,0]) rotate([0,0,0]) cylinder(r=20,h=7);
		cube([40,25,12]);
	}
translate([20,73,-1]) rotate([0,0,0]) cylinder(r=7,h=64);
translate([13,-1,-1]) cube([14,74,20]);
translate([-1,-1,-1]) cube([42,16,20]);
}