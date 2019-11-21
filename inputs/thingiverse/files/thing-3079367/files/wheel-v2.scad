/*
Author: Jose Lopez, JoLoCity
Date: 9/4/2018
www.jolocity.com
*/


WHEEL_HEIGHT = 25;

WHEEL_RADIUS_INNER_R1 = 5;
WHEEL_RADIUS_INNER_R1_SIDES = 32;
WHEEL_RADIUS_INNER_R2 = 30;
WHEEL_RADIUS_INNER_R2_SIDES = 32;

WHEEL_RADIUS_OUTER_R1 = 60;
WHEEL_RADIUS_OUTER_R1_SIDES = 16;
WHEEL_RADIUS_OUTER_R2 = 73;
WHEEL_RADIUS_OUTER_R2_SIDES = 16;

WHEEL_TREAD_DEPTH = 5;
WHEEL_TREAD_HEIGHT = 27;
WHEEL_TREAD_WIDTH = 5;
WHEEL_TREAD_COUNT = 48;

SPOKE_COUNT = 12;
SPOKE_DIAMETER=12;
SPOKE_HEIGHT=WHEEL_RADIUS_OUTER_R1;
SPOKE_START = 6;
SPOKE_SIDES = 6;

INDENT_COUNT = 6;
INDENT_DISTANCE = 15;
INDENT_SIZE = 5;

WHEEL_INSERT_RADIUS = 10;
WHEEL_INSERT_SIDES = 64;
WHEEL_INSERT_HEIGHT = 10;
WHEEL_INSERT_CENTER_OFFSET = 15 ;

// Main
Treads(WHEEL_TREAD_COUNT, WHEEL_RADIUS_OUTER_R2);
WheelR2();

// indents & bearings

difference() {
    union(){
        WheelR1();
        Spokes(SPOKE_DIAMETER, SPOKE_HEIGHT, SPOKE_START, SPOKE_COUNT, SPOKE_SIDES);
    }
    Indents(INDENT_COUNT, INDENT_DISTANCE, INDENT_SIZE);
    Bearing(WHEEL_INSERT_HEIGHT, WHEEL_INSERT_RADIUS, WHEEL_INSERT_SIDES, WHEEL_INSERT_CENTER_OFFSET);
}

module Bearing(height, radius, sides, center_offset) {
    color("cyan")
        translate([0, 0, center_offset])
            cylinder(h=height, r=radius, center=false, $fn=sides);
}

module Indents(count, distance, size) {
    instances = 360/count;
    for(angle = [0 : instances : 360]){
        y = sin(angle) * distance;
        x = cos(angle) * distance;
        translate([x,y,0]) 
            rotate([0,0,angle+90])
                Indent(size);
    }
}
module Indent(size) {
    color("Red")
        translate([15,0,WHEEL_HEIGHT/2])
            sphere(5);

        translate([15,0,-1*WHEEL_HEIGHT/2])
            sphere(size);
}    


module WheelR1() {
    color("Green")
        difference() {
            cylinder(h=WHEEL_HEIGHT, r=WHEEL_RADIUS_INNER_R2, center=true, $fn=WHEEL_RADIUS_INNER_R2_SIDES);
            cylinder(h=WHEEL_HEIGHT+1, r=WHEEL_RADIUS_INNER_R1, center=true, $fn=WHEEL_RADIUS_INNER_R1_SIDES);
        }
}
module WheelR2() {
    color("Purple")
        difference() {
            cylinder(h=WHEEL_HEIGHT, r=WHEEL_RADIUS_OUTER_R2, center=true, $fn=WHEEL_RADIUS_OUTER_R2_SIDES);
            cylinder(h=WHEEL_HEIGHT+1, r=WHEEL_RADIUS_OUTER_R1, center=true, $fn=WHEEL_RADIUS_OUTER_R1_SIDES);
        }
}
module Treads(count) {
    instances = 360/count;
    for(angle = [0 : instances : 360]){
        y = sin(angle) * (WHEEL_RADIUS_OUTER_R2);
        x = cos(angle) * (WHEEL_RADIUS_OUTER_R2);
        translate([x,y,0]) 
            rotate([0,0,angle+90])
                Tread(WHEEL_TREAD_WIDTH, WHEEL_TREAD_DEPTH, WHEEL_TREAD_HEIGHT);
    }
}    

module Tread(w, d, h) {
    // back support
    color("LightBlue")       
        cube([w,d,h],center=true);
}

module Spokes(radius, height, start, count, sides) {
    instances = 360/count;
    for(angle = [0 : instances : 360]){
        y = sin(angle) * start;
        x = cos(angle) * start;
        translate([x,y,0]) 
            rotate([0,0,angle])
                Spoke(radius, height, sides);
    }
}    

module Spoke(radius, height, sides) {
    // back support
    color("yellow")       
        rotate([0,90,0])
            cylinder(h=height, r=radius, center=false, $fn=SPOKE_SIDES);
    
}
