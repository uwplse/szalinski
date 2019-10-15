// Customizable box with lid
// by Hari Wiguna, Oct 2013

// Box Width (mm)
boxX = 20;

// Box Depth (mm)
boxY = 20;

// Box Height (mm)
boxZ = 10;

// Wall Thickness (mm)
wallT = 1;

// Lid lip height (mm)
lidZ = 5;

// (mm. Smaller number means tighter fit)
lidClearance = 0.24;

// Choose No if you're just tweaking the lid clearance
printBox = 1; // [1:Yes,0:No]

printLid = 1; // [1:Yes,0:No]

t2 = wallT * 2;
t4 = wallT * 4;

// Generate Box & Lid
union()
{
	Box();
	translate([-boxX-10,0,0]) Lid();
}

module Box()
{
	if (printBox==1)
	difference()
	{
		// Outer box
		cube([boxX, boxY, boxZ]);

		// Subtract inner void
		translate([wallT, wallT, wallT])
			cube([boxX-t2,boxY-t2,boxZ]);
	}
}

module Lid()
{
	if (printLid==1)
	union()
	{
		cube([boxX, boxY, wallT]);
		LidInset(boxX, boxY, lidZ);
	}
}

module LidInset(x,y,z)
{
	f = lidClearance;
	translate([wallT+f, wallT+f, wallT])
	difference()
	{
		cube([x-2*(wallT+f), y-2*(wallT+f), z-wallT]);

		translate([wallT,wallT,0])
			cube([x-t4-(2*f), y-t4-(2*f), z]);
	}
}