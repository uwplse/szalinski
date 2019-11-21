$fn=64;
LEN=30;
DIST=30;
WIDTH=50;

module screw() {
    translate([0,0,-0.1]) {
        cylinder(d=9,h=5.1);
    }
    translate([0,0,4.9]){
        cylinder(d=4.5,h=10.2);
    }
}

module hole() {
    
}

module slot(length) {
    hull(){
        translate([0,0,-0.1]) {
            cylinder(d=4.2,h=8.1);
        }
        translate([0,length,0]) {
            translate([0,0,-0.1]) {
                cylinder(d=4.2,h=8.1);
            }
        }
    }
    hull(){
        translate([0,0,7.9]){
            rotate([0,0,30]){
                cylinder(d=8.2,h=7.2,$fn=6);
            }
        }
        translate([0,length,0]) {
            translate([0,0,7.9]){
                rotate([0,0,30]) {
                    cylinder(d=8.2,h=7.2,$fn=6);
                }
            }
        }
    }
}

module cutout_slot(){
    slot(LEN-22);
    translate([DIST,0,0]) {
        slot(LEN-22);
    }
}

module cutout_screw() {
    screw();
    translate([DIST,0,0]) {
        screw();
    }
}
module adapterplate() {
    width=((WIDTH-20)<DIST)?(DIST+20):WIDTH;

    difference(){
        cube([width,LEN,15]);
        union(){
            translate([((width-DIST) / 2.0), LEN-7,0]){
                cutout_screw();
            }
            translate([((width-DIST)/2.0) ,5,0]){
                cutout_slot();
            }
        }
    }
    
}

adapterplate();