// Tetris Style
style = 7; // [7: Tetris,21: SuperTetris,32: UltraTetris]

run = "all"; // [piece:Single Piece, background: Background Image Generator, all: All Pieces]

//Red
r = 250; // [0:255]
//Green
g = 128; // [0:255]
//Blue
b = 128; // [0:255]
//Piece Number 1-7
Tetris = 1; // [1:7]
//Piece Number 8-21
SuperTetris = 8; // [8:21]
////Piece Number 22-32
UltraTetris = 22; // [22:32]

run(run);

module run(run) {
    if (run == "piece") {
        if (style == 7) {
            num = Tetris;
            color([a(r),a(g),a(b)]) select(num);
        }
        else if (style == 21) {
            num = SuperTetris;
            color([a(r),a(g),a(b)]) select(num);
        }
        else if (style == 32) {
            num = UltraTetris;
            color([a(r),a(g),a(b)]) select(num);
        }
    }
    else if (run == "background") {
        background();
    }
    if (run == "all") {
        for (num = [1:style]) {
            translate([num*250,0,0]) rotate([0,0,90]) color(c()) select(num);
        }
    }
}
//random piece selector
function r() = round(rands(1,style,1)[0]);
//color gen
function c() = [rands(0,255,1)[0]/256,rands(0,255,1)[0]/256,rands(0,255,1)[0]/256];
//color segement gen
function a(a) = a/256;
//Background Generator
module background() {
    for (x = [1:16]) {
        for (y = [1:8]) {
           color(c()) translate([x*500,y*500,0]) rotate([180,180,0]) rotate([x*22.5,y*45,0]) select(r());
        }
    }
}
//Piece Selector
module select(piece) {
    //original tetris pieces
    if (piece == 1) {
        Ipiece();
    }
    else if (piece == 2) {
        Lpiece();
    }
    else if (piece == 3) {
        Jpiece();
    }
    else if (piece == 4) {
        Spiece();
    }
    else if (piece == 5) {
        Zpiece();
    }
    else if (piece == 6) {
        Opiece();
    }
    else if (piece == 7) {
        Tpiece();
    }
    //super tetris pieces
    else if (piece == 8) {
        BigIpiece();
    }
    else if (piece == 9) {
        BigLpiece();
    }
    else if (piece == 10) {
        BigJpiece();
    }
    else if (piece == 11) {
        BigL2piece();
    }
    else if (piece == 12) {
        BigJ2piece();
    }
    else if (piece == 13) {
        BigSpiece();
    }
    else if (piece == 14) {
        BigZpiece();
    }
    else if (piece == 15) {
        BigPpiece();
    }
    else if (piece == 16) {
        BigQpiece();
    }
    else if (piece == 17) {
        BigTpiece();
    }
    else if (piece == 18) {
        BigTZpiece();
    }
    else if (piece == 19) {
        BigTSpiece();
    }
    else if (piece == 20) {
        CapTpiece();
    }
    else if (piece == 21) {
        Upiece();
    }
    //ultra tetris pieces
    else if (piece == 22) {
        DLpiece();
    }
    else if (piece == 23) {
        TLpiece();
    }
    else if (piece == 24) {
        TJpiece();
    }
    else if (piece == 25) {
        TTpiece();
    }
    else if (piece == 26) {
        LJpiece();
    }
    else if (piece == 27) {
        JLpiece();
    }
    else if (piece == 28) {
        DL2piece();
    }
    else if (piece == 29) {
        TL2piece();
    }
    else if (piece == 30) {
        TT2piece();
    }
    else if (piece == 31) {
        LJ2piece();
    }
    else if (piece == 32) {
        JL2piece();
    }
}
//Cube for each segement of a piece
module cube() {
    hull() {
        linear_extrude(45) offset(5) square(50,true);
        translate([-22,0,22]) rotate([0,90,0]) linear_extrude(45) offset(5) square(50,true);
    }
}
//Pieces
//original tetris pieces
module Ipiece() {
    for (i = [1:4]) {
        translate([i*55,0,0]) cube();
    }
}

module Lpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([3*55,55,0]) cube();
}

module Jpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([3*55,-55,0]) cube();
}

module Spiece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,55,0]) cube();
    translate([2*55,-55,0]) cube();
}

module Zpiece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,-55,0]) cube();
    translate([2*55,55,0]) cube();
}

module Opiece() {
    for (x = [1:2]) {
        for (y = [1:2]) {        
            translate([x*55,y*55,0]) cube();
        }
    }
}

module Tpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,55,0]) cube();
}
//super tetris pieces
module BigIpiece() {
    for (i = [1:5]) {
        translate([i*55,0,0]) cube();
    }
}

module BigLpiece() {
    for (i = [1:4]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,-55,0]) cube();
}

module BigJpiece() {
    for (i = [1:4]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,55,0]) cube();
}

module BigL2piece() {
    for (i = [1:4]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,-55,0]) cube();
}

module BigJ2piece() {
    for (i = [1:4]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,55,0]) cube();
}

module BigSpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,55,0]) cube();
    translate([3*55,-55,0]) cube();
}

module BigZpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,-55,0]) cube();
    translate([3*55,55,0]) cube();
}

module BigPpiece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    for (i = [1:2]) {
        translate([i*55,55,0]) cube();
    }
    translate([2*55,2*55,0]) cube();
}

module BigQpiece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    for (i = [1:2]) {
        translate([i*55,55,0]) cube();
    }
    translate([2*55,-55,0]) cube();
}

module BigTpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,-55,0]) cube();
    translate([2*55,55,0]) cube();
}

module BigTZpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,-55,0]) cube();
    translate([3*55,55,0]) cube();
}

module BigTSpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([3*55,-55,0]) cube();
    translate([2*55,55,0]) cube();
}

module CapTpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([3*55,-55,0]) cube();
    translate([3*55,55,0]) cube();
}

module Upiece() {
    for (i = [1:3]) {
        translate([i*55,55,0]) cube();
    }
    translate([3*55,0,0]) cube();
    translate([55,0,0]) cube();
}
//ultra tetris pieces
module DLpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,-55,0]) cube();
    translate([55,0,55]) cube();
}

module TLpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,-55,0]) cube();
    translate([55,0,-55]) cube();
}

module TJpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,-55,0]) cube();
    translate([55,0,55]) cube();
}

module TTpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,-55,0]) cube();
    translate([2*55,0,-55]) cube();
}

module LJpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,-55,0]) cube();
    translate([3*55,0,-55]) cube();
}

module JLpiece() {
    for (i = [1:3]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,55,0]) cube();
    translate([3*55,0,-55]) cube();
}

module DL2piece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,-55,0]) cube();
    translate([55,0,55]) cube();
}

module TL2piece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,-55,0]) cube();
    translate([55,0,-55]) cube();
}

module TT2piece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    translate([2*55,-55,0]) cube();
    translate([2*55,0,-55]) cube();
}

module LJ2piece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,-55,0]) cube();
    translate([2*55,0,-55]) cube();
}

module JL2piece() {
    for (i = [1:2]) {
        translate([i*55,0,0]) cube();
    }
    translate([55,55,0]) cube();
    translate([2*55,0,-55]) cube();
}