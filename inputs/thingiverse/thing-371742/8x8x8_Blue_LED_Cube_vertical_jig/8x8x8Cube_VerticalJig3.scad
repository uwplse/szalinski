// Wall Parameters
wallCount = 4; // Total number of vertical walls
wallWidth = 60;
wallHeight = 10;
wallDepth = 3;
wallSeparation = 40;
floorHeight = 1;

// Hole Parameters
holeR = (4.92 / 2.0) + 0.05;
holeL = (wallSeparation+wallDepth+wallDepth)*wallCount + 2;
holeXOffset = (wallWidth - wallSeparation) / 2;
holeZoffset = 8; // How high should the LED holes be?
holeRightFudge = 0.10; // my printer prints this hole too small

// Mounting wings Parameters
mountWing = wallSeparation/3; // How deep
mountingScrewHoleR=1.5;

// Computed variables
wallMax = wallCount - 1;

$fn=16; // higher # means smoother cylinders

module Wall()
{
	union()
	{
		// Front Wall -- Always printed
		cube([wallWidth, wallDepth, wallHeight]);

		// Back Walls -- Print as many as requested
		for (n=[1:wallMax])
		{
			translate([0,wallSeparation*n,0]) cube([wallWidth, wallDepth, wallHeight]);
		}

		// Floor and mounting wings
		translate([0,-mountWing,0])
		cube([wallWidth, wallMax*wallSeparation + wallDepth + 2*mountWing, floorHeight]);
	}
}

module LEDHolePuncher()
{
	// Left hole
	translate([holeXOffset,-wallDepth,holeZoffset])
		rotate([-90,0,0])
			cylinder(h=holeL, r=holeR);

	// Right hole
	translate([wallWidth-holeXOffset,-wallDepth,holeZoffset])
		rotate([-90,0,0])
			cylinder(h=holeL, r=holeR+holeRightFudge);
}

module MountingHoles()
{
	// Front mount holes
	translate([wallWidth/2,-wallSeparation/6,0])
		cylinder(h=floorHeight,r=mountingScrewHoleR);

	// Rear mount holes
	translate([wallWidth/2,(wallMax*wallSeparation)+ wallDepth +(wallSeparation/6),0])
		cylinder(h=floorHeight,r=mountingScrewHoleR);
}

module Indicator()
{
	translate([0,-wallSeparation/3,0])
		cylinder(h=floorHeight,r=3);
}

module Jig()
{
	difference()
	{
		Wall();
		LEDHolePuncher();
		MountingHoles();
		Indicator(); // Indicate which side is nearest origin in case we need to make adjustments then we'll know which hole is which.
	}
}

Jig();
