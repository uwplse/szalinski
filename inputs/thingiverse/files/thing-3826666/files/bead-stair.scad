beads = 2;
resolution = 42;

union() {

  // beginning torus
  rotate_extrude(convexity = 10, $fn = resolution)
    translate([6/2-(1.75/2), 0, 0])
    circle(r = 1.75/2, $fn = resolution);

  // spheres
  for (a = [0:beads-1]) {
    translate([6+(6.5*a),0,0])
      sphere(d=7,$fn=resolution);
  }

  // ending torus
  translate([6+(6.5*(beads-1))+6,0,0])
    rotate_extrude(convexity = 10, $fn = resolution)
    translate([6/2-(1.75/2), 0, 0])
    circle(r = 1.75/2, $fn = resolution);
}
