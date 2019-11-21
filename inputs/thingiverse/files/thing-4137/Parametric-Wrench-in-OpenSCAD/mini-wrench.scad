include <MCAD/regular_shapes.scad>

// DIAMETER OF NUT in mm
D = 6.94;
// MARGIN	
M = D/2; 	
// HEIGHT (THICKNESS) OF TOOL in mm
H = 5;
// TOTAL LENGTH OF TOOL in mm
Ltot = 75; 	

// Length from Center of One Side to Center of Other Side
L = Ltot-2*(D/2+M);

difference() {
	union() {
		translate([0,L/2,H/2]) {
			cylinder(r = (D/2+M), h = H,center = true);
		}
		translate([0,-L/2,H/2]) {
			cylinder(r = (D/2+M), h = H,center = true);
		}
		translate([-1*D/2,-L/2,0]) {
			cube([D,L,H], center=false);
		}
	}
	translate([0,-L/2,H/2]) {
		rotate([0,0,30]) {
			hexagon(D, H);
		}	
	}
	translate([0,-1*D-L/2,H/2]) {
		cube([D,2*D,H], center = true);
	}
	translate([0,L/2,H/2]) {
		rotate([0,0,30]) {
			hexagon(D, H);
		}	
	}
}