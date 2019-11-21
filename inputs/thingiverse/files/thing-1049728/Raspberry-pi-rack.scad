/*Customizer Variables*/
/* [All] */

// Generate poles to stack another rack on top?
poles = 0; // [1:Yes,0:No]

// Height of poles in mm (not counting standoffs); the raspberry pi B+ is about 15mm tall.
poleheight = 16.5; // [15.5:0.5:25]

// Generate a vent on the bottom of the rack?
vented = 1; // [1:Yes,0:No]

// Generate standoffs to mount a pi? Overrides poles option. (Disable for a top cover)
standoffs = 1; // [1:Yes,0:No]

// Radius of the corners of the base - 0 will produce non-rounded corners.
corner_radius = 3; // [0:0.5:6]

/***********
*  Don't   *
*  Touch!  *
***********/

/* [Hidden] */

$fn=64;

x=85;
y=56;
thickness=2;
offsetheight=3;

module pole(x,y,height=0) {
	translate([x,y,thickness]) {
		cylinder(offsetheight,d=4);
		translate([0,0,offsetheight])
			cylinder(2+height,d=2.5);
	}
		
}

module indent(x,y,depth=thickness/2) {
	translate([x,y,-0.01])
		// translated down Z to prevent Z fighting in preview
		cylinder(depth+0.01,d=2.75);
}

module vent(x,y) {
	translate([x,y,-0.01]) {
		// translated down Z to prevent Z fighting in preview
		rotate([0,0,45]){
			difference() {
				union() {
					difference() {
						cylinder(thickness+0.02,d=26);
						cylinder(thickness+0.02,d=22);
					}
					difference() {
						cylinder(thickness+0.02,d=18);
						cylinder(thickness+0.02,d=14);
					}
					difference() {
						cylinder(thickness+0.02,d=10);
					}
				}
				translate([-25,-1,-0.01])
					cube([50,2,thickness+0.02]);
				translate([-1,-25,-0.01])
					cube([2,50,thickness+0.02]);
			}
		}
	}
}

module roundedcube(x, y, z, r) {
	if (r == 0) {
		cube([x,y,z]);
	} else {
		hull() {
			translate([r,r,0]) cylinder(z,r=r);
			translate([x-r,r,0]) cylinder(z,r=r);
			translate([r,y-r,0]) cylinder(z,r=r);
			translate([x-r,y-r,0]) cylinder(z,r=r);
		}
	}
}

difference() {
	union() {
		roundedcube(x,y,thickness,corner_radius);
		if (poles) {
			if (standoffs) {
				pole(3.5,3.5,poleheight);
				pole(3.5,y-3.5,poleheight);
				pole(x-23.5,3.5,poleheight);
				pole(x-23.5,y-3.5,poleheight);
			}
		} else {
			if (standoffs) {
				pole(3.5,3.5);
				pole(3.5,y-3.5);
				pole(x-23.5,3.5);
				pole(x-23.5,y-3.5);
			}
		}
	}
	indent(3.5,3.5);
	indent(3.5,y-3.5);
	indent(x-23.5,3.5);
	indent(x-23.5,y-3.5);
	if (vented)
		vent((x-23.5)/2,y/2);
}