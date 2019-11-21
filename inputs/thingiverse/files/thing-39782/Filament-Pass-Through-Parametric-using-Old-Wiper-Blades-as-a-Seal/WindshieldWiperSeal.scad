/*
 * Windshield Wiper Seal (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Dec 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: Holds pieces of windshield wiper blade rubber together in order to cover a gap in 
 *   a channel while still permitting something to go through it. This is useful if you have a 
 *   channel at the top of a ventilated case through which you pass filament. 
 * 
 * INSTRUCTIONS: Change "User-defined values" to suit your needs, print, and insert wiper blades. 
 * 
 * v0.42, Dec 29, 2012: Initial Release.
 * 
 * TODO: 
 *   * Clean up OpenSCAD to avoid having to NetFabb. 
 */


/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

layerHeight         = 0.4; // This makes it easier to print the holes, but they need to be drilled

bladeBaseWidth      = 6;   // Width of the base of the rubber wiper blade (with blade pointing up) 
bladeBaseHeight     = 5.5; // Height of the base of the rubber wiper blade (with blade pointing up) 
bladeHeight         = 5;   // Distance that the blade extends from the base
bladeOverlap        = 1;   // Distance that blades should overlap at the middle

openingLength       = 134; // Length of opening/channel being covered
mountingHoles       = 3;   // Number of *sets* of mounting holes along the length of the channel
edgeThickness       = 2;   // Thickness of printed material along the edges 
topThickness        = 1.2; // Thickness of printed material covering (holding down) the wiper blade
endWidth            = 2;   // Distance the printed part extends beyond the channel to be covered 
endPadding          = 4;   // Distance between the end of the opening and the edge of the printed piece 

screwDiameter       = 3.3; // Diameter of mounting screw
nutInDiameter       = 5.9; // In-diameter of the mounting nut (flat to flat), 5.5 for M3
nutThickness        = 2.5; // Thickness of mounting nut, 2.3 for M3
screwHolePadding    = 1.5; // Width of printed material around screw holes 
bracketThickness    = 3.8; // Thickness of bracket (should be greater than nut thickness)
supportAngle        = 45;  // Angle of support material

$fn                 = 35;  // General curve quality


/////////////////////////////////////////////////////////////////////////////
// The code...
/////////////////////////////////////////////////////////////////////////////

rounding = min(edgeThickness,endWidth); 
channelWidth = bladeHeight*2-bladeOverlap; 
size = [openingLength+2*endWidth+endPadding*2, 
	channelWidth+2*edgeThickness+2*bladeBaseHeight,
	bladeBaseWidth+topThickness];
bracketWidth = (nutInDiameter/sqrt(3)+screwHolePadding)*2; 
mountingLength = size[0]-rounding*2; // length along which to put mounting holes 
mountingGap = (mountingLength-(mountingHoles*bracketWidth))/(mountingHoles-1);
bladeLength = openingLength+endPadding*2; 

echo(str("Cut blades to exactly ", bladeLength, "mm long.")); 

echo(str("Total body size is ",size)); 
if ( bracketThickness <= nutThickness )
	echo(str("WARNING: Bracket thickness ", bracketThickness, " should be greater than nut thickness ", 
		nutThickness)); 

rotate([180,0,0]) 
union() {
	difference() {
		roundedBox(size, rounding); 
		
		// Center channel 
		translate([0,0,-0.5]) 
			roundedBox([openingLength,channelWidth,size[2]+1], channelWidth/2); 
	
		// Blade housing
		translate([0,0,(bladeBaseWidth+1)/2-1]) 
			cube([bladeLength,channelWidth+bladeBaseHeight*2,bladeBaseWidth+1], center=true);
	}

	translate([(bracketWidth-mountingLength)/2,0,0]) 
	for(x=[0:mountingHoles-1], y=[-1,1]) 
		translate([(bracketWidth+mountingGap)*x,y*(size[1]+nutInDiameter)/2,0]) 
		rotate([0,0,90*y]) 	
		bracket(nutInDiameter/2,screwDiameter/2,[nutInDiameter,nutThickness],
			screwHolePadding,bracketThickness,size[2],supportAngle,layerHeight); 
	
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
module bracket(length, holeRadius, nutSize, holePadding, thickness, totalHeight, supportAngle,layerHeight) {
	outRadius = nutSize[0]/sqrt(3); 
	radius = outRadius+holePadding; 
	size = [length+radius,radius*2,totalHeight];

	carveBlock = [size[0],size[1]+1,size[2]*2]; // used to carve off material 

	union() {
		difference() {
			union() {
				translate([-length/2,0,totalHeight/2]) 	
					cube([size[0]-size[1]/2,size[1],size[2]], center=true); 
				cylinder(h=totalHeight,r=size[1]/2);
			}
			
			// Carve out nut trap 
			translate([0,0,thickness-(nutSize[1]+totalHeight)/2+totalHeight]) 
				rotate(30) 
					nut([nutSize[0],nutSize[1]+totalHeight]); 
	
			// Carve out hole 
			cylinder(h=totalHeight*2+1,r=holeRadius,center=true);
	
			// Carve out support material slope 
			translate([radius,0,thickness-nutSize[1]]) 
				rotate([0,-90+supportAngle,0]) 
					translate([0,-carveBlock[1]/2,0]) 
						cube(carveBlock); 
	
			// Carve out extra hole padding 
			translate([-carveBlock[0]-length,-carveBlock[1]/2,-0.5]) 
				cube(carveBlock); 
	
		}

		// Add bridging layer for hole 
		translate([0,0,-layerHeight/2+thickness-nutSize[1]]) 
			cylinder(r=holeRadius+1, h=layerHeight, center=true);
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

// My nutty nut -- used in several designs. nutSize = [inDiameter,thickness]
module nut( nutSize ) { 
	side = nutSize[0] * tan( 180/6 );
	if ( nutSize[0] * nutSize[1] != 0 ) {
		for ( i = [0 : 2] ) {
			rotate( i*120, [0, 0, 1]) 
				cube( [side, nutSize[0], nutSize[1]], center=true );
		}
	}
}