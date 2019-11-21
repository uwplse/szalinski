/*
 * Parametric Flanged Wheel
 */
 
// what diameter hole do we need for the axle
hub_diameter = 8;

// outer diameter of wheel, does not include flange
outer_diameter = 30;

// Height/length through wheel
height = 30;

// How far the flange extends
flange_height = 5;

// how many spokes do we want
spokes = 3;

// Width of all features/walls
feature_width = 2;

// Flange on one side only? (set to 1 to enable)
flange_on_one_side_only = 0;

/*** end of parameters */

outer_width = height;
hub_length = height;
$fn = 200;


// draw me one
wheel(hub_diameter,hub_length,outer_diameter,outer_width,spokes);


// draw the hub with hole for axle
module Hub(hub_radius=4, outer_width=10)
{
	difference() {
		cylinder(r=hub_radius+feature_width, h=outer_width);
		translate([0,0,-2]) cylinder(r=hub_radius,h=outer_width+8);
	}
}

// Draw the rim, with flange_height flange
module Rim(outer_radius=20,outer_width=10)
{
	difference(){
		union(){
            if (flange_on_one_side_only != 1) {
                translate([0,0,outer_width - 1.5]) cylinder(r=outer_radius+flange_height, h=1.5);
            }
			cylinder(r=outer_radius+flange_height, h=1.5);
			cylinder(r=outer_radius, h=outer_width);
		}
		translate([0,0,-2]) cylinder(r=outer_radius-feature_width,h=outer_width+8);
	}
}

// draw the spokes holding rim to hub
module Spokes(hub_radius=4, outer_radius=20, outer_width=10, steps=4)
{
	for (angle=[0:360/steps:360]) {
		rotate([0,0,angle]) {
			translate([hub_radius+1,-1,0]) {
				cube( size=[outer_radius-feature_width-hub_radius,feature_width,outer_width], center=false);
			}
		}
	}
}

module wheel(hub_dia=8,hub_length=10,outer_dia=40,outer_width=10,spokes=6)
{
	hub_radius = hub_dia * 0.5;
	outer_radius = outer_dia * 0.5;
	union() {
		Rim(outer_radius, outer_width);
        translate ([0,0,(outer_width - hub_length) / 2]) {
            Hub(hub_radius, hub_length);
            Spokes(hub_radius, outer_radius, min(hub_length,outer_width), spokes);
        }
	}
}