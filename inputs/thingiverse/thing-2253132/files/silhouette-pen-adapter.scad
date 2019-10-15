// Distance from step to tip of Silhouette pen. You shouldn't have to change this.
standard_tip_length = 31.5;

// Diameter of thin section of Silhouette pen, below the step. You shouldn't have to change this.
standard_thin_diameter = 13.9;

// Diameter of thick section of Silhouette pen, above the step. You shouldn't have to change this.
standard_thick_diameter = 15.4;

// Diameter of thin section of pen, below the step.
pen_thin_diameter = 10;

// Diameter of thick section of pen, above the step. Allow a little bit extra for clearance.
pen_thick_diameter = 11.3;

// Length of pen tip, from step to tip.
pen_tip_length = 44;

// Length of holder, to extend above the step. Overall length will be this dimension + pen_tip_length.
holder_length = 30;

/* [Hidden] */
slop = 0.1;
$fa = 5;
$fs = 0.5;

module pen() {
     translate([0, 0, -slop]) cylinder(h=pen_tip_length + 2*slop, d=pen_thin_diameter);
     translate([0, 0, pen_tip_length]) cylinder(h=100, d=pen_thick_diameter);
}

module holder_solid() {
     cylinder(h=standard_tip_length + slop, d=standard_thin_diameter + slop);
     translate([0, 0, standard_tip_length]) cylinder(h=holder_length, d=standard_thick_diameter);
}

difference() {
     holder_solid();
     pen();
}

