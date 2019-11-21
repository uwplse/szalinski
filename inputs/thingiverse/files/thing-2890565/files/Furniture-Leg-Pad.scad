/* [Pad Dimensions] */
// - Length of the pad
pad_length = 23;
// - Diameter of the pad
pad_diameter = 36.2;
// - Diameter of the screw head
screw_head_diameter = 10;
// - Diameter of the screw shank
screw_shank_diameter = 5;
// - Length of the screw shank that would remain inside the pad
screw_shank_length = 8.8;
// - Thickness of the pad walls
wall_thickness = 5;

pad_with_screw_hole(pad_diameter, pad_length, wall_thickness, screw_head_diameter, screw_shank_diameter, screw_shank_length);

module pad_with_screw_hole(pad_diameter, pad_length, wall_thickness, screw_head_diameter, screw_shank_diameter, screw_shank_length) {
    union() {
        pad(pad_diameter, pad_length, wall_thickness, screw_head_diameter);
        screw_hole(screw_head_diameter, screw_shank_diameter, screw_shank_length, wall_thickness, pad_length);
    }
}

module pad(diameter, length, thickness, screw_head_diameter) {
    pad_bottom_thickness = thickness;
    union() {
        cylinder_with_hole(diameter - thickness, thickness, length);

        translate([0, 0, (-length + pad_bottom_thickness) / 2]) {
            cylinder_with_hole(screw_head_diameter, diameter - screw_head_diameter, pad_bottom_thickness);
        }
    }
}

module screw_hole(head_diameter, shank_diameter, shank_length, thickness, length) {
    outer_diameter = head_diameter + thickness;
    screw_head_container_length = length - shank_length;
    // Buffer to avoid a gap at the join
    screw_head_container_length_buffer = 2;
    
    shank_container_offset = (shank_length / 2) + (length / 2) - shank_length;
    screw_head_container_offset = (screw_head_container_length / 2) + (length / 2) - screw_head_container_length;

    translate([0, 0, shank_container_offset]) {
        cylinder_with_hole(shank_diameter, outer_diameter - shank_diameter, shank_length);
    }
    translate([0, 0, -screw_head_container_offset + (screw_head_container_length_buffer / 2)]) {
        cylinder_with_hole(head_diameter, outer_diameter - head_diameter, screw_head_container_length + screw_head_container_length_buffer);
    }
}

module cylinder_with_hole(hole_diameter, thickness, length) {
    difference() {
        cylinder(h = length, r = (hole_diameter + thickness) / 2, center = true, $fn = 1000);
        cylinder(h = length + 2, r = hole_diameter / 2, center = true, $fn = 1000);
    }
}
