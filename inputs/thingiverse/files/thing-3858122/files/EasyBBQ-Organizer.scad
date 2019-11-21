//  Thing Name: EasyBBQ Digital Thermometer Organizer
// Description: Used to hold the EasyBBQ digital Bluetooth 6-probe Thermometer, 
// 	            or similar device, along with all 6 probes.
//  Created by: Doug Krahmer
//  Created on: 2019-09-12

// With $fn = 30 rendering takes 8 minutes (4Ghz i7)
// With $fn = 60 rendering takes 2 hours, 15 minutes (4Ghz i7)

$fn = 30;
	
InnerWidth = 95;
InnerDepth = 100;
Height = 50;

WallThickness = 3;
ProbeWallThickness = 15;

ProbeHoleDiameter = 4.5;

SmothnessRadius = 1.25;

main();

module main()
{
	Width = InnerWidth + ProbeWallThickness * 2;
	Depth = InnerDepth + WallThickness;

	minkowski()
	{
		difference()
		{
			cube([Width - SmothnessRadius * 2, Depth - SmothnessRadius * 2, Height - SmothnessRadius * 2]);
			
			translate([ProbeWallThickness - SmothnessRadius * 2, 0 - SmothnessRadius, WallThickness - SmothnessRadius * 2])
				cube([Width - ProbeWallThickness * 2 + SmothnessRadius * 2, Depth - WallThickness + SmothnessRadius, Height - WallThickness + SmothnessRadius * 2]);
			
			translate([-SmothnessRadius, -SmothnessRadius, -SmothnessRadius])
				AllProbeHoles(Width, Depth);
		}
		sphere(r = SmothnessRadius);
	}
}

module AllProbeHoles(Width, Depth)
{
	ProbeHoleCenterOffset = Depth / 3;
	
	translate([0, -ProbeHoleCenterOffset, 0])
		ProbeHolePair(Width, Depth);

	ProbeHolePair(Width, Depth);
	
	translate([0, ProbeHoleCenterOffset, 0])
		ProbeHolePair(Width, Depth);
}

module ProbeHolePair(Width, Depth)
{
	ProbeHole(Width, Depth);
	translate([InnerWidth + ProbeWallThickness, 0, 0])
		ProbeHole(Width, Depth);
}

module ProbeHole(Width, Depth)
{
	translate([ProbeWallThickness / 2, Depth / 2, WallThickness])
		cylinder(h = Height - WallThickness, d = ProbeHoleDiameter + SmothnessRadius * 2);
}
