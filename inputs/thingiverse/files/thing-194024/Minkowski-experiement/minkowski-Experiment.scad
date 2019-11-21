Width = 10;
Depth = 10;
Height = 2;
Radius = 2;

$fn=360;
minkowski()
{
cube([Width-2*Radius,Depth-2*Radius,Height]);
cylinder(Height,Radius,Radius);
}