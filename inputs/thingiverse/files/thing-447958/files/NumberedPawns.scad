use <write/Write.scad>

/* [Dimensions] */

// Diameter of the whole figure.
PAWN_DIAMETER = 25.4; // [10:60]

// Height of the whole figure.
PAWN_HEIGHT = 31;  // [15:60]

// The base is the round piece that holds the pawn up.
BASE_HEIGHT = 3;  // [1:10]

// The "upright" is the tall thing that holds the glyph (number, etc.).  Its dimensions are exclusive of the "hat".
UPRIGHT_WIDTH = 19;  // [10:60]
UPRIGHT_DEPTH = 4.2;  // [3:7]

// The "hat" goes on the top of the upright, to round it out.  This is the radius of its corner curve.
HAT_CORNER_RADIUS = 3;  // mm

/* [Glyphs] */

GENERATE = "single";  // [single:Single letter or number, digits:Digits 1-9]

// A single letter or number to put on one pawn, if you select Single Letter above.
SINGLE_GLYPH = "A";

// Hard edges are quicker to render, but soft edges won't require support.  Soft thickens the letters too.
ENGRAVING_STYLE = "soft";  // ["hard":Hard-edged, "soft":Soft-edged]

FONT = "write/orbitron.dxf";  // ["write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron,"write/knewave.dxf":Knewave]

// mm to shift the glyph in X (right/left)
GLYPH_RIGHT = -0.7; // mm
// mm to shift the glyph in Z (up/down)
GLYPH_UP = 0;  // mm
// Factor to scale the glyph by, in percent
GLYPH_SCALE = 100;  // [10:150]

/* [Hidden] */

GRID = PAWN_DIAMETER + 4;
//color([1, 1, 0, 0.5])

if (GENERATE == "digits") {
  doDigitPawns();
} else {
  doPawn(SINGLE_GLYPH);
}

// From MCAD/layouts.scad.  Customizer's version is behind.
module grid(iWidth,iHeight,inYDir = true,limit=3)
{
	for (i = [0 : $children-1]) 
	{
		translate([(inYDir)? (iWidth)*(i%limit) : (iWidth)*floor(i/limit),
					(inYDir)? (iHeight)*floor(i/limit) : (iHeight)*(i%limit)])
					child(i);
	}
}

module doDigitPawns() {
  grid(GRID, GRID, true, 3) {
    doPawn("1");
    doPawn("2");
    doPawn("3");
    doPawn("4");
    doPawn("5");
    doPawn("6");
    doPawn("7");
    doPawn("8");
    doPawn("9");
  }
}

// Extrudes a trapezoid with bottom width x1, top width x2, and height z, to depth y.
// Places it with its bottom at z=0, centered along the Y axis.
module thickTrapezoid(x1, x2, y, z) {
  translate([0,y/2,0])
    rotate([90, 0, 0])
      linear_extrude(height=y)
        polygon([[-x1/2, 0], [x1/2, 0], [x2/2, z], [-x2/2, z]]);
}

// Makes a platform that has a trapezoidal profile in two dimensions,
// and a rectangular cross-section all along its height.
// Specify the dimensions of the rectangle at the bottom and the top.
// Built centered around the Z axis, with the bottom at Z=0 and the top at height.
module slantedPlatform(height, width1, width2, depth1, depth2) {
  intersection() {
    thickTrapezoid(width1, width2, max(depth1, depth2), height);
    rotate([0,0,90])
      thickTrapezoid(depth1, depth2, max(width1, width2), height);
  }
}

// Derived values.
BASE_DIAMETER = PAWN_DIAMETER;
BASE_RADIUS = BASE_DIAMETER / 2;

// The "plinth" is what transitions from the base to the upright.
PLINTH_SIDE_INSET = (BASE_DIAMETER - UPRIGHT_WIDTH) / 2;
PLINTH_FACE_INSET = PLINTH_SIDE_INSET / 3;  // mm inset from front and back.
PLINTH_HEIGHT = PLINTH_SIDE_INSET;
UPRIGHT_HEIGHT = PAWN_HEIGHT - BASE_HEIGHT - PLINTH_HEIGHT - HAT_CORNER_RADIUS;
UPRIGHT_BOTTOM = BASE_HEIGHT + PLINTH_HEIGHT;
HAT_BOTTOM = PAWN_HEIGHT - HAT_CORNER_RADIUS;

