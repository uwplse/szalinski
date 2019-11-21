/*
 * Rocker Switch Panel, v0.42
 *
 * by Alex Franke (CodeCreations), Feb 2014
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, and render. 
 * 
 * v1.00, Mar 7, 2014: Supports angles between 90-180, suggested by MyMakibox 
 * v0.42, Feb 1, 2014: Initial Release.
 */
 
/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////
 
/* [General Properties] */

// The thickness of the material (switch panel, clip, etc)
thickness = 2;

// The in-diameter of mounting nut (flat to flat)
nutInDiameter = 5.5; 

// The height of the mounting nut
nutHeight = 2.5; 

// The diameter of the screw holes 
screwHoleDiameter = 3; 

// Curve quality
$fn = 20;


/* [Switch Properties] */

// How many rows of switches? 
rows = 1; 

// How many columns of switches? 
columns = 3; 

// The width of the switch opening
switchWidth = 13;

// The length of the switch opening
switchLength = 20; 


/* [Mounting Clip Properties] */

// The angle of the mounted panel 
angle = 70; 

// The number of mounting clips
mountingClips = 3; 

// The distance between the mounting clips and the edges of the panel 
mountingClipMargin = 3;

// The width of the clip that attaches to the board
clipWidth = 13;

// The thickness of the board you're mounting the clips onto
boardWidth = 6.6; 

// The length that the clips extend over the board
boardClampLength = 10; 

// The length of the extender tab that you mount the panel to
extenderLength = 11; 


/* [Spacing] */

// The amount of space between each column of switches (X direction) 
xSwitchPadding = 5;

// The amount of space between each row of switches (Y direction) 
ySwitchPadding = 6;

// The amount of space between the switches and the left and right edges of the panel
xMargin = 7;  

// The amount of space between the switches and the top and bottom edges of the panel
yMargin = 5;  

// How much space to leave for labels
labelPadding = 10; 

// Should label space go below the switch or above it?
labelBelow = true;


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

rockerSwitchPanel();

yOffset = ( angle < 90 ) ? 0 : extenderLength * cos(180-angle);

translate([
	(thickness+boardClampLength+extenderLength+1)/2,
	-((thickness*2+boardWidth+nutHeight)/2)-1 - yOffset,
	clipWidth/2
	]) 
for ( i=[0:mountingClips-1] ) {
	translate([(thickness+boardClampLength+extenderLength+1)*i,0,0]) 
	mount();
}


/////////////////////////////////////////////////////////////////////////////
// Modules... 
/////////////////////////////////////////////////////////////////////////////

module rockerSwitchPanel() {

	panelSize = [
		columns*switchWidth + xSwitchPadding*(columns-1) + xMargin*2,
		rows*(switchLength+labelPadding) + ySwitchPadding*(rows-1) + yMargin*2,
		thickness
		];
	clipSeperation = (panelSize[0] - 2*mountingClipMargin - mountingClips*clipWidth)
		/(mountingClips-1);

	union() {

		// mounting clips
*		translate([
			mountingClipMargin+boardClampLength/2,
			(thickness*2+boardWidth)/2,
			-(thickness+boardClampLength)/2
		]) 
		for ( i=[0:mountingClips-1] ) { 
			translate([i*(clipSeperation+clipWidth),0,0]) 
			rotate([0,90,180]) 
			mount(); 
		}

		// panel
		//	rotate([angle,0,0]) 
		difference() {
			cube(panelSize);
			
			translate([xMargin,yMargin+(labelBelow?labelPadding:0),-0.5]) 
			for( i=[0:columns-1], j=[0:rows-1] ) {
				translate([
					i*(switchWidth+xSwitchPadding),
					j*(switchLength+ySwitchPadding+labelPadding),
					0]) 		
				 	cube([switchWidth, switchLength, thickness+1]);
			}

			// mounting holes 
			translate([
				mountingClipMargin+boardClampLength/2,
				extenderLength/2,
				-0.5
				])
			for ( i=[0:mountingClips-1] ) { 
				translate([i*(clipSeperation+clipWidth),0,0]) 
				cylinder( h=thickness+1, r= screwHoleDiameter/2);
			}
		}
	}
}

module mount () {

	boxSize = [thickness+boardClampLength,thickness*2+boardWidth,clipWidth]; 

	difference() {
		union() {
			cube(boxSize, center=true); 
			translate([0,-boardWidth/2-((nutHeight + 0.5)+thickness)/2,0]) 
				cube([nutInDiameter+thickness,(nutHeight + 0.5)+thickness,clipWidth], center=true); 

			translate([-boxSize[0]/2,boxSize[1]/2-0.05,clipWidth/2]) 
			rotate([180,0,-angle]) 
			difference() {
				union() {
					cube([thickness,extenderLength,clipWidth], center=false); 
					if ( angle > 90 ) 
						translate([0,-thickness+0.05,0]) 
						cube([thickness,thickness,clipWidth], center=false); 
				}
				translate([-0.5,extenderLength/2,clipWidth/2]) 
				rotate([0,90,0]) 
				cylinder(h=thickness+1, r=screwHoleDiameter/2);
			}

			translate([0,0,-clipWidth/2]) 
			linear_extrude( height=thickness ) 
				polygon( points=[
					[-boxSize[0]/2,-boxSize[1]/2],
					[-boxSize[0]/2,boxSize[1]/2],
					[-boxSize[0]/2-extenderLength*sin(angle)+thickness*sin(90-angle),
						boxSize[1]/2-extenderLength*cos(angle)-thickness*cos(90-angle)]
					] ); 

		}
		translate([thickness,0,0]) 
			cube([boxSize[0],boardWidth,clipWidth+1], center=true); 

		translate([0,-(boardWidth/2 + (nutHeight + 0.5)/2 + thickness/2),0])
		rotate([90,-90,0]) 
		captiveNut( [nutInDiameter,nutHeight + 0.5], setScrewHoleDiameter=screwHoleDiameter, 
			depth=10, holeLengthTop=5, holeLengthBottom=5 );
	}
}


// This is the captive nut module I use in several of my designs. 
module captiveNut( nutSize, setScrewHoleDiameter=3, 
	depth=10, holeLengthTop=5, holeLengthBottom=5 )
{
	render()
	union() {
		nut( nutSize ); 
	
		if ( depth > 0 ) 
			translate([depth/2,0,0]) 
				cube( [depth, nutSize[0], nutSize[1]], center=true );
	
		translate([0,0,-(nutSize[1]/2)-holeLengthBottom]) 
			cylinder(r=setScrewHoleDiameter/2, h=nutSize[1]+holeLengthTop+holeLengthBottom, $fn=15);
	}
}

// nutSize = [inDiameter,thickness]
// (Yes, it's a little nutty.)
module nut( nutSize ) { 
	side = nutSize[0] * tan( 180/6 );
	if ( nutSize[0] * nutSize[1] != 0 ) {
		for ( i = [0 : 2] ) {
			rotate( i*120, [0, 0, 1]) 
				cube( [side, nutSize[0], nutSize[1]], center=true );
		}
	}
}