// MPCNC tool mount nut trap
// https://www.thingiverse.com/thing:3038722
// Robbert Klarenbeek
//
// Remixed from https://www.thingiverse.com/thing:907882 (by GeoDave)
//
// - Uses standard spacings as shown on MPCNC assembly page
// - Built for 25mm conduit (international "F" version)
// - Uses $fn = 0 in order to create smooth arcs when imported
//   into FreeCAD, which in turn generates a smooth STEP export

// Size of the conduit used / MPCNC version
conduit_outer_diameter = 25; // [23.5:Version C (23.5mm), 25:Version F (25mm), 25.4:Version J (25.4mm)]
// How thick the wall of your conduit is
conduit_wall_thickness = 1.5;
// How far from the bottom the 1st hole will be
first_hole_position = 22.5;
// The distance between the 1st and 2nd hole
hole_distance = 75;
// Added space above the 2nd hole
top_clearance = 8;
// Diameter of the holes (for M4, use 4mm)
hole_diameter = 4;
// Distance between 2 parallel sides of the hex shape (for M4, use 7.2mm)
nut_size = 7.2;
// Height of your nut (for M4 nyloc nut, use 4.7mm)
nut_height = 4.7;
// Orientation of the hex shape
nut_orientation = 0; // [0:Parallel to long edge, 30:Parallel to short edge]

// Create anonymous scope to hide from customizer
{
    $fn = 0; // Keep at 0 for smooth FreeCAD import / STEP output
    $fa = 2;
    $fs = 0.1;
    cut_margin = 1;
    second_hole_position = first_hole_position + hole_distance;
    length = second_hole_position + top_clearance;
    diameter = conduit_outer_diameter - 2 * conduit_wall_thickness;
    radius_margin = diameter / 2 + cut_margin;
    nut_diameter = nut_size * 2 / sqrt(3);
    nut_chamfer_height = 1;
    nut_chamfer_diameter = nut_diameter - 2;
}

module ConduitInsert() {
    difference()
    {
        rotate([0, 90, 0])
            cylinder(d = diameter, h = length);
        translate([-cut_margin, -radius_margin, -radius_margin])
            cube([length + cut_margin * 2, radius_margin * 2, radius_margin]);
    }
}

module HoleAndNutTrap() {
    rotate([0, 0, nut_orientation]) translate([0, 0, -cut_margin]) {
        cylinder(d = hole_diameter, h = radius_margin + cut_margin);
        cylinder(d = nut_diameter, h = nut_height + cut_margin, $fn = 6);
        translate([0, 0, nut_height + cut_margin - 0.01])
            cylinder(d1 = nut_diameter, d2 = nut_chamfer_diameter, h = nut_chamfer_height, $fn = 6);
    }
}

module Thing() {
    // Using nested difference() to prevent FreeCAD import from crashing
    difference() {
        difference() {
            ConduitInsert();
            translate([first_hole_position, 0, 0])
                HoleAndNutTrap();
        }
        translate([second_hole_position, 0, 0])
            HoleAndNutTrap();
    }
}

Thing();
