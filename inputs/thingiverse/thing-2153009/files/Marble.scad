// Parametric customizable marble.
// Originally designed for the 3D Marble maze

// Copyright 2017 - Robert Baumstark <rbaumstark@gmail.com>


// 3/8" = 9.525 mm

// Diameter of the marble to create (3/8" = 9.525 mm)
marble_diameter = 9.525;

// How to print the marble - in parts does not require support.
print_method = 0; // [1:Whole,0:Parts]

// Also print a pin to align the parts, and a slot for it to go into?
print_pin = 1; // [1:Yes,0:No]

// Tolerance to leave for the pin
pin_tolerance = 0.3;

/* [Hidden] */

// Save a lot of typing...
md = marble_diameter;

// pin diameter
pd = (md/3) - pin_tolerance;


if (print_method) {
    sphere(d=md, $fn=128);
} else {
    difference() {
        union() {
            sphere(d=md, $fn=128);
            translate([md*1.5,0,0]) sphere(d=md, $fn=128);
        }
        translate([-md,-md,-md*2]) cube([md*5,md*2,md*2]);
        if (print_pin) {
            cylinder(d=pd,h=md/3,$fn=6);
            translate([md*1.5,0,0]) cylinder(d=pd,h=md/3,$fn=6);
        }
    }
    if (print_pin) translate([md*0.75,md/2,0]) cylinder(d=pd,h=pd*2,$fn=6);
}