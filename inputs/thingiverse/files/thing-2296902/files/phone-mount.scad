/* width of the vertical mount */
horizontal_mount_length = 110;
/* distance from bottom to bottom of eye piece block */
vertical_mount_length = 125;
/* how far from the bottom to position the horizontal mount */
horizontal_mount_y_position = 40;
/* how much to shift, left or right, the horizontal mount from center */
horizontal_mount_x_offset = 15;

difference() {
  union() {
    /* vertical mount */
    cube(size=[12, vertical_mount_length, 5]);
    /*  horizontal mount */
    translate([6 + horizontal_mount_x_offset, horizontal_mount_y_position, 2.5]) {
      cube(size=[horizontal_mount_length, 12, 5], center=true);
    }
    /* eye piece block */
    translate([-30 + 6, vertical_mount_length, 0]) {
      cube(size=[60, 25, 40]);
    }
  }
  /* subtract out eyepiece */
  translate([6, vertical_mount_length + 30, 20]) {
    cylinder(r=20, h=50, center=true, $fa=.1, $fs=.1);
  }
  /* screw holes */
  translate([6 + 30 - 5, vertical_mount_length + 12.5, 20]) {
    rotate([90, 0, 0]) {
      cylinder(r=2, h=30, center=true, $fa=.1, $fs=.1);
    }
  }
  translate([6 - 30 + 5, vertical_mount_length + 12.5, 20]) {
    rotate([90, 0, 0]) {
      cylinder(r=2, h=30, center=true, $fa=.1, $fs=.1);
    }
  }
  /* vertical slot */
  translate([12 / 2 - 2, 4, -5]) {
    cube(size=[4, vertical_mount_length - 8, 15]);
  }
  /* horizontal slot */
  translate([6 + horizontal_mount_x_offset, horizontal_mount_y_position, 2.5]) {
    cube(size=[horizontal_mount_length - 8, 4, 10], center=true);
  }
}
