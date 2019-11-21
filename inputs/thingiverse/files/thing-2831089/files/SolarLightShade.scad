//linear_extrude(height =20)
Diameter=98;
Height=50;
Thick=1.5;

HubDiameter=Diameter;
HubHeight=5;
HubThick=3.5;
LockRadius=49.0;
$fn=100;
Shade(1);
for (a=[0:30:360]){
// echo(a)
//lock(a,LockRadius,3.51,3.5,-.5);
};
//lock(100,LockRadius,3.51,4);

module lock(Rot,OffSet,SizeX,SizeY,AdjZ){
    translate([0,0,AdjZ]){
        rotate([0,0,Rot]){
            translate([0,OffSet,-(SizeY/2)]){
                difference(){
                cube([9.26,SizeX,SizeY],true);
                    translate([0,1,SizeY/2]){    
                        cube([9.26,SizeX,SizeY],true);
                    }
                }
            }
        }
    }
}
module lock2(Rot,OffSet,SizeX,SizeY){
    rotate([0,0,Rot]){
        translate([0,OffSet,-2]){
            difference(){
            cube([9.26,SizeX,SizeY],true);
                translate([0,1,SizeY/2]){    
                    cube([9.26,SizeX,SizeY],true);
                }
            }
        }
    }
}
module Shade(go) {
rotate([0,0,0]){
union(){
translate([0,0,HubHeight]){
    Tube(Diameter,Height,Thick);
}
union(){
union(){
union(){
union(){
    Tube(HubDiameter,HubHeight,HubThick);
    lock(90,LockRadius,3.51,4);
}
lock(0,LockRadius,3.51,4);
}
lock(180,LockRadius,3.51,4);
}
lock(270,LockRadius,3.51,4);
}
}
}
}

module lock1(Rot,OffSet){
    rotate([0,0,Rot]){
        translate([0,OffSet,-2]){
            difference(){
            cube([9.26,4.11,4],true);
                translate([0,1,2]){    
                    cube([9.26,4.11,4],true);
                }
            }
        }
    }
}
module Tube(Diameter,Height,Thick) {
    difference(){
        cylinder(d=Diameter,h=Height);
        cylinder(d=(Diameter-Thick),h=Height);
    }
}