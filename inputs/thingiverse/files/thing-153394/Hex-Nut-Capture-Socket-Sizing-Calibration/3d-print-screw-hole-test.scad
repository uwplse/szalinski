// File: 3d_print_screw_hole_test.scad
// Author: Mark Heywood alias Airtripper
// Airtripper Extruder Filament Force Sensor Bracket
// by Airtripper May 2013
// Copyright © 2013 Airtripper
// http://www.airtripper.com
// Licensed Attribution-NonCommercial-ShareAlike 3.0 Unported. 
// Last edit: 26/09/2013




/* [Global] */

//  - Select part to view/print from list
view_part = 1;	// [0:design, 1:head_up, 2:head_down, 3:horizontal]


//  - Screw head diameter - flat side to flat side on hex nut or bolt head
head = 6.75;		
//  - Screw head type - [6] for hex head and [50] or more for round head
type = 6;			
//  - Screw size diameter
size = 3.65;		
//  - Screw size diameter smoothness
smoothness = 50;	
//  - Screw size length - not including screw head
length = 5;			
//  - Screw head length
cap = 3;			
//  - Block border thickness between screw head and block edge
border = 4;			
//  - Print layer thickness - only required for head down print
layer = 0.25;			



/* hidden */

//++++++++++++++++++++ Model View, Positioning and Rotation ++++++++++++++++++++


if (view_part == 0) {	// Original design view & position
	translate([0,0,0]) rotate([0,0,0]) screw_block();
}
if (view_part == 1) {	// Centred head up position
	translate([-((border*2)+head)/2,-((border*2)+head)/2,0]) rotate([0,0,0]) screw_block();
}
if (view_part == 2) {	// Centred head down position
	translate([((border*2)+head)/2,-((border*2)+head)/2,length+cap]) rotate([0,-180,0]) screw_block();
}
if (view_part == 3) {	// Centred horizontal position
	translate([-((border*2)+head)/2,(length+cap)/2,0]) rotate([90,0,0]) screw_block();
}


//++++++++++++++++++++ Script Subroutines ++++++++++++++++++++


//######################### Screw Block ##########################

// screw_block();

module screw_block() {
	difference() {
		translate([0,0,0]) cube([head+(border*2),head+(border*2),length+cap]);	// block
		translate([border+(head/2),border+(head/2),-1-layer]) cylinder(length+1, r=size/2, $fn=smoothness);	// screw size
		translate([border+(head/2),border+(head/2),length]) cylinder(cap+1, r=head/2, $fn=type);	// screw head/cap
		translate([border+(head/2),border+(head/2),-1]) color("red") cylinder(1.5, r1=(size/2)+2, r2=size/2, $fn=smoothness);	// screw size taper
		translate([border+(head/2),border+(head/2),length+cap-0.5]) color("red") cylinder(2, r1=head/2, r2=(head/2)+2, $fn=type);	// screw head/cap taper
	}

}














// end