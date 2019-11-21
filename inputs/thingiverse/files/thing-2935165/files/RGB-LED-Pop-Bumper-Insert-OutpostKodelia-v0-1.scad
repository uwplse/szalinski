/////////////////////////////
// LED Holder for Pirahna Super-Flux RGB LEDs and Williams/Bally Pop Bumper Bodies
//
// Created by Outpost Kodelia (https://www.thingiverse.com/OutpostKodelia)
// License: Creative Commons - Attribution
//
// This is designed to fit in the standard Williams/Bally pop bumper body and mount
// a Pirahna Super-flux RGB LED bulb. It uses stock screws/holes to mount and to
// run the wires through to the bottom of the playfield.
//
// Install the bulb on the side with the triangle mark. Align the corner notch on the
// LED with the triangle. On the back side, solder wires perpendicular to the 
// terminals according to the labels. Then route the wires through the neighboring 
// holes* so they are now coming out the top of the adapter. Remove your old light 
// and the screws that hold the bumper down. Now run the wires down through the 
// body's wire holes. Snug the wires up and screw it down with the original screws, 
// aligning the countersunk screw holes with the original screw holes. Wire up to 
// your controller and enjoy!
//
// *  Some pop bumper bodies may not have the raised rings around the wire holes. If
//    yours don't have the raised rings, you can route the wires directly from the
//    soldered pins down into the body's wire holes.
// ** Depending on your original screw length, you may need to use screws that are 
//    up to 1/8" (or 4mm) longer to account for the extra height.
//
// Recommend using 26ga wire to ensure all four wires fit through the two wire holes.
// Should also work with any other RGB LED with 5mm square pin spacing.
//
// v0.1 - Initial creation.
//
// Print recommendations:
// - Supports: No
// - Reduce speed to improve accuracy and reduce strings around small details
// - Print at high resolution
// 
// This should work with the following Williams/Bally parts:
//  - 03-7443-5
//  - 3A-7443
//  - Wico 19-0155
//  - 545-5199-00
/////////////////////////////

// Set high number of sides for smooth curvature
$fn=180;

difference() {
    // Create the main body
    union() {
        // Main platform
        translate([0, 0, -1])
            cylinder(2, d=26, center=false);
        
        // Support struts
        translate([-5, 9, .5])
            color("orange")
            cube([10, 2, 2.5]);
        
        translate([-5, -11, .5])
            color("orange")
            cube([10, 2, 2.5]);
        
        translate([6, -4, .5])
            color("orange")
            cube([2, 4, 2.5]);
        
        translate([-8, 0, .5])
            color("orange")
            cube([2, 4, 2.5]);
    }
    
    // Remove the side notches
    translate([-16, 0, -1.5])
        cylinder(3, d=15, center=false);
    
    translate([16, 0, -1.5])
        cylinder(3, d=15, center=false);
    
    // Remove the bumper body holes
    translate([-7.778, -7.778, -1.5])
        cylinder(3, d=5, center=false);
    
    translate([-7.778, 7.778, -1.5])
        cylinder(3, d=5, center=false);
    
    translate([7.778, -7.778, -1.5])
        cylinder(3, d=5, center=false);
    
    translate([7.778, 7.778, -1.5])
        cylinder(3, d=5, center=false);
    
    // Remove screw head countersinks
    translate([7.778, -7.778, -4.5])
        sphere(d=10);
    
    translate([-7.778, 7.778, -4.5])
        sphere(d=10);
    
    // Remove the RGB LED pin holes
    translate([-2.5, -2.5, -1.5])
        cylinder(3, d=1, center=false);
    
    translate([-2.5, 2.5, -1.5])
        cylinder(3, d=1, center=false);
    
    translate([2.5, -2.5, -1.5])
        cylinder(3, d=1, center=false);
    
    translate([2.5, 2.5, -1.5])
        cylinder(3, d=1, center=false);
        
    // Remove the RGB LED pin notches
    translate([-3, -3.75, -1.5])
        cube([1, 2.5, 1.5]);

    translate([2, -3.75, -1.5])
        cube([1, 2.5, 1.5]);
        
    translate([2, 1.25, -1.5])
        cube([1, 2.5, 1.5]);
        
    translate([-3, 1.25, -1.5])
        cube([1, 2.5, 1.5]);
    
    // Remove the wire return holes
    translate([-6.5, -2, -1.5])
        cylinder(3, d=2, center=false);
    
    translate([-2, 6.5, -1.5])
        cylinder(3, d=2, center=false);
    
    translate([2, -6.5, -1.5])
        cylinder(3, d=2, center=false);
    
    translate([6.5, 2, -1.5])
        cylinder(3, d=2, center=false);
    
    // Remove lettering for pin placement guides
    color("red")
        translate([-4.5, -4.5, .5])
        linear_extrude(1)
        text(text="R", font="Arial Bold", size=3, halign="center", valign="center");
        
    color("green")
        translate([4, -4.5, .5])
        linear_extrude(1)
        text(text="G", font="Arial Bold", size=3, halign="center", valign="center");
        
    color("blue")
        translate([4, 4.5, .5])
        linear_extrude(1)
        text(text="B", font="Arial Bold", size=3, halign="center", valign="center");

    color("black")
        translate([-4, 4.5, .5])
        linear_extrude(1)
        text(text="+", font="Arial Bold", size=3, halign="center", valign="center");
        
    // Remove the marker for the RGB LED notched corner
    polyhedron(
        points=[
            [.5,   .5,   -1.5], //0
            [.5,   2.5, -1.5], //1
            [2.5, .5,   -1.5], //2
            [.5,   .5,   -.5], //3
            [.5,   2.5, -.5], //4
            [2.5, .5,   -.5]  //5
    ], faces=[
            [0, 2, 1],
            [3, 4, 5],
            [0, 3, 5, 2],
            [1, 4, 3, 0],
            [5, 4, 1, 2]
    ]);
}