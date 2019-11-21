// Adjustable Params

// The diamater of the base plate
baseDiameter = 40; // [1:200]

// The height of the base plate
baseHeight = 2; // [1:20]

// The length of the cup wall
cupLength = 10; // [1:20]

// The thickness of the cup wall
cupThickness = 1; // [0:10]

// The angle of the cup
cupAngle = 45; // [15:75]

// The height of the ring pole
poleHeight = 50; // [10:200]

// The diameter of the pole of at the base
poleStartingDiameter = 15; // [5:100]

// The diameter of the pole at the top
poleEndingDiameter = 8; // [5:100]

// The mimimum size of an edge (smaller is smoother)
$fs = .25;

// The mimimum angle between two edges (smaller is smoother)
$fa = 1;


union() {
    // Base
    linear_extrude(baseHeight / 2)
    circle(d=baseDiameter);

    // Cup
    rotate_extrude(angle=360)
    translate([baseDiameter/2, 0 ,0])
    rotate([0, 180, -45])
    union() {
        // Wall
        square([cupThickness, cupLength], false);
       
        // Cap
        translate([cupThickness, cupLength, 0])
        circle(cupThickness);
    }
    

    // Pole
    union() {
        // Pillar
        translate([0, 0, baseHeight/2])
        cylinder(poleHeight, d1=poleStartingDiameter, d2=poleEndingDiameter);

        // Cap
        translate([0, 0, baseHeight/2 + poleHeight])
        sphere(poleEndingDiameter/2);
    }
    
}