// For the text cutter.
INNER_WALL = 0.6;  // mm to leave between one cut-out and the other
BEZEL = ENGRAVING_STYLE == "soft"? (UPRIGHT_DEPTH - 1)/2 : 0;
TEXT_DEPTH = UPRIGHT_DEPTH - INNER_WALL - BEZEL * sqrt(2);

// Additional adjustments for "hard" engraving.  Kludgy.  Probably needs to depend on BEZEL.
GLYPH_X = GLYPH_RIGHT + (ENGRAVING_STYLE == "hard"? 1.3: 0);
GLYPH_Z = GLYPH_UP + (ENGRAVING_STYLE == "hard"? 0: 0);
GLYPH_SCALE_FACTOR = GLYPH_SCALE / 100 * (ENGRAVING_STYLE == "hard"? 1.1: 1);

module doPawn(text) {
  difference() {
    union() {
      // Base
      cylinder(BASE_HEIGHT, r=BASE_RADIUS, $fn=60);
      
      // Plinth
      translate([0, 0, BASE_HEIGHT]) {
        intersection() {
          // Trapezoid
          slantedPlatform(PLINTH_HEIGHT, 
            BASE_DIAMETER, UPRIGHT_WIDTH, 
            UPRIGHT_DEPTH + 2*PLINTH_FACE_INSET, UPRIGHT_DEPTH);
          
          // Clip everything so it doesn't extend over the edge// clip everything so it doesn't extend over the edge of the base
          cylinder(PAWN_HEIGHT, r=BASE_RADIUS);  
        }
      }
      
      // Upright
      translate([-UPRIGHT_WIDTH/2, -UPRIGHT_DEPTH/2, UPRIGHT_BOTTOM])
        cube([UPRIGHT_WIDTH, UPRIGHT_DEPTH, UPRIGHT_HEIGHT]);
        
      // Hat: left ear
      translate([-(UPRIGHT_WIDTH/2 - HAT_CORNER_RADIUS), 0, HAT_BOTTOM])
        rotate([90,0,0])
          cylinder(UPRIGHT_DEPTH, r=HAT_CORNER_RADIUS, center=true, $fn=20);
      // Right ear
      translate([+(UPRIGHT_WIDTH/2 - HAT_CORNER_RADIUS), 0, HAT_BOTTOM])
        rotate([90,0,0])
          cylinder(UPRIGHT_DEPTH, r=HAT_CORNER_RADIUS, center=true, $fn=20);
      // Middle bridge
      translate([0,0, HAT_BOTTOM + HAT_CORNER_RADIUS/2])
        cube([UPRIGHT_WIDTH - 2*HAT_CORNER_RADIUS, UPRIGHT_DEPTH, HAT_CORNER_RADIUS], center=true);
    }
      
    // Inscribe the glyph
    translate([GLYPH_X, -(UPRIGHT_DEPTH + BEZEL)/2, UPRIGHT_BOTTOM + MARGIN + GLYPH_Z])
      doLetter(text);
    rotate([0, 0, 180])
      translate([GLYPH_X, -(UPRIGHT_DEPTH + BEZEL)/2, UPRIGHT_BOTTOM + MARGIN + GLYPH_Z])
        doLetter(text);
  }
}

MARGIN = 3/17.9 * UPRIGHT_HEIGHT;  // mm on all sides of the glyph
GLYPH_HEIGHT = (UPRIGHT_HEIGHT + HAT_CORNER_RADIUS - 2*MARGIN);
GLYPH_WIDTH = GLYPH_HEIGHT * 0.6;

module doLetter(text) {
  translate([0,0, GLYPH_HEIGHT / 2])
    scale([GLYPH_SCALE_FACTOR, 1, GLYPH_SCALE_FACTOR])
      rotate([90,0,0])
        if (ENGRAVING_STYLE == "soft") {
          minkowski() {
            write(text, t=TEXT_DEPTH, h=GLYPH_HEIGHT, center=true, font=FONT);
          rotate([45, 45, 0])  // try 45, 45, 45?  Need to adjust placement though.
            cube([BEZEL,BEZEL,BEZEL]);
          }
        } else {
          write(text, t=TEXT_DEPTH, h=GLYPH_HEIGHT, center=true, font=FONT);
        }
}
