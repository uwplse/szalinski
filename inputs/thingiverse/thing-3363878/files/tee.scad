include <../bitbeam-lib.scad>

translate([unit*4, 0, 0])
    cube_t(3, 6);

translate([unit*-3, 0, 0])
    cylinder_t(6, 3);
