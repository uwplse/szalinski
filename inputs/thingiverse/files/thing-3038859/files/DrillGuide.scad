// MPCNC nut trap drill guide
// https://www.thingiverse.com/thing:3038859
// Robbert Klarenbeek
//
// Remixed from https://www.thingiverse.com/thing:910707 (by GeoDave)
//
// - Uses standard spacings as shown on MPCNC assembly page
// - Built for 25mm conduit (international "F" version)
// - Uses $fn = 0 in order to create smooth arcs when imported
//   into FreeCAD, which in turn generates a smooth STEP export

// Size of the conduit used / MPCNC version
conduit_outer_diameter = 25; // [23.5:Version C (23.5mm), 25:Version F (25mm), 25.4:Version J (25.4mm)]
// How far from the bottom the 1st hole will be
first_hole_position = 22.5;
// The distance between the 1st and 2nd hole
hole_distance = 75;
// Thickness of the walls holding the conduit
wall_thickness = 5;
// Diameter of the drill holes
drill_hole_diameter = 4.2;
// Space on both sides of the drill holes
drill_hole_clearance = 6;

// Create anonymous scope to hide from customizer
{
    $fn = 0; // Keep at 0 for smooth FreeCAD import / STEP output
    $fa = 2;
    $fs = 0.1;

    cut_margin = 1;
    
    second_hole_position = first_hole_position + hole_distance;
    length = second_hole_position + drill_hole_clearance;
    width = conduit_outer_diameter + 2 * wall_thickness;
    height = conduit_outer_diameter / 2 + wall_thickness;
    cut_height = height + cut_margin * 2;
    
    first_cut_offset = -cut_margin;
    first_cut_length = first_hole_position - drill_hole_clearance + cut_margin;
    second_cut_offset = first_hole_position + drill_hole_clearance;
    second_cut_length = hole_distance - drill_hole_clearance * 2;
}

module Holder() {
    difference() {
        translate([0, -width / 2, 0])
            cube([length, width, height]);
        rotate([0, 90, 0]) translate([-height, 0, -cut_margin])
            cylinder(d = conduit_outer_diameter, h = length + cut_margin * 2);
        
        Trim();
    }
    translate([-wall_thickness, -width / 2, 0])
        cube([wall_thickness, width, wall_thickness + conduit_outer_diameter / 4]);
}

module Trim() {
    translate([first_cut_offset, -conduit_outer_diameter / 2, -cut_margin])
        cube([first_cut_length, conduit_outer_diameter, cut_height]);

    translate([second_cut_offset, -conduit_outer_diameter / 2, -cut_margin])
        cube([second_cut_length, conduit_outer_diameter, cut_height]);

    translate([first_hole_position, -(width + cut_margin * 2) / 2, wall_thickness + 2])
        cube([hole_distance, width + cut_margin * 2, cut_height]);
}

module DrillHole() {
    translate([0, 0, -cut_margin])
        cylinder(d = drill_hole_diameter, h = cut_height);
}

module Thing() {
    difference() {
        Holder();
        translate([first_hole_position, 0, 0])
            DrillHole();
        translate([second_hole_position, 0, 0])
            DrillHole();
    }
}

Thing();
