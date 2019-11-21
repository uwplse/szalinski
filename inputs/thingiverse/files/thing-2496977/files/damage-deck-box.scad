module panel(x,y,z)
{
    translate([x,y,z]) rotate([90,0,0]) {
    difference() {
        cube([30,30,1]);
        translate([0,14.5,0]) cube([30,1,1]);
        translate([14.5,0,0]) cube([1,30,1]);
        translate([15,15,0]) cylinder(h=1,r=3);
    }
    translate([15,15,0]) cylinder(h=1,r=2.5);
    }
}

l=70;
w=48;
h=30;
t=2;
difference() {
    union() {
    hull() {
    translate([1,1,1]) sphere(r=1);
    translate([1,1,h+t+1]) sphere(r=1);
    translate([l+t,1,h+t+1]) sphere(r=1);
    translate([l+t,1,1]) sphere(r=1);
    translate([1,w+t+1,1]) sphere(r=1);
    translate([1,w+t+1,h+t+1]) sphere(r=1);
    translate([l+t,w+t+1,h+t+1]) sphere(r=1);
    translate([l+t,w+t+1,1]) sphere(r=1);
    }
    panel(3.5,0,2);
    panel(40.5,0,2);
    panel(3.5,53,2);
    panel(40.5,53,2);
    }
    translate([0,-1,-15]) rotate([0,-45,0]) cube([2*l,w+2*t+3,l]);
    translate([t,t,t]) cube([l,w,h]);
}
difference() {
    union() {
        translate([0,1.5,1.5]) cube([50,.8,h+1]);
        translate([0,2+w,1.5]) cube([50,.8,h+1]);
        translate([0,2,1.5]) cube([50,w,.8]);
        translate([0,2,1.7+h]) cube([50,w,.8]);
    }
    translate([-9,-1,-10]) rotate([0,-45,0]) cube([2*l,w+2*t+3,l]);
}
