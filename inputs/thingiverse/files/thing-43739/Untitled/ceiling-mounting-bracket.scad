// author: clayb.rpi@gmail.com
// date: 2013-01-20
// units: mm
//
// description: A standoff bracket for mounting things to a ceiling.

// The width of the thing you are mounting.
THING_WIDTH = 23;

// The height of the thing you are mounting.
THING_HEIGHT = 5;

// The depth of the fingers grasping the thing you are mounting.
FINGER_DEPTH = 3;

// Distance from the wall the thing should be kept.
STANDOFF_HEIGHT = 15;

// How thick the walls of the bracket should be.
WALL_THICKNESS = 2;

// The printing height of the bracket.
BRACKET_HEIGHT = 6;

// The radius of the screw hole.
MOUNTING_SCREW_RADIUS = 2.5;


module ceilingMountingBracket($fn=24) {
  assign(outer_depth=2 * WALL_THICKNESS + THING_HEIGHT + max(0, STANDOFF_HEIGHT),
         outer_width=THING_WIDTH + 2 * WALL_THICKNESS,
         mounting_screw_height=max(BRACKET_HEIGHT / 2, WALL_THICKNESS + MOUNTING_SCREW_RADIUS)) {
    difference() {
      union() {
        // The rough shape of the bracket.
        cube([outer_depth, outer_width, BRACKET_HEIGHT]);

        // extra support for the mounting screw.
        translate([0, outer_width / 2, mounting_screw_height])
        rotate([0, 90, 0])
        cylinder(r=MOUNTING_SCREW_RADIUS + WALL_THICKNESS, h=WALL_THICKNESS);
      }

      // cut away the spot for the thing being mounted.
      translate([WALL_THICKNESS + max(0, STANDOFF_HEIGHT), WALL_THICKNESS, -1])
      cube([THING_HEIGHT, THING_WIDTH, BRACKET_HEIGHT + 2]);

      // cut away the core of the bracket.
      translate([WALL_THICKNESS, WALL_THICKNESS + FINGER_DEPTH, -1])
      cube([outer_depth, THING_WIDTH - 2 * FINGER_DEPTH, BRACKET_HEIGHT + 2]);

      // cut away the mounting screw hole.
      translate([-1, outer_width / 2, mounting_screw_height])
      rotate([0, 90, 0])
      cylinder(r=MOUNTING_SCREW_RADIUS, h=WALL_THICKNESS + 2);

      // cut away excess volume from the arms.
      translate([WALL_THICKNESS, WALL_THICKNESS, WALL_THICKNESS])
      cube([max(0, STANDOFF_HEIGHT - WALL_THICKNESS), THING_WIDTH, BRACKET_HEIGHT]);
    }
  }
}
ceilingMountingBracket();
