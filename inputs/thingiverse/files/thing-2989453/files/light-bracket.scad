$fs = 0.5;
$fa = 0.5;
rail_diameter = 7.5;
cutout_diameter = 38;
cutout_depth = 7;
rail_separation = 36;
base_length = 20;
tie_width = 3;
tie_depth = 2;
gap = 8;
mount_diameter = 25;
mount_height = 22;
saddle_angle = 10;
lip = 2;
base_thickness = rail_diameter - 0.5;
base_width = rail_separation + rail_diameter * 0.5;
wall = 2;
$e = 0.001;

module tie_hole() {
  translate([wall - rail_separation / 2, 0, -$e])
    cube([tie_depth, tie_width, base_thickness + 2*$e]);
}

module base() {
  difference() {
    translate([-base_width / 2, 0, 0])
      cube([base_width, base_length, base_thickness]);
    for (kx = [-1, 1]) {
      translate([kx * (rail_separation + rail_diameter) / 2, -$e, base_thickness / 2])
        rotate([-90, 0, 0])
          cylinder(r = rail_diameter / 2, h = base_length + 2*$e);
    }
    translate([0, cutout_depth - cutout_diameter / 2, -$e])
      cylinder(r = cutout_diameter / 2, h = base_thickness + 2*$e);

    for (y = [2 * wall, base_length - wall - tie_width]) {
      translate([0, y, 0]) {
        tie_hole();
        mirror([1, 0, 0]) tie_hole();
      }
    }
  }
}

module lamp_mount() {
  r = mount_diameter / 2;
  foot = 2 * base_thickness + r * tan(saddle_angle);
  translate([0, cutout_depth + gap + mount_diameter / 2, -base_thickness]) {
    rotate([saddle_angle, 0, 0]) {
      rotate_extrude() {
        polygon([
          [0, 0],
          [r + lip, 0],
          [r + lip, foot - lip],
          [r, foot],
          [r, foot + mount_height],
          [r + lip, foot + mount_height + lip],
          [r + lip, foot + mount_height + 2 * lip],
          [0, foot + mount_height + 2 * lip]
        ]);
      }
    }
  }
}

difference() {
  union() {
    base();
    lamp_mount();
  }
  translate([-100, -100, -100])
    cube([200, 200, 100]);
}
