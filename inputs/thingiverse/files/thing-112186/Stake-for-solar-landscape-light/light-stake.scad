// how tall to make the top section
cap_riser_height = 16;
// the diameter of the top section
cap_riser_width = 17;
// how thick the top section's straight sections are (the + section)
cap_riser_thickness = 2;
// how far from the top to put the circular section of the top
cap_circle_offset = 9;

// how thick to make the circle dividing the point from the cap
cap_divider_thickness = 2;

// length of the stake's point
point_height = 95;
// radius of the top section of the stake
point_top_radius = 15;
// how much of the stake to cutoff, making it have a blunt edge
point_tip_cutoff = 5;
// how thick the stake's sections should be
point_thickness = 2;



/*****************
 The bottom pointy part
 */

module stake_edge(height, top_radius, tip_cutoff=10, thickness=2) {
  rotate([0, 90, 0])
    linear_extrude(height=thickness, center=true)
    difference() {
      // triangle
      polygon(points = [[0, 0], [0, top_radius], [height, 0]],
              paths=[[0, 1, 2]]);
    // the square for cutting off the tip
    translate([height - tip_cutoff, 0, 0]) {
      square([tip_cutoff, top_radius * 2]);
    }
  }
}

// all arguments expected to be in the same base syste
// final_radius should be about 5 (.5cm)
module stake_point(height, top_radius, tip_cutoff=10, thickness=2) {
  union() {
    stake_edge(height, top_radius, tip_cutoff, thickness);
    rotate(90) stake_edge(height, top_radius, tip_cutoff, thickness);
    rotate(180) stake_edge(height, top_radius, tip_cutoff, thickness);
    rotate(270) stake_edge(height, top_radius, tip_cutoff, thickness);
  }
}

module circle_at_top_of_point(radius, thickness) {
  linear_extrude(height=thickness)
    circle(r=radius);
}

/*****************
 The top section that the light goes on
 */

module cap_x_unrounded(width, thickness) {
    union() {
      translate([-width / 2.0, -thickness / 2.0])
        square([width, thickness], center=false);
      rotate([0, 0, 90])
        translate([-width / 2.0, -thickness / 2.0])
          square([width, thickness], center=false);
    }
}

module cap_x(riser_height, riser_width, riser_thickness) {
  linear_extrude(height=riser_height)
  // make a + but rounded off
  intersection() {
    cap_x_unrounded(riser_width, riser_thickness);
    circle(r=riser_width / 2.0);
  }
}

module cap_middle_circle(radius, thickness) {
  linear_extrude(height=thickness, center=false) circle(r=radius);
}

module cap_riser(riser_height, riser_width, cap_circle_offset, riser_thickness) {
  union() {
    cap_x(riser_height, riser_width, riser_thickness);
    translate([0, 0, riser_height - cap_circle_offset])
      cap_middle_circle(riser_width / 2.0, riser_thickness);
  }
}

module stake(point_height,
  point_top_radius,
  point_tip_cutoff,
  point_thickness,
  cap_divider_thickness,
  cap_riser_height,
  cap_riser_width,
  cap_riser_thickness,
  cap_circle_offset) {

  union() {
    stake_point(point_height, point_top_radius, point_tip_cutoff, point_thickness);
    circle_at_top_of_point(point_top_radius, cap_divider_thickness);

    translate([0, 0, cap_divider_thickness])
      cap_riser(cap_riser_height, cap_riser_width, cap_circle_offset, cap_riser_thickness);
  }
}

stake(point_height,
  point_top_radius,
  point_tip_cutoff,
  point_thickness,
  cap_divider_thickness,
  cap_riser_height,
  cap_riser_width,
  cap_riser_thickness,
  cap_circle_offset
);