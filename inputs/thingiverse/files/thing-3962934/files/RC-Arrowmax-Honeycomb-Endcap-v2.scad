/* RC Arrowmax Honeycomb Endcap

Measurements:
Inner Diameter: ~15mm
Outer Diameter: ~17mm
M3 Cylinder Screwhead: 5.5mm wide, 2mm high
M3 Countersunk Screwhead: 6mm wide, 2mm high

*/

use <../Modules/Write.scad_GitHub_2015-03-22/write.scad>


$fn=42;
gDiaInner=15.0+0.2; // allow for my unprecise printer
//gDiaInner=15.0;
gDiaOuter=17.0;
//gText="1.5";
//gText="2.0";
//gText="2.5";
gText="3.0";

difference()
{
	union()
	{
		cylinder(d1=gDiaOuter, d2=gDiaOuter-2, h=2);

		translate([0, 0, -10])
		cylinder(d=gDiaInner, h=10);
	} // union



	if (0)
	{
		#writecylinder(gText, [0,0,0], 9, 2,face="top",ccw=true);
		#writecylinder(gText, [0,0,0], 9, 2,face="top");
	}
	else
	{
		#write(gText, h=6, t=6, center=true);
	}
	
	
} // difference