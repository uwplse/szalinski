$fn=50;

CORNER_RADIUS = 4;

// thickness of the shield
SHEILD_THICKNESS = 1.5;

// length, thickness and height of the clip that attaches to the glasses
CLIP_LENGTH = 20;
CLIP_THICKNESS = 1;
CLIP_HEIGHT = 10;

// width of the glasses arm
ARM_WIDTH = 2;

// by default the blinder for the right is rendered. Enable mirroring to render the left side
MIRROR = false;

//  only render the arm clip in order to test sizing.
ONLY_PRINT_CLIP = false;

module blinder() {
  // shield
  hull() {
      translate([-45, 5, 0]) cylinder(SHEILD_THICKNESS, r = CORNER_RADIUS); // top - front
      translate([30, 5, 0]) cylinder(SHEILD_THICKNESS, r = CORNER_RADIUS); // top - back
      translate([30, -20, 0]) cylinder(SHEILD_THICKNESS, r = CORNER_RADIUS); // bottom - back
      translate([-45, -40, 0]) cylinder(SHEILD_THICKNESS, r = CORNER_RADIUS); // bottom - front
  }

  // clip - horizontal part
  cube([CLIP_LENGTH, CLIP_THICKNESS, ARM_WIDTH + CLIP_THICKNESS + SHEILD_THICKNESS]);

  // clip - vertical part
  translate([0, 0, SHEILD_THICKNESS + ARM_WIDTH]) rotate([90, 0, 0]) cube([CLIP_LENGTH, CLIP_THICKNESS, CLIP_HEIGHT]);
}

if (ONLY_PRINT_CLIP) {
  intersection() {
    blinder();
    translate([-5, -(CLIP_HEIGHT + 5), 0]) cube([CLIP_LENGTH + 10, 100, SHEILD_THICKNESS + ARM_WIDTH + CLIP_THICKNESS]);
  }
} else {
  if (MIRROR) {
    mirror([1, 0, 0]) blinder();
  } else {
    blinder();
  }
}
