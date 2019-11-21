// Imhotep Burial Creator

// The size of the Cubes, in millimeters
cube_size = 15;

// How heigh should the burial grid be?
chamber_size_h = 2;

// The distance between the cube holes
cube_distance = 1;

chamber_size_w = 9 * ( cube_size + cube_distance ) - cube_distance * 2;
chamber_size_l = 3.5 * ( cube_size + cube_distance ) - cube_distance * 2;

cube_fit = 1.1;

cube_hole_size = cube_size * cube_fit;

difference() { 
    // Raft
    color("gray")
        cube(
            [
                chamber_size_w,
                chamber_size_l,
                chamber_size_h
            ],
            true );

    // Cube Holes
    for( y = [ 0 : 2 ] ) {
        for( x = [ 0 : 7 ] ) {
            translate(
                [
                    ( -4 + x ) * ( cube_hole_size + cube_distance ) + ( cube_hole_size + cube_distance ) / 2,
                    ( -1.5 + y ) * ( cube_hole_size + cube_distance ) + + ( cube_hole_size + cube_distance ) / 2,
                    cube_hole_size / 4
                ])
                {
                    cube(
                        [
                            cube_hole_size,
                            cube_hole_size,
                            cube_hole_size
                        ],
                        true);
                }
        }
    }
}