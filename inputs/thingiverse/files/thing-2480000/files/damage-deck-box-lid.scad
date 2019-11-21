l=84;
w=48;
h=30;
t=2;

//translate([0,t,50]) {
    difference() {
    cube([l-t,w,t]);
    rotate([45,0,0]) cube([l,2*t,2*t]);
    translate([0,w,0]) rotate([45,0,0]) cube([l,2*t,2*t]);
    }
//}

translate([22,7,t]) scale([0.8,0.8,1.0]) import("empire.stl");