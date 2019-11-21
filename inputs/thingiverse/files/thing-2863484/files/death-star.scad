//!OpenSCAD

radius = 50;
color([0.2,0.2,0.2]) {
  difference() {
    difference() {
      sphere(r=radius);

      // torus
      rotate_extrude($fn=100) {
        translate([radius, 0, 0]) {
          circle(r=2, $fn=100);
        }
      }
    }

    translate([40, 0, 30]){
      sphere(r=15);
    }
  }
}
