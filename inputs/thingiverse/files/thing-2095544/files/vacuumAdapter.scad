SmallDiameter=32;
LargeDiameter=63;
WallThick=3;
SleeveLength=10;
ConeLength=30;

$fn = 100;

difference(){
    union(){
        translate([0,0,-SleeveLength]) cylinder(d=LargeDiameter+WallThick,h=SleeveLength);
        cylinder(d1=LargeDiameter+WallThick,d2=SmallDiameter+WallThick,h=ConeLength);
        translate([0,0,ConeLength]) cylinder(d=SmallDiameter+WallThick,h=SleeveLength);
    }
    union(){
        translate([0,0,-SleeveLength]) cylinder(d=LargeDiameter,h=SleeveLength);
        cylinder(d1=LargeDiameter,d2=SmallDiameter,h=ConeLength);
        translate([0,0,ConeLength]) cylinder(d=SmallDiameter,h=SleeveLength);
    }
}