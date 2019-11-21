// A dummy object to increase the cooling time of the real printed object.


/* [Global] */

// Should be at least the height of your 'real' printed object.
total_height = 40;
base_diameter = 15;
base_height = 1;
cone_bottom_diameter = 8;
cone_top_diameter = 5;
cone_wall_thickness = 1.2;
// For debugging. Normally should be 0.
cross_cut = 0;

/* [Hidden] */

// Small, greater than zero values to maintain manifold.
eps=0.001;
eps2 = 2*eps;

$fn=32;

module base() {
  cylinder(d=base_diameter, h=base_height);
}

module cone_body() {
  translate([0, 0, base_height-eps]) cylinder(
      d1=cone_bottom_diameter, 
      d2=cone_top_diameter, 
      h=total_height - base_height + eps);
}

module cone_hole() {
  translate([0, 0, base_height]) cylinder(
      d1=cone_bottom_diameter-2*cone_wall_thickness, 
      d2=cone_top_diameter-2*cone_wall_thickness, 
      h=total_height - base_height + eps);
}

module main() {
  difference() {
    union() {
      base();
      cone_body();
    }
    cone_hole();
    if (cross_cut) {
      translate([0, 0, -eps]) cube([base_diameter, base_diameter, total_height+eps2]);
    }
  }
}

main();

