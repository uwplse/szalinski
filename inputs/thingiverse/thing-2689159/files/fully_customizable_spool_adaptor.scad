/*
 * Parametric Spool Adaptor
 */
 
// how big a hole do you need for the spindle rod
hub_diameter = 20;

// how long/tall is the spindle rod (how tall is the inner cylinder)
hub_length = 40;

// how big is the hole in the spool that you want to adapt
spool_inner_diameter = 85;

// how long/tall is the spool (how tall is the outer cylinder)
spool_length = 40;

// how wide is the flange
flange_radius = 25;

// how thick is the flange (for horizontal mounting strength)
flange_thickness = 4;

// how thick is the inner cylinder
hub_thickness = 2;

// how thick is the outer cylinder
rim_thickness = 2;

// how thick are the spokes
spoke_thickness = 1.6;

// how many spokes do you want
spokes = 6;

// how many degrees (out of 360) for each side of the cylinders
cylinder_resolution=1;


/*** end of parameters */

displayMode = rezPrinter;


// draw me one
spool_adaptor(hub_diameter,hub_length,spool_inner_diameter,spool_length,spokes);



// draw the hub with hole for spindle
module Hub(axis_radius=4, spool_length=10)
{
	difference() {
		cylinder($fa=cylinder_resolution, r=axis_radius+hub_thickness, h=spool_length+2);
		translate([0,0,-2]) cylinder($fa=cylinder_resolution, r=axis_radius,h=spool_length+8);
	}
}

// Draw the rim, with 2mm flange
module Rim(spool_radius=20,spool_length=10)
{
	difference(){
		union(){
			cylinder($fa=cylinder_resolution, r=spool_radius+flange_radius, h=flange_thickness);
			cylinder($fa=cylinder_resolution, r=spool_radius, h=spool_length+2);
		}
		translate([0,0,-2]) cylinder($fa=cylinder_resolution, r=spool_radius-rim_thickness,h=spool_length+8);
	}
}

// draw the spokes holding rim to hub
module Spokes(axis_radius=4, spool_radius=20, spool_length=10, steps=4)
{
	for (angle=[0:360/steps:360]) {
		rotate([0,0,angle]) {
			translate([axis_radius+1,-spoke_thickness/2,0]) {
				cube( size=[spool_radius-rim_thickness-axis_radius,spoke_thickness,spool_length+2], center=false);
			}
		}
	}
}


//; draw one spool adaptor
module spool_adaptor(axis_dia=8,hub_length=10,spool_dia=40,spool_length=10,spokes=6)
{
	axis_radius = axis_dia * 0.5;
	spool_radius = spool_dia * 0.5;
	union() {
		Rim(spool_radius, spool_length);
		Hub(axis_radius, hub_length);
		Spokes(axis_radius, spool_radius, min(hub_length,spool_length), spokes);

	}
}