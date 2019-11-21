/*
 * Lid Postion Guide (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Dec 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: Serves as a guide for placing a rectangular lid onto a flat surface in 
 *   a specific position. 
 * 
 * INSTRUCTIONS:  Print 3-4 guides and install then with the lid in place, if possible. 
 * 
 * v0.42, Dec 28, 2012: Initial Release.
 * 
 * TODO: 
 *   * None at this time.
 */


/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

cornerAngle    = 90;   // Angle of corner the guild will be placed against
sideLength     = 10;   // The length of each side of the guide, extending from the corner
guideHeight    = 10;   // The height of the guide portion of the piece
bodyHeight     = 3;    // The height of the body portion that gets fastened down

shaftDiameter  = 3.75; // The diameter of the through-hole for the screw. #6=3.58
headDiameter   = 7.25; // The diameter of the head of the screw. #6=7.14
holePadding    = 2.5;  // The width of the material around the hole 
screwAngle     = 82;   // Countersink angle (angle of screw head -- 82 is pretty standard for wood 
                       //   screws.) Other common countersink angles are 60, 90, 100, 110, and 120. 

counterSink    = 0.5;  // Additional distance to inset the countersink

$fn            = 35;   // General curve quality


/////////////////////////////////////////////////////////////////////////////
// The code...
/////////////////////////////////////////////////////////////////////////////

wedgeLength = sideLength*cos(cornerAngle/2);
wedgeHeight = sideLength*sin(cornerAngle/2);
yHeight = (headDiameter/2-shaftDiameter/2)/tan(screwAngle/2); 

difference() {
	union() {
		intersection() {
	
			union() {
				wedge(wedgeLength, guideHeight, cornerAngle);
					linear_extrude(height=bodyHeight, convexity=4) {
						polygon(points=[
							[wedgeLength,wedgeHeight],
							[wedgeLength+headDiameter+holePadding,0],
							[wedgeLength,-wedgeHeight]
						]);
					}
			}
			translate([wedgeLength,0,0]) 
				scale([wedgeLength,wedgeLength,guideHeight]) 
					sphere(r=1) ;
		}
	
		rotate(180) 
			translate([-(wedgeLength+headDiameter/2),0,0]) 
				bracket(headDiameter/2,shaftDiameter/2,headDiameter/2,holePadding,bodyHeight);
	}
	
	rotate(180) 
		translate([-(wedgeLength+headDiameter/2),0,-counterSink]) 
			bracketHole(shaftDiameter/2,headDiameter/2,screwAngle,bodyHeight);
}


/////////////////////////////////////////////////////////////////////////////
// Modules...
/////////////////////////////////////////////////////////////////////////////

// length = end to hole center
module bracket(length, holeRadius, headRadius, holePadding, thickness) {
	union() {
		translate([length/2,0,thickness/2]) 	
			cube([length,(headRadius+holePadding)*2,thickness], center=true); 
		cylinder(h=thickness,r=headRadius+holePadding);
	}
}

module bracketHole(holeRadius, headRadius, headAngle, thickness) {
	translate([0,0,thickness]) 
	rotate_extrude(convexity=4) {
		polygon(points=[
			[0,-(thickness+1)-yHeight],
			[holeRadius,-(thickness+1)-yHeight],
			[holeRadius,-yHeight],
			[headRadius,0],
			[headRadius,thickness+1],
			[0,thickness+1]
		]);
	}
}

module wedge(length, height, angle) {

	x = length; 
	y = 2*x*tan(angle/2); 
	z = height;
	x2 = (y/2)/sin(angle/2);

	difference() {
		translate([0,-y/2,0]) 
			cube([x,y,z]);

		for(i=[-1,1])
			rotate([0,0,angle/2*i]) 
				translate([0,-y/2 +y/2*i,-0.5]) 
					cube([x2,y,z+1]);

	}
}