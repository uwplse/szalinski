include <../bitbeam-lib.scad>

translate([unit*4, 0, 0])
    cylinder_plate(4, 6, holes=[0, 2]);

translate([unit*-2, 0, 0])
    cube_plate(4, 6, 2, h=0.5);
