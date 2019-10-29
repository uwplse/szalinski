/*
*  Name: screw-washer.scad
*  Description: washer ring
*  Author: Anhtien Nguyen
*  Date: Aug 24, 2018
*/

// inner diameter of washer, default is M3 screw
diameter=3;
// clearance 
gap=0.6; 
// wall thickness between inner & outter wall
thickness=2; 
//  height
height=20; 
// how many copies
qty = 4;

 for (x = [1:1:qty])
    {
    translate([(x-1)*(diameter+gap+thickness+5),0,0]) printWasher();
}

module printWasher(rad = (diameter+gap)/2,thick=thickness,height=height) {
    difference() {
        // outter circle
        cylinder(r=rad+thick,h=height,$fn=50);
        // inner circle
        translate([0,0,-1]) cylinder(r=rad,h=height+2,$fn=50);
    }
}
    

