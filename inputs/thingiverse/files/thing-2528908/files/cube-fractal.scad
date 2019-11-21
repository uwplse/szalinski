// Direction to omit
direction = 0; // [-1:None, 0:Down, 1:Up, 2:Left, 3:Right, 4:Front, 5:Back]

// Direction to omit on all
global_direction = 0; // [-1:None, 0:Down, 1:Up, 2:Left, 3:Right, 4:Front, 5:Back]

// How small the next part should be
scale_factor = 0.5; // [0:0.01:0.5]

// How far to draw
recursive = 5; // [0:10]

// How big to make the model
size = 10; // [0:0.1:25]

module Fractal(r, s, d, gd) {
    if (r > 0) {
        if (d != 1 && gd != 1) {
            translate([0, 0, 0.5 + s / 2]) scale(s) Fractal(r - 1, s, 0, gd);
        }
        if (d != 0 && gd != 0) {
            translate([0, 0, -(0.5 + s / 2)]) scale(s) Fractal(r - 1, s, 1, gd);
        }
        if (d != 3 && gd != 2) {
            translate([0.5 + s / 2, 0, 0]) scale(s) Fractal(r - 1, s, 2, gd);
        }
        if (d != 2 && gd != 3) {
            translate([-(0.5 + s / 2), 0, 0]) scale(s) Fractal(r - 1, s, 3, gd);
        }
        if (d != 5 && gd != 4) {
            translate([0, 0.5 + s / 2, 0]) scale(s) Fractal(r - 1, s, 4, gd);
        }
        if (d != 4 && gd != 5) {
            translate([0, -(0.5 + s / 2), 0]) scale(s) Fractal(r - 1, s, 5, gd);
        }
    }
    cube(1, true);
}

scale(size) Fractal(recursive, scale_factor, direction,  global_direction);