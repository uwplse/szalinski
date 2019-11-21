// Wheel radius
radius = 18;
// Wheel width
width = 12;
// Outside radius of the centre shaft
shaft_od = 4;
// Inside radius of the outer ring
outside_id = 14;

// D hole diameter. This works for me for a 3mm shaft.
motor_shaft_diameter = 3.2;
// How far from the outside of the shaft to place the flat
motor_shaft_flat = 0.8;
// The length of the shaft
shaft_length = 10;

// The thickness of the circles between the hub and the rim.
// Smaller values should make a more flexible wheel.
spoke_thickness = 1;
spoke_width = 6;

// How wide to make the groove
groove_width = 2;

$fn = 96;

module hole(d, f, h, od) {
  difference() {
    cylinder(d=d, h=h, $fn=30);
    translate([-(d/2) + f - 2, -d/2, 0]) cube([2, d, h]);
  }
}

module radial_indent(r, d) {
  rotate_extrude($fn=96)
    translate([r-1, 0, 0])
    polygon(points=[[0,0],[d,d],[d,-d]]);
}

difference() {
  union() {
    cylinder(r=shaft_od, h=shaft_length);
    difference() {
      cylinder(r=radius, h=width);
      cylinder(r=outside_id, h=width);
    }
    for (a = [0, 120, 240]) {
      id = outside_id - shaft_od;
      rotate([0, 0, a])
      translate([id/2 + shaft_od, 0, 0])
      difference() {
        cylinder(d=id + spoke_thickness * 2, h=spoke_width);
        cylinder(d=id, h=spoke_width);
      }
    }
  }
  cylinder(r1=2.5, r2=0, h=2.5); // bevel
  hole(motor_shaft_diameter, motor_shaft_flat, shaft_length, shaft_od);
  translate([0, 0, width/2])
    radial_indent(radius, groove_width / 2);
}
