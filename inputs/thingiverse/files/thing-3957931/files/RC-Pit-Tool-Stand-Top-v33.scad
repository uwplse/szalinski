/* my version of a perfect, modular tool stand, again. Incarnation #3 :-)


	LOOK FOR THE "IF"S AND COMMENTED-OUT-SECTIONS!

	Design by frogfish_42. Find me on thingiverse and follow me. :-)

*/

/* Modules */
include <RC Pit Tool Stand Modules v33a.scad>;
include <RC Pit Tool Stand Globals v33a.scad>;
include <../../Modules/Module_Rounded_Cube.scad>;
include <../../Modules/Module_Really_Rounded_Cube.scad>;
include <../../RC-Team Logo/RC-Team Logo lolores.scad>;
use <../../Modules/Write.scad_GitHub_2015-03-22/Write.scad>;

/* Top piece */
if (1)
{
	difference()
	{
		thingy();

		/* 5 holes * /
		lHoles=5;
		/**/
		
		/* 7 holes */
		lHoles=7;
		/**/
		
		/* Diameters */
		lDia1=8.0;
		lDia2=10;
		
		
		lStep=(gThingLength-2*gSlotLength)/lHoles;
		cylinder(d2=lDia2, d1=lDia1, h=gMS, center=true); // center
			for (rl=[-1, 1])
			for (xi=[rl:rl:rl*(lHoles-1)/2])
			translate([(lStep)*xi, 0, 0])
			cylinder(d2=lDia2, d1=lDia1, h=gMS, center=true); // center +xi*rl
		
		/* Slots */
		for (rl=[-1, 1])
		translate([rl*(gThingLength/2-5), gThingWidth/2-gSlotLength/2, 0])
		rotate([0, 0, 90])
		slot();
	
	}

	
} // if top piece



/*

/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
/
-
\
|
*/


// EOF