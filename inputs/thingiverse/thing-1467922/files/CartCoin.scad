Diameter=26.48;
Thickness=1.92;
RingDia=3;
SlotThick=1;
$fn=60;

difference(){
    union(){
        cylinder(d=Diameter,h=Thickness,center=true);
        translate([3*Diameter/4-2,0,0])cylinder(d=Diameter/4+RingDia,h=Thickness,center=true);
        translate([Diameter/2-2,0,0])cube([Diameter/2,Diameter/4+RingDia,Thickness], center=true);
    }
    translate([3*Diameter/4-2,0,0]){
        union(){
            cylinder(d=RingDia,h=Thickness*2,center=true);
            cube([Diameter/4+RingDia,SlotThick,Thickness*2],center=true);
            
        }
        translate([-3*Diameter/4-1,-2,0])Signature();
    }
}


module Signature(){
    cube([1,4,1]);
    translate([0,4,0]){
        rotate([0,0,45])translate([0,-3,0]){
            difference(){
                cube([3,3,1]);
                translate([1,1,-1])cube([3,3,3]);
            }
        }
    }
    translate([4.95,3.29,0]){
        rotate([0,0,-45])translate([0,-3,0]){
            difference(){
                cube([3,3,1]);
                translate([1,1,-1])cube([3,3,3]);
            }
        }
    }
    translate([2.83,-0.95,0])cube([1,2.12,1]);
}