module bolt_hole_cone(
    base_height=3,
    hole_d=2.9,
    wall = 2,
    wall_extra = 3,
    height_extra = 7,
    border = 0.1
) {

  out_d = hole_d + wall * 2;
  
  translate([-out_d/2 - wall_extra, 0, -base_height]) {
    difference() {
      hull() {
        cylinder(d=out_d, h=base_height);
        translate([0, -out_d/2, 0]) {
          cube([out_d/2 + wall_extra, out_d, base_height]);
        }
        translate([out_d/2 + wall_extra-border, -out_d/2, -height_extra]) {
          cube([border, out_d, 1]);
        }
      }
      translate([0, 0, -height_extra]) {
        cylinder(d=hole_d, h=base_height+height_extra);
      }
    }
  }
  
}

$fn = 30;
bolt_hole_cone();

