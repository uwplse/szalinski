// How large is the fan rotor ? (mm)
RotorDiameter=38;
// How large should each hole be ? (mm)
HolesDiameter=4;
// How much space should be left between each hole, proportionally to the hole size ?
HolesRingsSpacingFraction = 0.4; // [0.1:4.0]
// The height of the generated solids (mm)
Height = 10; 
// The number of faces of each hole outer perimeter
Resoultion=20;// [3:100]


// VARIABLES INITIALIZATION
echo("RotorDiameter=",RotorDiameter);
echo("HolesDiameter=",HolesDiameter);
echo("Height=",Height);
echo("Resoultion=",Resoultion);

HolesBoundingBox = HolesDiameter*(1+HolesRingsSpacingFraction);
echo("HolesBoundingBox=",HolesBoundingBox);
NumberOfRings = RotorDiameter / HolesBoundingBox;
echo("NumberOfRings=",NumberOfRings);

OuterRadius = RotorDiameter/2;
echo("OuterRadius=",OuterRadius);

RingRadiusStep = HolesBoundingBox;
echo("RingRadiusStep=",RingRadiusStep);


 
difference()
{
 for (i=[0:1:NumberOfRings/2])
 {
  difference()
  {  
   for(j=[0:360/((i*HolesBoundingBox*6/HolesBoundingBox)):360])
   {
    translate([sin(j)*(i*HolesBoundingBox),cos(j)*(i*HolesBoundingBox),0])cylinder(h=Height,d=HolesDiameter, center = false, $fn=Resoultion);
   }
  } 
 }
}