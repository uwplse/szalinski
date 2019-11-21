support_thickness = 6;
atomizer_hole = 8;
atomizer_size = 23;
atomizer_dist = 2;
atomizer_number = 4;

support_x = (atomizer_size * atomizer_number) + (atomizer_dist * (atomizer_number - 1)) + atomizer_dist * 2;
support_y = atomizer_size + atomizer_dist + support_thickness * 2;
support_z = support_thickness * 1.5;

support_hole_y = support_y - support_thickness * 2;
support_hole_x = support_x - support_thickness * 2;

hole_distance = atomizer_size/2+atomizer_dist;
atomizer_distance = atomizer_size+atomizer_dist;

union() {
    translate([0, support_y-support_thickness/8, 0])
        cube([support_x, support_thickness/2, support_z + support_thickness * 2]);

    difference() {
        cube([support_x, support_y, support_z]);
        // translate([-5, support_thickness, support_thickness])
        //     cube([support_hole_x+20, support_hole_y, support_hole_y]);
        union() {
            for(hole = [0:atomizer_number-1]) {
                translate([hole_distance+(atomizer_distance*hole), support_y/2, -2])
                    cylinder(h=support_thickness*2.5, r=atomizer_hole/2);
                translate([hole_distance+(atomizer_distance*hole), support_y/2, support_z-1])
                    cylinder(h=4, r=atomizer_size/2);
            }
        }
    }
}
