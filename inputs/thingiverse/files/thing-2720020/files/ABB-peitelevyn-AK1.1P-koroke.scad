//ABB_peitelevyn_AK1.1P_koroke
// 2017-12-17
wire=6;
height=wire+2;
wall=2;
$fn=100;



difference(){
    union(){
    cylinder(r=114/2, h=height);
    cylinder(r=112/2, h=height+1);
    }
    translate([0,0,-1])
    cylinder(r=114/2-wall, h=height+3);
    translate([0,114/2+10,wire/2])
    rotate([90,0,0])
    hull(){
        cylinder(r=wire/2, h=20);
        translate([0,-wire,0])
        cylinder(r=wire/2, h=20);
    }
}

