//the edge to edge diameter of the card. 50.8 mm = 2 inches.
diameter = 50.8; 
// how far in the holes are from the corners of the card.
inset=7; 
// how thick the cards are. Ideally a multiple or your layer height.
thickness =.7;
//the diameter of the of the corner.  
cornerDiameter =5;
// the diameter of the holes.
holeDiameter=8;
$fn=60;


difference()
{
	translate([cornerDiameter/2,cornerDiameter/2,0])render()
	{
		minkowski()
		{
			cube([diameter-cornerDiameter,diameter-cornerDiameter,thickness/2]);
			cylinder(thickness/2,d=cornerDiameter);
		}
	}
	translate([0,0,0])
		{
			translate([inset,inset,-.1])cylinder(d=holeDiameter,thickness*2);
			translate([diameter-inset,diameter-inset,0-.1])cylinder(d=holeDiameter,thickness*2);
			translate([inset,diameter-inset,-.1])cylinder(d=holeDiameter,thickness*2);
			translate([diameter-inset,inset,-.1])cylinder(d=holeDiameter,thickness*2);
		}
}