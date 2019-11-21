//#import("/home/sh/Stažené/opto_holder_4_rod_V1-thingiverse (1).stl");

include <M3.scad>;

$fn = 100;

difference() {
	union() {
		// big front
        color("Blue")
		translate([2.5, -27, 0]) cube(size = [7, 41.5, 10]);
		translate([0, 0, 5]) {
			// enclosure for rail		
			cylinder(h = 10, r=6, center = true);
			// enclosure screw cube
			color("Red")
			translate([-5, 0, 0]) 
				cube(size = [9.5, 11, 10], center = true);
				}  //translate
		translate([-10,-7.5,0]) 
			cube(size = [9.5, 6, 10]);
		translate([0, -22, 5]) {
			// enclosure for rail		
			cylinder(h = 10, r=6, center = true);
			// enclosure screw cube
			translate([-5, 0, 0]) 
				cube(size = [9.5, 11, 10], center = true);
            }  //translate            
        }  //union
	// rail hole
	translate([0, 0, 5]) cylinder(h = 20, r=4, center = true);
	translate([0, -22, 5]) cylinder(h = 20, r=4.1, center = true);
	// small difference in front for leaded pins
	translate([8.6, 0, 5]) 	cube(size = [3, 12, 20], center = true);
	// hole for front screw
	translate([0, -9.5, 5.1]) 
		rotate([0, 90, 0]) cylinder(h = 50, r=1.6, center = true);
	// hole for front screw
	translate([0, 9.5, 5.1]) 
		rotate([0, 90, 0])  cylinder(h = 50, r=1.6, center = true);
	// gap for rail enclosure
	translate([-8, 0, 5])  cube(size = [15, 6, 20], center = true);
	translate([-8, -22, 5])  cube(size = [15, 6, 20], center = true);
	// hole for screw
	translate([-6.5, 0, 5.1])  
        rotate([0, 90, 90])  cylinder(h = 30, r=1.6, center = true);
	translate([4.5,9.5,5.1]) rotate([0,90,0])  NutM3();
	translate([4.5,-9.5,5.1]) rotate([0,90,0]) NutM3();
	translate([-6.5,-8,5.1]) rotate([90,30,0]) NutM3();
	}