/* RC Arrowmax Honeycomb Rotating Endcap

Measurements:
Inner Diameter: ~15mm
Outer Diameter: ~17mm
M3 Cylinder Screwhead: 5.5mm wide, 2mm high
M3 Countersunk Screwhead: 6mm wide, 2mm high

*/

use <../Modules/Write.scad_GitHub_2015-03-22/write.scad>


$fn=42;
gMS=1.2; // minimum material strength

//gDiaInner=15.0-0.2; // allow for my unprecise printer
gDiaInner=15.0;
gDiaOuter=17.0;
gDiaOuter2=gDiaOuter-2;
gScrewHeadHeight=2.0+0.7;
gScrewHeadWidth=5.5+0.5;
//gText="1.5";
//gText="2.0";
//gText="2.5";
gText="3.0";

/* Part inserted into handle */
if (1)
{
	translate([-20, 0, 0])
	difference()
	{
		union()
		{

			cylinder(d=gDiaInner, h=10);
		} // union

		
		/* hole for M3 Screw */
		cylinder(d1=2.0, d2=3.0, h=10);
		
		/* Make a slot so it can expand while screwing the screw in */
		cube([23, 1, 42], center=false);
		
	} // difference
} // if

/* rotating part (base) */
if (1)
translate([20, 0, 0])
{

	difference()
	{
		cylinder(d1=gDiaOuter, d2=gDiaOuter2, h=gMS+gScrewHeadHeight+gMS);
		
		/* hole for M3 Screw */
		cylinder(d=3.4, h=10);
		
		/* hole for M3 Screw Head */
		translate([0, 0, gMS])
		cylinder(d=gDiaOuter2-gMS*2, h=gScrewHeadHeight+gMS);

	} // diff

}// if


/* rotating part (cap) */
if (1)
{
	difference()
	{
		/* Cap*/
		translate([0, 0, gMS*0])
		cylinder(d=gDiaOuter2-gMS*2-0.3, h=gMS);

		/* Text with size */
		if (1)
		if (0)
		{
			#writecylinder(gText, [0,0,0], 9, 2,face="top",ccw=true);
			#writecylinder(gText, [0,0,0], 9, 2,face="top");
		}
		else
		{
			#translate([-1, -1, 0])
			write(gText, h=4, t=5, space=1.0, center=true, font="stencil_TNH.dxf"); // bold=false, 
		}
	}
}




