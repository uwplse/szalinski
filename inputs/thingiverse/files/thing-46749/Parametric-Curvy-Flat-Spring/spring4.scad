/* Begin customizer.makerbot.com section. */

length = 150;
number_of_wiggles = 6;
// The portion of the circle that appears in each wiggle
angle = 240; // [180:360]
// The width of the band of material
width = 10;
height = 10;
// Circles are n-gons.  Choose n
resolution = 100;

/* End customizer.makerbot.com section. */




module ring(outer, inner, h) {
  difference() {
    cylinder(h=h, r=outer);
    cylinder(h=h, r=inner);
  }
}

module arc_of_cylinder(r, h, angle /* angle must be <= 180 */) {
  half_angle = 90 - (angle / 2);
  difference() {
    cylinder(h=h, r=r);
    rotate(half_angle) translate([-r,0,0]) cube(size=r*2);
    rotate(-half_angle) translate([-r,0,0]) cube(size=r*2);
  }
}

module arc_of_ring(outer, inner, h, angle /* must be 180 <= angle <= 360 */) {
  difference() {
    ring(outer, inner, h);
    arc_of_cylinder(r=2*outer, h=h, angle=360 - angle);
  }
}

module spring4(length, n, angle /* must be 180 <= angle <= 360 */, width, height) {
  useful_intermediate_angle = 180 - angle / 2;
  echo(useful_intermediate_angle);
  path_radius = length / (2 * n * sin(useful_intermediate_angle));
  echo(path_radius);
  half_width = width / 2;
  inner = path_radius - half_width;
  outer = path_radius + half_width;  
  x_spacing = length / n;
  y_offset = length / (2 * n * tan(useful_intermediate_angle));
  epsilon = y_offset / 10000;   // Grr.
  adjusted_y_offset = y_offset - epsilon;
  union() for (i = [0 : n-1]) {
    translate([x_spacing * i, 0, 0])
      rotate([0,0,180 * i])   // mirror() works better
      translate([0, adjusted_y_offset, 0])
      arc_of_ring(outer, inner, height, angle);
  }
}

// With args from customizer.makerbot.com section above
spring4(length, number_of_wiggles, angle, width, height, $fn=resolution);
