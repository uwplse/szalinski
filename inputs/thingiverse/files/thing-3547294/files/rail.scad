use <MCAD/nuts_and_bolts.scad>

// Length of the rail
length = 240;

// Distance from rail end to the first hole
hole_end_margin = 10;

// Distance from the beginning of the rail to the front fastening screw hole
front_fastening_position = 25;

// Distance from the end of the rail to the rear fastening screw hole
rear_fastening_position = 25;

// Adds extra gap to the rail slot
gap_tolerance = 1; // [0:0.1:2]

// Moves holes closer top of the rail
hole_top_tolerance = 0; // [0:0.05:1.25]

/* [Hidden] */

$fn=16;

top_height = 4;
slot_height = 6;
side_height = 6;
total_height = side_height + top_height;

total_width = 23;
slot_width = 2 + gap_tolerance * 2;
side_width = 4.5 - gap_tolerance;
chamfer_width = 1 + 1/3;
chamfer_height = 4;

wall_thickness = 2;
center_thickness = 6 - gap_tolerance * 2;

fastening_slot_length = 5.5;

hole_distance = 10;
rail_hole_top_margin = 1.25;

module profile() {
    polygon([
        [0, 0],
        [0, chamfer_height],
        [chamfer_width, side_height],
        [side_width, side_height],
        [side_width, side_height + top_height],
        [side_width + wall_thickness, total_height],
        [side_width + wall_thickness, total_height - slot_height],
        [side_width + wall_thickness + slot_width, total_height - slot_height],
        [side_width + wall_thickness + slot_width, total_height],
        [side_width + wall_thickness + slot_width + center_thickness, total_height],
        [side_width + wall_thickness + slot_width + center_thickness, total_height - slot_height],
        [side_width + wall_thickness + 2 * slot_width + center_thickness, total_height - slot_height],
        [side_width + wall_thickness + 2 * slot_width + center_thickness, total_height],
        [side_width + 2 * wall_thickness + 2 * slot_width + center_thickness, total_height],
        [total_width - side_width, side_height],
        [total_width - chamfer_width, side_height],
        [total_width, chamfer_height],
        [total_width, 0]
    ]);     
}

module railBoltHole() {
    rotate([90, 0, 0]) {
        rotate([0, 90, 0]) {
            union() {
                cylinder(side_width, d=6);
                linear_extrude(height=total_width) {
                    boltHole(size=3, length=total_width, tolerance=0.25, proj=1);
                }
                translate([0, 0, total_width - side_width]) {
                    linear_extrude(height=side_width) {
                        nutHole(size=3, proj=1);
                    }
                }
            }
        }
    }
}

module fasteningSlot() {
    union() {
        translate([side_width + wall_thickness + slot_width, 0, top_height]) {
            cube(size = [center_thickness, fastening_slot_length, slot_height ]);
            translate([center_thickness / 2, fastening_slot_length / 2, -total_height]) {
                rotate([0, 0, 90]) {
                    boltHole(size=3, length=total_height);
                }
            }
        }
    }
}

difference() {
    translate([0, length, 0]) {
        rotate([90, 0, 0]) {
            linear_extrude(height=length) {
                profile();
            }
        }
    }
    
    translate([0, hole_end_margin, 0]){
        for(i = [0: hole_distance: length - 2 * hole_end_margin]) {
            translate([0, i, total_height - slot_height / 2 + hole_top_tolerance]) {
                railBoltHole();
            }
        }
    }

    translate([0, front_fastening_position - fastening_slot_length / 2, 0]) {
        fasteningSlot();
    }

    translate([0, length - rear_fastening_position - fastening_slot_length / 2, 0]) {
        fasteningSlot();
    }

    linear_extrude(height=total_height) {
        polygon([
            [0,0],
            [side_width, 0],
            [0, side_width],
        ]);
        polygon([
            [total_width, 0],
            [total_width - side_width, 0],
            [total_width, side_width],
        ]);
    }
}
