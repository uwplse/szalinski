$fn=50;
union(){
    union(){
        cube([45,20,1]);
        translate([9,10,0])cylinder(d=16,h=15);
        translate([45-9,10,0])cylinder(d=16,h=15);
        translate([45/2-7/2, 20-1-3/2,0])hull(){
            cylinder(d=3, h=5);
            translate([7,0,0])cylinder(d=3, h=5);
            }
    }
    translate([1.5,1.5,0])cylinder(d=1.5,h=16);
    translate([45-1.5,1.5,0])cylinder(d=1.5,h=16);
    translate([1.5,20-1.5,0])cylinder(d=1.5,h=16);
    translate([45-1.5,20-1.5,0])cylinder(d=1.5,h=16);
}