/*
 * by Luke Crevier 
 * version v0.1
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */


 // Parameter Section //
//-------------------//

// Length
l = 80;

// Width
w = 80;

// Height
h = 40;

// Thickness of bars
barDiam = 2;

// Wall bar multiplier
wallCoef = 1;

// Angle of the floor bars
floorAngle = 45;

// Floor multiplier
floorCoef = 2.5;

// Boolean to chamfer the corner posts
chamferCorners = false;

/* [Hidden] */

module cross(basewid, h_) {
    rotate([0,30,0])
    cube([barDiam,barDiam, (h_ / sin(60))]);
}

module wall(length, wid, h_, wallCoef = 1) {
    segment = tan(30) * h_;
    segMult = segment * 5;
    wallSegments = [ for(i = [0 - segMult : segment / wallCoef  : length]) i];
    for(i = [0, wid - barDiam]){
        for(j = wallSegments) {
            translate([j,i,])
            cross(segment, h_);
        }
    }
    oppSegments = [ for(i = [length + segMult : -segment / wallCoef : 0]) i];
    for(i = [0, wid - barDiam]){
        for(j = oppSegments) {
            translate([j,i,])
            mirror([180,0,0])
            cross(segment, h_);
        }
    }
}
module floor(ang = 30, scaler = 2) {
    segment = tan(ang) * w ; 
    seg3 = 2 * segment;
    floorSegments = [ for(i = [0 - seg3 : segment / scaler : l]) i];
    oppSegments = [ for(i = [l + seg3: -segment / scaler : 0]) i];
    for(i = floorSegments) {
        translate([i,0,0]){
            rotate([0,0,-ang])
            cube([barDiam, segment / sin(ang), barDiam/1.5]);
        }
    }


    for(i = oppSegments) {
        translate([i,0,0]){
            rotate([0,0,ang])
            cube([barDiam, segment / sin(ang), barDiam/1.5]);
        }
    }
}


module skeleton() {
    wall(l,w, h, wallCoef);
    rotate([0,0,90])
    mirror([0,180,0])
    wall(w,l, h, wallCoef);
}

module edges(length, width, height){
    difference() {
        cube([l,w,h]);  
        union() {
            translate([-l/2,barDiam,barDiam/1.5])
            cube([l* 2, w-barDiam*2, h-barDiam*1.5]);
            translate([barDiam, -w/2, barDiam/1.5])
            cube([l-barDiam*2, w*2, h-barDiam*1.5]);
            translate([barDiam, barDiam, -1/2 * h])
            cube([l-barDiam*2, w-barDiam*2, h*2]);
            
        }
    }
}

difference(){
    union() { 
        edges();
        intersection() {
            skeleton();
            cube([l,w,h]);        
        }
        intersection() {
            cube([l,w,h]);
            floor(floorAngle, floorCoef);
            
        }
    }
    if (chamferCorners == true) {
        chamferEdges();
    }
}

module chamferEdges () {
    for(i = [0, l + barDiam*1.8]){
        for(j = [0,w + barDiam*1.8]){
            echo(i);
            echo(j);
            translate([i-barDiam,j-barDiam,-1]){
                rotate([0,0,45])
                translate([-barDiam*2,-barDiam*2,0])
                cube([barDiam*4,barDiam*4,h+2]);
            }
        }
    }
}