/*
 * Shower Caddy Anchor, v1.0
 *
 * by Alex Franke (CodeCreations), Jun 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This is a simple parametric shower caddy anchor that uses a suction
 *   cup from a nerf dart to keep the caddy stable. 
 * 
 * INSTRUCTIONS:  Choose some values in the "User-defined values" section, render,
 *   and print one or more of the shower caddy anchors. (For me, it required about 
 *   285mm of filament -- about 5 cents.) Pull the suction cup(s) off of a Nerf 
 *   suction dart (e.g. http://amzn.com/B00284C4FK -- or you can get them at places 
 *   like Walmart) and clean off any remaining glue. Attach dart head to shower caddy 
 *   anchor. 
 * 
 * v1.0, Jun 17, 2012: Initial Release.
 * 
 * TODO: 
 *   * nothing yet...  
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

diameter      = 12.5;  // Diameter of the nerf dart
holeDiameter  = 7;     // Diameter of the hole in the nerf dart
height        = 10;    // Height of the suction cup mount
thickness     = 4;     // Thickness of the base that connects the cup to the clip
clipThickness = 10;    // Overall width of the clip 
clipHeight    = 13;    // Overall height of the clip 
gap           = 2	;     // Distance between the clip and the suction cup mount 
wireDiameter  = 5.5;   // Diameter of the caddy wire
gutterWidth   = 4.7;   // Width of the gap used to snap the wire in place. 

$fn           = 20;    // Curve detail 


/////////////////////////////////////////////////////////////////////////////
// Calculated values... 
/////////////////////////////////////////////////////////////////////////////

length = clipThickness + gap + diameter/2; 
gutterHeight = clipHeight-wireDiameter/2 - 2; 


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

difference() {
	union() {
		// Suction cup mount 
		translate([0,0,height/2]) 
			cylinder( r=diameter/2, h=height, center=true );

		// Base connecting suction cup mount to clip 
		translate([length/2,0,thickness/2]) 
			cube( [length,diameter,thickness], center=true);  

		// Caddy clip 
		translate([length-clipThickness/2,0,clipHeight/2]) 
			cube( [clipThickness,diameter,clipHeight], center=true);  
	}

	// Suction cup mount hole 
	translate([0,0,height/2]) 
		cylinder( r=holeDiameter/2, h=height+1, center=true );

	// Caddy wire hole
	translate([length-clipThickness/2,0,clipHeight-wireDiameter/2 - 2]) 
		rotate([90,0,0]) 
			cylinder( r=wireDiameter/2, h=diameter+1, center=true );

	// Caddy wire gutter 
	translate([length-clipThickness/2,0,(gutterHeight-1)/2]) 
		cube( [gutterWidth, diameter+1, gutterHeight+1], center=true );
}
