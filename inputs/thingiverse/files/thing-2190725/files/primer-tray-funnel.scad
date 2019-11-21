// This is a primer tray funnel. It makes loading square primer boxes into round primer trays easier.
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

// Define height of lower ring and in mm
ring_height=5.0;

// Define outside diameter of lower cylinder in mm
outside_diameter=82.9;

// Define inside width of upper box in mm
inside_width=89.0;

// Define thickness of walls in mm
wall_thickness=2.5;

// Define height of cone in mm
cone_height=20.0;

module big_cone() // Draw shape of outer connecting cone
{
	intersection()
	{
		translate([0,0,0]) cylinder(h=cone_height,r1=outside_diameter/2,r2=inside_width*1.7/2,center=true);
		translate([0,0,0])	cube([inside_width+wall_thickness,inside_width+wall_thickness,cone_height+2],center=true);
	}
}

module little_cone() // Draw shape of inner connecting cone
{
	union()
	{
		intersection()
		{
			translate([0,0,0]) cylinder(h=cone_height+2,r1=outside_diameter/2,r2=inside_width*1.7/2,center=true);
			translate([0,0,0]) cube([inside_width,inside_width,cone_height+2],center=true);
		}
		translate([0,0,-cone_height/2-2]) cylinder(h=cone_height,r=(outside_diameter-wall_thickness)/2,center=true);
	}
}

module ring() // Draw shape of lower ring
{
	difference()
	{
		translate([0,0,0]) cylinder(h=ring_height,r=outside_diameter/2,center=true);
		translate([0,0,0]) cylinder(h=ring_height+6,r=(outside_diameter-wall_thickness)/2,center=true);
	}
}

union()
{
	difference()
	{
		translate([0,0,ring_height])                big_cone();
		translate([0,0,ring_height+wall_thickness]) little_cone();
	}
	translate([0,0,-cone_height/2+ring_height/2]) 	 ring();
}

