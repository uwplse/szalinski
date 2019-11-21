// Number of links along the x-axis
x_length = 1;

// Number of links along the y-axis
y_length = 1;

/* [Hidden] */
$fn = 20;

ring_torus_radius = 4.5;
ring_tube_radius = 0.5;
radial_offset = 2.75;
link_spacing = 13;
link_width = 11;

sheet(x_length, y_length);

/* Begin modules! */

module sheet(links_count_x, links_count_y) {
  for (x=[0:links_count_x-1]) {
    for (y=[0:links_count_y-1]) {
      translate([link_spacing * x, link_spacing * y, 0]) link();
    }
  }
}

module link() {
  supports();
  rings();
  translate([0, 0, -4]) cube([link_width, link_width, 2], center= true);
}

module supports() {
  for(i = [0:3]) {
    scale(0.75) rotate([0, 0, 45 + (90 * i)]) translate([0, 5, 0]) rotate([0, 90, 0]) support();
  }
}

module support() {
  translate([0, 0, -0.5])
  linear_extrude(1)
  difference() {
    union() {
      circle(d = 9);
      translate([0, -4.5]) square([4.5, 9]);
    }
    translate([0, 2.5, 0]) circle();
  }
}

module rings() {
  for(i = [0:90:270]) {
    translate([sin(i) * radial_offset, -cos(i) * radial_offset, 0]) rotate([0, 0, i]) angled_ring();
  }
  cylinder(d=10, h=7.5, center=true);
}

module angled_ring() {
  rotate([-45, 0, 90]) ring();
}
module ring() {
   rotate([90, 0, 0])
   rotate_extrude()
   translate([ring_torus_radius, 0, 0])
   circle(r = ring_tube_radius);
}
