/* [FAN FEATURES] */

// How large is the fan rotor ? (mm)
OuterDiameter=38; 
// How large is the inner part of the fan rotator ? (mm)
InnerDiameter=5; 

/* [RINGS] */

// How many concentric rings should be generated ?
NumberOfRings = 3; // [1:20]
// The height of the extruded rings (mm)
Height = 10; 
// The number of faces on each ring perimeter
Resoultion=45; // [3:100]


/* [CONNECTORS] */

// With of the solid connectors that keeps the rings attached to the surface (mm)
ConnectorsWidth=2;  
// Generate a pair of solid orthogonal connectors ?
AddOrtogonalConnectors="YES"; // [YES,NO]
// Generate a pair of solid diagonal connectors ?
AddDiagonalConnectors="YES"; // [YES,NO]


// VARIABLES INITIALIZATION
echo("OuterDiameter=",OuterDiameter);
echo("InnerDiameter=",InnerDiameter);
echo("NumberOfRings=",NumberOfRings);
echo("Height=",Height);
echo("Resoultion=",Resoultion);

OuterRadius = OuterDiameter/2;
echo("OuterRadius=",OuterRadius);
InnerRadius = InnerDiameter/2;
echo("InnerRadius=",InnerRadius);

DeltaRadius = OuterRadius-InnerRadius;
echo("DeltaRadius=",DeltaRadius);
RingRadiusStep =DeltaRadius/(NumberOfRings*2-1);
echo("RingRadiusStep=",RingRadiusStep);


 
difference()
{
for (i=[0:2:(NumberOfRings*2-1)]){
echo(i," - Outer radius=",OuterRadius-(RingRadiusStep*(i)));
echo(i," - Inner radius=",OuterRadius-(RingRadiusStep*(i+1)));
 difference()
 {  
  cylinder(h=Height,r=OuterRadius-(RingRadiusStep*(i)), center = true, $fn=Resoultion);
  cylinder(h=Height*2,r=OuterRadius-(RingRadiusStep*(i+1)), center = true, $fn=Resoultion);
 } 
}


if(AddOrtogonalConnectors=="YES")
{
cube(size = [OuterDiameter*1.1,ConnectorsWidth,Height*2], center = true);
cube(size = [ConnectorsWidth,OuterDiameter*1.1,Height*2], center = true);
}

if(AddDiagonalConnectors=="YES")
{
rotate([0,0,45])
{
cube(size = [OuterDiameter*1.1,ConnectorsWidth,Height*2], center = true);
cube(size = [ConnectorsWidth,OuterDiameter*1.1,Height*2], center = true);
}
}

}
