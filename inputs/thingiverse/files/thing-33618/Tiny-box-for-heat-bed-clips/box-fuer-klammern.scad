
WIDTH = 50;
LENGTH = 70;
HEIGHT = 40;


// 2 or less
WALL = 2;


// 1 or 2
// SCREWHOLE = 1;



// Box
difference() {
	cube([WIDTH,LENGTH,HEIGHT]);
	translate([2,2,-1]) {
		cube([WIDTH-WALL*2,LENGTH-WALL*2,HEIGHT+2]);
	}
}


// Top box border
difference() {
	translate([0,0,HEIGHT-2]) cube([WIDTH,LENGTH,2]);
	translate([3,3,HEIGHT-2.9]) cube([WIDTH-6,LENGTH-6,9]);
}

difference() {
	translate([0,0,HEIGHT-3]) cube([WIDTH,LENGTH,2]);
	translate([2.5,2.5,HEIGHT-4]) cube([WIDTH-5,LENGTH-5,4]);
}


// Screwhole
difference() {
	union() {
		translate([8,8,0]) cylinder(r=8,h=7);
		cube([16,8,7]);
		cube([8,16,7]);
	}
	union() {
		translate([9,9,-1])  cylinder(r=2,h=9);
		translate([9,9,0])   cylinder(r1=4.5, r2=2, h=1.8, center=true);
		translate([9,9,3.1]) cylinder(r1=0,   r2=6, h=6,   center=false);
	}
}

$fn=300;