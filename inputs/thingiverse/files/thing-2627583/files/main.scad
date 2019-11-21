
$fn = 100;

BELT_WIDTH = 7;
GAP_WITDH = 7;
TENSION_HEIGHT = 3.5;
SPINE_WIDTH = 3.5;
MIDDLE_SPLINE_WIDTH = 6;
OUTER_SPLINE_WIDTH = 3.5;
SPLINE_RADIUS = 2;

TOTAL_LENGTH =
    OUTER_SPLINE_WIDTH * 2 + GAP_WITDH * 2 + MIDDLE_SPLINE_WIDTH;


module spline (w) {
    linear_extrude (height = BELT_WIDTH) {
        intersection () {
            translate ([SPLINE_RADIUS, SPLINE_RADIUS])
                circle (r=SPLINE_RADIUS);

            square ([SPLINE_RADIUS, SPLINE_RADIUS]);
        }

        difference () {
            square ([w, TENSION_HEIGHT]);
            square ([SPLINE_RADIUS, SPLINE_RADIUS]);
        }
    }
}


rotate ([-90, 0, 90]) translate ([0, -TENSION_HEIGHT, SPINE_WIDTH]) {

translate ([0, TENSION_HEIGHT, 0]) mirror ([0, 1, 0]) {
    // left spline (seen from the open end)
    translate ([TOTAL_LENGTH - OUTER_SPLINE_WIDTH, 0, 0])
        spline (OUTER_SPLINE_WIDTH);


    // right spline (seen from the open end)
    translate ([OUTER_SPLINE_WIDTH, 0, 0])
        mirror ([1, 0, 0])
        spline (OUTER_SPLINE_WIDTH);
}


// middle spline
translate ([SPLINE_RADIUS + OUTER_SPLINE_WIDTH + GAP_WITDH, 0, 0]) {
    translate ([-SPLINE_RADIUS, 0, 0])
        spline (SPLINE_RADIUS + 0.1);

    translate ([0, 0, 0])
        cube (
            [ MIDDLE_SPLINE_WIDTH - SPLINE_RADIUS * 2
            , TENSION_HEIGHT
            , BELT_WIDTH
            ]);

    mirror ([1, 0, 0])
        translate ([-MIDDLE_SPLINE_WIDTH + SPLINE_RADIUS, 0, 0])
        spline (SPLINE_RADIUS + 0.1);
}


// back spine
translate ([0, 0, -SPINE_WIDTH])
    cube (
        [ TOTAL_LENGTH
        , TENSION_HEIGHT
        , SPINE_WIDTH
        ]);

}
