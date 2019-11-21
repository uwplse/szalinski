include <nuts_and_bolts.scad>

// Tube diameter
TUBE_DIAMETER = 12; // [1:30]

// Thickness of enclosure
THICKNESS = 5;  // [1:30]

 // Spacing between both holes
TUBE_SPACING = 40; // [1:200]

// Length of tube clamp
HEIGHT = 20;  // [20:200]

// Tolerancy for tube Holes
TOLERANCY = 0.4; // [0:2]

TUBE_HOLE_DIAMETER = TUBE_DIAMETER + TOLERANCY;

SCREW_DIAMETER = 3;
SCREW_HEAD_DIAMETER = 6;
SCREW_HEAD_THICKNESS = 4;

// Generated
HOLDER_TOTAL_THICKNESS = TUBE_DIAMETER + 2 * THICKNESS;

$fn = 80;
module tube_holder_block() {
linear_extrude(height = HEIGHT)
difference() {
    hull() {
        translate([-TUBE_SPACING/2, 0])circle(d = HOLDER_TOTAL_THICKNESS);
        translate([TUBE_SPACING/2, 0]) circle(d =  HOLDER_TOTAL_THICKNESS);
    }
    translate([-TUBE_SPACING/2, 0]) circle(d = TUBE_HOLE_DIAMETER);
    translate([TUBE_SPACING/2, 0]) circle(d = TUBE_HOLE_DIAMETER);
}
}

module screw_hole()
{
    cylinder(d = SCREW_HEAD_DIAMETER, h = SCREW_HEAD_THICKNESS); 
    cylinder(d = SCREW_DIAMETER, h = HOLDER_TOTAL_THICKNESS);
    translate([0, 0, TUBE_DIAMETER + 2 * THICKNESS - METRIC_NUT_THICKNESS[3]]) nutHole(3);
}


module split_tube_holder_block() {
    difference() {
        tube_holder_block();
        translate([0, 0, HEIGHT/2]) cube([TUBE_SPACING + TUBE_DIAMETER * 2 + THICKNESS * 2, 1, HEIGHT], center = true);
        translate([0, HOLDER_TOTAL_THICKNESS/2, HEIGHT/4]) rotate ([90, 0, 0]) screw_hole();
        translate([0, HOLDER_TOTAL_THICKNESS/2, HEIGHT/4 * 3]) rotate ([90, 0, 0]) screw_hole();
    }
}

split_tube_holder_block() ;
