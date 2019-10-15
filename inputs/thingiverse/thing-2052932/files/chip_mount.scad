// Common
base_thickness = 1.2;

// Hole 1 (Always created)
hole_1_diameter = 4.5;
hole_1_support_diameter = 15;

// Hole 2 (Created if offsets != 0)
hole_2_diameter = 5;
hole_2_support_diameter = 15;
hole_2_offset_x = 30;
hole_2_offset_y = 0;

// Hole 3 (Created if offsets != 0)
hole_3_diameter = 5;
hole_3_support_diameter = 15;
hole_3_offset_x = 0;
hole_3_offset_y = 0;

// Hole 4 (Created if offsets != 0)
hole_4_diameter = 5;
hole_4_support_diameter = 15;
hole_4_offset_x = 0;
hole_4_offset_y = 0;

// Chip parameters
chip_offset_x = -26;
chip_offset_y = 7.5;
chip_rotation = 0;  // [0:0, 90:90, 180:180, 270:270]
wall_thickness = 1.6;
chip_length = 60.5;
chip_width = 41.5;
chip_height = 18;
riser_height = 3;
riser_width = 0.8;
mount_top = 1;  // [0:No, 1:Yes]
mount_bottom = 1;  // [0:No, 1:Yes]
mount_left = 0;  // [0:No, 1:Yes]
mount_right = 0;  // [0:No, 1:Yes]
riser_top = 1;  // [0:No, 1:Yes]
riser_bottom = 1;  // [0:No, 1:Yes]
riser_left = 1;  // [0:No, 1:Yes]
riser_right = 1;  // [0:No, 1:Yes]
lighten_mount = 1;  // [0:No, 1:Yes]
dual_mount = 0;  // [0:No, 1:Yes]
bottom_left_hole = 1;  // [0:No, 1:Yes]
bl_hole_x = 4;
bl_hole_y = 4;
bl_hole_diameter = 2.8;
bl_hole_thickness = 1.6;


module hole(radius, thickness){
  fn = 30;
  fudge = 1 / cos(180 / fn);
  translate([0, 0, -thickness*0.01]) {
    cylinder(h=thickness * 1.02, r=radius * fudge, $fn=fn);
  }
}


module chip_mount(length, width, height, base_thickness, wall_thickness,
                  riser_width, riser_height,
                  mount_top, riser_top, mount_bottom, riser_bottom,
                  mount_left, riser_left, mount_right, riser_right, lighten,
                  bottom_left_hole, bl_hole_x, bl_hole_y, bl_hole_diameter,
                  bl_hole_thickness) {
  // Mount base
  difference() {
    cube([length + 2 * wall_thickness,
          width + 2 * wall_thickness,
          base_thickness]);
    if (lighten) {
      translate([wall_thickness + length * 0.125,
                 wall_thickness + width * 0.125,
                 -base_thickness * 0.1]) {
        cube([length * 0.75, width * 0.75, base_thickness * 1.2]);
      }
    }
  }
  // Mount top
  if (mount_top) {
    translate([0, wall_thickness + width, base_thickness]) {
      cube([length + 2 * wall_thickness, wall_thickness, height]);
    }
  }
  // Riser top
  if (riser_top) {
    translate([0, wall_thickness + width - riser_width, base_thickness]) {
      cube([length + 2 * wall_thickness,
            wall_thickness + riser_width,
            riser_height]);
    }
  }
  // Mount bottom
  if (mount_bottom) {
    cube([length + 2 * wall_thickness, wall_thickness, base_thickness + height]);
  }
  // Riser bottom
  if (riser_bottom) {
    cube([length + 2 * wall_thickness,
          wall_thickness + riser_width,
          base_thickness + riser_height]);
  }
  // Mount left
  if (mount_left) {
    cube([wall_thickness,
          width + 2 * wall_thickness,
          base_thickness + height]);
  }
  // Riser left
  if (riser_left) {
    cube([wall_thickness + riser_width,
          width + 2 * wall_thickness,
          base_thickness + riser_height]);
  }
  // Mount right
  if (mount_right) {
    translate([wall_thickness + length, 0, 0]) {
      cube([wall_thickness, width + 2 * wall_thickness, base_thickness + height]);
    }
  }
  // Riser right
  if (riser_right) {
    translate([wall_thickness + length - riser_width, 0, 0]) {
      cube([wall_thickness + riser_width,
            width + 2 * wall_thickness,
            base_thickness + riser_height]);
    }
  }
  // Bottom left hole
  if (bottom_left_hole) {
    bl_inner_radius = bl_hole_diameter * 0.5;
    bl_outer_radius = bl_inner_radius + bl_hole_thickness;
    support_height =
        (bl_hole_x < 6 && bl_hole_y < 6) ? riser_height : base_thickness;
    difference() {
      union() {
        hull() {
          cube([wall_thickness + bl_hole_x + bl_outer_radius,
                wall_thickness,
                support_height]);
          cube([wall_thickness,
                wall_thickness + bl_hole_y + bl_outer_radius,
                support_height]);
          translate([wall_thickness + bl_hole_x,
                     wall_thickness + bl_hole_y,
                     0]) {
            cylinder(r=bl_outer_radius, h=support_height, $fn=30);
          }
        }
        translate([wall_thickness + bl_hole_x, wall_thickness + bl_hole_y, 0]) {
          cylinder(r=bl_outer_radius, h=riser_height + base_thickness, $fn=30);
        }
      }
      translate([wall_thickness + bl_hole_x, wall_thickness + bl_hole_y, 0]) {
        hole(bl_inner_radius, riser_height + base_thickness);
      }
    }
    // Fill in the bottom of the hole
    translate([wall_thickness + bl_hole_x, wall_thickness + bl_hole_y, 0]) {
      cylinder(r=bl_outer_radius, h=base_thickness, $fn=30);
    }
  }
}


