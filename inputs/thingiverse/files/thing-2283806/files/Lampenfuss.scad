// lamp foot center pin
//
// Title:        Parametric lamp foot
// Version:      1.007
// Release Date: 20170429 (ISO)
// Author:       David Larsson
//
// customizable insize

// #################################
// customizer notation by David Larsson 20170429

// foot pin diameter
pin_dia=12.7; // [6:22]

// foot pin length
pin_len=30; // [12:42]

//Diameter of screw holes
hole=2.3; // [1.2:4.6]

//Distance between screw holes
hole_dist=16.2; // [10:18]

// width of screw block
wi=10.2; // [6:22]

difference() {
    union() {

translate([0,0,-.4])
cylinder(pin_len,.9*pin_dia/2,.9*pin_dia/2,$fn=60);
cylinder(pin_len,pin_dia/2,pin_dia/2,$fn=60);
translate([0,0,pin_len])
    cylinder(3,3+pin_dia/2,3+pin_dia/2,$fn=20);
translate([0,0,41])
    cube([2*hole_dist,wi,18],center=true);
    }
color("red") {
translate([10,-wi/2-.5,32])
rotate([0,45,0])
    cube([wi+3,wi+1,16]);
translate([-pin_len,-wi/2-.5,pin_len])
rotate([0,45,0])
    cube([13,wi+1,16]);

translate([7,-wi/2-.5,52])
rotate([0,45,0])
    cube([16,wi+1,16]);
translate([-pin_len,-wi/2-.5,47])
rotate([0,45,0])
    cube([13,wi+1,19]);

translate([hole_dist/2,wi,41])
rotate([90,0,0])
    cylinder(pin_len,hole,hole,$fn=60);
translate([-hole_dist/2,wi,41])
rotate([90,0,0])
    cylinder(pin_len,hole,hole,$fn=60);
}
}

