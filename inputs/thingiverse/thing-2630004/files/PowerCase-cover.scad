include <PowerCase.scad>

// Cover
difference() {
    translate([cover_inner, cover_inner, 0])
        cube([
          box_size_x-box_border_size*2-cover_inner*2,
          box_size_y-box_border_size*2-cover_inner*2,
          cover_height
          ]);

    // Hole 1
    offset_x_1 = 0;
    offset_y_1 = 0;
    translate([offset_x_1+screw_diameterupport_s/2, offset_y_1+screw_diameterupport_s/2, -1])
      cylinder(h=screw_head_height+1, r=screw_head_diameter);

    translate([offset_x_1, offset_y_1, cover_height-cover_over_size])
        SupportNeg(screw_diameterupport_s, screw_diameterupport_h);

    // Hole 2
    offset_x_2 = box_size_x-box_border_size*2-screw_diameterupport_s;
    offset_y_2 = 0;
    translate([offset_x_2+screw_diameterupport_s/2, screw_diameterupport_s/2, -1])
      cylinder(h=screw_head_height+1, r=screw_head_diameter);

    translate([offset_x_2, 0, cover_height-cover_over_size])
        SupportNeg(screw_diameterupport_s, screw_diameterupport_h);

    // Hole 3
    offset_x_3 = 0;
    offset_y_3 = box_size_y-box_border_size*2-screw_diameterupport_s;
    translate([offset_x_3+screw_diameterupport_s/2, offset_y_3 + screw_diameterupport_s/2, -1])
      cylinder(h=screw_head_height+1, r=screw_head_diameter);

    translate([offset_x_3, offset_y_3, cover_height-cover_over_size])
        SupportNeg(screw_diameterupport_s, screw_diameterupport_h);

    // Hole 4
    offset_x_4 = box_size_x-box_border_size*2-screw_diameterupport_s;
    offset_y_4 = box_size_y-box_border_size*2-screw_diameterupport_s;
    translate([offset_x_4+screw_diameterupport_s/2, offset_y_4+screw_diameterupport_s/2, -1])
      cylinder(h=screw_head_height+1, r=screw_head_diameter);

    translate([box_size_x-box_border_size*2-screw_diameterupport_s, box_size_y-box_border_size*2-screw_diameterupport_s, cover_height-cover_over_size])
        SupportNeg(screw_diameterupport_s, screw_diameterupport_h);

    // Remove uneeded part
    translate([cover_inner + screw_diameterupport_s, 0, cover_inner*2])
      cube([
        box_size_x - (box_border_size * 2) - (cover_inner * 2) - (screw_diameterupport_s * 2),
        box_size_y,
        cover_height
        ]);

    translate([0, cover_inner + screw_diameterupport_s, cover_inner*2])
      cube([
        box_size_x,
        box_size_y  - (box_border_size * 2) - (cover_inner * 2) - (screw_diameterupport_s * 2),
        cover_height
        ]);
}

// Module to create cover support
module SupportNeg(cube_size, cube_heigh) {
  union() {
      cube([cube_size, cube_size, cube_heigh]);
      translate([cube_size/2, cube_size/2, cube_heigh-screw_height])
        rotate([0,180,0])
            cylinder(h=screw_height*20, r=cover_hole_size);
  }
}