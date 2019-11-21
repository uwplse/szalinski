/*
Create a thread spool
Created by Mike Creuzer - Mike@Creuzer.com 20120820
Updated 1/14/2013 for Customizer optimization
*/

// Parameters are in mm

// The radius of the spool (half the diameter)
spool_radius = 8.8; // 17.6 / 2 for the toy I used
// The height of the spool
spool_height = 21.3;

// The top and bottom radius
lip_radius = 10.8; // 21.6 / 2 for the toy I used
// The height of the top and bottom
lip_height = 2.5;

// The radius of the whole in the center
spindle_radius = 3.7; // 7.4/2


difference()
{
	union() // Make the spool
	{
		cylinder(r=spool_radius, h=spool_height);
		cylinder(r=lip_radius, h=lip_height);
		translate([0,0,lip_height]) cylinder(r1=lip_radius, r2 = spool_radius, h=lip_height);
		translate([0,0,spool_height-lip_height]) cylinder(r=lip_radius, h=lip_height);
		translate([0,0,spool_height-lip_height-lip_height]) cylinder(r2=lip_radius, r1 = spool_radius, h=lip_height);
	}
	cylinder(r=spindle_radius, h=spool_height); // The hole down the middle
}
