/*
 * Wire Spool Clamp (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Jan 2013
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This will help keep spooled wire in its place. 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section if 
 *   necessary, render, and print. The default values fit a typical wire spool 
 *   found at Radio Shack. 
 * 
 * v0.42, Jan 30, 2013: Initial Release.
 * 
 * TODO: 
 *   * None at this time
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// The width of the spool clip.
width = 15;

// The inner diameter of the clip. (Go a bit small here because it bends open.)
diameter = 40;

// The thickness of the printed material. (Fine tune it for your printer.)
thickness = 1.35;

// The length of the tab/handle.
tabLength = 10; 

// The size of the opening at the back of the clip (not the window).
opening = 33; 

// The length of the guides on both sides of the back. 
guideLength = 4; 

// The amount of material on either side of the window. 
windowMargin = 3; 

// The angle position of the window.
windowAngle = 30; 

// General curve quality 
$fn = 50; 


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

angle = asin(opening/diameter);

union() {
	rodClamp( diameter, thickness, width, opening ); 

	for(y=[-1,1]) {
		rotate([0,0,angle*y])	
			translate([guideLength/2+diameter/2,thickness/2*y,0]) 
				cube([guideLength, thickness, width], center=true);
	}

	// tab
	translate([-(tabLength+diameter+thickness)/2,0,0]) 
	cube([tabLength+thickness,thickness,width], center=true);

}

// taken from my snapconnector.scad and then modified quite a bit... 
module rodClamp(rodDiameter=8, thickness=2, length=8, opening=6) {
	angle = asin(opening/rodDiameter);
	h = rodDiameter/2+thickness+1;
	x = cos(angle)*h; 
	y = sin(angle)*h;
	x2 = h/cos(angle);
	windowSide = (length/2-windowMargin)/cos(45);

	difference() {
		cylinder(h=length, r=rodDiameter/2 + thickness, center=true);
		cylinder(h=length+1, r=rodDiameter/2, center=true);

		rotate([0,0,-windowAngle]) 
			translate([-(rodDiameter/2+thickness)/2,0,0]) 
				rotate([45,0,0]) 
					cube([rodDiameter/2+thickness, windowSide, windowSide], center=true);
		
		linear_extrude(height=length+1, center=true) 
			polygon(points=[[0,0],[x,y],[x2,0],[x,-y]]);
	}
}
