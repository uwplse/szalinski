/*
 * Board Anchor (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Dec 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: Serves to anchor a board (such as the foot of a laser-cut printer) vertically. 
 * 
 * INSTRUCTIONS:  Print an anchor for each end to be anchored, then install with the board in place
 *   if possible. 
 * 
 * v0.42, Dec 28, 2012: Initial Release.
 * 
 * TODO: 
 *   * None at this time. 
 */


/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

thickness      = 3.25; // Thickness of the printed material 
anchorLength   = 16;   // Length of board edge to "wrap" in the anchor 
anchorHeight   = 5;    // Height of anchor portion  
boardThickness = 6;    // Thickness of the board to anchor

shaftDiameter  = 3;    // The diameter of the through-hole for the screw. #6=3.58, #4=2.78
headDiameter   = 6;    // The diameter of the head of the screw. #6=7.14, #4=5.95
holePadding    = 2.5;  // The width of the material around the hole 
screwAngle     = 82;   // Countersink angle (angle of screw head -- 82 is pretty standard for wood 
                       //   screws.) Other common countersink angles are 60, 90, 100, 110, and 120. 

counterSink    = 0.5;  // Additional distance to inset the countersink

$fn            = 35;   // General curve quality


/////////////////////////////////////////////////////////////////////////////
// The code...
/////////////////////////////////////////////////////////////////////////////

yHeight = (headDiameter/2-shaftDiameter/2)/tan(screwAngle/2); 

difference() {
	union() {
		roundedBox([anchorLength+thickness,boardThickness+thickness*2,anchorHeight],thickness);

		for(y=[-1,1]) 
			translate([0,(boardThickness/2+thickness+headDiameter/2)*y,0]) 
				rotate(y*-90) 
					bracket(headDiameter/2,shaftDiameter/2,headDiameter/2,holePadding,thickness);
	}

	// remove the board 
	translate([-(anchorLength+thickness)/2+thickness,-boardThickness/2,-0.5]) 
		cube([anchorLength+1,boardThickness,anchorHeight+1]);

	// Remove the screw holes 
	for(y=[-1,1]) 
		translate([0,(boardThickness/2+thickness+headDiameter/2)*y,-counterSink]) 
			rotate(y*-90) 
				bracketHole(shaftDiameter/2,headDiameter/2,screwAngle,thickness);
}


/////////////////////////////////////////////////////////////////////////////
// Modules...
/////////////////////////////////////////////////////////////////////////////

module roundedBox(size, radius) {
	union() {
		for(x=[-1,1],y=[-1,1]) 
			translate([x*(size[0]-radius*2)/2,y*(size[1]-radius*2)/2,0]) 
				cylinder(h=size[2],r=radius);

		translate([0,0,size[2]/2]) {
			cube([size[0],size[1]-radius*2,size[2]], center=true);
			cube([size[0]-radius*2, size[1],size[2]], center=true);
		}
	}
}

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