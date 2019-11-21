$fn=100;

difference() {
    union() {
        cylinder(d=28, h=2);
        cylinder(d=16.3, h=58);
        hull() {
            translate([17,1.5,0]) cylinder(d=2, h=2);
            translate([17,-1.5,0]) cylinder(d=2, h=2);
            translate([13,1.5,0]) cylinder(d=2, h=2);
            translate([13,-1.5,0]) cylinder(d=2, h=2);
        }
    }
    cylinder(d=14.3, h=58);
    translate([-10,-2.25,48]) cube([4.5, 4.5, 10]);
    translate([-10,-50,10]) cube([4.5, 100, 8]);
 }