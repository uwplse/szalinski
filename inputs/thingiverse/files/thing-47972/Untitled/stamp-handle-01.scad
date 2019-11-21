WIDTH 	= 61; // [0:200]
LENGTH 	= 18; // [0:200]

translate([0,0,1.25]) cube(size = [LENGTH,WIDTH,2.5], center = true);

translate([0,0,7.25]) {
	difference() {
		color("green") cube(size = [6,WIDTH-WIDTH*0.3,10], center = true);
		
		translate([101,0,0]) cylinder(h = 10.1, r = 100, $fn=700, center = true);
		translate([-101,0,0]) cylinder(h = 10.1, r = 100, $fn=700, center = true);
	}
}

translate([5.7,-1.25,3.25]) rotate([0,0,45]){
	color("red") cube([5, 1.5, 1.5], center = true);
	translate ([1.75,1.75,0]) color("red") cube([1.5, 5, 1.5], center = true);
}