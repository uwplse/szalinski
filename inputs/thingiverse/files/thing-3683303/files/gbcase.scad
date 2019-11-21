slots_deep = 8; // [1:30]
slots_wide = 2; // [1:8]

// In degrees
slot_lean = 22.5; // [0, 15, 22.5, 30, 45]

thumb_slot_radius = 5; // [15]
thumb_slot_width = 25; // [45]

wall_thickness = 1.6; // [1.6, 2]
wall_height = 20; // [10:30]

module cartbase() {
    difference() {
        cube([cart_width, cart_depth, 50]);
        rotate([0, 0, 45]) {
            translate([0, 0, 25]) cube([2, 2, 50], center=true);
        }
        translate([cart_width, 0, 0]) rotate([0, 0, 45]) {
            translate([0, 0, 25]) cube([2, 2, 50], center=true);
        }
    }
}

cart_width = 57.5;
cart_depth = 8;

slot_depth = cart_depth / cos(slot_lean) + wall_thickness;
slot_width = cart_width + wall_thickness;

total_width = slot_width * slots_wide + wall_thickness;
total_depth = slots_deep * slot_depth + wall_thickness + (wall_height- 2) * tan(slot_lean);

thumb_offset = (cart_width - thumb_slot_width) / 2;
thumb_slot_depth = slots_deep * slot_depth + wall_height + wall_thickness;

slot_bottom = cart_depth * tan(slot_lean);

difference() {
    // Base
    cube([total_width, total_depth, wall_height]);

    // Front cut
    translate([0, 0, 2]) rotate([-slot_lean, 0, 0]) mirror([0, 1, 0]) cube([total_width, 10 + slot_depth, wall_height * 2]);

    translate([0, -wall_thickness / sqrt(2), 2]) rotate([-slot_lean, 0, 0]) {
        rotate([0, 0, 45]) cube([5, 5, wall_height * 3], center=true);
        translate([total_width, 0, 0]) rotate([0, 0, 45]) cube([5, 5, wall_height * 3], center=true);
    }

    // Back cut
    translate([0, total_depth, wall_height / 2]) rotate([0, 0, 45]) cube([wall_thickness, wall_thickness, wall_height + 1], center=true);
    translate([total_width, total_depth, wall_height / 2]) rotate([0, 0, 45]) cube([wall_thickness, wall_thickness, wall_height + 1], center=true);

    for (z = [0:slots_wide - 1]) {
        translate([z * slot_width + wall_thickness, 0, 0]) {
            for (y = [0:slots_deep - 1]) {
                translate([0, y * slot_depth + wall_thickness, 2]) {
                    intersection() {
                        rotate([-slot_lean, 0, 0]) {
                            translate([0, 0, slot_bottom]) {
                                cartbase();
                            }
                            translate([(cart_width - 35) / 2, 0, 0]) cube([35, cart_depth, wall_height]);
                        }
                        cube([cart_width, wall_height * 2, wall_height]);
                    }
                }
            }
            if (thumb_slot_radius > 0) {
                translate([thumb_offset, 0, wall_height - thumb_slot_radius]) cube([thumb_slot_width, thumb_slot_depth, 10]);
                $fn = 80;
                translate([thumb_offset, 0, wall_height]) rotate([-90, 0, 0]) cylinder(r=thumb_slot_radius, h=thumb_slot_depth);
                translate([cart_width - thumb_offset, 0, wall_height]) rotate([-90, 0, 0]) cylinder(r=thumb_slot_radius, h=thumb_slot_depth);
            }
        }
    }
}