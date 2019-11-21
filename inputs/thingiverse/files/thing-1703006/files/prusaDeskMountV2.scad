$fn = 360;

module Drilling(height, radius, position = [0, 0, 0], rotation = [0, 0, 0]) {
    rotate(rotation) translate(position) cylinder(h = height, r = radius);
}

module RoundedRidge(length, radius = 1) {
    cylinder(h = length, r = radius);
}

module Baseplate() {
    size = [40, 20, 5];
    position = [-40, -24, 0];
    
    drillingHeight = 5;
    drillingRadius = 2;
    
    roundSize           = [40, 1, 1];
    roundLength         = 20;
    roundPosition       = [-39, -19, 0];
    
    drillingPositionOne = [13.3333, 7.5, 0];
    drillingPositionTwo = [26.6667, 7.5, 0];
    
    translate(position) difference() {
        cube(size);
        Drilling(drillingHeight, drillingRadius, drillingPositionOne);
        Drilling(drillingHeight, drillingRadius, drillingPositionTwo);
    }
}

module FrontplatePolyhedron() {
    points = [
        [0,0,0],    // 0
        [17.2,0,0], // 1
        [17.2,5,0], // 2
        [0,5,0],    // 3
        [0,0,5],    // 4
        [0,5,5]     // 5
    ];
    faces = [
        [0,1,2,3],  // Bottom
        [4,5,2,1],  // Top
        [0,3,5,4],  // Plate
        [0,4,1],    // Outer
        [3,2,5]     // Inner
    ];
    size = [17.8, 5, 5];
    position = [17.8, 0, 0];
    
    union() {
        cube(size);
        translate(position) polyhedron(points,faces);
    }
}

module Frontplate() {
    size = [35, 5, 25];
    position = [-35, -9, 5];
    
    drillingHeight = 5;
    drillingRadius = 4;
    
    drillingPosition = [22, 20, -5];
    drillingRotation = [90, 0, 0];
    
    polyhedronPosition = [0, 0, 25];
    
    translate(position) difference() {
        union() {
            cube(size);
            translate(polyhedronPosition) FrontplatePolyhedron();
        }
        Drilling(drillingHeight, drillingRadius, drillingPosition, drillingRotation);
    }
    
    
}

module Sideplate() {
    size = [5, 9, 35];
    position = [-40, -9, 0];
    
    translate(position) cube(size);
}

module DeskMountV2() {

    // Bodenplatte inkl. zwei Bohrungen
    color("Red") Baseplate();
    
    // Frontplatte
    color("Blue") Frontplate();
    
    // Seitenplatte
    color("Green") Sideplate();
}

rotate([0, -90, 0]) translate([40, 0, 0]) mirror([0, 0, 0]) DeskMountV2();
rotate([0, -90, 0]) translate([40, 0, 0]) mirror([0, 1, 0]) DeskMountV2();