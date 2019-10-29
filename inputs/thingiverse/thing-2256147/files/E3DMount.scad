$fn=50;
DIST_MNT_HOLE=30;
BLOCK_LEN=40;
module e3d_mount() {
    union(){
        translate([0,0,-0.1]) {
            cylinder(d=16,h=3.1);
        }
        translate([0,0,2.9]) {
            cylinder(d=12,h=6.2);
        }
        translate([0,0,9]) {
            cylinder(d=16,h=4.1);
        }
    }
}

module xmount() {
    union() {
        translate([0,0,-0.1]) {
            cylinder(d=4.2,h=25.2);
        }
        translate([0,0,10]) {
            rotate([0,0,30]) {
                cylinder(d=8.5,h=8,$fn=6);
                }
        }
    }
}

module jmount(){
    union() {
        translate([0,0,-0.1]) {
            cylinder(d=7,h=3.1);
        }
        translate([0,0,2.9]) {
            cylinder(d=3.2,h=22.2);
        }
        translate([0,0,20]) {
            rotate([0,0,30]) {
                cylinder(d=7,h=5.2,$fn=6);
                }
        }
    }
}

module cutout(){
    translate([0,0,10]) {
        rotate([-90,0,0]){
            e3d_mount();
        }
    }
    translate([8,6,0]) {
        jmount();
    }
    translate([-8,6,0]) {
        jmount();
    }

    translate([DIST_MNT_HOLE/2.0,6.5,0]){
        xmount();
    }
    translate([-(DIST_MNT_HOLE/2.0),6.5,0]){
        xmount();
    }
}

module mount(){
    difference(){
        translate([-(BLOCK_LEN/2.0),0,0]){
            cube([BLOCK_LEN,13,25]);
        }
        cutout();
    }
}

module top(){
    difference(){
        mount();
        translate([-(BLOCK_LEN/2.0+0.1),-0.1,10]) {
            cube([BLOCK_LEN+0.2,13.2,15.1]);
        }
    }
}

module bottom(){
    difference(){
        mount();
        translate([-(BLOCK_LEN/2.0+0.1),-0.1,-0.1]) {
            cube([BLOCK_LEN+0.2,13.2,10.11]);
        }
    }
}

{//color("Silver") {
    translate([0,1,0]) {
        top();
    }

    translate([0,-1,25]) {
        rotate([180,0,0]){
            bottom();
        }
    }
}