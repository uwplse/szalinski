// Put the pointer where it will be easy to see
Rotation_Angle=330;// [0:1:359]
// Notch for threaded rod
With_Notch="yes";// [yes,no]
/*hidden*/

/*************************************************
 TronXY X5S Z marker

 Author: Lee J Brumfield

*************************************************/

$fn=200;

color ("lightgreen")
{
difference()
{
union()
{
hull()
{
minkowski()
{
cube ([38.3,38.3,1],center=true);
cylinder(h=1,r=2,center=true);
}
translate([0,0,6])
cylinder(h=13,r=12,center=true);
}
translate([0,0,11])
cylinder(h=20,r=12,center=true);
}
translate([0,0,0])
rotate([0,0,Rotation_Angle])
{
translate([0,-11,17])
cube ([2,2.1,9],center=true);
translate([0,-12.8,17])
rotate([0,0,45])
cube ([4,4,9],center=true);
}
translate([15.5,15.5,4])
cylinder(h=10.1,r=1.7,center=true);
translate([15.5,-15.5,4])
cylinder(h=10.1,r=1.7,center=true);
translate([-15.5,15.5,4])
cylinder(h=10.1,r=1.7,center=true);
translate([-15.5,-15.5,4])
cylinder(h=10.1,r=1.7,center=true);
translate([15.5,15.5,6])
cylinder(h=10,r=3.2,center=true);
translate([15.5,-15.5,6])
cylinder(h=10,r=3.2,center=true);
translate([-15.5,15.5,6])
cylinder(h=10,r=3.2,center=true);
translate([-15.5,-15.5,6])
cylinder(h=10,r=3.2,center=true);
hull()
{
translate([0,0,12])
cylinder(h=1,r=10,center=true);
translate([-0,0,0])
cylinder(h=2.1,r=12,center=true);
}
if (With_Notch=="yes")
translate([0,11,10])
cube ([8.3,22.1,22.1],center=true);
translate([0,0,10])
cylinder(h=22.1,r=10,center=true);
}
}