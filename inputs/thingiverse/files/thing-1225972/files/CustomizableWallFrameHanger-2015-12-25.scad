echo("------------------------ BEGIN ------------------------");
////////////////////////////////////////////////////////////////////////////////////////////////////////
// Colors: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#hull
// HELP:   http://www.openscad.org/cheatsheet/index.html
// OPERATORS: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Mathematical_Operators
// http://www.homedepot.com/p/Crown-Bolt-1-4-in-20-x-36-in-Zinc-Plated-Threaded-Rod-17320/100338099
////////////////////////////////////////////////////////////////////////////////////////////////////////
// ----------------- NOTES ------------------
// 
// 
// ---------------------------------------------------------------------------------------------
// ----------------- Constants ------------------
Tolerance = 1*0.05;
SquareRootOfTwo = sqrt(2);
// ---------------------------------------------------------------------------------------------
// ----------------- Parameters ------------------
// (Effects # of vertices for every component)
Precision					= 200;
// (50=Default; The distance from the hooks to the screw hole)
HooksToHole_Height  		= 50;
// (100=Default; The distance between the center of each hook)
BetweenHooks_Width			= 100;
// (3=Default; The overall thickness of the hanger)
Thickness					= 3;
// (10=Default; The width of each hook)
Hooks_Width					= 10;
// (10=Default; The Depth of each hook)
Hooks_Depth					= 10;
// (10=Default; The Height of the Hooks Lip)
HookLip_Height				= 3;
// (4=Default; The width of the Small/Top Screw hole)
TopScrewHole_Diameter		= 4;
// (8=Default; The width of the Big/Bottom Screw hole)
BottomScrewHole_Diameter	= 8;
// (8=Default; The extra support above top Screw hole)
ExtraEdge					= 8;


// ---------------------------------------------------------------------------------------------
// PreCalculations
OverallHeight = ExtraEdge + HooksToHole_Height + ExtraEdge;
echo("OverallHeight",OverallHeight);
OverallWidth = ExtraEdge + (Hooks_Width/2) + BetweenHooks_Width + (Hooks_Width/2) + ExtraEdge;
echo("OverallWidth",OverallWidth);

// ---------------------------------------------------------------------------------------------
// Primary Build
union()
{
	// Baseplate
	difference()
	{
		// Primary baseplate
		cube([ OverallWidth, OverallHeight, Thickness], center=true);
			
		// Screw hole
		translate([ 0, (OverallHeight/2)-ExtraEdge-(TopScrewHole_Diameter/2), 0])
			ScrewHoleCutout(TopScrewHole_Diameter,BottomScrewHole_Diameter, Thickness);

		// Remove top right corner
		CornerCutout();
		
		// Remove top left corner
		mirror([1,0,0])
			CornerCutout();
	}
	
	// Bottom Right hook
	Hook();
	
	// Bottom Left hook
	mirror([1,0,0])
		Hook();
}

// ---------------------------------------------------------------------------------------------
// Modules
module Hook()
{
	translate([ BetweenHooks_Width/2, -((OverallHeight/2)-ExtraEdge-(Thickness/2)), (Hooks_Depth/2)+(Thickness/2)])
	{
		// Hook base
		RoundedCube( Hooks_Width, Thickness, Hooks_Depth );
	
		// Hook Lip
		translate([ 0, (Thickness/2)+(HookLip_Height/2)-((Thickness/2)/2), (Hooks_Depth/2)-(HookLip_Height/2)])
		rotate([90,0,0])
			RoundedCube( Hooks_Width, HookLip_Height, HookLip_Height+(Thickness/2) );
		
		// Hook Support
		translate([0,0,-(Thickness/2)])
		scale([1,ExtraEdge/(Thickness*2),1])
		{
			difference()
			{
				cylinder( h=Hooks_Depth-(Thickness/2), d1=Hooks_Width, d2=0, center=true, $fn=Precision);
				
				translate([0,Hooks_Width/2,0])
					cube([Hooks_Width, Hooks_Width, Hooks_Depth-(Thickness/2)+Tolerance ], center=true);
			}
		}
	}
}

module RoundedCube(x,y,z)
{
	hull()
	{
		translate([(x/2)-(y/2),0,0])
			cylinder( d=y, h=z, center=true, $fn=Precision);
		
		translate([-((x/2)-(y/2)),0,0])
			cylinder( d=y, h=z, center=true, $fn=Precision);
	}
	//cube([x, y, z ], center=true);
}

module CornerCutout()
{
	hull()
	{	
		// Top right
		translate([(TopScrewHole_Diameter/2)+ExtraEdge, OverallHeight/2, -((Thickness+Tolerance)/2)])
			cube([OverallWidth, OverallHeight, Thickness+Tolerance ], center=false);
	
		// Bottom right
		translate([(OverallWidth/2), -(((OverallHeight/2)-ExtraEdge-(Thickness/2))-ExtraEdge), -((Thickness+Tolerance)/2)])
			cube([OverallWidth, OverallHeight, Thickness+Tolerance ], center=false);
	}
}


module ScrewHoleCutout(TopScrewHole_Diameter,BottomScrewHole_Diameter, Thickness)
{
	ScrewHoleOffset = (TopScrewHole_Diameter/2)+(BottomScrewHole_Diameter/2);

	//Top Screw Hole
	cylinder(d=TopScrewHole_Diameter,h=Thickness+Tolerance,center=true,$fn=Precision);

	hull()
	{
		//Top screw hole TAPER
		cylinder(h=Thickness+Tolerance, d1=0, d2=BottomScrewHole_Diameter, center=true, $fn=Precision);
		
		//Bottom screw hole TAPER
		translate([0,-(ScrewHoleOffset),0])
			cylinder(h=Thickness+Tolerance, d1=0, d2=BottomScrewHole_Diameter, center=true, $fn=Precision);
	}
	
	// Bottom Screw Hole
	translate([0,-(ScrewHoleOffset),0])
		cylinder(h=Thickness+Tolerance, d=BottomScrewHole_Diameter, center=true, $fn=Precision);
	
	// Cutout
	translate([0,-(ScrewHoleOffset/2),0])
		cube([TopScrewHole_Diameter, ScrewHoleOffset, Thickness+Tolerance], center=true);
}

echo("------------------------- END -------------------------");

