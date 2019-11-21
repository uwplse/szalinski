// Adapter Tool Rig
// (c) 2018 Harald Mühlhoff, 58300 Wetter

// Width
a = 51;

// Height Top
b = 15;

// Length Top
c = 40;

// Length Side
d = 40;

// Thickness Side
e = 3;

// Diameter Screw Holes
f= 2;

// Height Screw Holes
g = b -2;

// Thickness Makrolon
h = 4;

// Vertical gap
i = 1;

// Height Side Connection
j = 12;

$fn=50;

// Top
difference() {
    cube([a, c, b]);
    
    union() {
        // Screw Holes
        
        ScrewHole();
        
        translate([13, 0, 0])
        ScrewHole();
    }
}


module ScrewHole() {
    translate([f/2 + 24, f/2 + 6, b-g])
    cylinder(d=f, h = g);
}


// Side
translate([0, 0, -d])
cube([a, e, d]);


// Side2
translate([0, -h-e, -d])
cube([a, e, d]);

// Side connection
difference() {
    translate([0, -h-e, -i-h])
    cube([a, 2*e + h, j]);

    // "Hack"
    translate([0, (-h-e), 0])
    rotate([45, 0, 0])
    #cube([a, 2*e + h, j]);
}


