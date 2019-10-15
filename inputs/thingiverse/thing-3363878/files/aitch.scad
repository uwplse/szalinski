include <../bitbeam-lib.scad>

translate([unit*4, unit, 0])
    cube_h(7, 4, 2);

translate([unit*-3, 0, 0])
    cylinder_h(6, 7);
