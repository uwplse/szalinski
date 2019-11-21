/* [Dimensions] */
	
	// Internal diameter of bottle outlet
	BottleSize = 18; // [10:30]
	
	// Quality
	Quality = 60; // [20:200]
	
/* [Hidden */
	$fn = Quality;
    
nozzle();

module nozzle() {
	difference() {
		union() {
			cylinder(d1=BottleSize-0.5,d2=BottleSize+0.5,h=6.1);
				translate([0,0,6]) cylinder(d1=BottleSize+0.5,d2=BottleSize+4,h=2.01);
				translate([0,0,8]) cylinder(d1=BottleSize+4,d2=6,h=10.01);
				translate([0,0,18]) cylinder(d1=6,d2=5,h=6);
		}
		translate([0,0,-1]) cylinder(d=BottleSize-6,h=8.01);
		translate([0,0,7]) cylinder(d1=BottleSize-6,d2=3,h=10.01);
		translate([0,0,17]) cylinder(d=3.5,h=10);
		translate([0,0,2.5]) rotate_extrude() translate([((BottleSize/2))-0.25,0,0]) circle(d=2);
	}
}