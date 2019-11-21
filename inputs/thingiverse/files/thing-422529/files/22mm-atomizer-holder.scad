// Center piece is the middle cylinder
// Outer piece is the square shell with interlocks
center_piece();
outer_piece();

AtomizerSize = 22;

_InternalAtomizerSize = AtomizerSize + 1;

module center_piece() {
  difference() {
    cylinder(h=8, d=_InternalAtomizerSize, $fn=100);
    translate([0, 0, 2]) cylinder(h=6, d=7.5, $fn=100);
  }
}

module outer_piece() {
  difference() {
    translate([-18.5, -18.5, 0]) cube(size=[34, 34, 12]);
    cylinder(h=12, d=_InternalAtomizerSize, $fn=100);
    translate([-18.5, 0, 0]) trap();
    translate([0, -18.51, 0]) rotate(90) trap();
  }
  translate([15.5, 0, 0]) scale([0.95, 0.95, 1]) trap();
  translate([0, 15.5, 0]) rotate(90) scale([0.95, 0.95, 1]) trap();
}

module trap() {
  polyhedron(points = [[0, 5, 0], [3, 7, 0],
      [3, -7, 0], [0, -5, 0], [0, 5, 12], [3, 7, 12],
      [3, -7, 12], [0, -5, 12]],
      faces = [[3, 2, 1, 0], [4, 5, 6, 7],
      [0, 1, 5, 4], [1, 2, 6, 5], [2, 3, 7, 6],
      [3, 0, 4, 7]]);
}
 