// Filament Spool Hanging/Standing Mount
//
// Title:        Filament Spool Hanging/Standing Mount Frame
// Version:      1.007
// Release Date: 20170508 (ISO)
// Author:       David Larsson
// License:      Creative Commons - Attribution - Non-Commercial - Share Alike
//

// filament spool mount orientation
mo=1; // [0:"standing",1:"hanging"]

// mount height
he=130; // [120:140]

// leg thickness
th=4; // [4:6]

// diameter of spool carrying bolt
di=8; // [4:10]

//foot
difference() {
    translate([-20,0,0])
        cube([60,20,th]);
    union() {
        translate([30,20/2,-0.3])
            cylinder(20,2.5,2.5,$fn=30);
        translate([-10,20/2,-0.3])
            cylinder(20,2.5,2.5,$fn=30);
    }
}

//back support
translate([0,(20-th)/2,0])
    cube([th,th,he]);

//side support
translate([20-th,-.6,th/4])
    rotate([-4.1,-3,0])
        cube([th,th,he-20/2+th/6]);
color("green")
translate([20-th,20-th+.6,th/4])
    rotate([4.1,-3,0])
        cube([th,th,he-20/2+th/6]);

//1st back support
translate([th/4,20/2-th/2,th/4])
    rotate([13,30,0])
    cube([th/2,th/2,33-th]);
//color("red")
translate([th/4,20/2,th/4+.4])
    rotate([-13,30,0])
    cube([th/2,th/2,33-th]);

//2nd back support
translate([20-th,20-th,23])
    rotate([14,-28,0])
    cube([th/2,th/2,35-th]);
translate([20-th,th/2,23])
    rotate([-14,-28,0])
    cube([th/2,th/2,35-th]);

//3rd back support
translate([th/4,20/2-th/2,47])
    rotate([8,28,0])
    cube([th/2,th/2,30.5-1.5*th]);
translate([th/4,20/2,47])
    rotate([-8,28,0])
    cube([th/2,th/2,30.5-1.5*th]);

//4th back support
color("red")
translate([20-1.5*th,14-th/6,66])
    rotate([10,-30,0])
    cube([th/2,th/2,29-1.3*th]);
translate([20-1.5*th,5-th/6,66])
    rotate([-10,-30,0])
    cube([th/2,th/2,29-1.3*th]);

//hold grip
difference() {
  translate([20/2,(20+th)/2,he])
    rotate([90,0,0])
        cylinder(th,20/2,20/2);
color("red")
  translate([20/2,(20/2+th),he-di*.7/2+di/2-1])
    rotate([90,-40+mo*70,0]) {
   translate([0,-di/2,0])
       cube([he,di+.2,2*th]);
    cylinder(th+4,di/2,di/2);
    }
}

//hold grip print support
translate([20/2,(20)/2,he])
    rotate([90,0,0])
        cylinder(.4,20/2-.5,20/2-.5);

