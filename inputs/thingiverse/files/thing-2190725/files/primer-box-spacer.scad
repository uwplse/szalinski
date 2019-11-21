// This is a primer spacer. It makes adapts my primer tray funnel to smaller primer boxes.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2190725

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define inside width of upper box in mm
inside_width=89.0;

// Define inside width of spacer box in mm
spacer_width=76.0;

// Define width of inside lip
lip_width=1.0;

// Define height of spacer box in mm
spacer_height=12.0;

module spacer_box()
{
	difference()
	{
		translate([0,0,0])                cube([inside_width,inside_width,spacer_height],center=true);
		union()
		{
			#translate([0,0,spacer_height/4])  cube([spacer_width+lip_width,spacer_width+lip_width,spacer_height/2+1],center=true);
			translate([0,0,-spacer_height/4]) cube([spacer_width,spacer_width,spacer_height/2+1],center=true);
		}
	}
	
}

spacer_box();
