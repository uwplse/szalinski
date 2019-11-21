/*************************************************
 LED lens for 20x20 Extruded Aluminum

 Author: Lee J Brumfield

 Adjustable for Lens Radius, Height and Lens Thickness

*************************************************/

//Variables
Height=90; // Height of lens
LensThickness=.25; // Thickness of the lens
LensRadius=10;


// Constants
lt1=LensRadius-LensThickness;
ht1=Height-2;
ht2=(Height/2)-1;
LensCenter=(LensRadius-15);

color ("blue")
{
difference()
{
translate([0,LensCenter,0])
cylinder(h = Height, r = LensRadius,$fn=200, center = true);
translate([0,LensCenter,0])
cylinder(h = Height+.01, r = lt1,$fn=200, center = true);
}
difference()
{
union()
{
translate([0,-12.5,0])
cube([10,10,Height], center=true);
translate([0,-19,0])
cube([20,4,Height], center=true);
translate([0,-23.5,0])
cube([6,6,Height], center=true);
translate([0,LensCenter,-ht2])
cylinder(h = 2, r = LensRadius,$fn=200, center = true);

}
translate([-3,-13,2])
cube([4,8,ht1+.01], center=true);
translate([3,-13,2])
cube([4,8,ht1+.01], center=true);
translate([0,LensCenter,-ht2])
cylinder(h = 2+.1, r = 5,$fn=200, center = true);
}
}