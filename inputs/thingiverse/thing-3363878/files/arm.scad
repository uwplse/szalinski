include <../bitbeam-lib.scad>

translate([0, -2.5*unit, 0])
    cube_arm(7);

cube_arm(7, skip_side=[1,3,5]);

translate([0, unit*2.5, 0])
    cube_arm(7, h=0.5);

translate([0, unit*5, 0])
    cylinder_arm(7, skip_side=[0,6]);

translate([0, unit*7.5, 0])
    mix_arm(7);
