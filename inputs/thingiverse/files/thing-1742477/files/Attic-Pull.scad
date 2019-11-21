
total_height = 40; // mm
rope_diameter = 5; // mm
knot_diameter = 10; // mm


// rotation puts it into netgative space, fix that.
translate([0, 0, total_height]) {
  // Rotate it so that it can be printed without supports.
  rotate([0, 180, 0]) {
    difference() {
      // main cone
      cylinder(d1=rope_diameter * 4, d2=(rope_diameter * 2), h=total_height, $fn=120);

      // cut a hole for the rope
      cylinder(d=rope_diameter + 0.5, h=total_height, $fn=60);

      // cut a hole for the knot
      cylinder(d=knot_diameter + 2, h=knot_diameter + 2, $fn=60);
    }
  }
}
