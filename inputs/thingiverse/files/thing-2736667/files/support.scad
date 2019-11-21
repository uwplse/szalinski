// Copyright (c) 2017 Adrian Weiler
// This file is licensed Creative Commons Attribution-NonCommercial-ShareAlike 4.0.
// https://creativecommons.org/licenses/by-nc-sa/4.0/

// You can get this file from http://www.thingiverse.com/thing:2736667

w=60;  // width
l=40;  // length
lm=30; // length of middle part
s=l/2; // length of support area
d=6.6; // diameter of holes, suitable for 6mm threaded rod
h=d+4; // height of support area
h1=10; // additional height
f=10;  // size of chamfer

module support(outer)
{
    rotate([90,0,0])
        difference()
        {
            // body
            linear_extrude(w)
                if (outer)
                    polygon([[0,0],[l,0],[l,h],[l-s,h],[l-s,h+h1],[f,h+h1],[0,h+h1-f]]);
                else
                    square(size=[lm,h]);

            // holes
            translate([0,h/2,w/4]) rotate([0,90,0]) cylinder(l, d=d);
            translate([0,h/2,3*w/4]) rotate([0,90,0]) cylinder(l, d=d);
        }
}

translate ([-l-1,0,0]) support(true);
support(false);
translate ([lm+1,0,0]) support(true);
