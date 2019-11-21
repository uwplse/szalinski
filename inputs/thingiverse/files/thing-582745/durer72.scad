//////////////////////////////////////////////////////////////////////////////////////////
//  
//  'Dürer's Solid (72°)' by Chris Molloy (http://chrismolloy.com/durer)
//  
//  Released under Creative Commons - Attribution - Share Alike licence
//  
//  For more information see:
//  https://en.wikipedia.org/wiki/Melencolia_I
//  https://en.wikipedia.org/wiki/Truncated_triangular_trapezohedron#D.C3.BCrer.27s_solid
//  http://mathworld.wolfram.com/DuerersSolid.html
//  
//////////////////////////////////////////////////////////////////////////////////////////

// Length of edge of cube base (resulting polyhedron will be ≈1.6 times this high)
scale_base = 25; // mm

/* Hidden */
zz = 1 / sqrt(3); // ≈ 0.57735
theta = acos(zz); // ≈ 54.73561°

stretch_72 = sqrt(1 + (3 / sqrt(5))); // ≈ 1.53024
unit_height_72 = sqrt((23 / sqrt(5)) - 0.25) / 2; // ≈ 1.58398
drop_72 = ((sqrt(3) * stretch_72) - unit_height_72) / 2; // ≈ 0.53324

module unit_cube() {
  rotate([0, 0, -15]) {
    rotate(a = theta, v = [1, -1, 0]) {
      cube([scale_base, scale_base, scale_base]);
    }
  }
}

module durers_solid(drop, stretch, unit_height) {
  difference() {
    translate([0, 0, -drop * scale_base]) {
      scale([1, 1, stretch]) {
        unit_cube();
      }
    }
    translate([0, 0, -scale_base / 2]) {
      cube([scale_base, scale_base, scale_base], center = true);
    }
    translate([0, 0, (unit_height * scale_base) + (scale_base / 2)]) {
      cube([scale_base, scale_base, scale_base], center = true);
    }
  }
}

durers_solid(drop_72, stretch_72, unit_height_72);