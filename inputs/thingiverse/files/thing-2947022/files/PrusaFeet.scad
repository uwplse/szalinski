// Feet for Prusa i3 MK3
// (c) 2018, Phil Dubach
//
// Creative Commons License
// Feet for Prusa i3 MK3 by Phil Dubach is licensed under a Creative
// Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
// Based on a work at https://github.com/phildubach/PrusaFeet.

// Length of the foot
LENGTH = 50;

module T3030_flex(height) {
    slit_uw = 8;
    slit_lw = 6;
    slit_d = 6;
    wall = 2.5;
    t_w = 10;
    t_h = 1.2;
    vertices = [[0,0], [slit_uw/2,0], [slit_uw/2, -wall], [t_w/2, -wall], [t_w/2, -(wall+t_h)], [slit_lw/2, -slit_d], [0, -slit_d], [0,0]];
    linear_extrude(height=height) {
        polygon(vertices);
        mirror([1,0,0]) polygon(vertices);
    }
}

T3030_flex(LENGTH);
translate([-15,0,0]) cube([30, 12, LENGTH]);
