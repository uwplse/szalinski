$fn = 100;
screwHoleD = 3.5;
frameHoleOffset = 20;
mosfetOffsetV = 42;
mosfetOffsetH = 52;
frameOffset = -25;

mosfetPlate();

module screwHole() {
   cylinder(h=20, d=screwHoleD, center=true);
}
module screwTunnel() {
        translate([0,0,-2]) cylinder(h=4, d=screwHoleD+4, center=true);
}

module mosfetPlate() {
difference() {
union() {
    translate([0,0,0]) screwTunnel();
    translate([mosfetOffsetV,mosfetOffsetH,0]) screwTunnel();
    translate([0,mosfetOffsetH,0]) screwTunnel();
    translate([mosfetOffsetV,0,0]) screwTunnel();
    translate([frameHoleOffset,frameOffset,0]) screwTunnel();
    translate([0,frameOffset,0]) screwTunnel();
    hull() {
        cylinder(h=2, d=screwHoleD+4, center=true);
        translate([mosfetOffsetV,mosfetOffsetH,0])  cylinder(h=2, d=screwHoleD+4, center=true);
    }
    hull() {
        translate([0,mosfetOffsetH,0])  cylinder(h=2, d=screwHoleD+4, center=true);
        translate([mosfetOffsetV,0,0]) cylinder(h=2, d=screwHoleD+4, center=true);
    };
    hull() {
        translate([0,frameOffset,0]) cylinder(h=2, d=screwHoleD+4, center=true);
        translate([frameHoleOffset,frameOffset,0]) cylinder(h=2, d=screwHoleD+4, center=true);
    }
    hull() {
        translate([0,frameOffset,0]) cylinder(h=2, d=screwHoleD+4, center=true);
        translate([0,mosfetOffsetH,0]) cylinder(h=2, d=screwHoleD+4, center=true);
    }
    hull() {
        translate([mosfetOffsetV,0,0]) cylinder(h=2, d=screwHoleD+4, center=true);
        translate([frameHoleOffset,frameOffset,0]) cylinder(h=2, d=screwHoleD+4, center=true);
    }
}
union() {
    translate([0,0,0]) screwHole();
    translate([mosfetOffsetV,mosfetOffsetH,0]) screwHole();
    translate([0,mosfetOffsetH,0]) screwHole();
    translate([mosfetOffsetV,0,0]) screwHole();
    translate([0,frameOffset,0]) screwHole();
    translate([frameHoleOffset,frameOffset,0]) screwHole();
}
}
}
