$fn=75;

difference(){
    union(){
        difference(){
            union(){
                cylinder(15,r=50,center);
                cylinder(11,r=52.5,center);
            }
            translate([0,0,2]) cylinder(15,r=47,center);
        }}

translate([30,0,5]) { rotate(a=[0,90,0]) {cylinder(30,r=2.5,center); }}}
