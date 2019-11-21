/* [Hidden] */ ////////////////////////////
$fn = 64;

/* [Plug] */ ////////////////////////////
// Innerdiameter of the Plug (aka ID of the Pipe)?
id = 21;

// Outerdiameter of the Plug (aka OD of the Pipe; used for the chamfer)?
od = 25;

// Height?
h = 20;

// Wallthickness?
w = 2.5;

// Slotted?
s = 1; // [1:Yes, 0:No]

/* [Cuts] */ ////////////////////////////
// Center-Hole-Diameter?
chd = 5;

// Cut-Diameter?
cd = 14;

// How many Cuts?
cc = 10;

// Cut-Thickness? 
cw = 0.35;

////////////////////////////

difference() {
	union() {
		cylinder(r=id/2, h=h);

		hull() {
			cylinder(r=id/2, h=(od-id)/2);
			translate([0, 0, (od-id)/2]) cylinder(r=od/2, h=0.00001);
		}
	}
	
	union() {
		translate([0, 0, w]) cylinder(r=(id/2-w), h=h-w);
		
		// slot
		if(s==1) {
			translate([0, -cw/2, 0]) cube([od/2, cw, h]);
		}
		
		// cuts
		for(i = [0:cc]) {
			rotate([0, 0, i*360/cc]) translate([0, -cw/2, 0]) cube([cd/2, cw, w]);
		}
		cylinder(r=chd/2, h=w);
	}
}