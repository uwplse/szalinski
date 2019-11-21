//Swiss Army Keyring replacement side with slots
//
//By Mark Benson CC NC 2013
//
//Based on http://www.thingiverse.com/thing:92847 by outcastrc

include <functions.scad>;

bodyLength = 78;
bodyWidth = 22;
curvatureOfEdges = 3.5;
curvatureResolution = 20;
screwHoleSize = 4;
screwHeadSize = 6;
sideThickness = 6;
cutoutOffset = 12; //Fingernail offset from centre hole of model
keyHoleOffset = 6.5; //How far from the end of the body the key holes are

renderNutHoles = 1; //If 1, model will include nut holes and keyring clip
						//If 0, model will include screwhead holes

difference()
{
	//Body
	minkowski()
	{
		hull()
		{
			translate([bodyWidth/2,0,0])
			cylinder(r=(bodyWidth-(2*curvatureOfEdges))/2,h=sideThickness*2);
			translate([bodyLength-bodyWidth/2,0,0])
			cylinder(r=(bodyWidth-(2*curvatureOfEdges))/2,h=sideThickness*2);
		}
		sphere(r=curvatureOfEdges, $fn=curvatureResolution);
	}
	
	//Cut outs
	union()
	{
		//Screw Hole Left
		translate([(keyHoleOffset),0,0])
		cylinder(r=screwHoleSize/2,h=30,$fn=20);
	
		//Screw Hole Middle
		translate([(bodyLength/2),0,0])
		cylinder(r=screwHoleSize/2,h=30,$fn=20);
	
		//Screw Hole Right
		translate([bodyLength-keyHoleOffset,0,0])
		cylinder(r=screwHoleSize/2,h=30,$fn=20);

		if (renderNutHoles == 1)
		{
			//Captive nut Hole Left
			translate([keyHoleOffset,0,sideThickness*2])
			nut(5.5,4);
	
			//Captive nut Hole Middle
			translate([(bodyLength/2),0,sideThickness*2])
			nut(5.5,4);
	
			//Captive nut Hole Right
			translate([bodyLength-keyHoleOffset,0,sideThickness*2])
			nut(5.5,4);

			//Fingernail opener cutout
			translate([(bodyLength/2)+cutoutOffset,15,15])
			sphere(r=10);
	
			//Fingernail opener cutout
			translate([(bodyLength/2)-cutoutOffset,-15,15])
			sphere(r=10);
		}
		else
		{	
			//Countersink Hole Left
			translate([keyHoleOffset,0,sideThickness*2.25])
			cylinder(r=screwHeadSize/2,h=30,$fn=20);
		
			//Countersink Hole Middle
			translate([(bodyLength/2),0,sideThickness*2.25])
			cylinder(r=screwHeadSize/2,h=30,$fn=20);
		
			//Countersink Hole Right
			translate([bodyLength-keyHoleOffset,0,sideThickness*2.25])
			cylinder(r=screwHeadSize/2,h=30,$fn=20);

			//Fingernail opener cutout
			translate([(bodyLength/2)-cutoutOffset,15,15])
			sphere(r=10);
	
			//Fingernail opener cutout
			translate([(bodyLength/2)+cutoutOffset,-15,15])
			sphere(r=10);
		}//End of if/else

		//Cut off the bottom of the main body
		translate([-1,-(bodyWidth/2)-1,-sideThickness-4])
		cube([bodyLength+2,bodyWidth+2,20]);

	}//End of union()

}

		//Body size check - The model should be no bigger than this!
		/*color("red")
		translate([0,-(bodyWidth/2),20])
		cube([bodyLength,bodyWidth,sideThickness]);*/

if(renderNutHoles==1)
{
	//Key ring clip
	translate([0,-7,0])
	rotate([0,0,45])
	difference()
	{
		hull()
			{
				translate([0,-10,sideThickness*2-2])
				cylinder(r=4, h=4.5, $fn=20);
				translate([10,-10,sideThickness*2-2])
				cylinder(r=4, h=4.5, $fn=20);
			}//End of hull
	
		translate([0,-10,sideThickness*2-2])
		cylinder(r=2, h=4.5, $fn=20);
	}//End of difference
}//End of if

