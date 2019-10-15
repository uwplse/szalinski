bearing_height = 7.25;
bearing_outer_diameter = 22.38;
bearing_inner_diameter = 7.89;
link_length = 45;
$fn = 50;

module press_fit_link(
  bearing_height,
  bearing_outer_diameter,
  bearing_inner_diameter,
  link_length,
  outer_diameter_margin=3,
  inner_diameter_margin=2,
  link_layer_margin=1.8,
) {
  link_width = bearing_inner_diameter + inner_diameter_margin;

  module negative() {
    translate([0, 0, -1])
    cylinder(h=bearing_height + 2, d=bearing_outer_diameter);
  }

  module positive() {
    cylinder(h=bearing_height, d=bearing_outer_diameter + outer_diameter_margin);

    translate([0, -link_width / 2, 0])
    cube([link_length, link_width, bearing_height]);

    translate([link_length, 0, 0]) {
      cylinder(h=bearing_height + link_layer_margin, d=link_width);
      cylinder(h=bearing_height * 2 + link_layer_margin, d=bearing_inner_diameter);
    }
  }

  difference() {
    positive();
    negative();
  }
}

press_fit_link(
  bearing_height=bearing_height,
  bearing_outer_diameter=bearing_outer_diameter,
  bearing_inner_diameter=bearing_inner_diameter,
  link_length=link_length
);

