hole_diameter = 4;
mount_diameter = 15;
vesa_size = 100;
base_thickness = 1.2;
wall_thickness = 1.6;
use_four_holes = 0;  // [0:No, 1:Yes]
mount_offset = 20;
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

hole_radius = hole_diameter / 2.0;
mount_radius = mount_diameter / 2.0;
mount_diag = sqrt(2.0) * vesa_size;
full_length = (dual_mount ? 2 : 1) * (2 * wall_thickness + chip_length);


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

difference() {
  union() {
    if (use_four_holes) {
      // Mount-3
      translate([0, vesa_size, 0]) {
        cylinder(h=base_thickness, d=mount_diameter);
      }
      // Mount-4
      translate([vesa_size, vesa_size, 0]) {
        cylinder(h=base_thickness, d=mount_diameter);
      }
      // Connection 1-3
      translate([-mount_radius, 0, 0]) {
        cube([mount_diameter, vesa_size, base_thickness]);
      }
      // Connection 2-4
      translate([vesa_size - mount_radius, 0, 0]) {
        cube([mount_diameter, vesa_size, base_thickness]);
      }
      // Connection 1-4
      rotate([0,0, 45]) {
        translate([0, -mount_radius, 0]) {
          cube([mount_diag, mount_diameter, base_thickness]);
        }
      }
      // Connection 2-3
      translate([vesa_size, 0, 0]) {
        rotate([0,0, 135]) {
          translate([0, -mount_radius, 0]) {
            cube([mount_diag, mount_diameter, base_thickness]);
          }
        }
      }
    }
    // Main mount
    hull() {
      // Mount-1
      cylinder(h=base_thickness, d=mount_diameter);
      // Mount-2
      translate([vesa_size, 0, 0]) {
        cylinder(h=base_thickness, d=mount_diameter);
      }
      // Mount offset
      translate([(vesa_size - full_length) * 0.5, -mount_offset, 0]) {
        cube([full_length, wall_thickness, base_thickness]);
      }
    }
    translate([(vesa_size - full_length) * 0.5,
               -(mount_offset + 2 * wall_thickness + chip_width), 0]) {
      chip_mount(chip_length, chip_width, chip_height, base_thickness,
                 wall_thickness, riser_width, riser_height,
                 mount_top, riser_top, mount_bottom, riser_bottom,
                 mount_left, riser_left, mount_right, riser_right, lighten_mount,
                 bottom_left_hole, bl_hole_x, bl_hole_y, bl_hole_diameter,
                 bl_hole_thickness);
    }
    if (dual_mount) {
      translate([(vesa_size + full_length) * 0.5, -mount_offset, 0]) {
        rotate([0,0,180]) chip_mount(chip_length, chip_width, chip_height,
                   base_thickness, wall_thickness, riser_width, riser_height,
                   mount_top, riser_top, mount_bottom, riser_bottom,
                   mount_left, riser_left, mount_right, riser_right, lighten_mount,
                   bottom_left_hole, bl_hole_x, bl_hole_y, bl_hole_diameter,
                   bl_hole_thickness);
      }
    }
  }  // End union
  // Hole-1
  hole(hole_radius, base_thickness, $fn);
  // Hole-2
  translate([vesa_size, 0, 0]) {
    hole(hole_radius, base_thickness, $fn);
  }
  if (use_four_holes) {
    // Hole-3
    translate([0, vesa_size, 0]) {
      hole(hole_radius, base_thickness, $fn);
    }
    // Hole-4
    translate([vesa_size, vesa_size, 0]) {
      hole(hole_radius, base_thickness, $fn);
    }
  }
}  // End difference
