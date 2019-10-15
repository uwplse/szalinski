include <../bitbeam-lib.scad>

translate([unit, 3*-unit, 0])
    rotate([0, 0, 30])
        cube_angle(3, 4);

translate([unit, 0, 0])
    rotate([0, 0, 30])
        cube_angle(3, 4, h=0.5);

translate([unit, unit*3, 0])
    rotate([0, 0, 30])
        cylinder_angle(3, 4, h=0.5);

translate([unit, unit*6, 0])
    rotate([0, 0, 30])
        cylinder_angle(3, 4, side_holes=false);

