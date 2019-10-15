// Convert from mm, to inches for easy printing.
scale_to_inches = true;

// Total cylinder length.
cylinder_length = 1.5;

// Cylinder center diameter.
cylinder_d = 0.625;

// Hollow inner diameter.
bore_d = 0.25;

// Slot depth cut into the cylinder.
slot_depth = 0.125;

// Slot length cut into the cylinder.
slot_length = 0.125;

// Top slot distance from top.
slot_offset_top = 0.5;

// Bottom slot distance from top.
slot_offset_bottom = 0.5;


/* [Hidden] */
// Minimum fragmet angle.
$fa=2;

// Minimum face size.
$fs=0.01;

// Creates a hollow cylinder
module hollow_cylinder(cylinder_length, cylinder_d, bore_d) {
  difference() {
    cylinder(cylinder_length, cylinder_d / 2, cylinder_d / 2);
    cylinder(cylinder_length, bore_d / 2, bore_d / 2);
  }
}

module mosney_connector(
    bore_d,
    slot_depth,
    slot_offset_bottom,
    slot_offset_top,
    cylinder_d,
    cylinder_length) {
  difference() {
    // Outer shell
    hollow_cylinder(cylinder_length, cylinder_d, bore_d);

    // Slot 1
    translate([0, 0, slot_offset_bottom]) {
      hollow_cylinder(slot_length, cylinder_d, cylinder_d - slot_depth);
    }

    // Slot 2
    translate([0, 0, cylinder_length - slot_depth - slot_offset_top]) {
      hollow_cylinder(slot_length, cylinder_d, cylinder_d - slot_depth);
    }
  }
}

if (scale_to_inches) {
  scale(25.4) {
    mosney_connector(bore_d, slot_depth, slot_offset_bottom, slot_offset_top, cylinder_d, cylinder_length);
  }
} else {
  mosney_connector(bore_d, slot_depth, slot_offset_bottom, slot_offset_top, cylinder_d, cylinder_length);
}
