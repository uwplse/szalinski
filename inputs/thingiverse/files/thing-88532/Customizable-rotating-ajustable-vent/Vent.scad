// Ilmion
// 2013-05

// preview[view:south, tilt:top]

/* [Parameters] */
// Which one would you like to see?
part = "all"; // [first:Vent hole,second:vent door,third:inside part, both:Vent hole and door, all:all]
// Diameter (in mm) of the hole to be ventillated (default : 54 mm = 2 1/8 inches)
Hole_Diameter = 54; // [2.0:170.0]
// Thickness (in mm) total of the vent door and holed part (default : 4 mm)
Thickness = 4; // [1.0:20.0]
// Number of hole in the vent (default : 4)
Number_of_Ventilation_hole = 4; // [2:6]
// How much wider (in mm) are the door compare to the hole they hide (default : 1.5 mm)
Plus_Width_of_door = 1.5; // [1.00:5.00]
// Tolerance (in mm) for better fitting of the door in the vent (default : 0.25)
Tolerance = 0.25; // [0.00:1.00]
// Thickness (in mm) of the wall to be ventillated. Set the height of the inside part.
Enclosure_Thickness = 4; // [1:20]
// Diameter (in mm) of the hole used for connecting the door with the holed part (default : 3 for 3mm filament)
Joint_Diameter = 3; // [0: 10]

/* [Screws] */

// Number of screw fixation (default : 3)
Number_of_fixation = 3; // [2:6]
// Diameter (in mm) of the screw to be use to fix the vent (default : 3mm)
Screw_diameter = 3;

/* [Hidden] */

gAngle = 360/(Number_of_Ventilation_hole*2);
gCenterDiam = max(0.20 * (Hole_Diameter/2), 9);
gScrewSectionLength = Screw_diameter*5;
gScrewSectionWidth = Screw_diameter*5;
$fs=1;

print_part();

module print_part() {
	if (part == "first") {
		VentHole();
	} else if (part == "second") {
		VentDoor();
	} else if (part == "both") {
		VentHole();
		translate([Hole_Diameter+16,0,0]) VentDoor();
	} else if (part == "third") {
		InsideConnector();
	} else if (part == "all") {
		VentHole();
		translate([Hole_Diameter+gScrewSectionLength+6,0,0]) VentDoor();
		translate([Hole_Diameter/3*2+gScrewSectionLength+6, Hole_Diameter+gScrewSectionLength+6,0]) InsideConnector();
	} else {
		VentHole();
		translate([Hole_Diameter+gScrewSectionLength+6,0,0]) VentDoor();
		translate([Hole_Diameter/3*2+gScrewSectionLength+6, Hole_Diameter+gScrewSectionLength+6,0]) InsideConnector();
	}
}

module ScrewSection()
{
	difference()
	{
		union()
		{
			cube([4,gScrewSectionWidth,Thickness]);
			translate([4,gScrewSectionWidth,0]) rotate([90,0,0]) linear_extrude(height = gScrewSectionWidth) polygon([[0,0], [0, Thickness], [gScrewSectionLength,0]]);
		}
		translate([4, 1.5, 1.5]) cube([gScrewSectionLength+10, gScrewSectionWidth-3, Thickness+5]);
		translate([gScrewSectionLength*0.5+2,gScrewSectionWidth/2,-1]) cylinder(h=10, r=Screw_diameter/2);
		translate([gScrewSectionLength,-1,-1]) cube([20,gScrewSectionWidth+2,20]);
	}
}

module FlatScrewSection()
{
	difference()
	{
		cube([gScrewSectionLength,gScrewSectionWidth,2]);
		translate([gScrewSectionLength*0.5+2, gScrewSectionWidth/2,-1]) cylinder(h=10, r=Screw_diameter/2);
	}
}

