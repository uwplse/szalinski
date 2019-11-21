// Customized Measuring Cup
// v 1.0
//
// (C) Copyright 2013, Brian Enigma, some rights reserved.
//
// Customized Measuring Cup by Brian Enigma is licensed under a Creative Commons 
// Attribution-ShareAlike 3.0 Unported License.
//
// - http://netninja.com
// - http://www.thingiverse.com/BrianEnigma

/*
Calculation Notes:

Cups       Cups (Reduced)      ml
~~~~       ~~~~~~~~~~~~~~      ~~
1/8        1/8     0.125       29.57
2/8        1/4     0.25        59.15
3/8        3/8     0.375       88.72
4/8        1/2     0.5         118.30
5/8        5/8     0.625       147.87
6/8        3/4     0.75        177.44
7/8        7/8     0.875       207.02
8/8        1       1           236.59

Volume of cylinder = pi * r^2 * h

If we make radius and height the same: 

v = pi * h^2 * h = pi * h^3

solve for h

h = cube_root(v) / cube_root(pi) * 10 = 6.8278 * cube_root(v)

h = 6.8278 * pow(v, 1/3)
*/

// Pick a predefined volume or select "Custom" to pick your own
volume = 59.15; // [29.57:1/8 Cup, 59.15:1/4 Cup, 88.72:3/8 Cup, 118.30:1/2 Cup, 147.87:5/8 Cup, 177.44:3/4 Cup, 207.02:7/8 Cup, 236.59:1 Cup, 0:Custom]
// If using a custom volume, pick a value
custom_volume_in_milliliters = 15; // [15:500]

// The thickness of the scoop wall
wall_thickness = 5; // [1:8]

// width of handle
handle_width = 15; // [10:20]

// length of handle (actually, not including the end-cap)
handle_length = 60; // [15:80]

// The diameter (in mm) of the hole in the handle
hanger_hole_hole_diameter = 4; // [0:5]

handle_thickness = 3 * 1;

// resolution of cylinders -- 10 makes for quick renders, higher makes for good prints
//DETAIL = 30 * 1;
DETAIL = 50 * 1;
//DETAIL = 100 * 1;

module handle(outer_wall_radius, handle_thickness, handle_width, handle_length, hanger_hole_hole_diameter) 
{
    difference()
    {
        union()
        {
            // flat handle part
            translate(v = [0, handle_width / -2, 0])
            	cube(size = [handle_length + outer_wall_radius - handle_width / 2, handle_width, handle_thickness]);
            // flat cap at end of handle
            translate(v = [handle_length + outer_wall_radius - handle_width / 2, 0, 0]) 
            	cylinder(h = handle_thickness, r = handle_width / 2, $fn = DETAIL);
			// curved handle part
            translate(v = [0, 0, handle_thickness])
				scale(v = [1, 1, 0.5])
					rotate(a = [0, 90, 0])
            			cylinder(h = handle_length + outer_wall_radius - handle_width / 2, r = handle_width / 2, $fn = DETAIL);
			// curved cap at end of handle
            translate(v = [handle_length + outer_wall_radius - handle_width / 2, 0, handle_thickness])
				scale(v = [1, 1, 0.5])
           			sphere(r = handle_width / 2, $fn = DETAIL);
			
        }
    	// subtract out hanger hole
    	translate(v = [handle_length + outer_wall_radius - handle_width / 2, 0, -1]) 
    		cylinder(h = handle_thickness * 10, r = hanger_hole_hole_diameter / 2, $fn = DETAIL);
	}
}

module build_measuring_cup(volume, height, radius, handle_thickness, handle_width, handle_length, handle_hole_diameter)
{
	echo(str("Building measuring cup with volume ", volume, "ml, height ", height, "mm, radius ", radius, "mm."));
	translate(v = [((radius + wall_thickness) / 2 + handle_length) / -2, 0, 0]) // slide over to be better centered on the table
		difference()
		{
			union()
			{
				// Outer cylinder
			    cylinder(h = height + wall_thickness, r = radius + wall_thickness, $fn = DETAIL);
				// Handle braces
				translate(v = [radius + wall_thickness, handle_width / 2, 0])
					rotate(a = [90, 0, 0])
						cylinder(h = 4, r = 8, $fn = DETAIL);
				translate(v = [radius + wall_thickness, handle_width / -2 + 4, 0])
					rotate(a = [90, 0, 0])
						cylinder(h = 4, r = 8, $fn = DETAIL);
				// Handle
				handle(radius + wall_thickness, handle_thickness, handle_width, handle_length, handle_hole_diameter);
			}
			// Subtract out inner cylinder
			translate(v = [0, 0, -1])
		    	cylinder(h = height + 1, r = radius, $fn = DETAIL);
			// Subtract out anything below the floor (e.g. leftover bits of the handle brace)
			translate(v = [radius * -2, (radius * 4) / -2, -50])
				cube(size = [radius * 2 + handle_length * 3 + 100, radius * 4, 50]);
		}
}

if (0 == volume)
{
	echo("Building custom measuring cup");
	build_measuring_cup(
		custom_volume_in_milliliters, 
		6.8278 * pow(custom_volume_in_milliliters, 1/3), 
		6.8278 * pow(custom_volume_in_milliliters, 1/3), 
		handle_thickness, 
		handle_width,
		handle_length, 
		hanger_hole_hole_diameter);
} else {
	echo("Building predefined measuring cup");
	echo(str("Test: ", pow(volume, 1/3)));
	build_measuring_cup(
		volume, 
		6.8278 * pow(volume, 1/3), 
		6.8278 * pow(volume, 1/3), 
		handle_thickness, 
		handle_width,
		handle_length, 
		hanger_hole_hole_diameter);
}

