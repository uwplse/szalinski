// preview[vi5ew:south, tilt:top]

// Grading thickness
// Images
// Text / Letters
// Colour

/* [Main] */

//how wide to make the guitar pick
base = 25;

//how tall to make the guitar pick
height = 30;

//how thick to make the guitar pick
thickness = 1;

//how rounded to make the corners
radii = [4, 4, 2.5];

//how curved to make the base (0 is straight)
curve = 25;

//adjusts how close the curve is to the center of the pick
curve_offset = 1.4;

//how smooth to render all circles
smooth = 100;

module pick(base, height, t, r, curve, co) {
  r0 = max(radii[0], 0.01);
  r1 = max(radii[1], 0.01);
  r2 = max(radii[2], 0.01);

  lw = r0 + r1;
  lh = r2 + max(r0, r1);

  hull()
  {
    translate([r0, r0, 0]) {
      cylinder(r=r0, h=t, $fn=smooth);
    }

    translate([base-r1, r1, 0]) {
      cylinder(r=r1, h=t, $fn=smooth);
    }

    translate([(base-r1+r0)/2, height-lh, 0]) {
      cylinder(r=r2, h=t, $fn=smooth);
    }

    if (curve > 0) {
translate([base/2, curve-co, 0])
difference() {
  rotate_extrude($fn=smooth)
    translate([curve-.01, 0, 0])
      square([.01, t]);
  translate([base/2-lw/2, -curve, -1])
    cube([curve, curve*2, t+1]);
  translate([-curve, 0, -1])
    cube([curve*2, curve, t+1]);
  translate([-curve-(base/2-lw/2), -curve, -1])
    cube([curve, curve, t+1]);
}
    }
  }
}

pick(base, height, thickness, radii, curve, curve_offset);
