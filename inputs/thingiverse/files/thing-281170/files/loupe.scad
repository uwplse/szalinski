wall_thickness = 2;

// Length of the tube holder.
lens_tube_length = 12;

// Radius of tube holder.
lens_tube_r = 15.1 / 2;

// Measured height of phone case, including fudge factor for fit.
case_height = 10.4;

// Measured width of the case, used to determine case thickness.
case_width = 62.2;

// Extra distance in the X axis to offset lens center. Positive moves lens left in image.
lens_offset_fudge_x = 0;

// Extra dystance in the Y axis to offset lens center. Positive moves lens down in image.
lens_offset_fudge_y = 0;

// From dimensional drawings for iPhone 5. You shouldn't have to change these next three, but you can if you need to.
iphone_width = 58.57;
iphone_lens_center_offset_x = 9.28;
iphone_lens_center_offset_y = 7.35;

// Guessed at. No precise numbers available.
iphone_corner_radius = 9;

// [None]
// Calculated dimensions
case_wall_thickness = (case_width - iphone_width) / 2;
case_lens_center_offset_x = iphone_lens_center_offset_x + case_wall_thickness + lens_offset_fudge_x;
case_lens_center_offset_y = iphone_lens_center_offset_y + case_wall_thickness + lens_offset_fudge_y;
case_corner_radius = iphone_corner_radius + case_wall_thickness;
full_tube_height = case_height + 2*wall_thickness + lens_tube_length;

slop = .1;

module tube() {
  translate([-case_lens_center_offset_x, -case_lens_center_offset_y, -lens_tube_length])
  cylinder(h=lens_tube_length, r=lens_tube_r + wall_thickness, $fn=50);
}

module tube_cutout() {
  translate([-case_lens_center_offset_x, -case_lens_center_offset_y, -lens_tube_length - slop])
  cylinder(h=full_tube_height + 2*slop, r=lens_tube_r, $fn=50);
}


module holder() {
  translate([-case_corner_radius, -case_corner_radius])
  linear_extrude(height=2*wall_thickness + case_height)
  circle(case_corner_radius + wall_thickness, $fn=50);
}

module iphone_cutout() {
  translate([-case_corner_radius, -case_corner_radius, wall_thickness]) {
    linear_extrude(height=case_height) {
      circle(case_corner_radius, $fn=50);
      difference() {
        translate([-(50 - case_corner_radius), -(50 - case_corner_radius)]) square(50);
        square(case_corner_radius);
      }
    }
  }
}

difference() {
  union() {
    tube();
    holder();
  }
  tube_cutout();
  iphone_cutout();
}

