leg_width = 63;
leg_depth = 63;

riser_height = 14;
padding_height = 2;

interior_padding = 3;

leg_container_height = (leg_width + leg_depth) / 4;
wall_thickness = riser_height / 2;
bottom_width = leg_width + riser_height;
bottom_depth = leg_depth + riser_height;

difference() {
  hull() {
    cube([
      leg_width + interior_padding * 2 + wall_thickness * 2,
      leg_depth + interior_padding * 2 + wall_thickness * 2,
      1
    ]);

    translate([-riser_height / 2, -riser_height / 2, -leg_container_height - riser_height]) {
      cube([
        bottom_width + interior_padding * 2 + wall_thickness * 2,
        bottom_depth + interior_padding * 2 + wall_thickness * 2,
        1
      ]);
    }
  }
  translate([wall_thickness, wall_thickness, -leg_container_height]) {
    #cube([leg_width + interior_padding * 2, leg_depth + interior_padding * 2, leg_container_height + 2]);
  }
}

