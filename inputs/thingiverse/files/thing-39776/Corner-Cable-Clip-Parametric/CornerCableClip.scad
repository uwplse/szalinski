/*
 * Corner Cable Clip (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Dec 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: Holds a cable into a corner with a single nail.  
 * 
 * INSTRUCTIONS: Change "User-defined values" to suit your needs and print. Attach with a single nail. 
 * 
 * v0.69, Dec 30, 2012: Fixed a bug that caused the nail hole to be placed too close the body 
 *   on short tabs. 
 * v0.42, Dec 30, 2012: Initial Release.
 * 
 * TODO: 
 *   * None at this time. 
 */


/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

cableDiameter  = 4.3; // The diameter of the cable to be clipped 
nailDiameter   = 1.8; // The diameter of the nail or screw used to fasten the clip down

width          = 5;   // The overall width of the cable clip
tabLength      = 6;   // The length of the tab the nail goes through

thickness      = 2;   // The thickness of the clip 

$fn            = 35;  // General curve quality


/////////////////////////////////////////////////////////////////////////////
// The code...
/////////////////////////////////////////////////////////////////////////////

radius = cableDiameter/2+thickness; 
cutcube = [radius*2+1,radius*2+1,width+1]; // used for trimming the piece down to size 

difference() {
	union() {
		cylinder(h=width,r=radius);

		// close circle
		translate([0,-radius,0]) 
			cube([radius, radius, width]);

		// tab
		translate([radius,-radius+thickness,0]) 
			cube([tabLength, thickness, width]);
	}

	// Nail hole 
	translate([radius+tabLength-min(width/2,tabLength/2),0,width/2]) 
		rotate([90,0,0]) 
			cylinder(h=radius*2+1,r=nailDiameter/2, center=true);

	// Cable hole 
	translate([0,0,width/2]) 
		cylinder(h=width+1,r=cableDiameter/2,center=true);

	// Cut out the rest 
	translate([-cutcube[0]/2,-cutcube[1]-cableDiameter/2,-0.5]) 
		cube(cutcube);
	translate([-cutcube[0]-cableDiameter/2,-cutcube[1]/2,-0.5]) 
		cube(cutcube);
	translate([-cutcube[0]+cableDiameter/4,-cutcube[1]+cableDiameter/4,-0.5]) 
		cube(cutcube);
}
