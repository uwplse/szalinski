// Customizable Desk Hook
// by knarfishness
// Diesel Powered Robotics, 2013

// variables

//Total width
width = 80;

//Total length
length = 130;

// The width of the surface to clamp to
clamp_width = 30;

// The width of the hook
hook_width = 50;

// The thickness of the hook
thickness = 5;

// Hook height
height = 20;

// Catch Diameter 
catch = 5;

// Rounding Radius (1 to 40)
rounding_radius = 5;

// Clamp Depth Offset
clamp_offset = 0;

// Hook Depth Offset
hook_offset = 0;

add_catch = "true"; // [true,false]


// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}


module base()
{
	//cube([width, length, height]);
	translate([width/2,length/2,0])
	roundedRect([width-rounding_radius, length, height], rounding_radius, $fn=12);
}

module clamp()
{
	translate([-1,thickness,-2])
	cube([width-thickness-clamp_offset+1, clamp_width, height+4]);
}

module hook()
{
	translate([thickness + hook_offset +1, length - hook_width - thickness,-2])
	cube([width-thickness+1, hook_width, height+4]);
}

module top()
{
	difference()
	{
		base();
		clamp();
	}
}

module loop()
{
	translate([width - catch,length-thickness,0])
	cylinder(h = height, r1 = catch, r2 = catch, center = false);
}

module final()
{
	difference()
	{
		top();
		hook();
	}
}

if(add_catch == "true")
{
	loop();
}

final();










