// All measurements are in mm.

// Hatchbox: 68 x 54.8
// 3D Solutech: 60 x 57.8
// Melca: 54 x 54
// Dikale: 62.7 x 57
// Tianse: 72.8 x 56.1

// The depth of the hole that the spool is filling. I.e., the width of the spool.
hole_depth = 68;

// The diameter of the hole that the spool is filling. Measure this as accurately as possible, we'll make leeway adjustments later.
hole_diameter = 54.8;

// The diameter of the hub around which the spool hub will turn. Measure this as accurately as possible, we'll make leeway adjustments later.
hub_diameter = 30;

// The thickness of the lip edge.
lip_thickness = 2.0;

// The width of the lip edge.
lip_width = 1.5;

// Allow this much space around the spool and hub.
leeway = 0.5;

// preview[view:north east, tilt:top diagonal]

$fn = 100;
difference() {
    union() {
        cylinder(
            lip_thickness,
            (hole_diameter / 2) + lip_width,
            (hole_diameter / 2) + lip_width
        );
        translate([0, 0, lip_thickness])
            cylinder(
                hole_depth,
                (hole_diameter / 2) - (leeway / 2),
                (hole_diameter / 2) - (leeway / 2)
            );
    }
    translate([0, 0, -5])
        cylinder(
            hole_depth + 10,
            (hub_diameter / 2) + (leeway / 2),
            (hub_diameter / 2) + (leeway / 2)
        );
}

