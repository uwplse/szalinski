/* my version of a perfect, modular tool stand 


	LOOK FOR THE "I"FS! You can en-/disable parts.
	Sizes of toolhandles are hardcoded below line 70.


	https://www.thingiverse.com/thing:3924478
	
*/

/* Modules */
include <../../Modules/Module_Rounded_Cube.scad>;
include <../../Modules/Module_Really_Rounded_Cube.scad>;

//$fn=23;
$fn=50;
gMS=1.6; /* Material Strength of base plate/trays */
gMS2=2.4; /* Material Strength of tool stands */
gMSMin=0.6;
gSizeX=200+10; 
gSizeY=100-20;
gSizeZ=8;
gDiaSocket=23+2*gMS; // 26.2mm
echo ("gDiaSocket" , gDiaSocket);
gDias=[gDiaSocket, gDiaSocket, gDiaSocket, gDiaSocket, gDiaSocket, gDiaSocket, gDiaSocket]; // Diameter of SOCKET (ex tool handles (until v7))
gDiaCount=7;
gOffset=( (gSizeX-2*gMSMin)-(gDiaSocket*gDiaCount))/(gDiaCount-1) + gDiaSocket;
gHeight=23-5; // height of tool stand socket thingambob
gAbsenkung=5.0;


/* The Base Plate */
if(1)
union()
{
	/* Base Plate */
	difference()
	{
		/* Base Plate */
		translate([0, 0, gSizeZ/2])
		roundedCube(gSizeX, gSizeY, gSizeZ, 10);

		tsx=gSizeX/2-3*gMS; //gSizeX/2-10; // tray size X
		tsy=gSizeY-gDiaSocket-gMS*2-gMS;  // 60; // tray size Y
		toy=-tsy/2+(gSizeY/2-gDiaSocket-gMS*0)*1; // -15; // tray offset Y
		
		/* Left Tray */
		translate([-tsx/2-gMS, toy-gMS, gMS])
		reallyRoundedCube(sizeX=tsx, sizeY=tsy, sizeZ=gSizeZ*2, diameter=10);

		/* Right Tray */
		translate([tsx/2+gMS, toy-gMS, gMS+0*gSizeZ/2])
		reallyRoundedCube(sizeX=tsx, sizeY=tsy, sizeZ=gSizeZ*2, diameter=10);

		/* Versenken der Halter */
		if (1)
		translate([-gSizeX/2+gDiaSocket/2+gMSMin, +gSizeY/2-gDiaSocket/2-gMSMin, 1*(gSizeZ-gAbsenkung)])
		{
			for (i=[0:1:gDiaCount-1])
			{
				translate([gOffset*i, 0, 0])
				cylinder(d=gDias[i], h=gHeight);
			} // end for
		} // end if
		
	} // end diff
} // end union


/* The the actual stand to insert into the sockets. Make them the size of your tools */
if (1)
translate([0, 60, 0])
{
	lSpace=0.4;
	
	/* Corally handles are around 21.5mm */
	if (0)
	bums(diaI=22.0, diaO=gDiaSocket-lSpace); // usually my prints are too wide -> adapt size. (f.e. my CTC Bizer prints 24.0 as 23.5 -> diff +0.5mm)
	
	/* Hudy and Arrowmax are around 17.8mm */	
	if (1)
	bums(diaI=18.8, diaO=gDiaSocket-lSpace); // usually my prints are too wide -> adapt size. (f.e. my CTC Bizer prints 20.0 as 19.5 -> diff +0.5mm )

	/* Alex' Tools 2x 21.1mm + 5x 18.1mm */
	if (0) bums(diaI=21.1+0.5, diaO=gDiaSocket-lSpace); // usually my prints are to big -> reduce size. 
	if (0) bums(diaI=18.1+0.7, diaO=gDiaSocket-lSpace); // usually my prints are to big -> reduce size. 

	/* Knut' Tools are max 18mm */
	if (0) bums(diaI=18.0+1.0, diaO=gDiaSocket-lSpace); // usually my prints are to big -> reduce size. 


} // end if


/* Sandbox */
if (0) bums(dia=20.10);
	
/* Modules */
module bums(diaI=23, diaO=42)
{
	difference()
	{
		cylinder(d=diaO, h=gHeight);
		
		cylinder(d=diaI, h=gHeight);
		
		translate([0, 0, gHeight-2.3])
		cylinder(d1=diaI, d2=diaO, h=2.3);
		
	}
} // end module bums













// EOF