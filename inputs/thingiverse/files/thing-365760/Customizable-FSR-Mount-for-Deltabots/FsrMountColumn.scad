// Height of the mount in mm. Kossel mini = 22.5, Pro = 75
gMountHeight = 75;

// How far from the top and bottom of the mount you want holes for mounting in mm.  Openbeam is 7.5
gMountHolesOffsetFromEnds = 7.5;

// What is the size in mm for the mounting holes, in mm?  3mm screws require 3.2mm clearance at a minimum
gMountHoleSize = 3.2;

// What is the diameter of the round part of the FSR head? (in mm)
gFsrDiameter=20;

// The neck is what joins the FSR to the head. (in mm)
gFsrNeckWidth=10;

// How thick should we make the pillar 'cup' the FSR? (in mm)
gFsrThickness=1;

// How round do you want the curvatures to be?
gQuality=200;

// How thick do you want the mount to be? (in mm)
gMountThickness=30;

// How many mm of thickness do you want between the screw and the mounting holes?
gScrewHoleBackWallThickness=5;

// Internal value: used to tunnel out huge amounts of stuff. :)
gSomethingRidiculous=20000;

module Mount_TopDownShape()
{
	linear_extrude(height=1, center=true)
	hull()
	{
		translate([0,gMountThickness/2,0])
		polygon(points = [[gMountThickness*.75,0], [-gMountThickness*.75, 0], [0, -1]]);
		circle(gMountThickness/2, $fn=gQuality);
	}
}

module Mount_Hole()
{
// Clearance for the actual threaded section to enter
	rotate([90,0,0])
	union()
	{
		// 200 just to clear us straight through the darned thing.  Should really parameterize it tho.
		cylinder(r=gMountHoleSize/2, h=gSomethingRidiculous, $fn=gQuality, center=true);

		translate([0,0,gSomethingRidiculous/2-gMountThickness/2+gScrewHoleBackWallThickness])
		// Clearance for a screwdriver
		cylinder(r=gMountHoleSize*1.2, h=gSomethingRidiculous, $fn=gQuality, center=true);
	}
}

module Mount_FSR()
{
	cylinder(r=gFsrDiameter/2, h=gFsrThickness, center=true);

	translate([0,-(gFsrDiameter/1.5+gSomethingRidiculous)/2,0])
	cube([gFsrNeckWidth,gSomethingRidiculous,gFsrThickness], center=true);

}

// Build the actual mount.
difference()
{
	scale([1,1,gMountHeight])
	Mount_TopDownShape();

	// Build holes.
	for(z = [-1, 1])
	{
		translate([0,0,(gMountHeight/2-gMountHolesOffsetFromEnds)*z])
		Mount_Hole();
	}

	// Space for FSR
	translate([0,0,gMountHeight/2-gFsrThickness/2])
#	Mount_FSR();
}



