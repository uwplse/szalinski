// author: clayb.rpi@gmail.com
// date: 2013-02-20
// units: mm
//
// description: A X-axis tensioner for the original printed printrbot.
//
// extra hardware needed:
//   - 2 M4 machine screws + nuts (JIS)
//   - 1 small ziptie

/*******************
 * measured values *
 *******************/

// How wide the belt is
BELT_WIDTH = 7;

// The thickness of the belt.
BELT_THICKNESS = 3;

// The depth of the gaps in the belt.
BELT_GAP_DEPTH = 1.1;

// The width of the gaps in the belt.
BELT_GAP_WIDTH = 2;

// The distance between repeated features in the belt.
BELT_GAP_SPACING = 5;

// How wide the mounting point is.
MOUNT_WIDTH = 17.75;

// How deep the mounting point is (only used for visualization).
MOUNT_DEPTH = 20;

// How high the mounting point is.
MOUNT_HEIGHT = 6;

// The side-size of the inner mounting point sqare (only used for visualization).
MOUNT_INNER_SQUARE = 7;

// How thick the walls should be.
WALL_THICKNESS = 3;

// How thick any bracing walls should be.
THIN_WALL_THICKNESS = 2;

// The diameter of the screws to be used.
SCREW_HOLE_DIAMETER= 3;

// The width of the nuts to be used as measured from flat sides.
NUT_SHORT_WIDTH = 5.5;

// The height of the nuts to be used.
NUT_HEIGHT = 2.14;


/*********************
 * calculated values *
 *********************/
$fn=24 + 0;

TOP_PART_WIDTH = max(NUT_SHORT_WIDTH + THIN_WALL_THICKNESS, WALL_THICKNESS);
TOP_PART_HEIGHT = 2 * BELT_WIDTH;

BOTTOM_HEIGHT = MOUNT_HEIGHT + BELT_THICKNESS + 3 * WALL_THICKNESS + THIN_WALL_THICKNESS;
BOTTOM_WIDTH = max(
    /* mount is the limiting factor */ MOUNT_WIDTH + 2 * WALL_THICKNESS + NUT_HEIGHT,
    /* if we have thick belts */ TOP_PART_WIDTH + 2 * BELT_THICKNESS + 4 * WALL_THICKNESS);
BOTTOM_DEPTH = BELT_WIDTH + 2 * WALL_THICKNESS;


/*
 * A small piece to actually grip the belt for tensioning.
 */
module top_piece() {
  difference() {
    union() {
      cube([BELT_WIDTH, TOP_PART_WIDTH, TOP_PART_HEIGHT]);
      for (h = [0 : BELT_GAP_SPACING : 2 * BELT_WIDTH - BELT_GAP_WIDTH]) {
        translate([0, -BELT_GAP_DEPTH, h])
        cube([BELT_WIDTH, TOP_PART_WIDTH + 2 * BELT_GAP_DEPTH, BELT_GAP_WIDTH]);
      }
    }

    // cut out slots for the tensioner nut and screw.
    translate([BELT_WIDTH / 2, TOP_PART_WIDTH / 2, -1])
    nut_hole(h = NUT_HEIGHT + 1);

    translate([BELT_WIDTH / 2, TOP_PART_WIDTH / 2, -1])
    cylinder(r = SCREW_HOLE_DIAMETER / 2, h = TOP_PART_HEIGHT + 2);
  }
}

/*
 * The bottom bracket piece of the tensioner.
 */
