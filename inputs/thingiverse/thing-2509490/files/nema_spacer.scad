//
// nema stepper motor spacer (rev 1) - 20170831-121947
//
// (c)Jeremie Francois (jeremie.francois@gmail.com)
//	http://www.thingiverse.com/MoonCactus
//	http://www.tridimake.com
//
// Licence: Attribution - Share Alike - Creative Commons
//

// Spacing with the wall (overall height)
tower_h= 15;

// Diameter of the columns
tower_d= 7;

// Thickness of the base plate
base_h= 2;

// Diameter of the screw holes
screw_d= 3.1;

// Nema stepper properties http://www.mosaic-industries.com/embedded-systems/microcontroller-projects/stepper-motors/specifications
screw_spacing= 31.0;

// Space between the arms
void_d= screw_spacing - tower_d;

// Size of facets (lower=finer)
$fs= 0+0.8;
$fa= 0+0.8;


difference()
{
    
    union()
    {
		// Baseplate
        hull()
			for(x=[-1,+1]) for(y=[-1,0]) scale([x,y,1])
				translate([screw_spacing/2,screw_spacing/2,0])
					cylinder(d= tower_d, h= base_h);
		// Rounded arms
		for(x=[-1,+1]) hull() for(y=[-1,+1]) scale([x,y,1])
			translate([screw_spacing/2,screw_spacing/2,-tol])
				cylinder(d= tower_d, h= base_h);

		// Columns
        for(x=[-1,+1]) for(y=[-1,+1]) scale([x,y,1])
            translate([screw_spacing/2,screw_spacing/2,0])
                cylinder(d= tower_d, h= tower_h);

		// Bottom wall
        hull()
			for(x=[-1,+1]) for(y=[-1]) scale([x,y,1])
				translate([screw_spacing/2,screw_spacing/2,0])
					cylinder(d= 2, h= tower_h);
    }


    
	// Screw holes
    for(x=[-1,+1]) for(y=[-1,+1]) scale([x,y,1])
        translate([screw_spacing/2,screw_spacing/2,-tol])
            cylinder(d= screw_d, h= tower_h+2*tol);

	// Void between the arms
    translate([0,0,-tol])
    hull()
    {
		for(t=[0,20])
			translate([0,t,0])
				cylinder(d=void_d,h=base_h+2*tol);
    }
}

tol=0.02;
