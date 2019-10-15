units = 25.4;

num_headers = 3;
width_in_units = 0.1;
height_in_units = 0.5;
wire_diameter_in_units = 0.04;
inner_width_in_units = 0.06;
wire_jut_in_units = 0.015;
reinforcement_in_units = 0.02;

width = width_in_units * units;
height = height_in_units * units;
inner_width = inner_width_in_units * units;
wire_diameter = wire_diameter_in_units * units;
wire_jut = wire_jut_in_units * units;
reinforcement = reinforcement_in_units * units;

module header_pin(
    width = 0.1 * units,
    height = 0.5 * units,
    inner_width = 0.05 * units,
    wire_diameter = 1,
    wire_jut = 0.02 * units,
    $fn = 20) {
  union() {
    translate([(width - inner_width) / 2, (width-inner_width) / 2, 0])
      cube([inner_width, inner_width, height]);
    translate([width / 2, (width + inner_width + wire_diameter - wire_jut) / 2, 0])
      union() {
        cylinder(r = wire_diameter / 2, h = height);
        translate([-wire_diameter / 2, -wire_diameter / 2 - 0.1, 0])
          cube([wire_diameter, wire_diameter / 2 + 0.1, height]);
      }
    *translate([width / 2, (width + inner_width) / 2, 2 * wire_diameter])
      rotate([-90, 0, 0])
        cylinder(r = wire_diameter / 2, h = (width - inner_width + wire_diameter) / 2);
  }
}

module header_row(
    width = 0.5 * units,
    height = 0.5 * units,
    inner_width = 0.05 * units,
    wire_diameter = 1,
    reinforcement = 0.02 * units,
    wire_jut = 0.02 * units,
    n = 3) {
  difference() {
    cube([width * n, width + wire_diameter + reinforcement - wire_jut, height]);
    for(i = [0:n-1])
      translate([width * i, 0, 0]) {
        header_pin(
            width,
            height,
            inner_width,
            wire_diameter,
            wire_jut);
       }
  }
}

header_row(width, height, inner_width, wire_diameter, reinforcement, wire_jut, num_headers);

