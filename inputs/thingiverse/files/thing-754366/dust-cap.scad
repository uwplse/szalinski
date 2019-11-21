//
//  dust cap for bearing
//  design by egil kvaleberg, 4 april 2015
//

// select for press fit, default is for 608-ZZ bearing, nominally 22mm dia
maindia = 22.20; 

// height of rim, based on how much space is available axially
rimheight = 8.4;

// wall thickness of dust cap 
wall = 1.2; 

// rim width
rim = 1.8; 

ridge = min(0.7, rimheight/4);

difference() {
	union() {
		cylinder(r1 = maindia/2-ridge, r2 = maindia/2, h = ridge, $fn=100); 
		translate([0, 0, ridge]) cylinder(r = maindia/2, h = rimheight - 2*ridge, $fn=100); 
		translate([0, 0, rimheight-ridge]) cylinder(r2 = maindia/2-ridge, r1 = maindia/2, h = ridge, $fn=100); 
	}
	translate([0, 0, wall]) cylinder(r = maindia/2-rim, h = rimheight, $fn=100); 
}
