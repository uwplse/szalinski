$fn = 36;
SIZE_X = 190;
SIZE_Y = 190;
SIZE_Z = 0.2;

ROUNDING = 10;

OUTER_WALL_THICKNESS = 4;
INNER_WALL_THICKNESS = 4;


module roundedBase(OFFSET, X, Y, Z) {
    RADIUS = OFFSET / 2;
    X1 = RADIUS;
    X2 = X - OFFSET;
    Y1 = RADIUS;
    Y2 = Y - OFFSET;

    resize([X, Y, Z]) {
        translate([X1, Y1, 0]) {
            minkowski() {
                cube([X2, Y2, Z]);
                cylinder(r = RADIUS, h = Z);
            }
        }
    }
}

module cross(KOEF = 1) {
    CROSS_SIZE_X = sqrt( pow(SIZE_X, 2) + pow(SIZE_Y, 2) );
    CROSS_SIZE_Y = INNER_WALL_THICKNESS;
    CROSS_SIZE_Z = SIZE_Z;

    ANGLE = asin( SIZE_Y / CROSS_SIZE_X );

    translate([SIZE_X / 2, SIZE_Y / 2, 0])
        rotate([0, 0, ANGLE * KOEF])
            translate([0, 0, CROSS_SIZE_Z/2])
                resize([CROSS_SIZE_X - OUTER_WALL_THICKNESS * 1.5, CROSS_SIZE_Y, CROSS_SIZE_Z])
                    cube([CROSS_SIZE_X, CROSS_SIZE_Y, CROSS_SIZE_Z], center = true);
}

union() {
    cross(-1);
    cross();
    difference() {
        roundedBase(ROUNDING, SIZE_X, SIZE_Y, SIZE_Z);
        translate([OUTER_WALL_THICKNESS, OUTER_WALL_THICKNESS, 0])
            roundedBase(ROUNDING - OUTER_WALL_THICKNESS, SIZE_X - OUTER_WALL_THICKNESS * 2, SIZE_Y - OUTER_WALL_THICKNESS * 2, SIZE_Z);
    }
}
