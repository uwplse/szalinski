/*
 * Creates a small sleeve to be used with 1/4" bolt through 8mm bearing
 */

FudgeFactor = 2; // Percentage to increase size of holes/cylinders to compensate for OpenSCAD polygon approximation

Inch = 25.4;  // Number of mm in an inch
InnerDiameter = 1/4*Inch;
OuterDiameter = 8;
Height = 7;

$fa = 1;
$fs = 1;

InnerRadius = InnerDiameter * (1 + FudgeFactor/100);
OuterRadius = OuterDiameter * (1 + FudgeFactor/100);

difference(){
  cylinder(r=OuterRadius, h=Height);
  cylinder(r=InnerRadius, h=Height);
}
