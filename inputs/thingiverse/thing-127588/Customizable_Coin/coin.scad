// Challenge coin generator.
// All dimensions in millimeters.

// preview[view:south, tilt:top diagonal]

use <write/Write.scad>

/* [Text] */
TOP_TEXT = "Hello, World";
BOTTOM_TEXT = "August 2013";
REVERSE_TOP = "Reverse Top";
REVERSE_BOTTOM = "Bottom";

/* [Coin Properties] */
// (mm)
DIAMETER = 39;
// (mm)
THICKNESS = 3.2;

/* [Text Properties] */

// Letter height (mm)
TEXT_HEIGHT = 5.0;
// ratio (1.0 is nominal)
SPACING = 0.8;
// Print height (mm)
RELIEF = 1.0;

/* [Hidden] */

// Epsilon
E = 0.01;

module coin(
    top_text="",             // Text of centered top text
    bottom_text="",          // Text of centered bottom text
    rev_top_text="",         // Reverse top text
    rev_bottom_text="",      // Reverse bottom text
    size=DIAMETER,           // Diameter of coin
    thickness=THICKNESS,     // Total coin thickness
    relief=RELIEF,           // Height of raised (relief) features
    text_height=TEXT_HEIGHT, // Height of a text letter
    spacing=SPACING,         // 1.0 == nominal spacing (ratio)
    rim_width=0.5            // Rim edge thickness
    ) {
  difference() {
    union() {
      cylinder(r=size / 2, h=thickness - relief, $fa=3);
      translate([0, 0, thickness - relief - E])
        face(top_text, bottom_text, size, relief + E, text_height, spacing, rim_width);
      }
    translate([0, 0, relief])
      rotate(a=180, v=[1, 0, 0])
      face(rev_top_text, rev_bottom_text, size, relief + E, text_height, spacing, rim_width,
           rim=false);
  }
}

module face(
    top_text="",      // Text of centered top text
    bottom_text="",   // Text of centered bottom text
    size=39,          // Diameter of coin
    relief=0.5,       // Height of raised (relief) features
    text_height=5.0,  // Height of a text letter
    spacing=1.0,      // 1.0 == nominal spacing (ratio)
    rim_width=0.5,    // Rim edge thickness
    rim=true,         // Boolean control drawing rim ridge
    image_file=""     // Optional face image (DXF file)
    ) {
  if (rim) {
    ring(r=size / 2, thickness=rim_width, height=relief);
  }
  arc_text(top_text, size / 2 - rim_width * 4, text_height, relief, spacing, true);
  arc_text(bottom_text, size / 2 - rim_width * 4, text_height, relief, spacing, false);
  if (image_file != "") {
    linear_extrude(height=relief, center=true, convexity=10)
      import_dxf(file=image_file, layer="none");
  }
}

module arc_text(
    text,
    r,
    text_height=3.0,
    height=1.0,
    spacing=1.0,
    top=true
    ) {
  ang = spacing * atan2(text_height, r);
  start_ang = (len(text) - 1) / 2 * ang;
  ang_sgn = top ? -1 : 1;
  offset_sgn = top ? 1 : -1;
  for (i = [0 : len(text) - 1]) {
    rotate(a=ang_sgn * (ang * i - start_ang), v=[0, 0, 1])
      translate([0, offset_sgn * (r - text_height / 2), height / 2])
        write(text[i], h=text_height, t=height, center=true);
  }
}

// Ring around origin (at z=0)
module ring(r, thickness, height) {
  translate([0, 0, height / 2]) {
    difference() {
      cylinder(h=height, r=r, $fa=3, center=true);
      cylinder(h=height + 2 * E, r=r - thickness, $fa=3, center=true);
    }
  }
}

coin(top_text=TOP_TEXT,
     bottom_text=BOTTOM_TEXT,
     rev_top_text=REVERSE_TOP,
     rev_bottom_text=REVERSE_BOTTOM
     );
