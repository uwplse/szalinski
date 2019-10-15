include <../bitbeam-lib.scad>

rim=true;

scale(1.5){
    translate([4*unit, -unit, 0])
        cube_arm(1);

    translate([2*unit, 0, 0])
        cube_arm(1, side_holes=false);

    translate([unit, 2*unit, 0])
        cylinder_arm(1);

    translate([-unit, 3*unit, 0])
        cylinder_arm(1, side_holes=false);
}
