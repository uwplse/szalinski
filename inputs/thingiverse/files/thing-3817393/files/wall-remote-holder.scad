
/* [Remote dimensions] */

// Standing up remote control's width 
$remote_width = 38;
// Standing up remote control's depth 
$remote_depth = 16;
// Standing up remote control's height 
$remote_height = 100;

/* [Holder remote container height] */
// Height of remote control holding part
$remote_holder_height = 50;

/* [Holder thicknesses] */
// Holder borders thickness
$box_thickness = 2;
// Holder wall side border thickness
$box_back_thickness = 4;

/* [Screw diameters] */
// Screw shank diameter
$screw_shank_diameter = 3;
// Screw head diameter
$screw_head_diameter = 8;

/* [Screw access diameter] */
// Front hole diameter (large enough to pass the screwdriver)
$front_hole_diameter = 16;

/* [Screw positions] */
// Screw top position (this model will ensure the top screw holes to be accessible)
$screw_top_position = 75;
// Screw bottom position
$screw_bottom_position = 25;

/* [Hidden] */
$fs = 0.1;

module cylinder_x90(h, r, r1, r2) {
  rotate([90,0,0]) cylinder(h=h, r=r, r1=r1, r2=r2);
};
module screw_hole() {
  cylinder_x90(
    h=$box_back_thickness, 
    r1=$screw_shank_diameter / 2, 
    r2=$screw_head_diameter / 2
  );
};

module whole_box() {
  minkowski() {
    cube([$remote_width, $remote_depth+$box_back_thickness, $remote_height]);
    sphere($box_thickness);
  }
};

module rectified_wall_box() {
  difference() {
    whole_box();
    translate([-$box_thickness, $remote_depth + $box_back_thickness, -$box_thickness]) 
      cube([$remote_width + 2 * $box_thickness, $box_thickness, $remote_height + 2 * $box_thickness]);
  }
};

difference() {
  rectified_wall_box();
  cube([$remote_width, $remote_depth, $remote_height]);
  translate([-$box_thickness, -$box_thickness, max(min($remote_holder_height, $remote_height - $screw_head_diameter), $front_hole_diameter + $box_thickness)]) 
    cube([
      $remote_width + 2 * $box_thickness, 
      $remote_depth + $box_thickness, 
      $remote_height + $box_thickness
    ]);
  $remote_half_width = $remote_width / 2;
  translate([$remote_half_width, 0, 0]) {
    translate([0, $remote_depth + $box_back_thickness, min(max($screw_top_position, $remote_holder_height + $screw_head_diameter / 2), $remote_height - $screw_head_diameter/2)]) {
      translate([-$remote_half_width / 2, 0, 0]) screw_hole();
      translate([$remote_half_width / 2, 0, 0]) screw_hole();
    }
    translate([0, 0, max($front_hole_diameter/2, min($screw_bottom_position, $remote_holder_height - $front_hole_diameter/2))]) {
      translate([0, $remote_depth + $box_back_thickness, 0]) screw_hole();
      cylinder_x90(h=$box_thickness, r=$front_hole_diameter / 2);
    }
  }
}