module Helice(pAngle, pDiam, pHeight, pWidth = 0.1)
{
	union()
	{
		for (i = [0:Number_of_Ventilation_hole-1])
		{
			hull()
			{
				rotate([0,0, (i * pAngle) + (i * (360 - (Number_of_Ventilation_hole*pAngle)) / Number_of_Ventilation_hole)]) 
				{
					translate([0, pWidth/-2,0]) cube([pDiam, pWidth, pHeight]);
					rotate([0,0, pAngle]) translate([0, pWidth/-2,0])cube([pDiam, pWidth, pHeight]);
				}
			}
		}
	}
}

module VentHole()
{
	union()
	{
	difference()
	{
		union()
		{
			difference()
			{
				Helice(gAngle, Hole_Diameter, Thickness/2);
				translate([0, 0, -1])
				{
					difference()
					{
						cylinder(h=Thickness+2, r=Hole_Diameter + 5);
						translate([0, 0, -1])
						{
							cylinder(h=Thickness+4, r=(Hole_Diameter / 2) + 5);
						}
					}
				}
			}
			cylinder(h=Thickness/2, r=gCenterDiam / 2);
			difference()
			{
				cylinder(h=Thickness, r=Hole_Diameter / 2 + 5);
				translate([0,0,-1]) cylinder(h=Thickness+2, r=Hole_Diameter / 2);
			}
			difference()
			{
				cylinder(h=Thickness/2, r=Hole_Diameter/2+1);
				translate([0,0,-1]) cylinder(h=Thickness/2+2, r=Hole_Diameter/2-1.5);
			}
		}
		if(Joint_Diameter > 0)
		{
			translate([0,0,-3]) cylinder(h=Thickness + 10, r=Joint_Diameter/2);
		}
	}
	for (j = [0:Number_of_fixation-1])
	{
		rotate([0,0,j*(360/Number_of_fixation)]) translate([Hole_Diameter/2+2, gScrewSectionWidth/-2,0]) ScrewSection();
	}
	}
}

module Pognee()
{
	rotate([90,0,0])
	difference()
	{
		cylinder(h=2, r=0.07*Hole_Diameter);
		translate([Hole_Diameter/2*-1,Hole_Diameter*-1,-1]) cube(Hole_Diameter,Hole_Diameter,4);
	}
}

module VentDoor()
{
	difference()
	{
		union()
		{
			difference()
			{
				Helice(gAngle, Hole_Diameter, Thickness/2, Plus_Width_of_door);
				
				translate([0,0,-1]) 
				{
					difference()
					{
						cylinder(h=Thickness/2+2, r=Hole_Diameter*2);
						translate([0,0,-1]) cylinder(h=Thickness/2+4, r=Hole_Diameter/2-Tolerance);
					}
				}
			}
			cylinder(h=Thickness/2, r=gCenterDiam/2);
			difference()
			{
			cylinder(h=Thickness/2, r=Hole_Diameter/2-Tolerance);
			translate([0,0,-1]) cylinder(Thickness/2+2, r=Hole_Diameter/2-2);
			}
			for (j = [0:Number_of_Ventilation_hole-1])
			{
				rotate([0,0,j*(360/Number_of_Ventilation_hole)]) translate([Hole_Diameter/2-0.07*Hole_Diameter-Tolerance-1,2,Thickness/2-0.1])
				{
					Pognee();
				}
			}
		}
		if(Joint_Diameter > 0)
		{
			translate([0,0,-3]) cylinder(h=Thickness + 10, r=Joint_Diameter/2);
		}
	}
}

module InsideConnector()
{
	difference()
	{
		union()
		{
			cylinder(h=Enclosure_Thickness+2, r=Hole_Diameter/2);
			cylinder(h=2, r=Hole_Diameter / 2 + 5);
		}
		translate([0,0,-1]) cylinder(h=Enclosure_Thickness+4, r=Hole_Diameter/2-2);
	}
	for (j = [0:Number_of_fixation-1])
	{
		rotate([0,0,j*(360/Number_of_fixation)]) translate([Hole_Diameter/2+2, gScrewSectionWidth/-2,0]) FlatScrewSection();
	}
}



