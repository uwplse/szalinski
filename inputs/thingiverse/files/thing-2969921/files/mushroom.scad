// This is a mushroom connector for a famous Italian top box brand.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing: 2969921

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define height of upper shape in mm
height01=5.5;

// Define total height in mm
height02=10.5;

// Define outside diameter of upper shape in mm
diameter01=15.5;

// Define outside diameter of lower cylinder in mm
diameter02=10.0;

// Define bolt diameter in mm
bolt_diameter=6.0;

difference()
{
	union() // Draw outer shape
	{
		translate([0,0,bolt_diameter/2-1.0]) intersection()
		{
			cylinder(h=height01*2,r=diameter01/2,center=true);
			translate([0,0,-height01]) sphere(r=diameter01/2,center=true);
		}
		translate([0,0,(height02-height01)/2]) cylinder(h=height02,r=diameter02/2,center=true);
	}
	// Drill countersunk hole for bolt
	union()
	{
		#translate([0,0,-(bolt_diameter*0.3+1.7)]) cylinder(h=bolt_diameter*0.6,r1=bolt_diameter,r2=bolt_diameter/2,center=false);
		#translate([0,0,(height02-height01)/2]) cylinder(h=height02+1,r=bolt_diameter/2+0.2,center=true);
	}
}