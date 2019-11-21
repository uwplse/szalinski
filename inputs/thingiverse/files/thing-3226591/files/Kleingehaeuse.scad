// -----------------------------------------------------
// Kleingehaeuse
//
//  Detlev Ahlgrimm, 11.2018
// -----------------------------------------------------


inner_length=82;
inner_width=24;   // muss mind. um wt groesser sein als auf voller Hoehe benoetigt
inner_height=16;


// inner_length=30;
// inner_width=16;
// inner_height=10;


// wall thickness
wt=1.6;

/* [Hidden] */
$fn=100;
ws=max(5, inner_length/10);

// -----------------------------------------------------
//  wie cube() - nur abgerundet
// -----------------------------------------------------
module BoxAbgerundet(v, r=2) {
  hull() {
    translate([    r,     r,     r]) sphere(r=r);
    translate([v.x-r,     r,     r]) sphere(r=r);
    translate([    r, v.y-r,     r]) sphere(r=r);
    translate([v.x-r, v.y-r,     r]) sphere(r=r);

    translate([    r,     r, v.z-r]) sphere(r=r);
    translate([v.x-r,     r, v.z-r]) sphere(r=r);
    translate([    r, v.y-r, v.z-r]) sphere(r=r);
    translate([v.x-r, v.y-r, v.z-r]) sphere(r=r);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module SnapIn_M(v) {
  cube(v);
  translate([0, 0, v.z-wt]) 
  rotate([0, 90, 0]) linear_extrude(v.x) polygon([[0,0], [-wt/2,-wt/2], [-wt,0]]);
}
//!SnapIn_M([inner_length/10-2, wt, inner_height]);

// -----------------------------------------------------
//
// -----------------------------------------------------
module Oberteil() {
  difference() {
    BoxAbgerundet([inner_length+2*wt, inner_width+2*wt, inner_height+2*wt]);
    translate([wt, wt, wt]) cube([inner_length, inner_width, inner_height+2*wt]);
    translate([-0.1, -0.1, wt+inner_height/2]) cube([inner_length+2*wt+0.2, inner_width+2*wt+0.2, inner_height]);
    translate([wt+ws,                wt/2,               inner_height+wt]) mirror([0, 0, 1])                   SnapIn_M([ws, wt, inner_height/2+3]);
    translate([wt+ws,                inner_width+wt*1.5, inner_height+wt]) mirror([0, 1, 0]) mirror([0, 0, 1]) SnapIn_M([ws, wt, inner_height/2+3]);
    translate([wt+inner_length-2*ws, wt/2,               inner_height+wt]) mirror([0, 0, 1])                   SnapIn_M([ws, wt, inner_height/2+3]);
    translate([wt+inner_length-2*ws, inner_width+wt*1.5, inner_height+wt]) mirror([0, 1, 0]) mirror([0, 0, 1]) SnapIn_M([ws, wt, inner_height/2+3]);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Unterteil() {
  difference() {
    BoxAbgerundet([inner_length+2*wt, inner_width+2*wt, inner_height+2*wt]);
    translate([wt, wt, wt]) cube([inner_length, inner_width, inner_height+2*wt]);
    translate([-0.1, -0.1, wt+inner_height/2]) cube([inner_length+2*wt+0.2, inner_width+2*wt+0.2, inner_height]);
  }
  translate([wt+ws+0.5,                wt/2,               wt])                   SnapIn_M([ws-1, wt, inner_height/2+3]);
  translate([wt+ws+0.5,                wt*1.5+inner_width, wt]) mirror([0, 1, 0]) SnapIn_M([ws-1, wt, inner_height/2+3]);
  translate([wt+inner_length-2*ws-0.5, wt/2,               wt])                   SnapIn_M([ws-1, wt, inner_height/2+3]);
  translate([wt+inner_length-2*ws-0.5, wt*1.5+inner_width, wt]) mirror([0, 1, 0]) SnapIn_M([ws-1, wt, inner_height/2+3]);
}

/*
difference() {
  Unterteil();
  translate([-0.1, 2*wt, wt+inner_height/2-0.8]) cube([3*wt+inner_length, inner_width-2*wt, 2*wt]);
}
translate([0, inner_width+3*wt, 0]) difference() {
  Oberteil();
  translate([wt+(inner_length-8)/2, wt+(inner_width-12)/2, -0.1]) cube([8, 12, wt+0.2]);
}
*/

Unterteil();
translate([0, inner_width+3*wt, 0]) Oberteil();
