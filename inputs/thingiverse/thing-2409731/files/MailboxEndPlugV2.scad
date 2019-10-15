outerDiameter=8.0;
innerDiameter=7.0;
length=8.0;
capHeight=2.5;

$fn=40;

cylinder(d=outerDiameter, h=capHeight);
cylinder(d=innerDiameter, h=capHeight+length);