// This 12 gauge primer punch. Insert a 40d nail and round off its end.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2208570

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define height of upper body in mm
body_height=75.0;

// Define height of lower cone in mm
cone_height=40.0;

// Define outside diameter of upper body in mm
body_diameter=16.0;

// Define outside diameter of lower cone end in mm
end_diameter=6.25;

// Define inside diameter of hole in mm
inside_diameter=6.05;

// Countersink depth in mm
depth=1.5;

// Counsersink diameter in mm
head_diameter=12.0;

difference()
{
	intersection()
	{
		#translate([0,0,0]) cube([body_diameter/sqrt(2)+3,body_diameter/sqrt(2)+3,body_height+cone_height],center=true);
		union() // Draw outer shape
		{
			translate([0,0,0])                           cylinder(h=body_height,r=body_diameter/2,center=true);
			translate([0,0,(body_height+cone_height)/2]) cylinder(h=cone_height,r1=body_diameter/2,r2=end_diameter/2,center=true);
		}
	}
	// Drill hole
	translate([0,0,cone_height/2])  cylinder(h=body_height+cone_height+2,r=inside_diameter/2,center=true);
	// Counter sink part of nail head
	translate([0,0,-(body_height-depth)/2]) cylinder(h=depth,r=head_diameter/2,center=true);
}