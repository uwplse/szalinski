// Thickness of outer ring wall.
outer_ring_thickness = 2.5;
outer_ring_od = 158;
blade_thickness = 1.7;
blade_angle = -20;
hub_od = 19.5;
slot_width = 11.25;
slot_length = 6;

// Overall height of the whole propeller.
thickness = 5.5;

// Rotational offset of first blade (to match originals).
rotational_offset = 90;

// Number of blades.
n_blades = 3;

/* [Hidden] */
slop = 0.1;

module ring() {
  difference() {
    cylinder(h = thickness + slop, r = outer_ring_od/2, center = true, $fa = 5, $fs = 0.5);
    cylinder(h = thickness + 2*slop, r = outer_ring_od/2 - outer_ring_thickness, center = true, $fa = 5, $fs = 0.5);
  }
}

module blade() {
  difference() {
    difference() {
      rotate([blade_angle, 0, 0])
      translate([0, -25, -blade_thickness/2])
      cube([outer_ring_od/2 - outer_ring_thickness/2, 50, blade_thickness]);
    }
    translate([0, 0, thickness/2 + 10])
    cube([outer_ring_od, outer_ring_od, 20], center=true);
    translate([0, 0, -(thickness/2 + 10)])
    cube([outer_ring_od, outer_ring_od, 20], center=true);
  }
}

module blades() {
  for (i = [0 : n_blades - 1]) {
    rotate([0, 0, rotational_offset + i * 360/n_blades]) blade();
  }
}

module slot() {
  intersection() {
    cylinder(h = 2*thickness, r = slot_width/2, center = true);
    cube([slot_width + slop, slot_length, 2*thickness], center = true);
  }
}

module hub() {
  difference() {
    cylinder(h = thickness + slop, r = hub_od/2, center = true);
  }
}

difference() {
  union() {
    ring();
    blades();
    hub();
  }
  slot();
}