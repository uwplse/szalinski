//Spray extender
module side() {
    difference(){
        union(){
            cube([60,7,90],center=true);
    translate([52-32,0,0]) cylinder(h=90,d=24+8,center=true);
        translate([-
    (52-20.5-8),0,0]) cylinder(h=90,d=20.5+8,center=true);
        }
            translate([52-32,0,0]) cylinder(h=92,d=24,center=true);
             translate([-
    (52-20.5-8),0,0]) cylinder(h=92,d=20.5,center=true);
        translate([-2,0,0]) rotate([90,0,0]) cylinder(h=9,d=7,center=true);
        translate([0,-25,0]) cube([80,50,92],center=true);
        }
}

side();