/* my version of a perfect tool stand */

/* Modules */
include <../Modules/Module_Rounded_Cube.scad>;
include <../Modules/Module_Really_Rounded_Cube.scad>;

//$fn=23;
$fn=50;
gMS=1.6; /* Material Strength of base plate/trays */
gMS2=2.4; /* Material Strength of tool stands */
//gA=12;
//gH=8.0;
//gH2=10;

/* locations and sizes for the tools */
	/* Alex S. möchte 2x21.10 + 5x18.10 * /
	gSizeX=200; 
	gSizeY=100;
	gSizeZ=10;
	gDia1=21.10+0.2;
	gDia2=18.10+0.3;
//	gDias=[21.10, 21.10, 18.10, 18.10, 18.10, 18.10, 18.10]; // Diameter of tool handles
	gDias=[gDia1, gDia1, gDia2, gDia2, gDia2, gDia2, gDia2]; // Diameter of tool handles
	gDiaCount=7;
	gDiaMax=gDia1;
	gDiaMaxOuter=gDiaMax+gMS2*2;
	//gOffsets=[0, 25, 50, 72, 94, 116, 138]; // Distance of tool handles
	gOffset=gDiaMaxOuter+2.0+1.35-0.25;
	gHeight=23;
	gAbsenkung=5.0;
	/**/
	
	/* Heiko: 4x Arrowmax 18mm, 1x Hudy 18mm, 2 x Corally 21.5mm */
	gSizeX=200+10; 
	gSizeY=100-20;
	gSizeZ=8;
	gDiaArrowmax=18.00+0.3; // 18.00 will be printed as 17.7
	gDiaHudy=gDiaArrowmax;
	gDiaCorally=21.50+0.2; // 21.50 will be printed as 21.30
	gDias=[gDiaArrowmax, gDiaArrowmax, gDiaArrowmax, gDiaArrowmax, gDiaHudy, gDiaCorally, gDiaCorally]; // Diameter of tool handles
	gDiaCount=7;
	gDiaMax=gDiaCorally;
	gDiaMaxOuter=gDiaMax+gMS2*2;
	//gOffsets=[0, 25, 50, 72, 94, 116, 138]; // Distance of tool handles
	gOffset=gDiaMaxOuter+4.05;
	gHeight=23;
	gAbsenkung=5.0;
	/**/
	

/* The Whole thing */
if(1)
union()
{
	/* Base Plate */
	difference()
	{
		/* Base Plate */
		translate([0, 0, gSizeZ/2])
		roundedCube(gSizeX, gSizeY, gSizeZ, 10);

		/* Left Tray */
		tsx=gSizeX/2-3*gMS; //gSizeX/2-10; // tray size X
		tsy=gSizeY-gDiaMaxOuter-gMS*2;  // 60; // tray size Y
		toy=-tsy/2+(gSizeY/2-gDiaMaxOuter-gMS*0)*1; // -15; // tray offset Y
		
		translate([-tsx/2-gMS, toy, gMS])
		reallyRoundedCube(sizeX=tsx, sizeY=tsy, sizeZ=gSizeZ*2, diameter=10);

		/* Right Tray */
		translate([tsx/2+gMS, toy, gMS+0*gSizeZ/2])
		reallyRoundedCube(sizeX=tsx, sizeY=tsy, sizeZ=gSizeZ*2, diameter=10);

		/* Versenken der Halter */
		if (1)
		translate([-gSizeX/2+gDiaMaxOuter/2, +gSizeY/2-gDiaMaxOuter/2, 1*(gSizeZ-gAbsenkung)])
		{
			for (i=[0:1:gDiaCount-1])
			{
				translate([gOffset*i, 0, 0])
				cylinder(d=gDias[i], h=gHeight);
			} // end for
		} // end if
		
	} // end diff
	
	/* The the actual stands */
	if (1)
	translate([-gSizeX/2+gDiaMaxOuter/2, +gSizeY/2-gDiaMaxOuter/2, gSizeZ-gAbsenkung])
	{
		di=0;
		os=0;
		for (i=[0:1:gDiaCount-1])
		{
			//os=os+o;
			//echo(os);
			translate([gOffset*i, 0, 0])
			//translate([gOffsets[i], 0, 0])
			bums(dia=gDias[i]);
//			di=di+1;
			//echo(i);
		} // end for
	} // end if

} // end union

/* Sandbox */
if (0) bums(dia=20.10);
	
/* Modules */
module bums(dia=42)
{
	difference()
	{
		cylinder(d=dia+2*gMS2, h=gHeight);
		
		cylinder(d=dia, h=gHeight);
		
		translate([0, 0, gHeight-2.3])
		cylinder(d1=dia, d2=dia+2*gMS2, h=2.3);
		
	}
} // end module bums













// EOF