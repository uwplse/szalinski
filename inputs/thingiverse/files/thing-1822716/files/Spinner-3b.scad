BearingD=22.25;
BearingT=7;
CapSDia=8;
CapBDia=17;
CapL=7;
CapT=1;
Wall=3;
WallT=1.6;
Spacing=25;
Rad=5;
$fn=50;


module Spinner(){
    difference(){
        union(){
            BearingRing(BearingD+Wall+WallT*2);
            rotate([0,0,360/3])translate([Spacing,0,0])BearingRing(BearingD+Wall);
            translate([Spacing,0,0])BearingRing(BearingD+Wall);
            rotate([0,0,-360/3])translate([Spacing,0,0])BearingRing(BearingD+Wall);
        }
        union(){
            cylinder(d=BearingD+WallT*2,h=BearingT*2,center=true);
            rotate([0,0,360/3])translate([0,0,0])BearingRace();
            translate([0,0,0])BearingRace();
            rotate([0,0,-360/3])translate([0,0,0])BearingRace();
        }
    }
}

module BearingRing(Dia){
    minkowski(){
        cylinder(d=Dia,h=BearingT-Wall,center=true);
        sphere(d=Wall);
    }
}

module BearingRace(){
    translate([Spacing,0,0])cylinder(d=BearingD,h=BearingT*2,center=true);
    //translate([Spacing,0,0])cube([Spacing,Wall/2,BearingT*2],center=true);
}

module Retain(){
    difference(){
        union(){
            translate([0,0,WallT/2])cylinder(d1=BearingD+WallT*2-0.5,d2=BearingD+WallT*2,h=BearingT/2);
            translate([0,0,BearingT/2])cylinder(d=BearingD+WallT*3,h=WallT/2);
        }
        cylinder(d=BearingD,h=BearingT,center=true);
        cylinder(d=BearingD-WallT,h=BearingT*2,center=true);
        translate([0,BearingD/2,0])cube([WallT/2,BearingD,BearingT*2],center=true);
    }
}

module Cap(){
    cylinder(d=CapSDia,h=CapL/2);
    difference(){
        translate([0,0,-CapT*1.5]){
            minkowski(){
                cylinder(d=CapBDia,h=CapT,center=true);
                sphere(d=CapT*2);
            }
        }
        //translate([0,0,-CapT*3])scale([1,1,.1])sphere(d=CapBDia-CapT);
    }
}

rotate([0,0,360/3])translate([-Spacing-Wall*3,0,BearingT/2+WallT/2])Cap();
translate([-Spacing-Wall*3,0,BearingT/2+WallT/2])Cap();
translate([0,0,BearingT/2])Spinner();
translate([-Spacing-Wall*3,0,BearingT/2+WallT/2])rotate([180,0,0])Retain();
rotate([0,0,360/3])translate([-Spacing-Wall*3,0,BearingT/2+WallT/2])rotate([180,0,0])Retain();