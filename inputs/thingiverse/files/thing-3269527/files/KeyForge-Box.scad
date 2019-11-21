// preview[view:south west, tilt:top diagonal]

/* [Layer Parameters] */
FIRST_LAYER_HEIGHT = 0.27;
LAYER_HEIGHT = 0.18;

function roundToLayers(h) = ceil(h / LAYER_HEIGHT) * LAYER_HEIGHT;

// Thickness in layers of the back of the box
BOTTOM_LAYERS = 2; // [1:10]
BOTTOM_THICKNESS = FIRST_LAYER_HEIGHT + LAYER_HEIGHT * (BOTTOM_LAYERS - 1);

// Number of layers above the top loader bevel
TOP_LAYERS = 2; // [1:10]
TOP_THICKNESS = TOP_LAYERS * LAYER_HEIGHT;

// Thickness around the sides of the top loader in millimeters
SIDE_WALL_THICKNESS = 1.5;

/* [Deck] */

// Sleeves
// DECK_WIDTH = 67.5;
// DECK_HEIGHT = 92;
// DECK_THICKNESS = roundToLayers(23);

// Width of the deck in mm
DECK_WIDTH = 63; // [63:0.5:70]

// Height of the deck in mm
DECK_HEIGHT = 89.5; // [89.5:0.5:95]

// How tall 36 card are in mm
DECK_TARGET_THICKNESS = 13; // [13:0.5:26]
DECK_THICKNESS = roundToLayers(DECK_TARGET_THICKNESS);

/* [Top Loader] */

TOP_LOADER_TARGET_THICKNESS = 1.6;
TOP_LOADER_THICKNESS = roundToLayers(TOP_LOADER_TARGET_THICKNESS);
TOP_LOADER_WIDTH = 77;
TOP_LOADER_HEIGHT = 101;
TOP_LOADER_CORNER_RADIUS = 2;

/* [Text] */
SIDE_TEXT = "#keyforge";
SIDE_TEXT_THICKNESS = 0.45;
SIDE_TEXT_FONT = "Georgia";
SIDE_TEXT_SIZE = 8;


/* [Hidden] */
$fa=5; 
$fs=0.05;

LIP_WALL_THICKNESS = 3;

INNER_LIP_ANGLE = 55;
INNER_LIP_THICKNESS = roundToLayers(
  tan(90 - INNER_LIP_ANGLE) * (LIP_WALL_THICKNESS - SIDE_WALL_THICKNESS)
);

TOP_LOADER_BRACE_WIDTH = 10;
TOP_LOADER_BRACE_HEIGHT = 0.96;
TOP_LOADER_BRACE_THICKNESS = TOP_LOADER_THICKNESS / 2;
TOP_LOADER_BRACE_OFFSET = 15;

THUMB_HOLE_THICKNESS = 2;
THUMB_HOLE_RADIUS = 10;
THUMB_HOLE_OFFSET = 4;

OUTER_WIDTH = TOP_LOADER_WIDTH + 2 * SIDE_WALL_THICKNESS;
OUTER_HEIGHT = TOP_LOADER_HEIGHT + 2 * SIDE_WALL_THICKNESS;
OUTER_THICKNESS =
  BOTTOM_THICKNESS +
  DECK_THICKNESS +
  TOP_LOADER_THICKNESS +
  INNER_LIP_THICKNESS +
  TOP_THICKNESS;

HOLE_WIDTH = OUTER_WIDTH - 2 * LIP_WALL_THICKNESS;
HOLE_HEIGHT = OUTER_HEIGHT - 2 * LIP_WALL_THICKNESS;
HOLE_CORNER_RADIUS = 1.5;
SLIDE_EXTENSION = 20;

OUTER_CORNER_RADIUS = 1.2;

// Set to true to have the key logo on the inside back. Thingiverse customizer
// doesn't support importing DXF files.
DECAL = false;
DECAL_HEIGHT = roundToLayers(0.3);
DECAL_OFFSET_H = -28;
DECAL_OFFSET_V = -20;

CORNERS = [[1, 1], [-1, 1], [-1, -1], [1, -1]];

module outer_case() {
  w_offset = OUTER_WIDTH / 2 - OUTER_CORNER_RADIUS;
  h_offset = OUTER_HEIGHT / 2 - OUTER_CORNER_RADIUS;

  linear_extrude(OUTER_THICKNESS) {
    hull() {
      for (c = CORNERS) {
        translate([c[0] * w_offset, c[1] * h_offset]) {
          circle(r = OUTER_CORNER_RADIUS);
        }
      }
    }
  }
}

