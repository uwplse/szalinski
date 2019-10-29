// Written by Volksswitch <www.volksswitch.org> 
// based on the Straw Holder design by NoHands: https://www.thingiverse.com/thing:1953484
// 
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
//


//------------------------------------------------------------------
// User Inputs
//------------------------------------------------------------------

/*[Parameters]*/
straw_diameter = 6;
straw_holder_height = 15;
cup_diameter=88;
cup_wall_thickness=3;

/*[Hidden]*/
straw_dia = straw_diameter;
straw_radius=straw_dia/2;
straw_wall=3;
cup_radius=cup_diameter/2;
tab_length=straw_radius+straw_wall+cup_wall_thickness+5;
$fn=50;

difference(){

	union(){
		cylinder(r=straw_radius+straw_wall,h=straw_holder_height,center=true);
		translate([-tab_length/2,0,0])
		cube([tab_length,straw_dia+2*straw_wall,straw_holder_height],center=true);
	}

	cylinder(r=straw_radius,h=straw_holder_height+0.05,center=true);

	difference(){
		translate([cup_radius-straw_radius-straw_wall-cup_wall_thickness,0,5])
		cylinder(r=cup_radius,h=straw_holder_height,center=true);
		translate([cup_radius-straw_radius-straw_wall-cup_wall_thickness,0,5])
		cylinder(r=cup_radius-cup_wall_thickness,h=straw_holder_height+0.05,center=true);
	}
}