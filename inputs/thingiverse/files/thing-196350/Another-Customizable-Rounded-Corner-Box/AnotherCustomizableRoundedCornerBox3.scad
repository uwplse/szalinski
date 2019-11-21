// Another Customizable Rounded Corner box
// Hari Wiguna, Dec 2013

// Box Outer dimensions (in mmm)
Width = 20;
Depth = 20;
Height = 10;
Radius = 4;
WallThickness = 1;

// Lip at bottom of the lid that fits into the box
LipHeight = 2;

// Clearance between the lid lip and the box inside. Smaller = Tighter fit
Clearance = 0.2;

// Curve resolution (higher=smoother)
$fn=30;
Width2 = Width - WallThickness;
Depth2 = Depth - WallThickness;
Radius2 = Radius - WallThickness;
Height2 = Height - WallThickness;

Width3 = Width2 - 2*WallThickness;
Depth3 = Depth2 - 2*WallThickness;

Box();
translate([Width+5,0,0]) LidWithLip();

module LidWithLip()
{
	union()
	{
		Lid();
		LidLip();
	}
}

module Lid()
{
	minkowski()
	{
		cube([Width-2*Radius,Depth-2*Radius,WallThickness/2]);
		cylinder(WallThickness/2,Radius,Radius);
	}
}

module LidLip()
{
	difference()
	{
		translate([WallThickness/4+Clearance,WallThickness/4+Clearance,WallThickness])
		minkowski()
		{
			cube([Width2-2*Radius-2*Clearance, Depth2-2*Radius-2*Clearance, LipHeight/2]);
			cylinder(LipHeight/2, Radius2, Radius2);
		}

		translate([WallThickness*1.5,WallThickness*1.5,WallThickness])
		minkowski()
		{
			cube([Width3-2*Radius, Depth3-2*Radius, LipHeight/2]);
			cylinder(LipHeight/2, Radius2, Radius2);
		}
	}
}

module Box()
{
	difference()
	{
		OuterShell();
		InnerShell();
	}
}

module OuterShell()
{
	minkowski()
	{
		cube([Width-2*Radius,Depth-2*Radius,Height/2]);
		cylinder(Height/2,Radius,Radius);
	}
}


module InnerShell()
{
	translate([WallThickness/2,WallThickness/2,WallThickness])
	minkowski()
	{
		cube([Width2-(2*Radius), Depth2-(2*Radius), Height/2]);
		cylinder(Height2/2, Radius2, Radius2);
	}
}