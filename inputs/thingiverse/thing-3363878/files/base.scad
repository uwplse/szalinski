include <../bitbeam-lib.scad>

translate([unit*4, 0, 0])
    cylinder_base(4, 6, fill_holes=false);

translate([unit*-2, 0, 0])
    cube_base(4, 6, 2);
