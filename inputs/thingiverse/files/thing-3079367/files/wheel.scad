
WHEEL_HEIGHT = 25;

WHEEL_RADIUS_INNER_R1 = 5;
WHEEL_RADIUS_INNER_R2 = 30;

WHEEL_RADIUS_OUTER_R1 = 60;
WHEEL_RADIUS_OUTER_R2 = 73;

WHEEL_TREAD_DEPTH = 5;
WHEEL_TREAD_HEIGHT = 27;
WHEEL_TREAD_WIDTH = 5;
WHEEL_TREAD_COUNT = 48;

SPOKE_COUNT = 12;
SPOKE_DIAMETER=12;
SPOKE_HEIGHT=WHEEL_RADIUS_OUTER_R1;
SPOKE_START = 6;

INDENT_COUNT = 6;
INDENT_DISTANCE = 15;
INDENT_SIZE = 5;

// Main
Treads(WHEEL_TREAD_COUNT, WHEEL_RADIUS_OUTER_R2);
WheelR2();
difference() {
    union(){
        WheelR1();
        Spokes(SPOKE_DIAMETER, SPOKE_HEIGHT, SPOKE_START, SPOKE_COUNT);
    }
    Indents(INDENT_COUNT, INDENT_DISTANCE, INDENT_SIZE);
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
            cylinder(h=WHEEL_HEIGHT, r=WHEEL_RADIUS_INNER_R2, center=true, $fn=8);
            cylinder(h=WHEEL_HEIGHT+1, r=WHEEL_RADIUS_INNER_R1, center=true, $fn=8);
        }
}
module WheelR2() {
    color("Purple")
        difference() {
            cylinder(h=WHEEL_HEIGHT, r=WHEEL_RADIUS_OUTER_R2, center=true, $fn=64);
            cylinder(h=WHEEL_HEIGHT+1, r=WHEEL_RADIUS_OUTER_R1, center=true, $fn=64);
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

module Spokes(radius, height, start, count) {
    instances = 360/count;
    for(angle = [0 : instances : 360]){
        y = sin(angle) * start;
        x = cos(angle) * start;
        translate([x,y,0]) 
            rotate([0,0,angle])
                Spoke(radius, height);
    }
}    

module Spoke(radius, height) {
    // back support
    color("yellow")       
        rotate([0,90,0])
            cylinder(h=height, r=radius, center=false, $fn=64);
    
}
