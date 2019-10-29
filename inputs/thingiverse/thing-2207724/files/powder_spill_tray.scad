// This is a powder spill tray.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2207724

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=50;

// Define height of the cylinder wall in mm
height=8.0;

// Define outside diameter of cylinder in mm
outside_diameter=60.0;

// Define wall thickness in mm
thickness=2.5;

// Define diameter of hole in mm
hole_diameter=17.47;

difference()
{
	// Make outer shape
	translate([0,0,0])              cylinder(h=height,r=outside_diameter/2,center=true);
	// Make inner shape
	translate([0,0,thickness/2]) cylinder(h=height-thickness+.5,r=(outside_diameter-thickness)/2,center=true);
	// Drill hole
	translate([0,0,thickness])    cylinder(h=2*height,r=hole_diameter/2,center=true);
}