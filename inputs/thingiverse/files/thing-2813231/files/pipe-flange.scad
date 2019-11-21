/* [Center hole parameters] */
$fn = 50;
// Overall height of the design
height = 15;
// Size of the center hole
hole_diameter = 25;
// Thickness of the center hole
hole_wall_thickness = 3;

/* [Flange] */

// Radius of the base
flange_diameter = 55;
// Thickness of the base
flange_thickness = 4;

/* [Attachment holes] */

// Number of attachment holes
attachment_holes = 3;
// Size of the attachment holes
attachment_hole_diameter = 5;
// How far attachment is from middlepoint between outer and inner edge. Positive value moves towards outer edge, negative towards inner edge.
attachment_offset = 0;
// Size of the screw head for the attachment
attachment_head_diameter = 10;
// select this if you want countersunk holes for the screw heads
attachment_head_hole = "countersink"; // [none, countersink]

/* [Miscellaneous settings] */

// Size added to all holes to account for printing inaccuracy
tolerance = 0.15;
corner_chamfer = 5;

flange_radius = flange_diameter / 2;
c_hole_radius = hole_diameter / 2 + tolerance;
a_hole_radius = attachment_hole_diameter / 2 + tolerance;
a_head_radius = attachment_head_diameter / 2 + tolerance;

center_radius = hole_diameter / 2 + hole_wall_thickness;
a_distance = (flange_diameter / 2 + center_radius) / 2 + attachment_offset;

difference() {
    union() {
        // flange disk or the base
        cylinder(flange_thickness, flange_radius, flange_radius);
        
        // the pipe looking part
        cylinder(height, center_radius, center_radius);
        
        // chamfer
        translate([0, 0, flange_thickness]) cylinder(center_radius + corner_chamfer, center_radius + corner_chamfer, 0);
    }

    union() {
        // center hole
        cylinder(height * 5, c_hole_radius, c_hole_radius);
        
        // attachment holes
        hole_angle = 360 / attachment_holes;
        for (i = [0: attachment_holes]) {
            translate([sin(hole_angle * i) * a_distance,  cos(hole_angle * i) * a_distance, -1]) cylinder(height, a_hole_radius, a_hole_radius);
             translate([sin(hole_angle * i) * a_distance,  cos(hole_angle * i) * a_distance, flange_thickness]) cylinder(height, a_head_radius, a_head_radius);
            // attachment head holes
            if (attachment_head_hole == "countersink") {
                translate([sin(hole_angle * i) * a_distance,  cos(hole_angle * i) * a_distance, flange_thickness+0.01]) rotate([180, 0, 0]) cylinder(a_head_radius, a_head_radius, 0);
            }
        }
    }
}