module deck_cavity() {
  translate([-DECK_WIDTH / 2, -DECK_HEIGHT / 2]) {
    cube([DECK_WIDTH, DECK_HEIGHT, 1000]);
  }
}

module hole_2d() {
  translate([-HOLE_WIDTH / 2, HOLE_HEIGHT / 2]) {
    translate([HOLE_CORNER_RADIUS, -HOLE_CORNER_RADIUS]) {
      circle(r=HOLE_CORNER_RADIUS);
    }

    translate([HOLE_WIDTH - HOLE_CORNER_RADIUS, -HOLE_CORNER_RADIUS]) {
      circle(r=HOLE_CORNER_RADIUS);
    }

    translate([0, -TOP_LOADER_HEIGHT - SLIDE_EXTENSION + 1]) {
      square([
        HOLE_WIDTH,
        1]);
    }
  }
}

module top_loader() {
  union() {
    hull() {
      translate([
          -TOP_LOADER_WIDTH / 2,
          -TOP_LOADER_HEIGHT / 2]) {
        translate([TOP_LOADER_CORNER_RADIUS, TOP_LOADER_HEIGHT - TOP_LOADER_CORNER_RADIUS]) {
          cylinder(r=TOP_LOADER_CORNER_RADIUS, h=TOP_LOADER_THICKNESS);
        }

        translate([TOP_LOADER_WIDTH - TOP_LOADER_CORNER_RADIUS, TOP_LOADER_HEIGHT - TOP_LOADER_CORNER_RADIUS, 0]) {
          cylinder(r=TOP_LOADER_CORNER_RADIUS, h=TOP_LOADER_THICKNESS);
        }

        translate([0, -SLIDE_EXTENSION]) {
          cube([
            TOP_LOADER_WIDTH,
            100,
            TOP_LOADER_THICKNESS]);
        }
      }

      translate([0, 0, TOP_LOADER_THICKNESS]) {
        linear_extrude(INNER_LIP_THICKNESS) {
          hole_2d();
        }

      }
    }

    translate([0, 0, INNER_LIP_THICKNESS]) {
      linear_extrude(4) {
        hull() {
          hole_2d();
        }
      }
    }
  }
}

module key() {
  linear_extrude(height = DECAL_HEIGHT, convexity = 20) {
    translate([DECAL_OFFSET_H, DECAL_OFFSET_V]) {
      scale(0.25) {
        import(file = "vector keyforge key.dxf");
      }
    }
  }
}

union() {
  difference() {
    outer_case();

    translate([0, 0, BOTTOM_THICKNESS]) {
      deck_cavity();
      
      translate([0, 0, DECK_THICKNESS]) {
        top_loader();
      }
    }

    translate([0, -OUTER_HEIGHT / 2 + THUMB_HOLE_THICKNESS, BOTTOM_THICKNESS + DECK_THICKNESS + THUMB_HOLE_OFFSET]) {
      rotate([90, 0, 0]) {
        cylinder(r=THUMB_HOLE_RADIUS, h=THUMB_HOLE_THICKNESS * 2);
      }
    }
  }

  if (DECAL) {
    translate([0, 0, BOTTOM_THICKNESS]) {
      key();
    }
  }

  translate([-TOP_LOADER_BRACE_WIDTH / 2, -OUTER_HEIGHT / 2, BOTTOM_THICKNESS + DECK_THICKNESS]) {
    translate([-TOP_LOADER_BRACE_OFFSET - TOP_LOADER_BRACE_WIDTH / 2, 0]) {
      cube([
        TOP_LOADER_BRACE_WIDTH,
        TOP_LOADER_BRACE_HEIGHT,
        TOP_LOADER_BRACE_THICKNESS]);
    }

    translate([TOP_LOADER_BRACE_OFFSET + TOP_LOADER_BRACE_WIDTH / 2, 0]) {
      cube([
        TOP_LOADER_BRACE_WIDTH,
        TOP_LOADER_BRACE_HEIGHT,
        TOP_LOADER_BRACE_THICKNESS]);
    }
  }

  translate([-OUTER_WIDTH / 2 + SIDE_TEXT_THICKNESS / 2, 0, OUTER_THICKNESS * .45]) {
    rotate([90, 0, -90]) {
      linear_extrude(SIDE_TEXT_THICKNESS * 2) {
        text(SIDE_TEXT, font=SIDE_TEXT_FONT, size=SIDE_TEXT_SIZE, halign="center", valign="center");
      }
    }
  }
}
