//////////////////////////////////////////////////////////////////////////////////////////
//  
//  'Dürer's Solid (60°)' by Chris Molloy (http://chrismolloy.com/durer)
//  
//  Released under Creative Commons - Attribution - Share Alike licence
//  
//  For more information see:
//  https://en.wikipedia.org/wiki/Melencolia_I
//  https://en.wikipedia.org/wiki/Truncated_triangular_trapezohedron#D.C3.BCrer.27s_solid
//  http://mathworld.wolfram.com/DuerersSolid.html
//  
//////////////////////////////////////////////////////////////////////////////////////////

// Length of edge of cube base (resulting polyhedron will be ≈2.3 times this high)
scale_base = 25; // mm

/* Hidden */
zz = 1 / sqrt(3); // ≈ 0.57735
theta = acos(zz); // ≈ 54.73561°

stretch_60 = 2;
unit_height_60 = (sqrt(3) - zz) * stretch_60; // ≈ 2.30940
drop_60 = ((sqrt(3) * stretch_60) - unit_height_60) / 2; // = zz

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

durers_solid(drop_60, stretch_60, unit_height_60);
