/* [General] */
layout = "all";
extrusion_width = .38;
wall_width = extrusion_width * 4;
base_height = 4;

/* [Mounting Hole] */
mount_hole_major_axis = 17.25;
mount_hole_minor_axis = 10;
// Measured off the bottom of the mount (includive of base_height).
mount_block_height = 12;
clearance = 0.1;
// Offset off front wall of gantry clamp to place the iSight edge.
y_offset = 10;
// Offset off side wall of gantry clamp to place mounting block.
x_offset = 40;

/* [Hidden] */
isight_radius = 35/2;
r = mount_hole_minor_axis/2;
$fn = 50;

module isight_mount(h = 5, c = clearance) {

  linear_extrude(height = h, center = true)
  difference() {
    hull() {
      translate([0, r]) circle(r + c + wall_width);
      translate([0, mount_hole_major_axis - r]) circle(r + c + wall_width);
    }
    hull() {
      translate([0, r]) circle(r + c);
      translate([0, mount_hole_major_axis - r]) circle(r + c);
    }
  }
}

module mount_test() {
  for (i = [0 : 3]) {
    translate([i * 15, 0]) mount(c = .1 * i);
  }
}

module hole(h, c = clearance) {
  linear_extrude(height = h, center = true)
  hull() {
    translate([0, r]) circle(r + c);
    translate([0, mount_hole_major_axis - r]) circle(r + c);
  }
}

module all() {
  difference() {
    union() {
      translate([-43, 0, 0])
      cube([43, 8, base_height]);

      translate([-8, -(y_offset + isight_radius + r + wall_width), 0])
      cube([8, y_offset + isight_radius + r + wall_width + 53, base_height]);

      translate([-8, -(y_offset + isight_radius + r + wall_width), 0])
      cube([8 + x_offset + mount_hole_major_axis + 2*wall_width, mount_hole_minor_axis + 2*wall_width, base_height]);

      translate([x_offset, -(y_offset + isight_radius + r + wall_width), 0])
      cube([mount_hole_major_axis + 2*wall_width, mount_hole_minor_axis + 2*wall_width, mount_block_height]);
    }

    translate([x_offset + wall_width, -y_offset - isight_radius, mount_block_height])
    rotate([0, 0, -90]) hole(h = 60);
  }
}

if (layout == "isight_mount_test") mount_test();
else all();