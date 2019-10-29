module Drilling(height, radius, position = [0, 0, 0]) {
    translate(position) cylinder(h = height, r = radius);
}

module MirrorCopy(vector = [0, 1, 0]) {
    mirror (vector) children();
}

$fn = 50;

module RoundedRidge(length, radius = 1) {
    cylinder(h = length, r = radius);
}


module Baseplate() {
    cubeSize            = [5, 25, 20];
    cubePosition        = [-5, -30, 0];
    roundSize           = [1, 1, 20];
    roundLength         = 20;
    roundPosition       = [-4, -29, 0];
    drillingPosition    = [-10, 10, 0];
    drillingRotation    = [0, 90, 0];
    drillingHeight      = 5.00001;
    drillingRadius      = 2;
    
    translate(roundPosition) RoundedRidge(roundLength);
    
    translate(cubePosition) difference() {
        cube(cubeSize);
        cube(roundSize);
        rotate(drillingRotation) Drilling(drillingHeight, drillingRadius, drillingPosition, drillingRotation);
    }
}


module Pillar() {
    basisSize           = [35, 5, 20];
    basisPosition       = [-35, -10, 0];
    domeSize            = [10, 10, 20];
    roundSize           = [5, 5, 20];
    
    translate(basisPosition) difference() {
        union() {
            cube(basisSize);
            cube(domeSize);
        }
        cube(roundSize);
    }
}


module Arc() {
    roundLength         = 20;
    roundRadius         = 5;
    roundPosition       = [-30, -5, 0];
    
    union() {
        Pillar();
        translate(roundPosition) RoundedRidge(roundLength, roundRadius);
    }
}


module HalfBridge() {
    
    drillingHeight      = 20;
    drillingRadius      = 5;
    drillingPosition    = [-25, 0, 0];
    
    difference() {
        Arc();
        Drilling(drillingHeight, drillingRadius, drillingPosition);
    }
}


module DeskMount() {
    union() {
        Baseplate();
        HalfBridge();
    }
}



DeskMount();
MirrorCopy() DeskMount();