// This is a razor holder for Merkur Futur DE safety razors and clones.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2234055
//
// As of: 7 Apr 2017

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define total body height in mm
total_height=32.0;

// Define outside diameter of upper and lower cylinders in mm
outside_diameter=35.0;

// Define height of upper and lower cylinders in mm
cylinder_height=8.0;

// Define outside diameter main body in mm
body_diameter=30.0;

// Define inside diameter of hole in mm
inside_diameter=17.5;

module toroid(thickness=cylinder_height)
{
	rotate_extrude(convexity=10)
	translate([1.75*thickness,0,0])
	intersection()
	{
		circle(r=thickness/1.5);
		square([thickness,thickness],center=true);
	}
}

difference()
{
	union() // Draw outer shape
	{
		translate([0,0,0]) cylinder(h=total_height,r=body_diameter/2,center=true);
		translate([0,0,+(total_height-cylinder_height)/2]) toroid(thickness=cylinder_height);
		translate([0,0,-(total_height-cylinder_height)/2]) toroid(thickness=cylinder_height);
	}
	// Drill hole
	#translate([0,0,0]) cylinder(h=total_height+1,r=inside_diameter/2,center=true);
}