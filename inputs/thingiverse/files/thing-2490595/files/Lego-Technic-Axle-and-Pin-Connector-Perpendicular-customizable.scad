$fn=40;

eps = 0.05*1;

//Nuber of the holes
NrOfHoles = 3;

Pitch = 8*1;
Radius1 = 4.8 / 2;
Radius2 = 6.1 / 2;
Height = 7.8*1;
Depth = 0.8*1;
Width = 7.5*1;
MidThickness = 2*1;
MiniCubeOffset = 1.1*1; // was 0.9
MiniCubeWidth = Radius1 - MiniCubeOffset;
CrossInnerRadius = 1.5*1;

drawBeam();
translate([Pitch*(NrOfHoles/2-1),-Width/2,0])rotate([90,0,90])OneCross();



module drawBeam()
{
	Length = (NrOfHoles - 1) * Pitch;
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			cube([Length, Thickness, Height]);
			translate([0, Width-Thickness,0]) cube([Length, Thickness, Height]);
			translate([0, 0, Height/2-MidThickness/2]) cube([Length, Width, MidThickness]);
			for (i = [1:NrOfHoles])
			{
				translate([(i-1)*Pitch, Width/2,0]) 
				{
					cylinder(r=Width/2, h=Height);
				}
			}
		}

		union()
		{
			for (i = [1:NrOfHoles])
			{
				translate([(i-1)*Pitch, Width/2,0]) 
				{
					translate([0,0,-eps]) cylinder(r=Radius2,h=Depth+eps);
					translate([0,0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0,0,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
				}
			}
		}
	}
}




module drawCross(x)
{	
	translate([x - MiniCubeOffset - MiniCubeWidth, Width/2 + MiniCubeOffset, 0]) cube([MiniCubeWidth, MiniCubeWidth, Height]);
	translate([x + MiniCubeOffset, Width/2 + MiniCubeOffset, 0]) cube([MiniCubeWidth, MiniCubeWidth, Height]);
	translate([x - MiniCubeOffset - MiniCubeWidth, Width/2 - MiniCubeOffset - MiniCubeWidth, 0]) cube([MiniCubeWidth, MiniCubeWidth, Height]);
	translate([x + MiniCubeOffset, Width/2 - MiniCubeOffset - MiniCubeWidth, 0]) cube([MiniCubeWidth, MiniCubeWidth, Height]);
}

module OneCross()
{
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			cube([Pitch/2, Thickness, Height]);
            translate([0, Width-Thickness+0.3,0]) cube([Pitch/2, Thickness, Height]);
			translate([0, Width/2+0.15,0])cylinder(r=Width/2+0.15, h=Height);
		}
			difference()
			{
				union()
				{
					translate([0, Width/2,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0, Width/2 - MiniCubeOffset,-eps]) cube([Width/2, 2* MiniCubeOffset, Height+2*eps]);
				}
					drawCross(0);
			}
		
	}
}

