/* Customizable 'Tak - A beautiful game' playing board
 */

// The border (in mm) to leave around the board
BORDER=20;
// The number of big squares (hybrid will be +1) in the board
SQUARES=4;
// The height (in mm) of the board
HEIGHT=5;
// The size (in mm) of the big squares of the board
SQUARE_SIZE=35;
// The width (in mm) of the line separating squares on the board
SEPARATOR_SIZE=2;
// The depth (in mm) of the separating lines
SEPARATOR_DEPTH=1;
// The size (in mm) of the hybrid squares (set to 0 to disable hybrid)
HYBRID_SIZE=10;
// The width (in mm) of the separator around the hybrid squares (set ot 0 to disbale hybrid)
HYBRID_SEPARATOR_SIZE=1;
// The depth (in mm) of the hybrid squares and their separator
HYBRID_DEPTH=2;
// Hybrid mode for dual extrusion possibility
HYBRID_MODE="single"; // ["single":All-in-One single extruder board , "main":Main board without the hybrid squares for dual extrusion, "hybrid":Hybrid only squares for dual extrustion] 

eta=0.1;

BOARD_SIZE = BORDER*2 + (SQUARE_SIZE + SEPARATOR_SIZE) * SQUARES + SEPARATOR_SIZE;
HYBRID_TOTAL_SIZE = HYBRID_SIZE + HYBRID_SEPARATOR_SIZE * 2;
HYBRID_HYP=sqrt(HYBRID_SIZE * HYBRID_SIZE * 2);
HYBRID_TOTAL_HYP=sqrt(HYBRID_TOTAL_SIZE * HYBRID_TOTAL_SIZE * 2);

union () {
  if (HYBRID_MODE == "single" || HYBRID_MODE == "main") {
    difference () {
      // The board
      cube([BOARD_SIZE, BOARD_SIZE, 5]);

      for (line = [0 : 1 : SQUARES]) {
        // Create the grid
        translate([BORDER, BORDER + (SQUARE_SIZE + SEPARATOR_SIZE) * line, HEIGHT-SEPARATOR_DEPTH])
          cube([BOARD_SIZE - BORDER*2, SEPARATOR_SIZE, SEPARATOR_DEPTH+eta]);
        translate([BORDER + (SQUARE_SIZE + SEPARATOR_SIZE) * line, BORDER, HEIGHT-SEPARATOR_DEPTH])
          cube([SEPARATOR_SIZE, BOARD_SIZE - BORDER*2, SEPARATOR_DEPTH+eta]);

        // Remove the hybrid squares
        for (column = [0 : 1 : SQUARES]) {
          translate([BORDER + SEPARATOR_SIZE/2 + (SQUARE_SIZE + SEPARATOR_SIZE) * column,
                     BORDER + SEPARATOR_SIZE/2 - HYBRID_TOTAL_HYP/2 + (SQUARE_SIZE + SEPARATOR_SIZE) * line, HEIGHT-HYBRID_DEPTH])
            rotate([0, 0, 45])
            cube([HYBRID_TOTAL_SIZE, HYBRID_TOTAL_SIZE, HYBRID_DEPTH+eta]);
        }
      }
    }
  }
  if (HYBRID_MODE == "single" || HYBRID_MODE == "hybrid") {
    // Create hybrid squares
    for (line = [0 : 1 : SQUARES]) {
      for (column = [0 : 1 : SQUARES]) {
        translate([BORDER + SEPARATOR_SIZE/2 + (SQUARE_SIZE + SEPARATOR_SIZE) * column,
                   BORDER + SEPARATOR_SIZE/2 - HYBRID_HYP/2 + (SQUARE_SIZE + SEPARATOR_SIZE) * line, HEIGHT-HYBRID_DEPTH])
          rotate([0, 0, 45])
          cube([HYBRID_SIZE, HYBRID_SIZE, HYBRID_DEPTH+eta]);
      }
    }
  }
}
