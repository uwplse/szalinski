//Glass divider
//
//A divider thing to put inside a glass to divide it into segments
//
//Handy if you store things in drinking glasses
//
//Need to know:
// Glass inside diameter
// Clearance between thing and glass
// Number of seqments
// Wall thickness
// Height of thing
// Bottom chamfer required
// Bottom chamfer size
//
Diameter = 50;
Clearance = 0.3;
Segments = 7;
WallThickness = 2;
Height = 50;
ChamferOn = false;
ChamferSize = 10;
//
//Build one leg
module OneLeg()
{
    aDiameter = Diameter - (2 * Clearance);
    intersection()
    {
        circle(d=aDiameter);
        polygon(points = [[0, WallThickness/2], [0, -WallThickness/2], 
                    [Diameter, -WallThickness/2], [Diameter, WallThickness/2]]); 
    }
}
//
//Make a collection of legs
module AllLegs()
{
    for (aLeg=[1:1:Segments])
    {
        aAngle = (aLeg-1) * (360 / Segments);
        rotate (aAngle) OneLeg();
    }
}
//
//Make the chamfer shape
module Chamfer()
{
    //Make the chamfer cross section (yz plane) and rotate it (z axis)
    aRadius = Diameter/2;
    translate([0,0,Height])
    rotate([0,180,0])
    rotate_extrude($fn=360)
    polygon (points = [[aRadius-ChamferSize, -0.1], [aRadius, -0.1],
            [aRadius, ChamferSize]]);
}

//Extrude the legs
module Walls()
{
    linear_extrude(height = Height, center=false)
    AllLegs();
}
//
//Add the Chamfer if required
if (ChamferOn)
{
    difference()
    {
        Walls();
        Chamfer();
    }
}
else
{
    Walls();
}