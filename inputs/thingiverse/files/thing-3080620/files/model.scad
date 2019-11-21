$fn=10; // Visual detail (lower this for preview renders)
WIDTH = 100; // [100:400]
DEPTH = 80; // [80:120]
HEIGHT = 20; // [15:30]

/* Render the model */
RoundedWristRest();

/* 
This generates the dynamic molding for the palm of your hands
*/
module Mold() {
  angle = 90+(HEIGHT*0.5)+(-0.020*DEPTH)+(-0.010*WIDTH);
  translate([WIDTH/2,DEPTH/2,HEIGHT+(0.01*DEPTH)])
    rotate([angle])
      scale([((DEPTH/HEIGHT)*0.6)*(WIDTH*0.01*2),1,2])
        cylinder(h = DEPTH*1.5, 
                 r1 = HEIGHT/1.5,
                 r2 = HEIGHT/1.5,
                 center=true);
}

/* 
Build the dynamic base platform
*/
module Platform() {
  linear_extrude(HEIGHT/2) {
    square([WIDTH, DEPTH]);
  }
  
  translate([0,0,0+HEIGHT/2]) {
    polyhedron(
      points=[
        [0,0,0], [WIDTH,0,0],
        [WIDTH,DEPTH,0], [0,DEPTH,0],
        [0,DEPTH,HEIGHT/2], [WIDTH,DEPTH,HEIGHT/2]],
      faces=[[0,1,2,3], [5,4,3,2], [0,4,5,1], [0,3,4], [5,2,1]]
    );
  }
}

/* 
Build the wrist rest
*/
module WristRest() {
  difference() {
    Platform();
    Mold();
  }
}

/* 
Build a rounded version of the wrist rest (just looks nicer)
*/
module RoundedWristRest() {
  minkowski() {
    WristRest();
    cylinder(r=1, h=1);
  }
}