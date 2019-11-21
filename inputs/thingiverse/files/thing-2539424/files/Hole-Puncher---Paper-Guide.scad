// This is a paper guide for a hole puncher.
// It is designed for paper sizes according to DIN EN ISO 216
//
// Designed by Timothy_McPrint
// Date: 2017-09-17
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (https://creativecommons.org/licenses/by-nc-sa/4.0/)

// You will need this additional library: https://www.thingiverse.com/thing:16193
use<write.scad>;


// Length of the puncher (the side where the guide slides in):
puncher_length = 96;
// Length of the guide:
length = 160;
// Width of the slot in the puncher minus tolerance:
guide_length  = 13.7;
// Height of the slot in the puncher minus tolerance:
guide_height = 2.8;
// Scale margin:
boder = 2.0;


// Marking for position 1 (paper size A4 = 297):
position_marking1 = 297;
// Marking for position 2 (paper size A5 = 210):
position_marking2 = 210;
// Marking for position 3 (paper size A6 = 148):
position_marking3 = 148;


cube([length,guide_length,guide_height]);
// Edge stop:
translate([length,0,0])
	cube([3,guide_length,10]);

PrintPosition( "A4", position_marking1 );
PrintPosition( "A5", position_marking2 );
PrintPosition( "A6", position_marking3 );


module PrintPosition( text, location )
{
	color([1,0,1])
	{
		// The scale:
		translate([length-location/2+puncher_length/2,boder/2,guide_height])
			cube([1,guide_length-boder,0.5]);
		// The labeling:
		translate([length-location/2+10+puncher_length/2,1.5,guide_height]) // < Text offset
			rotate([0,0,90])
				write( text,h=8,t=0.5 );
	}
}