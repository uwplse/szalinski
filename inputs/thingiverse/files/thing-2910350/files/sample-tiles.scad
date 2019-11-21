// https://www.thingiverse.com/thing:2910350
// Copyright 2018 - Andrew Cutler. License Creative Commons Attribution.

// corner diameter
corner_d = 12; // [1:50]
// hole diameter
hole_d = 6; // [1:50]
// thickness
thickness = 2; // [1:10]
// width
width = 25; // [10:100]
// label
label = "Label";

/* [Hidden] */

$fn=64;
pad=0.01;

difference() {
    minkowski() {
      cube([width-corner_d,width-corner_d,thickness/2]);
      cylinder(d=corner_d, h=thickness/2);
    }

    cylinder(d=hole_d, h=1000, center=true);
    translate([-corner_d/4,width/2-corner_d/4,thickness/2+pad]) 
    linear_extrude(height=thickness/2) {
        text(label, font="Liberation Sans", size=5);
    }
}

