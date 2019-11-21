//----------------------------------------------------------------------------
//	Filename:		WineGlass_Holder.scad
//	Author:			Robert H. Morrison
//	Thingiverse:	http://www.thingiverse.com/rhmorrison/designs
//	Date:			July 2nd, 2013
//----------------------------------------------------------------------------
//	Based on:		http://www.thingiverse.com/thing:109326
//	Created by:		http://www.thingiverse.com/daMaker/designs
//----------------------------------------------------------------------------

wgh_length = 169.78;
wgh_width  =  29.87;
wgh_height =   8.96;

wgh_front_height = 3;

leg_length = 13;
leg_width  = 14.94;
leg_height = 11.95;

cut_out_width  = 16.66;

air_hole_gap = 10;
air_hole_width  = 20.35;

use <utils/build_plate.scad>

/* [Build Plate] */

//: for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/* [Hidden] */

//---[ C A L C U L A T E D ]--------------------------------------------------

wgh_leg_height = wgh_height + 2.99;
cut_out_length  = ( wgh_length - 3 * leg_length ) / 2;
air_hole_length = ( wgh_length - 5 * air_hole_gap ) / 4;

module base()
{
	color ("blue")
	{
		union()
		{
			translate([-wgh_length/2,-0.001,0])
				cube([wgh_length,leg_width,leg_height], false);
				
			rotate([90,0,-90])
				linear_extrude(height = wgh_length, center = true, convexity = 10)
					polygon([[0,0],[wgh_width,0],[wgh_width,wgh_front_height],[0,wgh_height]],
						convexity = 10);
		}
	}
}

module bevel(x)
{
	color("magenta")
	{
		translate([x, leg_width/2, 2.998/2])
			cylinder(r1 = 7.08/2, r2 = 2.04, h = 3, center = true, $fn=31);
	}
}

module screw_hole(x)
{
	color("magenta")
	{
		translate([x,leg_width/2,(leg_height+2)/2])
			cylinder(r = 2.04, h = leg_height+2, center = true, $fn=19);
	}
}

module cut_out(x)
{
	color("red")
	{
		translate([x-cut_out_length/2,-0.001,-0.5])
			cube([cut_out_length,cut_out_width+1,leg_height+1], false);
	}
}

module air_hole(x)
{
	color("green")
	{
		translate([x-air_hole_length/2,-0.001-(air_hole_width+wgh_width)/2,-0.5])
			cube([air_hole_length,air_hole_width,leg_height+1], false);
	}
}

module wineglass_holder()
{
	difference()
	{
		base();
		
		for(xsh=[(leg_width-wgh_length)/2,0,(wgh_length-leg_width)/2])
			screw_hole(xsh);
			
		for(xb=[(leg_width-wgh_length)/2,0,(wgh_length-leg_width)/2])
			bevel(xb);
			
		for (xcu=[-(cut_out_length+leg_length)/2,(cut_out_length+leg_length)/2])
			cut_out(xcu);
			
		for (iah=[  -(air_hole_length+air_hole_gap)*3/2,
					-(air_hole_length+air_hole_gap)/2,
					 (air_hole_length+air_hole_gap)/2,
					 (air_hole_length+air_hole_gap)*3/2
				 ]
			)
			air_hole(iah);
	}
}

wineglass_holder();