hole_2 = (hole_2_offset_x != 0) || (hole_2_offset_y != 0);
echo("hole_2",hole_2);
hole_3 = (hole_3_offset_x != 0) || (hole_3_offset_y != 0);
echo("hole_3",hole_3);
hole_4 = (hole_4_offset_x != 0) || (hole_4_offset_y != 0);
echo("hole_4",hole_4);
mount_width =
  2.0 * wall_thickness + ((chip_rotation % 180) ? chip_width : chip_length);
echo("mount_width",mount_width);
mount_height =
  2.0 * wall_thickness + ((chip_rotation % 180) ? chip_length : chip_width);
echo("mount_height",mount_height);
mod_offset_x = chip_offset_x +
  ((chip_rotation == 90 || chip_rotation == 180) ? mount_width : 0.0);
echo("mod_offset_x", mod_offset_x);
mod_offset_y = chip_offset_y + ((chip_rotation >= 180) ? mount_height : 0);
echo("mod_offset_y", mod_offset_y);


difference() {
  // Main mount
  hull() {
    // Mount-1
    cylinder(h=base_thickness, d=hole_1_support_diameter);
    // Mount-2
    if (hole_2) {
      translate([hole_2_offset_x, hole_2_offset_y, 0]) {
        cylinder(h=base_thickness, d=hole_2_support_diameter);
      }
    }
    // Mount-3
    if (hole_3) {
      translate([hole_3_offset_x, hole_3_offset_y, 0]) {
        cylinder(h=base_thickness, d=hole_3_support_diameter);
      }
    }
    // Mount-4
    if (hole_4) {
      translate([hole_4_offset_x, hole_4_offset_y, 0]) {
        cylinder(h=base_thickness, d=hole_4_support_diameter);
      }
    }
    // Mount offset
    translate([chip_offset_x, chip_offset_y, 0]) {
      cube([mount_width, mount_height, base_thickness]);
    }
  }  // End hull
  // Hole-1
  hole(hole_1_diameter * 0.5, base_thickness, $fn);
  // Hole-2
  if (hole_2) {
    translate([hole_2_offset_x, hole_2_offset_y, 0]) {
      hole(hole_2_diameter * 0.5, base_thickness, $fn);
    }
  }
  // Hole-3
  if (hole_3) {
    translate([hole_3_offset_x, hole_3_offset_y, 0]) {
      hole(hole_3_diameter * 0.5, base_thickness, $fn);
    }
  }
  // Hole-4
  if (hole_4) {
    translate([hole_4_offset_x, hole_4_offset_y, 0]) {
      hole(hole_4_diameter * 0.5, base_thickness, $fn);
    }
  }
  if (lighten_mount) {
    translate([chip_offset_x + wall_thickness + (mount_width - 2 * wall_thickness) * 0.125,
               chip_offset_y + wall_thickness + (mount_height - 2 * wall_thickness) * 0.125,
               -base_thickness * 0.1]) {
      cube([(mount_width - 2 * wall_thickness) * 0.75,
            (mount_height - 2 * wall_thickness) * 0.75,
            base_thickness * 1.2]);
    }
  }
}  // End base plate

translate([mod_offset_x, mod_offset_y, 0]) {
  rotate([0, 0, chip_rotation])
    chip_mount(chip_length, chip_width, chip_height, base_thickness,
               wall_thickness, riser_width, riser_height,
               mount_top, riser_top, mount_bottom, riser_bottom,
               mount_left, riser_left, mount_right, riser_right, lighten_mount,
               bottom_left_hole, bl_hole_x, bl_hole_y, bl_hole_diameter,
               bl_hole_thickness);
}
