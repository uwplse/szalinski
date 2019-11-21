difference () {
	union() {
		minkowski(){
			cube([62,15,39]);
			cylinder(r=2,h=1);
			}
		minkowski(){
			translate([0,15,0]) cube([25,20,39]);
			cylinder(r=2,h=1);
			}
	}
		translate([5,18,-1]) cube([7.1,65,42]);
		translate([5,18,-1]) cube([13,10.1,42]);
		translate([30,25,-1])rotate([0,0,45]) cube([10,20.1,42]);
translate([12,7.5,-1]) cylinder(r=9.7/2,h=44);
translate([50,7.5,-1]) cylinder(r=9.7/2,h=44);

}