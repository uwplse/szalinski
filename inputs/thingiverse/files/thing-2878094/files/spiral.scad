min_size = 1;
box_size = 4/10;
rotate_y = 2;
rotate_z = 20;
translate_x = 1/1.3;
translate_z = 1/10;

module box(a, b) {
  length = box_size * a + min_size;
  rotate([0, b*rotate_y, a*rotate_z])
  translate([a*translate_x, 0, b*a*translate_z])
  cube([length, length, length]);
}

difference() {
  for (b = [0:1:10]) {
    for (a = [0:1:30]) {
      hull() {
        box(a, b);
        box(a, b + 1);
      }
    }
  }

  translate([0, 0, -500])
  cube([1000, 1000, 1000], center=true);
}
