// file: tabletop_fastener
// author: clayb.rpi@gmail.com
// date: 2014-03-17
//
// A tabletop fastener for connecting a tabletop to a slotted rail.
//
// NOTE: The convex corners are rounded to discourage warping while printing.


// The diameter of the screw being used. This affects bracket width.
SCREW_DIAMETER = 4;

// How thick the piece should be. This will need to be less than your slot width.
THICKNESS = 2.5;

// How deep the slot is.
SLOT_DEPTH = 5;

// How offset the slot is from the table top.
SLOT_OFFSET = 10;


$fn=24;

difference() {
  union() {
    linear_extrude(height=SCREW_DIAMETER * 3) {
      hull() {
        circle(r=THICKNESS / 2);
        translate([SLOT_DEPTH, 0])
        circle(r=THICKNESS / 2);
      }
    }

    linear_extrude(height=SCREW_DIAMETER * 3) {
      translate([0, SLOT_OFFSET])
      hull() {
        circle(r=THICKNESS / 2);
        translate([-SCREW_DIAMETER * 3, 0])
        circle(r=THICKNESS / 2);
      }
    }

    translate([-THICKNESS / 2, 0, 0])
    cube([THICKNESS, SLOT_OFFSET, SCREW_DIAMETER * 3]);
  }

  // Cut out a hole for the screw.
  translate([-2 * SCREW_DIAMETER, SLOT_OFFSET - THICKNESS, SCREW_DIAMETER * 3 / 2])
  rotate([-90, 0, 0])
  cylinder(r=SCREW_DIAMETER / 2, h=2 * THICKNESS);
}
