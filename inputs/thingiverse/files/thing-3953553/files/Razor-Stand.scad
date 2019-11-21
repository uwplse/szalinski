// Customizable Razor Stand
// (c) Rainer Schlosshan
// The Diameter of the Razor Handle
RazorDia=10.5; 
// The Depth of the hole in the Base
RazorHoleDepth=25;

// The Diameter of the base
BaseDia=30;
// the thickness of the bottom
BottomT=3;
/* [Hidden] */
$fn=180;

RazorStand();
//TopRoundCylinder();
module RazorStand(){
    difference(){
        union(){
            // The Base
            TopRoundCylinder(r=BaseDia/2,h=RazorHoleDepth+BottomT);
        }
        // Negative Part
            translate ( [0,0,BottomT+0.01])cylinder(r=(RazorDia)/2,h=RazorHoleDepth);
    }
}


module TopRoundCylinder(r=15,h=25){
    difference(){
        union(){
            cylinder(r=r,h=h-r);
            translate([0,0,h-r])sphere(r=r);
        }
        // negative part
        // cut bottom in case spehere is too large...
        translate([0,0,-r])cylinder(r=r,h=r);
    }
}