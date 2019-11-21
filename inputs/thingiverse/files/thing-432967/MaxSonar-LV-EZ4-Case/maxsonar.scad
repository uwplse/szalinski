/*
###############################################################################
# DESCRIPTION
###############################################################################
This is a small case for mounting and protecting the MaxBotix LV-MaxSonar-EZ4 module.

---

The latest snapshot is available on [GitHub](https://github.com/Cylindric3D/quad_parts).


###############################################################################
# INSTRUCTIONS
###############################################################################
Simply print out one base and one cover, either individually, or with the combined STL.

###############################################################################
 */

/* [Global] */

// Which part would you like to see?
part = "both"; // [both:Both,cover:Cover,base:Base,demo:Demo]

/* [Printer] */
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 180; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 180; //[100:400]


/* [Hidden] */
j = 0.1;
$fn=100;
x = 0; y = 1; z = 2;

Thickness = 1;
Aperture = 16;
BoardSize = [20, 22.2, 2];
HoleSize = 3;
HoleOffset = 1;
PCBThickness = 1.6;

Hole1Pos = [HoleSize/2 + 2.75, HoleSize/2 + 0.85, 0];
Hole2Pos = [BoardSize[x] - HoleSize/2 - 1, BoardSize[y] - HoleSize/2 - 1.1, 0];
BigHolePos = BoardSize[x]-8-1;

BaseSize = [BoardSize[x]+Thickness*2, BoardSize[y]+Thickness*2, Thickness];
WallHeight = Thickness*2 + 8;

use<utils/build_plate.scad>;



module MaxSonar()
{
	union()
	{
		color([0, 100/255, 0, 0.5]) 
		difference()
		{
			cube([BoardSize[x], BoardSize[y], PCBThickness]);
			translate([Hole1Pos[x], Hole1Pos[y], -j]) cylinder(r = HoleSize/2, h = BoardSize[z] + j*2);
			translate([Hole2Pos[x], Hole2Pos[y], -j]) cylinder(r = HoleSize/2, h = BoardSize[z] + j*2);
		}
	
		color([0.5, 0.5, 0.5, 0.5])
		translate([BigHolePos, BoardSize[y]/2, PCBThickness])
		cylinder(r = Aperture / 2, h = 13.9);
	}
}


module PCBPeg(holeDiameter, height, standoff)
{
	union()
	{
		translate([0, 0, standoff - j]) cylinder(r = holeDiameter/2 * 0.9, h = height - standoff - j);
		cylinder(r = (holeDiameter/2 * 0.9)+0.5, h = standoff);
	}
}


module Cover()
{
	color("Khaki")
	union()
	{
		difference()
		{
			cube(BaseSize);
			
			translate([BigHolePos + Thickness, BaseSize[y]/2, -j])
			cylinder(r = Aperture / 2 + j + 0.2, h = Thickness + j * 2);
		}

		// Closed side
		translate([BaseSize[x] - Thickness, Thickness, 0])
		cube([Thickness, BaseSize[y] - Thickness * 2, WallHeight-4+Thickness]);

		// Closed side PCB grip
		translate([BaseSize[x] - Thickness - 1, Thickness, 0])
		cube([Thickness + j, BaseSize[y] - Thickness * 2, WallHeight-2.7]);
		
		// Back side
		translate([0, Thickness, 0])
		union()
		{
			cube([BaseSize[x], Thickness, 4]);
		}

		// Front side
		translate([0, BaseSize[y]-Thickness * 2, 0])
		union()
		{
			cube([BaseSize[x]/2, Thickness, WallHeight-2.7]);
			cube([BaseSize[x], Thickness, WallHeight-4]);
		}
	}
}


module Base()
{	
	union()
	{
		// Base
		cube(BaseSize);
		
		difference()
		{
			// Cable side wall
			cube([Thickness, BaseSize[y], 4]);
			
			// -
			translate([-Thickness/2, 3, 1.75])
			cube([Thickness, 2, 0.5]);

			// +
			translate([-Thickness/2, 6, 1.75]) cube([Thickness, 2, 0.5]);
			translate([-Thickness/2, 7.25, 1]) rotate([90, 0, 0]) cube([Thickness, 2, 0.5]);			
		}

		// Opposite side wall
		translate([BaseSize[x]-Thickness, 0, 0]) cube([Thickness, BaseSize[y], 4]);
		
		// Near wall
		translate([0, 0, j]) cube([BaseSize[x], Thickness, WallHeight-j]);
		
		// Far wall
		translate([0, BaseSize[y] - Thickness, j]) cube([BaseSize[x], Thickness, WallHeight-j]);
		
		// PCB Supports
		translate([Thickness, Thickness, Thickness - j])
		union()
		{
			translate(Hole1Pos)
			PCBPeg(HoleSize, Thickness + BoardSize[z] + Thickness *2 + j, Thickness + j);

			translate(Hole2Pos)
			PCBPeg(HoleSize, Thickness + BoardSize[z] + Thickness * 2 + j, Thickness + j);

			translate([Hole1Pos[x], Hole2Pos[y], 0])
			cylinder(r = (HoleSize / 2 * 0.9) + 0.5, h = Thickness + j);

			translate([Hole2Pos[x], Hole1Pos[y], 0])
			cylinder(r = (HoleSize / 2 * 0.9) + 0.5, h = Thickness + j);
		}
	}
}

module print_part()
{
	if (part == "demo")
	{	
		translate([-BaseSize[x]/2, -BaseSize[y]/2, 0])
		union()
		{
			Base();
			
			translate([0, 0, WallHeight+j])
			translate([0, BaseSize[y], Thickness]) rotate([180, 0, 0])
			Cover();

			translate([Thickness, Thickness, Thickness*2])
			%MaxSonar();
		}
	}
	if (part == "both")
	{
		translate([0, -BaseSize[y]/2, 0])
		union()
		{
			translate(-[BaseSize[x]+Thickness, 0, 0]) Base();
			translate([Thickness, 0, 0]) Cover();
		}
	}
	if (part == "cover")
	{
		translate([-BaseSize[x]/2, -BaseSize[y]/2, 0]) Cover();
	}
	if (part == "base")
	{
		translate([-BaseSize[x]/2, -BaseSize[y]/2, 0]) Base();
	}
}

print_part();


%build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);
