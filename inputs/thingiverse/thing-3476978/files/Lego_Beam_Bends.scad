NrOfHolesLeft = 3; // [1:20]
NrOfHolesRight = 5; // [1:20]
EasyPrintable = 1; // [0,1]
NumBends = 1; // [1,2]

/* [Hidden] */
$fn=80;
Angle = 45;
eps = 0.05;
Pitch = 8;
Radius1 = 4.8 / 2;
Radius2 = 6.1 / 2;
Height = 7.8;
Depth = 0.8;
Width = 7.5;
MidThickness = 2;
MiniCubeOffset = 1.1; // was 0.9
MiniCubeWidth = Radius1 - MiniCubeOffset;
CrossInnerRadius = 1.5;
NrOfVirtualHoles = 4;



function getMidThickness() = EasyPrintable?Height:MidThickness;



module drawCrossHole()
{	
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{
			cylinder(r=Width/2, h=Height);
			translate([0, -Width/2, 0]) cube([Pitch, Thickness, Height]);
			translate([0, Width/2-Thickness,0]) cube([Pitch, Thickness, Height]);
		}
		union()
		{
			difference()
			{
				union()
				{
					translate([0, 0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0, -MiniCubeOffset,-eps]) cube([Width/2, 2* MiniCubeOffset, Height+2*eps]);
				}
				union()
				{
					translate([-MiniCubeOffset - MiniCubeWidth, MiniCubeOffset, -eps]) cube([MiniCubeWidth, MiniCubeWidth, Height+2*eps]);
					translate([MiniCubeOffset, MiniCubeOffset, -eps]) cube([MiniCubeWidth, MiniCubeWidth, Height+2*eps]);
					translate([-MiniCubeOffset -MiniCubeWidth, -MiniCubeOffset - MiniCubeWidth, -eps]) cube([MiniCubeWidth, MiniCubeWidth, Height+2*eps]);
					translate([MiniCubeOffset, -MiniCubeOffset - MiniCubeWidth, -eps]) cube([MiniCubeWidth, MiniCubeWidth, Height+2*eps]);
				}
			}
		}
	}
}


module drawHoleTop()
{
	translate([0,0,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
}


module drawHoleMid()
{
	translate([0,0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
}


module drawHoleBottom()
{
	translate([0,0,-eps]) cylinder(r=Radius2,h=Depth+eps);
}


module drawHole()
{
	drawHoleTop();
	drawHoleMid();
	drawHoleBottom();
}


module drawBeam(prmNrOfHoles)
{
	Length = (prmNrOfHoles - 1) * Pitch;
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			translate([0, -Width/2, 0]) cube([Length, Thickness, Height]);
			translate([0, Width/2-Thickness,0]) cube([Length, Thickness, Height]);
			translate([0, -Width/2, Height/2-getMidThickness()/2]) cube([Length, Width, getMidThickness()]);
			for (i = [1:prmNrOfHoles])
			{
				translate([(i-1)*Pitch, 0,0]) cylinder(r=Width/2, h=Height);
			}
		}

		union()
		{
			for (i = [1:prmNrOfHoles])
			{
				translate([(i-1)*Pitch, 0,0]) drawHole();
			}
		}
	}
}


module drawMidBeam()
{
	Length = (NrOfVirtualHoles - 1) * Pitch;
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			translate([0, -Width/2, 0]) cube([Length, Thickness, Height]);
			translate([0, Width/2-Thickness,0]) cube([Length, Thickness, Height]);
			translate([0, -Width/2, Height/2-getMidThickness()/2]) cube([Length, Width, getMidThickness()]);

			translate([0,0,0]) cylinder(r=Width/2, h=Height);
			hull() 
			{
				translate([Pitch,0,0]) cylinder(r=Width/2, h=Height);
				translate([2*Pitch,0,0]) cylinder(r=Width/2, h=Height);	
			}
			translate([(NrOfVirtualHoles-1)*Pitch,0,0]) cylinder(r=Width/2, h=Height);
		}

		union()
		{
			translate([0,0,0]) drawHole();
			hull() 
			{
				translate([Pitch,0,0]) drawHoleTop();
				translate([2*Pitch,0,0]) drawHoleTop();	
			}
			hull() 
			{
				translate([Pitch,0,0]) drawHoleMid();
				translate([2*Pitch,0,0]) drawHoleMid();	
			}
			hull() 
			{
				translate([Pitch,0,0]) drawHoleBottom();
				translate([2*Pitch,0,0]) drawHoleBottom();	
			}
			translate([(NrOfVirtualHoles-1)*Pitch,0,0]) drawHole();
		}
	}
}


module bends(NumBends)
{
	if (NumBends==1){

	}else{

	}
}


module drawDoubleBentLiftArm()
{

	if (NumBends==1){
		LengthLeft = (NrOfHolesLeft - 1) * Pitch;
		LengthRight = (NrOfHolesRight - 1) * Pitch;
		translate([-LengthLeft-Pitch,0,0]) drawCrossHole();
		translate([-LengthLeft,0,0]) drawBeam(NrOfHolesLeft);
		rotate([0,0,Angle]) drawBeam(NrOfHolesRight);
		rotate([0,0,Angle]) translate([LengthRight+Pitch,0,0]) rotate([0,0,180]) drawCrossHole();
		
	}else{
		LengthLeft = (NrOfHolesLeft - 1) * Pitch;
		LengthRight = (NrOfHolesRight - 1) * Pitch;

		translate([-LengthLeft-Pitch,0,0]) drawCrossHole();
		translate([-LengthLeft,0,0]) drawBeam(NrOfHolesLeft);
		rotate([0,0,Angle]) drawMidBeam();
		offset = (NrOfVirtualHoles-1) * Pitch * cos(Angle);
		translate([offset,offset,0]) 
		{
			rotate([0,0,2*Angle]) drawBeam(NrOfHolesRight);
			rotate([0,0,2*Angle]) translate([LengthRight+Pitch,0,0]) rotate([0,0,180]) drawCrossHole();
		}
	}	
}


// tests
//drawBeam(5);
//drawMidBeam();
//drawCrossHole();


// parts
drawDoubleBentLiftArm();