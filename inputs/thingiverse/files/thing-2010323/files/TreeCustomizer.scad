

//Number of Sides
NumSides = 5; //[3:1:10]
$fn = NumSides;

//This changes the height of the tree
Height = 12; //[10:1:30]

//This changes the spacing of each segment
Spacing = 3; //[1:.5:10]

//Diameter of the trunk
TrunkDiameter = 5; //[2:1:25]

//Height of Segment
CylinderHeight = 5; //[1:1:30]

//Radius of Segments
RadiusValue = 1; //[1:.5:5]
//cylinder(h = 15, r1 = 15, r2 = 1);


for (i = [Height - 3:-1:4]) 
{
    translate([0,0,i*Spacing - (3*Spacing)])
    {
       cylinder(h = CylinderHeight, r1 = (Height-i) * RadiusValue, r2 = 1);
    }
}
cylinder(h = ((Height - 6)*Spacing), d = TrunkDiameter);