// https://www.thingiverse.com/thing:2523257
// Spark Plug Socket Insert
// Copyright 2017 - Andrew Cutler. License Creative Commons Attribution.
// print with flexible filament
// suggested 2 perimeters, 20 % infill

// tolerance adjustment to make for a tight fit
fudge = 0.1;

// outer diameter (socket)
o_d = 15.0;

// inner diameter (spark plug)
i_d = 10.0;

// length of socket insert
length = 24.0;

// inner bumps diameter
bump_diameter = 1.0;

/* [Hidden] */
pad = 0.001;
$fn = 128;


module bump() {
     cylinder(d=bump_diameter, h=length, center=true);
}


union() {
    difference() {
        cylinder(d=o_d+fudge, h=length, center=true);
        cylinder(d=i_d-fudge, h=length+pad, center=true);
    }

    translate([0,i_d/2,0]) bump();
    translate([0,-i_d/2,0]) bump();
    translate([i_d/2,,0]) bump();
    translate([-i_d/2,,0]) bump();
}

