difference() {
  translate([10.0000000000, 10.0000000000, 1.5000000000]) {
    scale([20.0000000000, 20.0000000000, 3.0000000000]) {
        cube([1, 1, 1], center = true);
    }
  }
  for (i = [0:1]) {
      for (j = [0:1]) {
          translate([10 * i + 5, 10 * j + 5, 0])
          scale([3.2, 3.2, 3])
            cylinder($fn = 6, true);
      }
  }
}
