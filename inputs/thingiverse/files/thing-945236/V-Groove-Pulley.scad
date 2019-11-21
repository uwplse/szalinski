/*
Created by David Taylor
http://bit.ly/Gineer

This is one half of two parts that should be glued together to form a V-Groove Pulley
*/

//What is the outer diameter of the enclosed bearing (eg. 22 for a 608)?
BearingDiameter=22;

//What is the width of the bearing (eg. 7 for a 608)? 
BearingWidth=7;

//What is the depth between the bottom of the V and the bearing?
Depth=1;

//How think should the walls be over the sides of the bearing?
Walls=1;

//How deep should the Sholder protrude over the side of the bearing?
Shoulder=1;

/* [Hidden] */
fn=360;

difference()
{
	rotate_extrude(convexity=10, $fn=fn)
	{
		polygon(points=[[(BearingDiameter/2)-Shoulder,(BearingWidth/2)+Walls],
							[(BearingDiameter/2)+(BearingWidth/2)+Depth,(BearingWidth/2)+Walls],
							[(BearingDiameter/2)+(BearingWidth/2)+Depth,(BearingWidth/2)],
							[(BearingDiameter/2)+Depth,0],
							[(BearingDiameter/2)+(BearingWidth/2)+Depth,-((BearingWidth/2))],
							[(BearingDiameter/2)+(BearingWidth/2)+Depth,-((BearingWidth/2)+Walls)],
							[(BearingDiameter/2)-Shoulder,-((BearingWidth/2)+Walls)]]);
	}
	cylinder(r=BearingDiameter/2, h=BearingWidth, center=true, $fn=fn);
	translate([0,0,(BearingWidth+Walls)/2])
	{
		cylinder(r=BearingDiameter+Walls, h=BearingWidth+Walls, center=true, $fn=fn);
	}
}