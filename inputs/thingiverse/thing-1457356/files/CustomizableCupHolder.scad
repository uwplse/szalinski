//!OpenSCAD

/* [Cup Holder Parameters] */
//Outer Box Shape
outerShape = 2; //[1:cube,2:cylinder]
//Box Base Size in mm
boxSize = 40; // [20:120]
//Box Height in mm
boxHeight = 40; // [20:100]
//Hole Diameter in mm
holeDiameter = 30; // [0:100]
//Hole Height (depth) in mm
holeHeight = 38; // [0:100]
/* [Cup Holder Personalization] */
//Your Name
yourName = "Mr.Johnson";

use <write/Write.scad> 

$fn=50;
difference()
{
    difference()
    {
        if (outerShape == 1) { 
            translate([0,0,boxHeight/2])
            cube([boxSize,boxSize,boxHeight], center=true);
        } else {
            cylinder(d=boxSize,h=boxHeight);
        }    
        translate([0,0,(boxHeight-holeHeight)])
        cylinder(d=holeDiameter,h=holeHeight);
    };
    if (outerShape == 1 ) {
        translate([boxSize/2,0,10])
        writecube(yourName,size=40,face="right", h=6);
    } else {
        writecylinder(yourName,[0,0,10],boxSize/2,boxSize,rotate=0,center=true, h=6);
    }
    
}