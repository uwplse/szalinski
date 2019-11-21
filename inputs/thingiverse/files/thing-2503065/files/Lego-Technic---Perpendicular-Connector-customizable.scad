$fn=40;

eps = 0.05*1;

//Nuber of the holes
NrOfHolesX = 4;
NrOfHolesY = 2;

Pitch = 8*1;
Radius = 4.8;
Radius1 = Radius / 2;
Radius2 = 6.1 / 2;
Height = 7.8*1;
Depth = 0.8*1;
Width = 7.5*1;
MidThickness = 2*1;
MiniCubeOffset = 1.1*1; // was 0.9
MiniCubeWidth = Radius1 - MiniCubeOffset;
CrossInnerRadius = 1.5*1;

drawBeam(NrOfHolesX);
rotate([0,0,90])drawBeam(NrOfHolesY);
//translate([Pitch*(NrOfHoles/2-1),-Width/2,0])rotate([90,0,90])OneCross();


module drawBeam(NrOfHoles){
translate([0,-Width/2,0])union(){    
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
}
}



