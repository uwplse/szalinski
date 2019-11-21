/* (C) Copyright 2017 by Thomas R. Koll
 * LED strip holder is a 3D model released under the Creative Commons Attribution Share Alike license
*/

spacing_of_clip_legs = 15;
height = 20;
extrude_to_width = 10;
clip_thickness = 5;
// set to true if you want some decorative cut-out in the top
cut_into_top = true; // [false, true]

// width is the strip
wires = 3;
// diameter of a single wire
wire_diameter = 2;

q = wire_diameter * (wires + 0.5);
k = wire_diameter;

/* [Hidden] */
t = clip_thickness;
w = spacing_of_clip_legs + clip_thickness;

module top_decoration(w, t) {
    // overhang on the top
    translate([-0.5, 0]) square([w + 1, t/5]);
    // pyramid on the top
    polygon([[w/4, 0], [w/2, -w/8], [w * 0.75, 0]]);
}

module bottom_decoration(w, t) {
    f = t/5;
    translate([t/2, 0]) polygon([[0, 0], [f, 0], [0, -f]]);
    translate([w -t/2, 0]) polygon([[0, 0], [-f, 0], [0, -f]]);
}

linear_extrude(extrude_to_width) union() {
    difference() {
        union() {
            top_decoration(w, t/2);
            difference() {
                square([w, height]); // base body
                translate([t/2, t/2]) {
                    square([w-t, height]);
                }
            }
        }
        s = 0.25;
        translate([w * s/2, t/5]) top_decoration(w * (1-s), t * (1-s));
    }
    translate([0, height]) bottom_decoration(w, t);
    
    // clip to hold the cable
    translate([w, height - 3 * k]) difference() {
        square([q, k * 3]);
        difference() {
            translate([0, k]) square([q, k]);
            polygon([[q, k], [q, k * 1.2], [q - k / 1.2, k]]);
            translate([0, k]) polygon([[q, k], [q, k / 1.2], [q - k / 1.3, k]]);
        }
    }
}

