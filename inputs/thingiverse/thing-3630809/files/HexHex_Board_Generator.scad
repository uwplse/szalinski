// HexHex Board Generator
//   by Michael Van Biesbrouck, (c) 2019.
//   License: Attribution 4.0 International
//            https://creativecommons.org/licenses/by/4.0/

/* [Basic Board Parameters] */
// Number of hexes on an edge.
hexhex_size = 2;        // [1:8]
// Diameter of balls in mm.
ball_diameter = 16;     // [5:30]
// Spacing between balls in mm.
separation = 4;         // [20]
// Diameter of holes in mm.
hole_diameter = 8;      // [15]
// Thickness of the board in mm.
board_thickness = 2;    // [1:20]
// Extra girth to the board in mm.
board_margin = 8;       // [20]
// Set to true for an irregular, interlocking perimeter.
modular = false;

/* [Decorative Cut Parameters] */
// Depth of decorative cut in mm.  (0 to disable.)
decoration_depth = 1;   // [0:0.25:20]
// Distance from board edge in mm.  (0 for bevel, large values to mark hexhex sub-boards.)
decoration_outer = 0;   // [1000]
// Width of decorative cut in mm.
decoration_width = 2;   // [1000]

/* [Guide Parameters] */
// Depth of guides for sliding balls between holes in mm.  (0 to disable.)
guide_depth = 0;        // [0:0.5:10]
// Width of guides in mm, best to just calculate this.
guide_width = hole_diameter / 2;
// If true, the guide will leave the board (e.g. Abalone board).
guide_exits = false;

/* [Drawn Hex Parameters] */
// Depth of lines for marked hexes in mm. (0 to disable.)
hex_line_depth = 0.5;   // [0:0.25:1]
// Width of hex lines in mm.
hex_line_width = 1;
// Spacing to separate hexes in mm.  (0 for a grid instead of separate hexes.)
hex_line_extra_space = 2;       // [0:0.5:20]
// It is possible to give a different depth to two hex rings.  Depth in mm.
hex_line_highlight_depth = 0;   // [0:0.25:1]
// First ring to highlight.  (0 to disable.)
hex_line_highlight_ring1 = 0;   // [10]
// Second ring to highlight.  (0 to disable.)
hex_line_highlight_ring2 = 0;   // [10]
hex_line_highlight_rings = [hex_line_highlight_ring1, hex_line_highlight_ring2];

eps = 0+0.00001;
board_diameter_mm = (2*hexhex_size-1)*(ball_diameter+separation)+board_margin;

spacing=ball_diameter+separation;
hex_diameter=spacing*sqrt(3/2)-hex_line_extra_space-hex_line_width/2;
h=sqrt(3/4)*spacing;

module horizontal_guides (spacing) {
    for (i = [0:hexhex_size-1]) translate ([i*h, 0, 0])
        cube ([guide_width, spacing*(2*hexhex_size-(guide_exits ? 0 : 2)-i), board_thickness], center=true);
}

module rotations () {
    for (i = [0:60:300]) rotate ([0, 0, i]) children();
}

module guides (spacing) {
    if (guide_depth > 0) rotations () translate ([0, 0, board_thickness-guide_depth])
    horizontal_guides (spacing);
}

function height (ring) = eps+board_thickness-(len(search(ring, hex_line_highlight_rings)) == 1 ? hex_line_highlight_depth : hex_line_depth);

module hexhex_arrangement_internal(spacing, rings) {
    rotations ()
        for (ring = rings) for (i = [0:ring-2])
            translate ([(ring-1)*h, (i+(1-ring)/2)*spacing, height(ring)]) children();
}

module hexhex_arrangement(spacing) {
    translate ([0, 0, height(1)]) children();
    hexhex_arrangement_internal(spacing, [2:hexhex_size]) children();
}

module board (diameter, thickness) {
    rotate ([0, 0, 30]) cylinder(h=thickness, d=diameter, center=true, $fn=6);
}

difference () {
    board (board_diameter_mm, board_thickness);
    hexhex_arrangement(spacing) union () {
        cylinder(h=4*board_thickness, d=hole_diameter, center=true, $fn=50);
        difference () {
            cylinder(h=board_thickness, d=hex_diameter, center=true, $fn=6);
            cylinder(h=board_thickness, d=hex_diameter-2*hex_line_width, center=true, $fn=6);
        }
    }
    if (decoration_depth > 0) translate ([0, 0, board_thickness-decoration_depth]) difference () {
        board (board_diameter_mm-decoration_outer, board_thickness);
        board (board_diameter_mm-decoration_outer-decoration_width, board_thickness+1);
    }
    guides (spacing);
    if (modular) hexhex_arrangement_internal(spacing, hexhex_size+1) cylinder(h=4*board_thickness, d=spacing*sqrt(3/2), center=true, $fn=6);
}
