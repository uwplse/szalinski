use <utils/build_plate.scad>
use <write/Write.scad>

//----------------------------------------------------------------------------
// Customize and print your own Slider Switch cover
// http://www.thingiverse.com/thing:394501
// 
// by Erwin Ried (2014-07-15)
// http://www.thingiverse.com/eried/things

//---[ USER Customizable Parameters ]-----------------------------------------

/* [Switch] */
// Width of the switch slider (mm):
switch_width = 5.3;

// Length of the switch in the sliding direction (mm):
switch_length = 6.7;

/* [Cover] */
// Internal padding of the cover (mm) per side:
padding = 0.7;

// Width of the cover from the padded space (mm) to border:
cover_width = 2.5;

// Length of the cover from the padded space (mm) to border:
cover_length = 7.3;

// Height of the cover (mm):
cover_height = 0.6;


//---[ Build Plate ]----------------------------------------------------------

/* [Build plate] */
//: for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// preview[view:south, tilt:top]

//----------------------------------------------------------------------------

draw_cover();


module draw_cover()
{
	translate([0,0,cover_height])
	{
		difference()
		{
			cube([switch_width+(2*(padding+cover_width)),switch_length+(2*(padding+cover_length)),cover_height],true);
			cube([switch_width+(2*padding),switch_length+(2*padding),cover_height*2],true);
		}
	}
}

