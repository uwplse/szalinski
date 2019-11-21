//--------------------------------------------------------------------
//	Filename:	ObjectHolder.scad
//	Author:		Robert H. Morrison (rhmorrison)
//	Created On:	15 October 2011
//	Updated On: 30 January 2013
//--------------------------------------------------------------------

use <MCAD/boxes.scad>
use <MCAD/teardrop.scad>

//Object Thickness
KT=20;
//Screw head Thickness
ST=5;
//Wall Thickness
T=2;

use <utils/build_plate.scad>

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
 
BW=KT+ST+4*T;	// Box Width
BL=BW*2;		// Box Length

module Holes(S) {
	for (i=[
			[-2*T-(BW/2)+S*2*(2*T+BW/2),(KT+2.5*T+ST)/2,2*T+BW/2],
			[-2*T-(BW/2),(KT+2.5*T+ST)/2,-(2*T+BW/2)],
			[2*T+BW/2,(KT+2.5*T+ST)/2,-(2*T+BW/2)]
		])
	{
		translate(i)
			rotate([90,0,0])
				cylinder(h=ST, r=2.5, center=true);
	}
	for (i=[
			[-2*T-(BW/2)+S*2*(2*T+BW/2),-(T+ST)/2,2*T+BW/2],
			[-2*T-(BW/2),-(T+ST)/2,-(2*T+BW/2)],
			[2*T+BW/2,-(T+ST)/2,-(2*T+BW/2)]
		])
	{
		translate(i)
			rotate([0,0,90])
				teardrop(5, KT+ST+T, 90);
	}
}

// SIDE: 0 = LEFT, 1 = RIGHT
module ObjectHolder(SIDE) {
	difference() {
		roundedBox([BL,BW,BL], 5, false);	// Holder frame
		translate([T-SIDE*2*T,(KT+T)/2,T])
			roundedBox([BL,ST,BL], 2, true);	// Kindle
		translate([T-SIDE*2*T,-(ST+T)/2,T])
			roundedBox([BL,KT,BL], 2, true);  // Screw heads
		translate([2*BW/3-4*SIDE*BW/3,-(ST+T)/2,2*BW/3])
			rotate([90,0,0])
				roundedBox([BL,BL,(KT+ST)*2], 2, true);  // Cut-out L
		Holes(SIDE);
	}
}

translate([0,(BW/2+5),BL/2])
	ObjectHolder(0);		// LEFT  SIDE
translate([0,-(BW/2+5),BL/2])
	ObjectHolder(1);		// RIGHT SIDE
