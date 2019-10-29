// This is a primer tray spacer. It makes adapts my primer tray funnel to larger primer trays.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2190725

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=50;

// Define outside diameter of spacer ring in mm
outside_diameter=95.0;

// Define inside diameter of the spacer ring in mm
inside_diameter=82.9;

// Define height of spacer ring in mm
spacer_height=6.0;

module spacer_ring()
{
	difference()
	{
		cylinder(h=spacer_height,r=outside_diameter/2,center=true);
		cylinder(h=spacer_height+1,r=inside_diameter/2,center=true);
	}
	
}

spacer_ring();
