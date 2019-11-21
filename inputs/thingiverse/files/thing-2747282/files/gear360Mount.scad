$fn=100;
width=70;
length=70;
wedgeHeight=4;
mountWidth=50;
mountLength=30;
mountHeight=8;
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
        translate([width/2,length-mountHeight-1,mountLength/2+wedgeHeight])rotate([-90,0,0])
            cylinder(h=mountHeight+2,d=holeSize);
    }

