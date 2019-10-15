{
module holder(){
	difference() {
		translate([10.5, 15, 0])
			cube([21, 30, 7], center = true);	
		union() {
			translate([10.5, 19.2, 0])
				cube([10.2, 23.6, 10], center = true);
		}

	}
	translate([31, 27.5, 0])
		cube([20, 5, 7], center = true);
	translate([26.3, 15.5, 0]) rotate(-15, [0, 0, 1])
		cube([19, 5, 7], center = true);
	translate([30, 16.5, 0]) rotate(-15, [0, 0, 1])
		cube([2, 7, 7], center = true);
	translate([35.1, 15.5, 0]) rotate(-15, [0, 0, 1])
		cube([2, 8, 7], center = true);
}
translate([ 0, 0, 10]) holder();
}