/*
Parametric Cell Phone Battery holder. 

Case to hold a spare battery without fear of shorting it out.

Created by Mike Creuzer - Mike@Creuzer.com - 20120816
*/

// Battery dimensions in mm
// Internal height
height = 65;
// Internal Width
width  = 44;
// Internal narrow bit
depth  = 5.4;

// Print Settings in mm
// Looking at the gcode of a sliced file often times tells you this at the top of the file
singleWallWidth = .49; 
// Number of walls you want
thickness          = 2; 
// how much added 'slop' you want so the case is easier to use.
clearence          = .25; 




difference()
{
	cube(size = [width + 2*thickness*singleWallWidth + clearence, depth + 2*thickness*singleWallWidth + clearence, height + thickness*singleWallWidth], center=true);

	translate([0,0,2*thickness*singleWallWidth + clearence]) cube(size = [width,depth, height], center=true);
	translate([.5*(width + 2*thickness*singleWallWidth + clearence),0,.5 * (height + 2*thickness*singleWallWidth + clearence)]) rotate([90,0,0]) cylinder(r = depth + 2*thickness*singleWallWidth, h=depth + 2*thickness*singleWallWidth + clearence, center=true);
	translate([-.5*(width + 2*thickness*singleWallWidth + clearence),0,.5 * (height + 2*thickness*singleWallWidth + clearence)]) rotate([90,0,0]) cylinder(r = depth + 2*thickness*singleWallWidth, h=depth + 2*thickness*singleWallWidth + clearence, center=true);

}
