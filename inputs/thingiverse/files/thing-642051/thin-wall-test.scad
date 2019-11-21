// Thin walls 3D printer test pattern.

/* [Global */

// List of wall widthes [mm].
wall_widthes = [0.8, 1.0, 1.2, 1.4, 1.8, 1.8, 2.0];

// Wall height above the base [mm].
wall_height = 5;

// Wall length [mm].
wall_length = 20;

// Wall spacing [mm].
wall_pitch = 10;

// Base height [mm].
base_height = 0.8;

module one_wall(i, w, h) {
  echo("wall:", i, w);
  x = i * wall_pitch;
  translate([x, 0, 0]) cube([w, wall_length, h]);
}

module all_walls(h) {
  for (i = [ 0 : len(wall_widthes) - 1 ]) {
    one_wall(i, wall_widthes[i], h); 
  }
}

module base() {
  hull() {
    translate([wall_pitch/2, 0, 0]) all_walls(base_height);
    translate([-wall_pitch/2, 0, 0]) all_walls(base_height);
  }
}

module main() {
  all_walls(base_height + wall_height);
  base();
}

main();

