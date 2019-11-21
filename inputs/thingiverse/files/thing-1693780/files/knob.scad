// Base width at top
W=30;

// Base width at bottom
BW=60;

// Base height
H=5;

// Number of edges
FN = 12;

// Diameter of hole
ID=7;

// Hole edge offset
EDGE=1.5;

// Handle height
HH = 30;

// Handle width
HW = 4;

// HANDLE X-AXIS SCALE
HXAS = 1.5;

union(){
    difference(){
        cylinder(d1=BW,d2=W,h=H,$fn=FN);
        translate([0,0,-1])cylinder(d=ID,h=H+2,$fn=60);
    }
    x = 1;
    translate([ID-EDGE,0,H/2])cube([ID,ID,H],true);
    difference(){
        scale([HXAS,1,1])translate([0,HW/2,H/2])rotate([90,0,0])cylinder(d=HH,h=4,$fn=60);
        translate([0,0,-HH+H])cylinder(d1=BW*3,d2=HH+2,h=HH,$fn=12);
    }
    translate([HH*HXAS/2,0,H/2+.05])rotate([0,0,45])cube([3,3,H],true);
}