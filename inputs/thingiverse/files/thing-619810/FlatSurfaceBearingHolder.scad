//number of sides of the holder plate
NumberOfSides = 3;
//dimension of the bearing outer dimension
DiameterOfBearing = 22;
//dimension of the bearing height
HeightOfBearing = 7;
//dimension of the bearing inner dimension
InnerDiameterBearing = 10;
//Screw holes diameter to fixen the holder
ScrewHoles = 3.2;

$fn=48;
difference(){
union(){
difference()
{
union(){
hull(){
//Generate the base plate
for (i=[0:NumberOfSides-1])
{
rotate([0,0,(360/NumberOfSides)*i])translate([DiameterOfBearing/2+10,0,0])cylinder(r=3,h=3);
}
}
hull(){
cylinder(r=DiameterOfBearing/2+0.2+2, h=HeightOfBearing+2);
translate([0,0,HeightOfBearing+2])cylinder(r=InnerDiameterBearing/2+2, h=2);
}
}
//space holder for the Bearing
cylinder(r=DiameterOfBearing/2+0.2, h=HeightOfBearing+0.1);
}
//inner support for the bearing roof
cylinder(r=InnerDiameterBearing/2+1,h = HeightOfBearing + 2);
}
//the inner hole
cylinder(r=InnerDiameterBearing/2,h = HeightOfBearing + 6);

//generate the fixing holes
for (i=[0:NumberOfSides-1])
{
rotate([0,0,(360/NumberOfSides)*i])translate([DiameterOfBearing/2+7,0,0])cylinder(r=ScrewHoles/2,h=3);
}
}