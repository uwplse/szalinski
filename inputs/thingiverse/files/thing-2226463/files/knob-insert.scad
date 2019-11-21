// This is a Guitar Knob Insert.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2226463

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define height of knob in mm
height=12.5;

// Define outside diameter of knob in mm (without knurl)
outside_diameter=8.0;

// Define depth of hole in mm
depth=10.0;

// Define inside diameter of hole in mm
hole_diameter=6.5;

// Define number of splines (must be multiple of 3)
splines=24;

// Define height of splines in mm
spline_height=7.0;

module knurl1()
{
	for(i=[0:1:5])
	{
		translate([outside_diameter/2+height/24,0,i*height/6+height/12])
        rotate([0,90,0]) cylinder(h=height/12,r1=height/12,r2=0,center=true,$fn=4);
	}
}
 
module knurl2()
{
    for(i=[0:1:4])
    {
           
        translate([outside_diameter/2+height/24,0,i*height/6+height/6])
        rotate([0,90,0]) cylinder(h=height/12,r1=height/12,r2=0,center=true,$fn=4);
    }
}

module splines()
{
	union()
	{
		if(splines==0)
		{
			translate([0,0,depth/2]) rotate([0,0,angle]) cylinder(h=depth+1,r=hole_diameter/2,center=true,$fn=100);
		}
		if(splines!=0)
		{
			for(angle=[0:360/splines:360/3])
			{
				translate([0,0,depth/2]) rotate([0,0,angle]) cylinder(h=depth+1,r=hole_diameter/2,center=true,$fn=3);
			}
		}
		translate([0,0,-0.25]) cylinder(h=depth-spline_height,r=hole_diameter/2,center=false,$fn=100);
	}
}

difference()
{
	union()
	{
		// Draw outer shape
		translate([0,0,0]) cylinder(h=height,r=outside_diameter/2,center=false);

		// Draw small pyramids
		for(angle=[0:30:330])
		{
			rotate([0,0,angle])    knurl1();
            rotate([0,0,angle+15]) knurl2();
		}
     
	}

	// Drill inside hole
	splines();
}