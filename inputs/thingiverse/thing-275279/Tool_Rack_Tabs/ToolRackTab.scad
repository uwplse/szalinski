// Tab thickness
tab_thickness = 4;

// Width of the sticky-uppy-bit
tab_width = 15;

// Width of the bit that bears the weight
tab_shoulder = 40;

// Screw hold diameter
screw_diameter = 4;

/* [Hidden] */
tab_radius = tab_width / 2;
screw_radius = screw_diameter / 2;

$fn = 50;

module tab() {
  difference() {
    union() {
      cylinder(h = tab_thickness, r = tab_radius, center = true);
      translate([0, -tab_radius, 0]) {
        cube([tab_width, tab_width, tab_thickness], center = true);
      }
      translate([0, -tab_width, 0]) {
        cube([tab_shoulder, tab_width, tab_thickness], center = true);
      }
    }
    cylinder(h = tab_thickness + 1, r = screw_radius, center = true);
  }
}

tab();
