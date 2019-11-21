/* [Base Plate Dimensions] */
// - Total width
width = 79;
// - Total Height
height = 50;
// - Thickness of the base plate
base_thickness = 3;
// - Radius of the base plate rounded corners
rounded_corner_radius = 4;

/* [Grip Dimensions] */
// - Width of the grip
grip_width = 55;
// - Height of the grip
grip_height = 25;
// - Thickness of the grip shape
grip_thickness = 4;
// - Additional thickness of the grip shape (Total grip thickness = grip_thickness + thickness_buffer)
thickness_buffer = 3;

/* [Screw Head Countersink Dimensions] */
// - Diameter of the top of the screw head
screw_head_top_diameter = 7;
// - Diameter of the bottom of the screw head
screw_head_bottom_diameter = 3;

/* [Screw Positions] */
// - Distance of the screws from the top of the base plate
screw_offset_top = 21.7;
// - Distance of the screws from the sides of the base plate
screw_offset_side = 6.3;

$fn = 1000;

handle();

module handle() {
    base_with_countersinks(width, height, base_thickness, rounded_corner_radius, screw_head_top_diameter, screw_head_bottom_diameter, screw_offset_top, screw_offset_side);

    translate([0, 0, base_thickness]) {
        grip(grip_width, grip_height, grip_thickness, thickness_buffer);
    }
}

module base_with_countersinks(width, height, thickness, rounded_corner_radius, countersink_top_diameter, countersink_bottom_diameter, screw_offset_top, screw_offset_side) {
    left_screw_top_offset = (height / 2) - screw_offset_top;
    left_screw_side_offset = -((width / 2) - screw_offset_side);
    right_screw_top_offset = (height / 2) - screw_offset_top;
    right_screw_side_offset = ((width / 2) - screw_offset_side);

    difference() {
        base_plate(width, height, thickness, rounded_corner_radius);

        rotate([0, 0, 90]) {
            translate([left_screw_top_offset, left_screw_side_offset, 0]) { 
                countersink(countersink_top_diameter, countersink_bottom_diameter, thickness + 2);
            }
            translate([right_screw_top_offset, right_screw_side_offset, 0]) { 
                countersink(countersink_top_diameter, countersink_bottom_diameter, thickness + 2);
            }
        }
    }
}

module base_plate(width, height, thickness, rounded_corner_radius) {
    linear_extrude(height = thickness, center = true) {
        offset(r = rounded_corner_radius) {
            square([width - (rounded_corner_radius * 2), height - (rounded_corner_radius * 2)], center = true);
        }
    }
}

module countersink(top_diameter, bottom_diameter, height) {
    cylinder(h = height, d1 = bottom_diameter, d2 = top_diameter, center = true);
}

module grip(width, height, thickness, thickness_buffer) {
    HOLE_BUFFER = 2;
    difference() {
        cube([width, height, thickness + thickness_buffer], center = true);
        translate([0, -((height + thickness_buffer) / 2), -(thickness / 2)]) {
            rotate([0, 90, 0]) {
                cylinder(h = width + HOLE_BUFFER, r = thickness, center = true);
            }
        }
        translate([0, ((height + thickness_buffer) / 2), -(thickness / 2)]) {
            rotate([0, 90, 0]) {
                cylinder(h = width + HOLE_BUFFER, r = thickness, center = true);
            }
        }
    }
}