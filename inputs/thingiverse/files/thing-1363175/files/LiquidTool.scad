$fn = 100;

A = 2;
B = 11;
C = 40;
D = 8;
E = 50;
F = 2;
G = 10;
H = 13;
J = 60;
K = 10;
L = 60;
N = 20;

difference() {
    cube([J,N,F]);
    translate([0,(N/2)+(G/2),0]) rotate([0,0,atan(((N/2)-(G/2))/H)]) cube([10000,10000,10000]);
    translate([0,(G/2),0]) rotate([0,0,270-atan(((N/2)-(G/2))/H)]) cube([10000,10000,10000]);
}

translate([0,(N/2)-(G/2),0]) cube([H,G,K]);

translate([J,N/2,0]) difference() {
    cylinder(r1=E,r2=E-(tan(90-L)*F),h=F);
    rotate([0,0,asin((C/2)/E)]) cube([10000,10000,10000]);
    rotate([0,0,270-asin((C/2)/E)]) cube([10000,10000,10000]);
    translate([-10000,-5000,0]) cube([10000,10000,10000]);
}

translate([J,0,0]) cube([(N/2)/tan(asin((C/2)/E)),N,F]);

translate([-(E-(E*sin(acos((B/2)/E)))),0,0]) translate([J,(N/2)-(B/2),0]) difference() {
    cube([E+D,B,F]);
    translate([E+D,0,0]) rotate([0,-(90-L),0]) translate([0,0,-5000]) cube([10000,10000,10000]);
    translate([E+D,(B/2)+(A/2),0]) rotate([0,-(90-L),90-(atan(((B/2)-(A/2))/D))]) translate([0,0,-5000]) cube([10000,10000,10000]);
    translate([E+D,(B/2)-(A/2),0]) rotate([90,-(90-L),-(90-(atan(((B/2)-(A/2))/D)))]) translate([0,-5000,-5000]) cube([10000,10000,10000]);
}
