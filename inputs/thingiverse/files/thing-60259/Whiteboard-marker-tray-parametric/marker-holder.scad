wall_thickness = 2;
tray_height = 7;
tray_width = 15;
clip_height = 11;
clip_width = 7;
holder_length = 100;

module marker_holder() {
  union() {
    difference() {
      cube([tray_width + 2 * wall_thickness, tray_height, holder_length]);
      translate([wall_thickness, -wall_thickness, -wall_thickness / 2]) {
        cube([tray_width, tray_height, holder_length + wall_thickness]);
      }
    }
    translate([0, 5, 0]) {
      difference() {
        cube([clip_width + 2 * wall_thickness, clip_height, holder_length]);
        translate([wall_thickness, wall_thickness, -wall_thickness / 2]) {
          cube([clip_width, clip_height, holder_length + wall_thickness]);
        }
      }
    }
  }
}

marker_holder();
