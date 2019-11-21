// Thickness of separation
sep = 1.5;

module z_top_sep_base() {
  difference() {
    cube([38,16,sep]);
    translate([5,-1,-1]) rotate([0,0,135]) cube([10,10,2+sep]);
  }
}

module z_top_sep_holes() {
  // holes
  translate([9,10,-1]) cylinder(r = 1.8, h = 2+sep, $fn = 10);
  translate([29,10,-1]) cylinder(r = 1.8, h = 2+sep, $fn = 10);
}

module z_top_sep() {
  difference() {
    z_top_sep_base();
    z_top_sep_holes();
  }
}

z_top_sep();
translate([-13,0,0]) mirror([1,0,0]) z_top_sep();