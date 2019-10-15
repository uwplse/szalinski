/**
 * a parameterized model for a furniture leg
 */
plate_thickness = 4; // mm
plate_width_x = 50; // mm
plate_width_y = 60; // mm
leg_width_x_top = 40; // mm
leg_width_y_top = 30; // mm
leg_offset_x = 0; // mm
leg_offset_y = 30; // mm
leg_width_x_bottom = 20; // mm
leg_width_y_bottom = 20; // mm
leg_height = 100; // mm
hole_diameter = 4; // mm

$fn=24;

module bottom(extra) {
  translate([leg_offset_x, leg_offset_y, leg_height + (0.1 + extra) / 2]) {
    cube([leg_width_x_bottom + extra, leg_width_y_bottom + extra, 0.1 + extra], center=true);
  }
}

difference() {
  union() {
    translate([0, 0, plate_thickness / 2]) {
      cube([plate_width_x, plate_width_y, plate_thickness], center=true);
    }
    hull() {
      translate([0, 0, plate_thickness - 0.5]) {
        cube([leg_width_x_top, leg_width_y_top, 0.1], center=true);
      }
      bottom(0);
    }
  }
  bottom(10);

  for (xd=[-1, 1]) {
    for (yd=[-1, 1]) {
      translate([
          xd * (plate_width_x / 2 - 1.5 * hole_diameter),
          yd * (plate_width_y / 2 - 1.5 * hole_diameter),
          plate_thickness / 2]) {
        cylinder(d=hole_diameter, h=plate_thickness + 0.1, center=true);
      }
    }
  }
}
