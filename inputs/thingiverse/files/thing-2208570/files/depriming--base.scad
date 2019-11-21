// This is a depriming base.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2208570

/* [Main] */

// Define shape of object
shape=0; // [0:Round Shape,1:Hex Shape,2:Square Shape]

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define height of the cylinder wall in mm
height=15.0;

// Define outside diameter of cylinder in mm
outside_diameter=35.0;

// Define inside diameter of hollowed out area in mm
inside_diameter=22.5;

// Define diameter of smaller hole in mm
hole_diameter=8.0;

difference()
{
	// Make outer shape
	if(shape==0)
	{
		translate([0,0,0])         cylinder(h=height,r=outside_diameter/2,center=true);
	}
	if(shape==1)
	{
		translate([0,0,0])         cylinder(h=height,r=outside_diameter/2,center=true,$fn=6);
	}
	if(shape==2)
	{
		translate([0,0,0])         cylinder(h=height,r=outside_diameter/2+4,center=true,$fn=4);
	}
	// Make inner shape
	#translate([0,0,height/4]) cylinder(h=height/2+1,r=inside_diameter/2,center=true);
	// Drill hole
	translate([0,0,0])        cylinder(h=height+1,r=hole_diameter/2,center=true);
}