$fn=75;

difference(){
    cylinder(6,r=52.5,center);
    union(){
        translate([0,0,-2]) cylinder(6,r=50.2,center);
        translate([0,0,2]) cylinder(15,r=47,center);
    }}
