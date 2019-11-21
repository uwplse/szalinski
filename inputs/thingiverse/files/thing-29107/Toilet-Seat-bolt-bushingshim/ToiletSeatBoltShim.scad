/*
Toilet seat wobble fixer
This bushing shims the bolt to the toilet so the seat won't wiggle so bad

Mike Creuzer - Mike@Creuzer.com - 2012-08-23
Update 2012-12-23 Added offset to allow for elliptical usage for seats that don't exactly align to the center of the stool's holes.
Update 2013-01-14 Tweaked parameter names for customizer

Measurements are dimensionless but assumed to be in mm for most programs.
*/

//Toilet measurement - maybe make this a bit short if your nut is convex
hole_depth = 10;
//Toilet measurement
hole_width = 16.25;

// Bolt measurement
bolt_width = 9.25;

// Part Measurement - Make this a couple of layers for your printer for good results.
brim_height = 0.6; 
// Part Measurement - Shoulder so the shim won't fall out of the hole.
brim_width = 5;
//Percentage to offset the center hole from center.
hole_offset = 75; //  [0:100]
offset = hole_offset * 0.01;
// (factor * by .02) 2 is the default for fast rendering, .01 is as good as it gets. 
curve_quality_percentage = 0.5; // [.5:100]
curve_quality = curve_quality_percentage * .02;

difference()
{
	union()
	{
		cylinder(r = hole_width / 2, h=hole_depth, $fs = curve_quality); // The shim
		cylinder(r = (hole_width + brim_width) / 2, h=brim_height); // the shoulder
	}
	translate(v = [offset * ((hole_width-bolt_width) / 2), 0, 0]) cylinder(r = bolt_width / 2, h=hole_depth, $fs = curve_quality); // The bolt hole
}
