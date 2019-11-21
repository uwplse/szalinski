offset=10; // explosion offset
a=20; // roof angle
l=188; // length
w=168/cos(a); // width
t=3; // roof thickness

difference(){
    rotate([a,0,0]) difference() {
        cube([l,w/2,t]);
        for(x=[0:4:w/2]) translate([0,x,t]) rotate([-10,0,0]) cube([l,4,t]);
    }
    translate([0,cos(a)*w/2-sin(a)*t,sin(a)*w/2-t]) cube([l,t*2,t*2]);
}

translate([l,cos(a)*(w-t)+offset,0]) rotate([0,0,180]) difference(){
    rotate([a,0,0]) difference() {
        cube([l,w/2,t]);
        for(x=[0:4:w/2]) translate([0,x,t]) rotate([-10,0,0]) cube([l,4,t]);
    }
    translate([0,cos(a)*w/2-sin(a)*t,sin(a)*w/2-t]) cube([l,t*2,t*2]);
}