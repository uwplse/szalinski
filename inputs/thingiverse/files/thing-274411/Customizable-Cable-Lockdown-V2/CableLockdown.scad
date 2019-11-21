// Rotating cable lock

// Radius of large end of latch
outerR = 5;
// How far off-center the pivot point is
offset = 2;
// Length of latch
len = 20;
// Radius of pivot hole
hubR = 2;
// Width of latch
width = 2;
// Thickness of side and bottom walls
thick = 3;
// Clearance between base and latch
gap=0.4;
// Tightness (positive makes latch press harder against base)
tight = 0;
// Line Radius
lR = .75;
// Number of Latches
numLatches = 1;
// Angle of latch
angle = 90; //[0:180]
// Which part to print
part=0; //[0:Assembled, 1:Base, 2:Latch]

/* [Hidden] */
$fn=32;
spacing = width+gap+thick+gap;

if (part==0) rotate([-90,0,0]) assembled();
if (part==1) rotate([-90,0,0]) bases();
if (part==2) latch();

module bases() {
	for (l = [1:numLatches]) {
		translate([0,0,l*spacing]) base();
		}
	}

//module body() {
//	h = outerR+thick+hubR+thick;
//	difference() {
//		hull() {
//			translate([-1,len,outerR+thick]) rotate([0,90,0]) 
//				cylinder(r=hubR+thick, h=width+2*thick+2);	
//			}
//		cube([width+2*thick,2*len,h]);
//		translate([thick-gap,-1,thick]) cube([width+2*gap,2*len+2,h]);
//		pin();
//		}
//	}

module latches(angle) {
	for (l = [1:numLatches]) {
		translate([0,0,l*spacing]) latch(angle);
		}
	}

module latch(angle) {
	rotate([0,0,angle]) difference() {
		hull() {
			cylinder(r=outerR, h=width);
			translate([len,0,0]) cylinder(r=1, h=width);
			}
		translate([0,offset,-1]) cylinder(r=hubR,h=width+2);
		}
	}

module pin() {
	translate([-1,len,outerR+thick])
	rotate([0,90,0])
	cylinder(r=hubR, h=width+2*thick+2);
	}

module assembled() {
	color("blue") bases();
	color("yellow") rotate([0,0,-angle]) translate([0,-offset,thick+gap]) latches(0);
	}

module base() {
	h=outerR+offset;
	tall=width+2*(thick+gap);
	
	difference() {
		hull() {
			cylinder(r=hubR+thick,h=tall);
			translate([-len/2-thick/2,h,0]) cube([thick,thick,tall]);
			translate([len/2-thick/2,h,0]) cube([thick,thick,tall]);
			}
		translate([0,0,-1]) cylinder(r=hubR,h=width+2*thick+2*gap+2);
		translate([-len-1,-10-tight,thick]) cube([2*len+4,h+10,width+2*gap]);
		translate([-len-1,h-tight-.01,thick+width/2-lR/2]) cube([2*len+4,2*lR,2*lR]);
		//#translate([0,0,thick+gap+width/2]) cylinder(r=h+2*lR, h=lR);
		}
	}




