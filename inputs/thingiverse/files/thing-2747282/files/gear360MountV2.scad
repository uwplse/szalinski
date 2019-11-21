$fn=100;
width=70;
length=70;
wedgeHeight=3;
mountWidth=40;
mountLength=20;
mountHeight=4;
boltHoleSize=8.2;
holeSize=6.4;
    difference() {
            union() {
                minkowski(){
                    cube([width,length,wedgeHeight]);
                    sphere([3,3,3]);
                }
                translate([width/2-mountWidth/2,length,wedgeHeight])rotate([90,0,0])
                minkowski(){
                    cube([mountWidth,mountLength,mountHeight]);
                    sphere([3,3,3]);
                }
                translate([width/2-mountWidth/2,length-mountLength-mountHeight,wedgeHeight])
                    difference(){
                minkowski(){
                      cube([mountWidth,mountLength,mountLength]);
                    sphere([3,3,3]);
                }
                      translate([-2,0,mountLength])rotate([0,90,0])
    cylinder(h=mountWidth+4,d=mountLength*2);
                 translate([mountHeight,0,-0.01])cube([mountWidth-2*mountHeight,mountLength+0.01,mountLength+0.01]);
                    
                }
            }
        translate([10,10,-1])cylinder(h=7,d=boltHoleSize);
        translate([25,10,-1])cylinder(h=7,d=boltHoleSize);
        translate([45,10,-1])cylinder(h=7,d=boltHoleSize);
        translate([60,10,-1])cylinder(h=7,d=boltHoleSize);
        translate([19,44,-1])cube([32,21,6.2]);    
//#        translate([25,50,-1])cylinder(h=15,d=2*boltHoleSize,$fn=6);
//#        translate([45,50,-1])cylinder(h=15,d=2*boltHoleSize,$fn=6);
        translate([width/2,length-mountHeight-1.2,mountLength/8])rotate([-90,0,0])
            cylinder(h=mountHeight+4,d=holeSize);
    }

