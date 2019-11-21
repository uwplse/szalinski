/*
 * Knob with Latch, v0.42
 *
 * by Alex Franke (CodeCreations), Jan 2013
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This is a parametric knob with hole cover and latch. The latch is meant to hold 
 *   a door or drawer from the back so it doesn't pull out or open. The latch is engaged or 
 *   released by turning the knob. 
 * 
 * INSTRUCTIONS: Edit the "User-defined values" section to meet your needs. Check the echo output 
 *   (rendering output) for the minimum screw length required. Insert a screw through the top of 
 *   the knob, and screw a nut onto the end. Tighten the screw until the nut is brought up into 
 *   the knob and locks into place. Insert the exposed threaded screw through the material you're 
 *   attaching the knob to. Add the latch over the end of the screw with the nut trap facing out. 
 *   Add a nut and turn the the knob until the nut is brought into the latch. Add another nut 
 *   and tighten it down against the previously added nut to lock the latch into place. Place the 
 *   cap over the screw hole in the front of the knob and snap into place. 
 * 
 * VIDEO: http://www.youtube.com/watch?v=ZVg8XCQSZRU 
 * 
 * v0.42, Jan 1, 2013: Initial Release.
 * 
 * TODO: 
 *   * Fix OpenSCAD silliness so you don't have to run it through netfabb 
 */


/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// Optional parameters that do not affect the rendered model
boardWidth             = 18;   // Used only for calculating minimum screw length

// Printer capabilities 
layerHeight            = 0.33; // Layer height for hole support material, or zero for none

// Hardware parameters 
holeDiameter           = 3.6;  // Diameter of clearance hole. M3=3
screwHeadDiameter      = 7.5;  // Diameter of the head of the screw. M3=6.7 
nutInDiameter          = 5.8;  // Flat-to-flat diameter of the nuts. M3=5.5 
nutHeight              = 2.5;  // Height or thickness of the nuts. M3=2.5

// Knob parameters 
knobBaseDiameter       = 15;   // Diameter of the base of the knob
knobTopDiameter        = 20;   // Diameter of the top of the knob
knobHeight             = 20;   // Total height of the knob (not including the cap) 
burlDiameter           = 10;   // Diameter of the burl cut-outs
burlInset              = 1.8;  // Distance the burl cut-outs are inset into the knob
screwHeadDepth         = 15;   // Depth of the screw head inside the knob

// Knob cap parameters 
knobCapTopDiameter     = 14;   // Top diameter of the knob cap 
knobCapHeight          = 2;    // Total height of the knob cap 
knobCapInsertionLength = 2;    // Insertion depth of the knob cap 

// Latch parameters 
latchThickness         = 1.5;  // Thickness of the latch material 
latchLength            = 16;   // Length of the latch, measured from the center of the hole
nutPadding             = 2;    // Width of material surrounding the nut on the latch

// Rendering parameters
printSeparation        = 3;    // Distance to separate rendered objects 
$fn                    = 30;   // General curve quality


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

// echo out required screw length 
echo( str("Screw length of at least ", knobHeight-screwHeadDepth+boardWidth
	+latchThickness+2*nutHeight, "mm required.") ); 

outerNutInDiameter = nutInDiameter+2*nutPadding; 

// Render Knob
knob();

// Render Latch
translate([0,-(knobBaseDiameter+outerNutInDiameter)/2-printSeparation,0]) 
	latch(); 

// Render Knob Cap
translate([knobBaseDiameter/2+max(knobCapTopDiameter/2,knobTopDiameter/2-burlInset)+printSeparation,0]) 
	knobCap(); 


/////////////////////////////////////////////////////////////////////////////
// Modules... 
/////////////////////////////////////////////////////////////////////////////

module knobCap() {
	union() {
		cylinder( r1=knobCapTopDiameter/2, r2=knobTopDiameter/2-burlInset, h=knobCapHeight);
		translate([0,0,knobCapHeight]) 
			cylinder(r=screwHeadDiameter/2, h=knobCapInsertionLength);
	}
}

module latch() {
	
	difference() {
		union() {
			translate([0,0,nutHeight/2+latchThickness]) 
				difference() {
					nut([outerNutInDiameter,nutHeight]);
					nut([nutInDiameter,nutHeight+1]);
				}
	
			translate([0,0,latchThickness/2]) 
				nut([outerNutInDiameter,latchThickness]);
	
			translate([latchLength/2,0,latchThickness/2]) 
				rotate([0,0,180]) 
					stick([latchLength,outerNutInDiameter,latchThickness], 1);
		}
	
		translate([0,0,-0.5]) 
			cylinder(h=latchThickness+nutHeight+1,r=holeDiameter/2);
	}

}

module knob() {

	if (knobHeight-screwHeadDepth-nutHeight < latchThickness) 
		echo("WARNING: Screw hole might be too deep!");

	union() {
		difference() {
			
			cylinder( r1=knobBaseDiameter/2, r2=knobTopDiameter/2, h=knobHeight);
	
			for ( i = [0 : 5] ) {
			   	rotate( [0,0, i*(360/6)])
					translate([(knobTopDiameter+burlDiameter)/2-burlInset,0,-0.5]) 
					   	cylinder( r=burlDiameter/2, h=knobHeight+1 );
			}
	
			translate([0,0,nutHeight/2 - 0.5]) 
				nut([nutInDiameter,nutHeight + 0.5]);	
	
			translate([0,0,nutHeight/2 - 0.5]) 
				cylinder(h=knobHeight-3, r=holeDiameter/2);	
	
	
			// Through hole 
			translate([0,0,-0.5]) 
				cylinder(h=knobHeight+1, r=holeDiameter/2);	
	
			// Screw head 
			translate([0,0,knobHeight-screwHeadDepth]) 
				cylinder(h=screwHeadDepth+1, r=screwHeadDiameter/2);	
	
			// Knob nut
			translate([0,0,(nutHeight+1)/2-1]) 
				nut([nutInDiameter,nutHeight+1]);
			
		}

		// support material to drill out. 
		translate([0,0,nutHeight+layerHeight/2]) 
			cube([holeDiameter,holeDiameter, layerHeight], center=true); 
	}
	
}

// My nutty nut code. nutSize = [inDiameter,thickness]
module nut( nutSize ) { 
	side = nutSize[0] * tan( 180/6 );
	if ( nutSize[0] * nutSize[1] != 0 ) {
		for ( i = [0 : 2] ) {
			rotate( i*120, [0, 0, 1]) 
				cube( [side, nutSize[0], nutSize[1]], center=true );
		}
	}
}

// Makes a stick with 0, 1, or 2 rounded ends, and optionally centered on the 
// circle center of one end. 
module stick( stickSize, numRounds, centerCircle=false ) {

	assign( dist = (stickSize[0]-stickSize[1])/2 )
	translate([centerCircle?dist:0,0,0]) 
	union() {
		for ( i=[-1,1] )
			translate([ i*dist, 0, 0 ]){
				cylinder( r=stickSize[1]/2, h=stickSize[2], center=true );
		}	
		cube(stickSize + [-stickSize[1],0,0], center=true);
		if ( numRounds < 2 ) 
			translate([ stickSize[0]/2 - stickSize[1]/4, 0, 0 ])
				cube([stickSize[1]/2,stickSize[1],stickSize[2]], center=true);
		if ( numRounds < 1 ) 
			translate([ -stickSize[0]/2 + stickSize[1]/4, 0, 0 ])
				cube([stickSize[1]/2,stickSize[1],stickSize[2]], center=true);
	}
}

