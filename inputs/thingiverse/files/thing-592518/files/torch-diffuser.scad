// https://www.thingiverse.com/thing:592518
// Parametric Torch Diffuser (v2)
// Copyright 2017 - Andrew Cutler. License Creative Commons Attribution.

// wall thickness
thickness = 2;

// torch diameter
torch_diameter = 21;

// height of ring
ring_height = 5;

// cone size
cone = 10;

/* [Hidden] */
$fn = 64;
pipe_outer_d = torch_diameter+thickness*2;
fudge = 0.01;

// --- modules

// not true thickness due to angle
module pipe(length, diameter, thickness) {
	cutout_l = length+2;
	cutout_d = diameter - (thickness*2);

	difference() {
		cylinder(length, d=diameter, center=true);
		cylinder(cutout_l, d=cutout_d, center=true);
	}	
}

module ring() {
    pipe(ring_height, pipe_outer_d, thickness);
}

module cone(tip_d, base_d) {
    hull() {
        translate([0,0,tip_d]) sphere(d=tip_d, center=true);
        cylinder(h=0.01, d=base_d);
    }
}

module tip(thickness, tip_d, base_d) {
    difference() {
        cone(tip_d+thickness, base_d+thickness*2);
        translate([0,0,-fudge]) cone(tip_d, base_d);
    }
}

// ---

module diffuser() {
    union() {
        // bottom ring
        translate([0, 0, -ring_height/2]) ring();
        // hollow cone body
        tip(thickness, cone, torch_diameter);
    }
}

diffuser();



