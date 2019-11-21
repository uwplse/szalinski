_1_depth = 10;
_2_inner_depth = 5;
_3_outer_diameter = 4;
_4_inner_diameter = 1.5;
_5_wire_diameter = 1;
_6_wire_jut = 0.1;
_7_wall_thickness = 2;

module barrel_connector(
  depth = 10,
  inner_depth = 5,
  outer_diameter = 4,
  inner_diameter = 2,
  wire_diameter = 1.3,
  wire_jut = 0.1,
  wall_thickness = 2) {
  $fn=32;
  difference() {
    or = outer_diameter / 2;
    ir = inner_diameter / 2;
    wr = wire_diameter / 2;
    wt = wall_thickness;
    translate([-or-wt, -or-wt, 0]) 
      cube([2 * wt + outer_diameter, 2 * wt + outer_diameter, depth + wt]);
    translate([-or-wr+wire_jut, 0, 0])
      cylinder(r=wr, h=depth+wt);// outer wire
    translate([ir-wr+wire_jut, 0, 0])
      cylinder(r=wr, h=depth+wt);// inner wire
    translate([0, 0, wt])
      difference() {
        cylinder(r=or, h=depth); // outer barrel
        cylinder(r=ir, h=inner_depth); // inner barrel
      }
  }
}

barrel_connector(
  _1_depth,
  _2_inner_depth,
  _3_outer_diameter,
  _4_inner_diameter,
  _5_wire_diameter,
  _6_wire_jut,
  _7_wall_thickness);

