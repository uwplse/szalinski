$fa=2;
$fs=.1;

mntHoleR = 3;
mntHoleToBarbCenterH=81;
barbOffsetX=10;
barbW1=15;
barbW2=18;
barbT=1.7;
barbStep=(barbW2-barbW1)/2;
barbOaL=21;

translate([-barbOffsetX,0,mntHoleToBarbCenterH-barbW1/2])
    rotate(a=[0,0,-90])
        rotate(a=[90,0,0])
            translate([-barbOaL,0,0])
                barb();

translate([0,-barbT,0]){
    difference(){
        union(){
            translate([-barbW1/2,0,0])
                cube([barbW1,barbT,mntHoleToBarbCenterH+barbW1/2]);
            translate([-barbOffsetX-5,0,mntHoleToBarbCenterH-barbW1/2])
                cube([barbOffsetX+5,barbT,barbW1]);
            rotate(a=[-90,0,0])
                cylinder(d=barbW1,h=barbT);
        }
        rotate(a=[-90,0,0])
            cylinder(r=mntHoleR,h=barbT);
    }
}

module barb(){
    linear_extrude(height=barbT){
        square([barbOaL,barbW1]);
        translate([barbStep,0])
            circle(r=barbStep);
        translate([barbStep,barbW1])
            circle(r=barbStep);
    }
}