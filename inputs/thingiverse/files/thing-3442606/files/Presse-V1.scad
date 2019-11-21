$fn=50;

cylinder(3,r=27);
translate([0,0,2.9]) cylinder(2.5,r1=25,r2=7.5);

translate([0,0,3])
    difference() {
        union(){
        cylinder(22,r=7.5);
        translate([0,0,20]) cylinder(7,r1=7.5,r2=17);
        }
        cylinder(30,r=5);
    }
