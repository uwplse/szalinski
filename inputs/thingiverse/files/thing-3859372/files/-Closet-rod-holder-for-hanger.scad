// Rod holder for cloth

RodDiameter = 20;		//Ros doameter
HolderDiameter = 25;	// ecternal diameter of rod support
LegHeight = 30;			// upper space for holder
BaseHeight = 4;
BaseWidth = 60;
Cork = false;			// make optional cork
LockDia = 8;			// locking screw diameter (if 0 no lock)
LockHeight = 4;			// locking screw height (if 0 no lock)
ScrewProfile = [
	[0,0],[2,0],[2,BaseHeight*2],[4,BaseHeight*2+4],
	[4,BaseHeight*2+8],[0,BaseHeight*2+8],[0,0] 
];

Clearance = 0.5;
$fn = 100;

Make();
	
module Make() { 
	translate([0,0,HolderDiameter/2]) rotate([-90,0,0]) RodHolder();
	if (Cork) translate([BaseWidth,0,0]) Cork();
}

module RodHolder() { 
	difference() { 
		union() { 
			Head();
			Base();
		}
		Holes();
	}
}

module Cork() { 
	translate([0,0,1]) 
		cylinder(h=BaseHeight, d1=RodDiameter-Clearance, d2=RodDiameter-Clearance*2);
	cylinder(h=1, d=RodDiameter+Clearance*2);
}

module Leg() { 
	if (false) { 
		cylinder(h=LegHeight, d=HolderDiameter);
	} else { 
		hull() { 
			scale([0.5,1,1]) cylinder(h=0.1, d=HolderDiameter);
			translate([0,0,LegHeight]) cylinder(h=0.1, d=HolderDiameter);
		}
	}
}

module Base() { 
	color("MediumBlue")
	hull() { 
		translate([0,0,BaseHeight*1.5]) sphere(d=BaseHeight);
		translate([0,0,BaseHeight/2]) 
			cube(size=[BaseWidth,HolderDiameter,BaseHeight], center=true);
	}
}

module Head() { 
	color("Red") 
	hull() { 
		Leg();
		translate([0,0,LegHeight+RodDiameter/2]) rotate([90,0,0]) 
			cylinder(h=HolderDiameter, d=HolderDiameter, center=true);
	}
}

module Holes() { 
	module Screw() { 
		translate([0,0,-BaseHeight*2]) 
			rotate_extrude(angle=360) polygon(ScrewProfile);
	}
	translate([0,0,LegHeight+RodDiameter/2]) rotate([90,0,0]) // main hole
		cylinder(h=HolderDiameter+Clearance, d=RodDiameter+Clearance, center=true);
	if (LockDia!=0 && LockHeight!=0) {
		translate([0,0,LegHeight-LockHeight/2]) // locking pin (screw) passage
			cube(size=[LockDia+Clearance, HolderDiameter, LockHeight+2], center=true);  
	}
	translate([-(BaseWidth/2-8),0,0]) Screw();
	translate([+(BaseWidth/2-8),0,0]) Screw();
}
