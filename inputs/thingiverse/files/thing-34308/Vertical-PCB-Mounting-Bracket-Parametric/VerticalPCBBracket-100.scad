/*
 * Vertical PCB Mounting Bracket
 *
 * by Alex Franke (CodeCreations), Oct 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This little bracket provides an easy way to mount a PCB vertically. It includes
 *   a small wire clamp that can be used to hold PCB wires in place. I use it to hold a small 1"  
 *   by 0.5" PCB that has a bank of header pins for X, Y, Z, and E motors. 
 * 
 * INSTRUCTIONS: Set User-defined values, render, and print. Insert the PCB in the channel and 
 *   route the wires between the mounting holes. Place the wire clamp on top and mount using the 
 *   holes. You may need to tweak the values a bit for a snug fit. 
 * 
 * THING: http://www.thingiverse.com/thing:34308
 * 
 * v1.00, Jun 15, 2012: Initial version. 
 *
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// Describe the PCB 
boardWidth       = 27.5;  // Width of the PCB or board to hold
boardThickness   = 2.05;  // Thickness of the PCB or board to hold
clipHeight       = 12.7;  // The height of the PCB or board to hold 

// Describe the bracket 
thickness        = 2;     // The thickness of the material surrounding the board 
baseThickness    = 2;     // The thickness of the base 
supportWidth     = 4;     // The overall width of the support risers
holeDiameter     = 3.5;   // The diameter of the holes 
holePadding      = 2;     // The distance between the edge of the hole other edges or walls

// Describe the wire clamp 
includeWireClamp = true;  // Whether or not to include the wire clamp 
play             = 1;     // The amount of play in the wire clamp

// Other parameters 
$fn              = 20;    // General circle quality. 


/////////////////////////////////////////////////////////////////////////////
// Some calculated values... 
/////////////////////////////////////////////////////////////////////////////

overallSize = [	boardWidth+thickness*2, 
				boardThickness+thickness*2+holeDiameter+holePadding*2, 
				baseThickness+clipHeight];

X=0;
Y=1;
Z=2;

/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

difference() {
	translate([overallSize[X]/2,0,0]) 
		rotate([90,0,-90]) 
			linear_extrude(height=overallSize[X])
				polygon(points=[
					[0,0],
					[0,overallSize[Z]],
					[boardThickness+thickness*2,overallSize[Z]],
					[overallSize[1],baseThickness],
					[overallSize[1],0],
					[0,0]
				]);

	translate([0,-overallSize[Y]/2,overallSize[Z]/2+baseThickness])
		cube([overallSize[X]-supportWidth*2,overallSize[Y]+1,overallSize[Z]], center=true);

	translate([0,-boardThickness/2-thickness,clipHeight/2+baseThickness+0.5]) 
		cube([boardWidth,boardThickness,clipHeight+1], center=true);

	for(i=[-1,1]) 
		translate([	i*(overallSize[X]/2-supportWidth-holePadding-holeDiameter/2),
					-boardThickness-thickness*2-holePadding-holeDiameter/2,
					-0.5]) 
			cylinder(h=boardThickness+1, r=holeDiameter/2);

}

if ( includeWireClamp ) {
	translate([0,-20,thickness/2]) 
	difference() {
		cube([	overallSize[X]-supportWidth*2-play,
				holeDiameter+holePadding*2,
				thickness], center=true);
	
		for(i=[-1,1]) 
			translate([	i*(overallSize[X]/2-supportWidth-holePadding-holeDiameter/2),0,0]) 
				cylinder(h=boardThickness+1, r=holeDiameter/2, center=true);
	
	
	}
}