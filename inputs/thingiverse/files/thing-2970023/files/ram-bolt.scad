// This is a one-inch ball mount for M8 bolts.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing:

/* [Main] */

// Number of facets (larger numbers provide better smoothing)
$fn=100;

// Outside diameter of ball in mm
ball_diameter=25.4;

// Diameter of bolt hole in mm
bolt_diameter=8.0;

// Diamter of bolt head in mm
head_diameter=13.0;

// Height of bolt head in mm
head_height=8.0;

// Diameter of connecting cylinder in mm
cylinder_diameter=11.0;

// Height of ball over base in mm
height01=20.0;

module ball(diameter)
{
    sphere(r=diameter/2,center=true);
}

difference()
{
	union() // Draw outer shape
	{
        ball(ball_diameter);
        translate([0,0,-(height01-head_height/2)]) cylinder(r=cylinder_diameter/2,h=height01+1,center=true);
        translate([0,0,-(height01+head_height/2)]) cylinder(r=head_diameter/2,h=head_height,center=true);
        translate([0,0,-height01+1]) cylinder(r1=head_diameter/2,r2=cylinder_diameter/2,h=head_diameter-cylinder_diameter,center=true);
	}
	// Drill holes
	#translate([0,0,-height01/2+2]) cylinder(h=height01+ball_diameter,r=bolt_diameter/2+0.2,center=true);
	#translate([0,0,ball_diameter/2-head_height/2-1]) cylinder(h=head_height+2,r=head_diameter/2+0.2,center=true);
}