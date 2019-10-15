part = "both"; // [large, small, both]

wall_thickness = 2;

// Handle width.
handle_width = 20;

// Handle inner diameter for large spoon.
lg_handle_id = 30;

// Offset from center of handle for center of magnet.
magnet_offset = 30;

// Offset from center of handle for each bowl.
bowl_center_offset = 60;

// Diameter of magnet.
magnet_d = 3.2;

// Height of magnet.
magnet_h = 1.6;

// How much clearance to give around the edge of the magnet.
magnet_clearance = 0.1;

// OpenSCAD parameters for controlling number of facets used to represent curves.
$fa = 5;
$fs = 0.5;

// [None]

// Next four values are calculated given V = 4/3 pi r^3
tbsp_r = 19.184;
tsp_r = 13.3014;
half_tsp_r = 10.5573;
quarter_tsp_r = 8.3794;

// A little additional clearance for the small spoon handle bump.
sm_handle_id = lg_handle_id - 2*wall_thickness - 0.4;
slop = 0.1;

module magnets() {
  translate([-magnet_offset, 0, 0])
  cylinder(h = 2*magnet_h, r = magnet_d/2 + magnet_clearance, center = true);

  translate([magnet_offset, 0, 0])
  cylinder(h = 2*magnet_h, r = magnet_d/2 + magnet_clearance, center = true);
}

module handle(bump_id, z_offset) {
  difference() {
    union() {
      cube(size = [2*bowl_center_offset, handle_width, 2*wall_thickness], center = true);

      translate([0, 0, z_offset])
      rotate([90, 0, 0])
      cylinder(h = handle_width, r = bump_id/2 + wall_thickness, center=true);
    }

    translate([0, 0, z_offset])
    rotate([90, 0, 0])
    cylinder(h = handle_width + 2*slop, r = bump_id/2, center = true);
    magnets();
  }
}

module bowl_hull(r, x) {
  translate([x, 0, 0])
  sphere(r + wall_thickness);
}

module bowl_hole(r, x) {
  translate([x, 0, 0])
  sphere(r);
}

module large_spoon() {
  difference() {
    union() {
      // Drop the center of the handle bump by the wall thickness so that
      // the center is coincident with that for the small spoon.
      handle(lg_handle_id, -wall_thickness);
      bowl_hull(tbsp_r, -bowl_center_offset);
      bowl_hull(tsp_r, bowl_center_offset);
    }
    bowl_hole(tbsp_r, -bowl_center_offset);
    bowl_hole(tsp_r, bowl_center_offset);

    translate([0, 0, -150])
    cube(size=300, center = true);
  }
}

module small_spoon() {
  difference() {
    union() {
      handle(sm_handle_id, 0);
      bowl_hull(half_tsp_r, -bowl_center_offset);
      bowl_hull(quarter_tsp_r, bowl_center_offset);
    }
    bowl_hole(half_tsp_r, -bowl_center_offset);
    bowl_hole(quarter_tsp_r, bowl_center_offset);

    translate([0, 0, -150])
    cube(size=300, center = true);
  }

}

if (part == "large") large_spoon();
else if (part == "small") small_spoon();
else {
  translate([0, 40, 0]) large_spoon();
  small_spoon();
}