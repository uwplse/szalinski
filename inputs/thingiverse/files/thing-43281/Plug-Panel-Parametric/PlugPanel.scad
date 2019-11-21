/*
 * Plug Panel (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Jan 2013
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This is a parametric plug panel, allowing you to attach a set of 
 *   panel-mounted plugs. It includes some ribs for added strength, and it's fully 
 *   "inside-out" parametric, with the overall size driven by the sizes and distances 
 *   you choose for the details. It prints out the total dimensions. 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section, render,
 *   and print. You may need to run the output through netfabb. 
 * 
 * v0.42, Jan 18, 2013: Initial Release.
 * 
 * TODO: 
 *   * None at this time
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// The diameter of the holes for the plugs
holeDiameter = 8.5;

// Number of rows of holes in the panel 
rows = 1;

// Number of columns of holes in the panel 
columns = 3;

// How far apart the holes are from each other
separation = 15;

// The thickness of the panel, mouting bracket and ribs
thickness = 2;

// Extra width added to each side
xMargin = 4;

// Extra height added to the top and bottom
yMargin = 0;

// Rounding radius at the corners opposide the bracket
roundRadius = 10;

// The depth of the mounting bracket
mountingDepth = 15;

// The diameter of the mounting holes
mountHoleDiameter = 3.5;

// Overall curve quality
$fn = 35;


/////////////////////////////////////////////////////////////////////////////
// Some calculated values and helpful output... 
/////////////////////////////////////////////////////////////////////////////
X = 0 + 0;  // ignore in customizer
Y = 1 + 0;  // ignore in customizer
Z = 2 + 0;  // ignore in customizer
margin = [xMargin,yMargin]; 

totalSize = [
	(holeDiameter+separation)*columns+margin[X]*2, 
	(holeDiameter+separation)*rows+margin[Y]*2,
	mountingDepth+thickness
	];
holeDist = holeDiameter+separation; 

echo( str( "Total size is ", totalSize ) ); 

/////////////////////////////////////////////////////////////////////////////
// The code...
/////////////////////////////////////////////////////////////////////////////
difference() {

	intersection() {
		union() {
			// face plate
			translate([0,0,thickness/2]) 
				cube([totalSize[X], totalSize[Y], thickness], center=true);
	
			// mounting plate
			translate([0,totalSize[Y]/2-thickness/2,mountingDepth/2+thickness]) 
				cube([totalSize[X], thickness, mountingDepth], center=true);
	
			// outer supports 
			for(i=[-1,1]) 
				translate([i*(totalSize[X]-thickness)/2,totalSize[Y]/2-thickness,thickness]) 
					support();
	
			// inner supports 
			translate([-(holeDist*(columns-2)/2),0,0])
				for(x=[0:columns-2]) 
					translate([holeDist*x,totalSize[Y]/2-thickness,thickness]) 
						support();
		}

		// Rounded edges 
		translate([0,0,totalSize[Z]/2]) 
		union() {
			translate([0,roundRadius/2,0]) 
				cube([totalSize[X], totalSize[Y]-roundRadius, totalSize[Z]], center=true);
			translate([0,-totalSize[Y]/2--roundRadius,0]) {
				cube([totalSize[X]-roundRadius*2, roundRadius*2, totalSize[Z]], center=true);
				for(x=[-1,1]) {
					translate([(totalSize[0]/2-roundRadius)*x,0,0]) 
						cylinder(h=totalSize[Z], r=roundRadius, center=true); 
				}
			}
		}	
	}


	// front panel holes 
	translate([-(holeDist*(columns-1))/2,-(holeDist*(rows-1))/2,0]) 
		for(x=[0:columns-1], y=[0:rows-1]) {
			translate([x*(holeDiameter+separation), y*(holeDiameter+separation),thickness/2]) 
				cylinder(h=thickness+1, r=holeDiameter/2, center=true);
	}

	// Mounting holes 
	translate([-(holeDist*(columns-1))/2,totalSize[Y]/2,thickness+mountingDepth/2]) 
		rotate([90,0,0]) 
		for(x=[0:columns-1]) {
			translate([x*(holeDiameter+separation), 0, thickness/2]) 
				cylinder(h=thickness+1, r=mountHoleDiameter/2, center=true);
	}

}


/////////////////////////////////////////////////////////////////////////////
// The modules...
/////////////////////////////////////////////////////////////////////////////

module support() {
	rotate([90,0,-90]) 
		linear_extrude(height=thickness, center=true) 
			polygon(points=[[0,0],[0,mountingDepth],[totalSize[Y]-thickness,0]]);
}