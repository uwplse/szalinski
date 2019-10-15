// A kitchen hook thingie
// by Cristian Sandu

hook_dia = 20; // mm
hook_width = 2;
hook_depth = 3;

module hook() {
  difference() {
    cylinder(r = hook_dia / 2 + hook_depth, h = hook_width, center=true);
    cylinder(r = hook_dia / 2, h = hook_width + hook_depth , center=true);
  }
}

module base() {
   translate([-hook_dia / 2 - hook_depth / 1.5, 0, hook_width * 2]) {
    rotate([90, 0, 0]) {
      cube(size=[hook_width, hook_dia / 2, hook_width * 5], center=true);
    }
  }
}

difference() {
  union() {
    base();
    hook();
  }

  translate([0, -hook_dia / 2, 0]) {
    cube(size=[hook_dia, hook_dia, hook_width * 2], center=true);
  }
}
