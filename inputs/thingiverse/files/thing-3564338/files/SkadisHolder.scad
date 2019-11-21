function sum(v, i = 0, r = 0) = i < len(v) ? sum(v, i + 1, r + v[i]) : r;

// The number of rows the holder should span
rows = 1;
// An array of hole diameters
holes = [5, 18];
// An array with spaces corresponding to each hole
widths = [15, 25];
// A tolerance subtracted from the holder dimensions
tolerance = 0.1;

module hooks(rows = 1, holes, uppers) {
  width = 40*(rows) + 3;
  depth = max(uppers);
  difference() {
    minkowski() {
      sphere(r=0.5 - tolerance, $fn=10);
      union() {
        for (i = [0:40:(40*rows)]) {
          translate([i, 0, 0]) {
            cube([3, 10, 3]);
            cube([3, 3, 10]);
          }
        }
        translate([0, 10, 0])
          cube([width, 3, 20]);
        translate([0, 13, 0])
          cube([width, depth, 3]);
      }
    }
    translate([0, 13, -1]) {
      offset = (width - sum(uppers)) / 2;
      uppers_with_dummy = concat([0], uppers);
      hole_offsets = 
        [for (i = [1:len(uppers_with_dummy) - 1]) 
          sum(uppers_with_dummy, i) - uppers_with_dummy[i]/2];
      for (i = [0:len(hole_offsets) - 1]) {
        translate([hole_offsets[i] + offset, depth/2, -1])
          cylinder(d=holes[i] + 1, h=8);
      }
    }
  }
}

hooks(rows, holes, widths);
