/* 
 Spring retainer for Traxxas R/C cars
 Eric Lindholm
 22 November 2016
*/

// preview[view:south east, tilt:top diagonal]

// Use mm please.
// This is a small part.

// Diameter of middle shaft
ShaftDiameter = 3.2;  // [2:0.1:5]
// Diameter of spring
SpringDiameter = 18;  // [6:0.1:28]

/* [Hidden] */
outerD=SpringDiameter+2.5;  
height=8.5;
filletR=outerD*0.3;
$fn=36;

retainer();

module retainer() {
	difference() {
	// Positive shapes
		union() {
		// Primary shape
			cylinder(r=outerD/2,h=height);
		}
	// Negative shapes
		union() {
		// Fillet	shape
			rotate_extrude(convexity=10)
				translate([outerD/2,height,0])
					circle(r=filletR);
		// Hollow at top
			translate([0,0,height-3])
				cylinder(r=ShaftDiameter,h=height);
		// Spring slot
			translate([0,0,-1])
				difference() {
					cylinder(r=SpringDiameter/2,h=2);
					cylinder(r=ShaftDiameter*1.8,h=2);
				}
		// Shaft hole
			translate([0,0,-1])
				cylinder(r=ShaftDiameter/2,h=height*2);
		// Slot for shaft
			translate([outerD/2,0,height/2])
				cube([outerD,ShaftDiameter*0.875,height*2],center=true);
		// Hollow at bottom
			translate([0,0,-1])
				cylinder(r1=ShaftDiameter,r2=ShaftDiameter/2,h=3.5);
		}
	}
}

