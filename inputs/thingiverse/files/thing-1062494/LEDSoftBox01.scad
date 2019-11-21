// Template to build a Display with printed SoftBoxes and std. LEDs
// by Jochen Krapf
// Version 1.01

// preview[view:south east, tilt:top diagonal]

/* [Global] */

// To render the parts choose the correcponding Part Name

Part = "Box";   // [Box:SoftBox,Spacer:Spacer grid for mounting,Test:Test]

// Parameters

// Diameter of a single LED in mm
LED_Diameter = 5.1;

// Count of LEDs at X direction
LEDs_X = 3;   // [1:10]

// Count of LEDs at Y direction
LEDs_Y = 2;   // [1:10]

// Mounting Depth in mm
MountingDepth = 20;

// Size of box at X direction
BoxSize_X = 60;

// Size of box at Y direction
BoxSize_Y = 35;

// Wall Width in mm
WallWidth = 1.5;

// Distance of mounting grid fillets in mm (or zero for no grid)
MountingGrid = 20;

// Thick ends of fillets
//FilletSwell = 2;   // [0:None, 2:Small, 3:Medium, 4:Large]

/* [Hidden] */

// Level of Details - Set to 0.1 for export to stl
$fs = 0.2;

Wall = WallWidth;
LED_Distance_X = (BoxSize_X-2*Wall) / (LEDs_X+0.7);
LED_Distance_Y = (BoxSize_Y-2*Wall) / (LEDs_Y+0.7);
LED_FirstOffset_X = (LEDs_X-1) * LED_Distance_X / -2.0;
LED_FirstOffset_Y = (LEDs_Y-1) * LED_Distance_Y / -2.0;

// Modules

module BoxTemplate(x, y, h, d)
{
	
	hull()
	{
		translate([0,0,h-Wall/2])
				cube(size = [x,y,Wall], center = true);
		
		for ( iy = [0 : (LEDs_Y-1)] )
			for ( ix = [0 : (LEDs_X-1)] )
			{
				translate([LED_FirstOffset_X + ix*LED_Distance_X, LED_FirstOffset_Y + iy*LED_Distance_Y, 0])
					cylinder (d=d, h=Wall, center=false);
			}
	}
}

module Grid()
{
	fdx = (floor((BoxSize_X-Wall)/(MountingGrid))-1) * MountingGrid / 2.0;
	fdy = (floor((BoxSize_Y-Wall)/(MountingGrid))-1) * MountingGrid / 2.0;

	if (MountingGrid>0)
		{
		for ( iy = [-fdy : MountingGrid : fdy+0.01] )
			translate([0, iy, MountingDepth/2])
				cube(size = [BoxSize_X, Wall, MountingDepth], center = true);
		for ( ix = [-fdx : MountingGrid : fdx+0.01] )
			translate([ix, 0, MountingDepth/2])
				cube(size = [Wall, BoxSize_Y, MountingDepth], center = true);
		}
}

module SoftBox()
{
	difference()
	{
		color( [1, 0.8, 0, 1] )
		union()
		{
			// outside
			BoxTemplate(BoxSize_X, BoxSize_Y, MountingDepth, LED_Diameter+2*Wall);

			// grid
			Grid();
		}

		// drill inside
		color( [1, 1, 1, 1] )
		translate([0, 0, Wall])
			BoxTemplate(BoxSize_X-2*Wall, BoxSize_Y-2*Wall, MountingDepth-Wall+0.01, LED_Diameter);

		// drill LEDs
		for ( iy = [0 : (LEDs_Y-1)] )
			for ( ix = [0 : (LEDs_X-1)] )
			{
				translate([LED_FirstOffset_X + ix*LED_Distance_X, LED_FirstOffset_Y + iy*LED_Distance_Y, -Wall])
					#cylinder (d=LED_Diameter, h=3*Wall, center=false);
			}
	}
}

module Spacer()
{
	Grid();
}

// Use Modules

if (Part == "Box")
{
	SoftBox();
}

if (Part == "Spacer")
{
	Spacer();
}

if (Part == "Test")
{
	for ( iy = [-3.5 : 3.5] )
		for ( ix = [-1 : 1] )
		{
			translate([ix*BoxSize_X, iy*BoxSize_Y, 0])
				SoftBox();
		}
}

