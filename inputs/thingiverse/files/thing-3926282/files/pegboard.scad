/*
 * pegboard.scad - library for generating pegboard and grids of pegs/holes
 *
 * Copyright 2019 Craig Ringer <ringerc@ringerc.id.au>
 *
 * BSD Licensed
 */

// if negative, print
negative = false;

// Length (mm) of board section (x axis)
p_board_length = 120;
// Width (mm) of board section (y axis)
p_board_width = 21;
// Depth (mm) of board section (z axis)
p_board_thickness = 3;

// Diameter of holes in board
p_hole_diameter = 4.0;
// Hole pitch (distance between centers of holes)
p_hole_pitch = 5.0;
// Should holes be in a packed triangular environment (true) or a regular grid (false)
p_hole_hexpattern = true;

// Margins around the edges of the board where no holes should be placed. Can be a 2-array [x,y] or a scalar. Actual margins will be slightly larger because the hole grid will get centered.
p_beam_margins = p_hole_pitch/2;

/*
 * Example usage:
 *
 * pegboard([board_length, board_width, board_thickness],
 *              peg_diameter, peg_pitch, hole_hexpattern,
 *              beam_margins);
 *
 */

 /* [Hidden] */

module pegboard(dims, hole_diameter, hole_pitch, hexpattern = true, margins = undef, center = true, hole_depth = undef)
{
    t_length = dims[0]; // x
    t_height = dims[1]; // y
    t_thickness = dims[2]; // z

    hole_depth =
        hole_depth == undef ? t_thickness: hole_depth;

    // margins can be an xy array or a scalar, or unset. Negative
    // margins are allowed.
    margin_x = margins == undef ? hole_diameter/2 :
        margins[0] == undef ? margins : margins[0];
    margin_y = margins[1] == undef ? margin_x : margins[1];

    punchthrough_slop = 0.1;

    // Make sure the pegs punch fully out the top, and the bottom if
    // we're going through both sides.
    peg_zoff = hole_depth >= t_thickness ? -punchthrough_slop : 0;
    peg_length = hole_depth + punchthrough_slop - peg_zoff;

    difference() {
        cube([t_length, t_height, t_thickness]);


        // Defend against floating point issues with holes
        // that fully punch out of the object by pushing
        // them right through. Extra height will be added
        // to the hole being punched to compensate.
        translate([0,0,peg_zoff])
        peg_grid([t_length,t_height,peg_length], hole_diameter, hole_pitch, hexpattern, [margin_x, margin_y], center)
        
        {
            // Hack to allow tests etc
            assert($strip_ncols != undef);
            assert($strip_nrows != undef);
            let ($strip_ncols = $strip_ncols,
                 $strip_nrows = $strip_nrows,
                 $pegboard_running_tests = true)
            children();
            
        }
    }
}

module peg_grid(dims, peg_diameter, peg_pitch, hexpattern=true, margins=0, center = true)
{
    t_length = dims[0]; // x
    t_height = dims[1]; // y
    peg_length = dims[2]; // z

    // margins can be an xy array or a scalar, or unset. Negative
    // margins are allowed.
    margin_x = margins == undef ? 0 : margins[0] == undef ? margins : margins[0];
    margin_y = margins[1] == undef ? margin_x : margins[1];

    assert(t_length > 0);
    assert(t_height > 0);
    assert(peg_length > 0);
    assert(peg_diameter > 0);
    assert(peg_pitch >= 0);
    assert(margin_x != undef);
    assert(margin_y != undef);

    /*
     * distance between centers of two adjacent holes in the same row.
     */
    xpitch = peg_pitch;
    /*
     * Y gap between lines drawn through centers of holes in two
     *  adjacent rows. If hexpatterned then there are equilateral
     * triangles between centers of each row; the pitch is the
     * hypotenuse so the y-gap is the long side of the triangle
     * formed between the y-axis and the line between the centers.
     */
    ypitch = xpitch * (hexpattern ? sin(60) : 1);
    nrows = 1 + max(0, floor(
        (t_height - margin_y * 2 - peg_diameter)/ypitch));
    ncols = 1 + max(0, floor(
        (t_length - margin_x * 2 - peg_diameter)/peg_pitch));
        
    assert(nrows != undef && nrows >= 0);
    assert(ncols != undef && ncols >= 0);
    assert((xpitch > 0 && ncols > 0) || ncols == 0);
    assert((ypitch > 0 && nrows > 0) || nrows == 0);
    
    /*
     * Compute bridge size for reporting use. Bridge min
     * size should not vary based on hexpattern since we x-offset
     * to compensate for the closer rows.
     */
    bridge_size = (peg_pitch - peg_diameter);

    /*
     * Work out how much space is left once we pack in the hole grid
     * area and subtract the margins. If we pad the margins by this
     * leftover/unused space the grid will be centered.
     */
    unused_x = t_length - margin_x * 2 - xpitch * (ncols-1) - peg_diameter;
    unused_y = t_height - margin_y * 2 - ypitch * (nrows-1) - peg_diameter;
    adjusted_margin_x = margin_x + (center ? unused_x / 2 : 0);
    adjusted_margin_y = margin_y + (center ? unused_y / 2 : 0);

    echo(str("pegboard or peg_grid: ", t_length, "x", t_height, " margins ", adjusted_margin_x, "x", adjusted_margin_y, " rows ", nrows, " cols ", ncols, , " holes diameter ", peg_diameter, (hexpattern ? " hexpatterned" : " straight"), " at pitch ", peg_pitch, " (bridges ", bridge_size, ")"));

    translate([adjusted_margin_x + peg_diameter/2,
               adjusted_margin_y + peg_diameter/2, 0])
    union() {
        for (r = [0 : 1 : nrows - 1])
        {
            for (i = [0 : 1 : ncols - 1])
            {
                /*
                 * For hexpatterned holes, t_ncols is computed to fit
                 * the non-offset row within the margins. The last
                 * hole of the offset row won't fit and must be
                 * omitted.
                 */
                if (!(hexpattern && r % 2 == 1 && i == ncols - 1))
                {
                    // Handle row hexpattern
                    translate(
                        hexpattern ?
                        /*
                         * Rows are hexpatterned so the y-offset is
                         * sin(45deg) of the pitch and every second
                         * row is inset by half the pitch.
                         */
                        [(r % 2)*xpitch/2 + i*xpitch, r * ypitch, 0]
                        :
                        // Not hexpatterned, regular grid
                        [i*xpitch, r * ypitch, 0]
                    )
                    cylinder(d=peg_diameter,
                             h=peg_length);
                }
            }
        }
    };


    /*
     * OpenSCAD doesn't let us assign values to outer scopes. Nor does
     * it let us pass functions as objects. So to allow assertions etc,
     * permit definition of child objects here but discard the product.
     *
     * There must be a better way to do this; what we really want to
     * do is pass a function to evaluate, or export some values to
     * the outer scope.
     */
    let ($strip_ncols = ncols,
         $strip_nrows = nrows,
         $pegboard_running_tests = true)
    children();
}



if (negative) {
    peg_grid([p_board_length, p_board_width, p_board_thickness],
                p_hole_diameter, p_hole_pitch, p_hole_hexpattern,
                p_beam_margins);
}
else
{
    pegboard([p_board_length, p_board_width, p_board_thickness],
            p_hole_diameter, p_hole_pitch, p_hole_hexpattern,
            p_beam_margins);
}