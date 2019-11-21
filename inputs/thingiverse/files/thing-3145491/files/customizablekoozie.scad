//actual can hegiht
h=122.682;

//uniform diameter of can
d=66.04;

//diameter of top of can
dt=54.102;

//height of lip
hl=10;

//upper lid height
hu=45;

//height of cup
hc=h-hl-hu;

//resolution
$fn=500;

module can() {
    difference () {
    cylinder (hc,d+3,d+3, false);
    translate([0,0,3])
    cylinder(hc,d,d, false);
    }
}

module cap() {
    difference(){
    translate ([0,0,h-hl])
    cylinder(hl,d+3,dt+3,false);
    translate([0,0,h-hl-.1])
    cylinder(hl+.2,d,dt,false);
    }
    difference(){
    translate([0,0,hc+hl])
    cylinder(hu-hl,d+3,d+3,false);
    translate([0,0,hc+hl-.1])
    cylinder(hu-hl+.5,d,d,false);
    }
}

module lower_joint() {
    difference(){
    translate([0,0,hc])
    cylinder(15,5+d,5+d,false);
    translate([0,0,hc-.5])
    cylinder(15+1,d,d,false);
    translate([0,0,hc+10])
    cylinder(4+1.01,2.5+d,2.5+d,false);
}
}

module upper_joint() {
    difference(){
    translate([0,0,hc+15/2])
    cylinder(15/2,5+d,5+d,false);
    translate([0,0,hc+15/2-.5])
    cylinder(15/2+1,d,d,false);
    }
}

module connector() {
    union(){
    upper_joint();
    difference(){
    translate([0,0,hc+15/2-4])
    cylinder(4,2.5+d,2.5+d,false);
    translate([0,0,hc+15/2-4.5])
    cylinder(4+1,d,d,false);
    }
    }
}
module bottom() {
    union(){
        can();
        lower_joint();
    }
}
module top(){
    rotate([180,0,0])
    translate([175,0,-h])
    union(){
        cap();
        upper_joint();
        connector();
    }
}
bottom();
top();