module bottom_piece() {
  difference() {
    union() {
      // bottom side.
      cube([BOTTOM_DEPTH, BOTTOM_WIDTH, WALL_THICKNESS]);

      // support beam.
      translate([0, 0, WALL_THICKNESS + MOUNT_HEIGHT])
      cube([BOTTOM_DEPTH, BOTTOM_WIDTH, THIN_WALL_THICKNESS]);

      // fill in the area around the mounting point.
      if (BOTTOM_WIDTH - 2 * WALL_THICKNESS - MOUNT_WIDTH -0.001 > NUT_HEIGHT) {
        translate([0, WALL_THICKNESS + NUT_HEIGHT + MOUNT_WIDTH, WALL_THICKNESS])
        cube([BOTTOM_DEPTH, BOTTOM_WIDTH - 2 * WALL_THICKNESS - MOUNT_WIDTH - NUT_HEIGHT, MOUNT_HEIGHT]);
      }

      // sides.
      cube([BOTTOM_DEPTH, WALL_THICKNESS, BOTTOM_HEIGHT]);

      translate([0, BOTTOM_WIDTH - WALL_THICKNESS])
      cube([BOTTOM_DEPTH, WALL_THICKNESS, BOTTOM_HEIGHT]);

      // Rounded areas for the bet interface.
      translate([0, WALL_THICKNESS, BOTTOM_HEIGHT - WALL_THICKNESS])
      rotate([0, 90, 0])
      cylinder(r=WALL_THICKNESS, h=BOTTOM_DEPTH);

      translate([0, BOTTOM_WIDTH - WALL_THICKNESS, BOTTOM_HEIGHT - WALL_THICKNESS])
      rotate([0, 90, 0])
      cylinder(r=WALL_THICKNESS, h=BOTTOM_DEPTH);
    }

    // cut out a hole for the belt.
    translate([WALL_THICKNESS, -1, WALL_THICKNESS + MOUNT_HEIGHT + THIN_WALL_THICKNESS])
    cube([BELT_WIDTH, BOTTOM_WIDTH + 2, BELT_THICKNESS]);

    // cut out a hole for the bracing screw.
    translate([BOTTOM_DEPTH / 2, -1, WALL_THICKNESS + MOUNT_HEIGHT / 2])
    rotate([-90, 0, 0])
    cylinder(r=SCREW_HOLE_DIAMETER / 2, h=WALL_THICKNESS + 2);

    translate([BOTTOM_DEPTH / 2, WALL_THICKNESS - THIN_WALL_THICKNESS, WALL_THICKNESS + MOUNT_HEIGHT / 2])
    rotate([-90, 0, 0])
    nut_hole(h=2 * NUT_HEIGHT);

    // cut out a hole for the tensioning screw.
    translate([BOTTOM_DEPTH / 2, BOTTOM_WIDTH / 2, WALL_THICKNESS + MOUNT_HEIGHT - 1])
    cylinder(r=SCREW_HOLE_DIAMETER / 2, h=THIN_WALL_THICKNESS + 2);
  }
}

/*
 * A representation of the mounting point on the printrbot for this part.
 */
module mounting_point() {
  difference() {
  	cube([MOUNT_DEPTH, MOUNT_WIDTH, MOUNT_HEIGHT]);

    translate([MOUNT_DEPTH - MOUNT_INNER_SQUARE - 6, (MOUNT_WIDTH - MOUNT_INNER_SQUARE) / 2, -1])
    cube([MOUNT_INNER_SQUARE, MOUNT_INNER_SQUARE, MOUNT_HEIGHT +  2]);
  }
}

/*
 * A cutaway for a nut as measured from the flat sides.
 */
module nut_hole(short_width=NUT_SHORT_WIDTH, h=NUT_HEIGHT) {
  translate([0, 0, h / 2])
  union() {
    for(r = [0, 120, 240]) {
      rotate([0, 0, r])
      cube([(short_width / 2) / cos(30), short_width, h], center=true);
    }
  }
}

/*
 * A module to render all of the pieces in their assembled form.
 */
module pieces_arranged_for_display() {
  bottom_piece();

  translate([WALL_THICKNESS, (BOTTOM_WIDTH - TOP_PART_WIDTH) / 2,
             WALL_THICKNESS + MOUNT_HEIGHT + THIN_WALL_THICKNESS + BELT_THICKNESS])
  top_piece();

  %
  // Visualize the mounting point on the printrbot.
  translate([BOTTOM_DEPTH - MOUNT_DEPTH, WALL_THICKNESS + NUT_HEIGHT, WALL_THICKNESS])
  mounting_point();
}

/*
 * A module to render all of the pieces in their printable form.
 */
module pieces_arranged_for_printing() {
  rotate([0, -90, 0])
  bottom_piece();

  translate([-BOTTOM_HEIGHT, (BOTTOM_WIDTH - TOP_PART_WIDTH) / 2, 0])
  rotate([0, -90, 0])
  top_piece();
}

// pieces_arranged_for_display();
pieces_arranged_for_printing();
