// This is a Givi spacer.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2179704

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define height of lower cylinder in mm
height01=18.7;

// Define total height cylinder in mm
height02=25.2;

// Define outside diameter of upper cylinder in mm
diameter01=9.9;

// Define outside diameter of lower cylinder in mm
diameter02=14.08;

// Define inside diameter of hole in mm
inside_diameter=6.2;

difference()
{
	union() // Draw outer shape
	{
		translate([0,0,0])                     cylinder(h=height01,r=diameter02/2,center=true);
		translate([0,0,(height02-height01)/2]) cylinder(h=height02,r=diameter01/2,center=true);
	}
	// Drill hole
	#translate([0,0,(height02-height01)/2]) cylinder(h=height02+1,r=inside_diameter/2,center=true);
}