include <../bitbeam-lib.scad>

translate([unit*2, 0, 0])
    cube_x(6, 8);

translate([unit*-4, unit*3, 0])
    cylinder_x(5, 5);
