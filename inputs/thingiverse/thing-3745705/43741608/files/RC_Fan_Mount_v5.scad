/* (paramteric) Touring Car Fan Mount */

//$fn=23;
$fn=50;
include <../Modules/Module_Rounded_Cube.scad>;
include <../Modules/Module_Really_Rounded_Cube.scad>;
include <../Modules/Module_Half_Rounded_Cube.scad>;



/* Settings for 50mm fan 
gWidth=50;
gDist=5.0+1; // distance of screw holes from oute redge (corner)
gHoleRad=sqrt(pow(gWidth/2, 2)*2)-gDist; // https://en.wikipedia.org/wiki/Pythagoras#In_mathematics 
//50/2-2.5;
//gMS=2.4;
gMS=3.6;
o=10; // Offset the base plate
gBaseWidth=25.23+o;
/**/

/* Settings for 40mm fan */
gWidth=40;
gDist=5.0+1; // distance of screw holes from oute redge (corner)
gHoleRad=sqrt(pow(gWidth/2, 2)*2)-gDist; // https://en.wikipedia.org/wiki/Pythagoras#In_mathematics 
//50/2-2.5;
gMS=2.4+1;
gMS2=0.5;
o=10; // Offset the base plate
gBaseWidth=25.23;
gDirksVerrundungsRundung=1.44;
/**/
sy=(gWidth+gMS*1.0)/2; // vertical

/* Fan mount */
difference()
{
	translate([0, 0+gMS/2+sy/2, gMS/2])
	//cube([gWidth+gMS, gWidth+gMS*1.0, gMS], center=true);
	roundedCubeWithCornerDiameter(gWidth+gMS, sy, gMS, 4, 4, 4, 4);
	
	translate([0, 0, gMS/2])
	cylinder(d=gWidth-1*gMS, h=23, center=true);

	for(a=[1, 2, 3, 4])
	{
		rotate([0, 0, 45+90*a])
		translate([0, gHoleRad, gMS/2])
		cylinder(d=4, h=23, center=true);
	}

}

/* Base */
w=gWidth/2;
if (0) // as v4
{
	translate([0-w/2, gWidth/2+gMS/2, gBaseWidth*0+o/2])
	cube([w, gMS, gBaseWidth], center=true);
}
else // as Dirk requested
{
	/* standard underside */
	translate([0-w/2, sy+gMS/2-gMS2/2, gBaseWidth*0+o/2])
	cube([w, gMS2, gBaseWidth], center=true);

	/* rounded upper side */
	if (1)
	translate([0-w/2, gWidth/2+gMS, gBaseWidth*0+o/2])
	rotate([90, 0, 0])
	halfRoundedCube(sizeX=w, sizeY=gBaseWidth, sizeZ=gMS, diameter=gDirksVerrundungsRundung);
}























/* EOF */