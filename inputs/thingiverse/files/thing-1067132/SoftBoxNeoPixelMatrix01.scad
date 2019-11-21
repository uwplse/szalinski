// Template for SoftBox for NeoPixel-LED-Matrix
// by Jochen Krapf
// Version 1.01

// preview[view:south east, tilt:top diagonal]

/* [Global] */

// To render the parts choose the correcponding Part Name

Part = "Matrix";   // [Matrix:Complete Matrix,Test:Test Single Segment]

// Parameters

// Count of LEDs per Row/Column
Segments = 8;

// Distance between LEDs in mm
LedDistance = 9;

// PCB Mounting Size in mm
PcbSize = 72;

// Mounting Depth in mm
MountingDepth = 10;

// Wall Width in mm
WallWidth = 1;

// Diameter of a single LED in mm
LedDiameter = 5;

// Use Mounting Domes
Mountings = 1;   // [0:No Mounting Domes,1:Print Mounting Domes]

// Use Printer Support
UsePrintSupport = 1;   // [0:No Print Support,1:Print Support Ring 1mm]


/* [Hidden] */

// Level of Details - Set to 0.1 for export to stl
//$fn = 24*4;
$fs = 0.5;

Wall = WallWidth;
LED_FirstOffset = (Segments-1) * LedDistance / -2.0;
ScrewDiameter = 3;


// Modules

module PrintSupport()
{
	s = LedDistance * (Segments-1);

	for ( iy = [0 : (Segments-1)] )
		translate([0, LED_FirstOffset + iy*LedDistance-0.5, MountingDepth/2])
			cube(size = [s, 1, MountingDepth], center = true);
	for ( ix = [0 : (Segments-1)] )
		translate([LED_FirstOffset + ix*LedDistance-0.5, 0, MountingDepth/2])
			cube(size = [1, s, MountingDepth], center = true);
}

module SegTemplate(w, l)
{
render()
	difference()
	{
		// make solid softbox
		hull()
		{
			// upper segment plate
			translate([-w/2,-w/2,MountingDepth-Wall])
				cube([w,w,Wall]);
		
			// lower led circle
			cylinder(d=l, h=Wall, $fn=24);
		}
	}
}

module MountingTemplate()
{
	screw = ScrewDiameter*0.7;
	l = PcbSize/2 - LED_FirstOffset;

//render()
	difference()
	{
		cylinder(d=5, h=MountingDepth);

		translate([-screw/2,-screw/2,-1])
			cube([screw,screw,MountingDepth+2]);
	}

	translate([-0.5,-l-screw,0])
		cube([1,l,MountingDepth]);
}

module Matrix()
{
	difference()
	{
		union()
		{
			// segments outside
			for ( iy = [0 : (Segments-1)] )
				for ( ix = [0 : (Segments-1)] )
				{
					translate([LED_FirstOffset + ix*LedDistance, LED_FirstOffset + iy*LedDistance, 0])
						SegTemplate(LedDistance+Wall-0.01, LedDiameter+2*Wall);
				}
		
			// mounting domes
			if (Mountings>0)
				for ( r = [0, 90, 180, 270] )
					rotate([0,0,r])
						for ( j = [-1, 1] )
							translate([j*LED_FirstOffset, (PcbSize+ScrewDiameter)/2, 0])
								MountingTemplate();

			if (UsePrintSupport>0)
				PrintSupport();
		}
	
		color( [1, 1, 1, 1] )
		for ( iy = [0 : (Segments-1)] )
			for ( ix = [0 : (Segments-1)] )
			{
				// segments inside
				translate([LED_FirstOffset + ix*LedDistance, LED_FirstOffset + iy*LedDistance, 0.01])
					SegTemplate(LedDistance-Wall, LedDiameter);
		
				// LEDs
				translate([LED_FirstOffset + ix*LedDistance, LED_FirstOffset + iy*LedDistance, -1])
					#cylinder(d=LedDiameter, h=1.02);
			}

	}
}

module Test()
{
	difference()
	{
		union()
		{
			SegTemplate(LedDistance+Wall, LedDiameter+2*Wall);
		
		}
	
		// segments inside
		translate([0,0,0.01])
		SegTemplate(LedDistance-Wall, LedDiameter);

		// LEDs
		translate([0,0,-1])
			#cylinder(d=LedDiameter, h=1.02);
	}
}

//	color( [0.25, 0.5, 1, 0.25] )

// Use Modules

if (Part == "Matrix")
{
	Matrix();
}

if (Part == "Test")
{
	Test();	
}

