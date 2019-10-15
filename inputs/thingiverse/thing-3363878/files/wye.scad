include <../bitbeam-lib.scad>

translate([unit*5, 0, -unit])
    cube_y(3, 6, 4);

translate([unit*-4, unit, 0])
    cylinder_y(5, 3, 4);
