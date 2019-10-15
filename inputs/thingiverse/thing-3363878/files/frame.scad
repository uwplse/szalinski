include <../bitbeam-lib.scad>

translate([unit*4, 0, 0])
    cube_frame(4, 6);

translate([unit*-2, 0, 0])
    cylinder_frame(4, 6, side_holes=false);
