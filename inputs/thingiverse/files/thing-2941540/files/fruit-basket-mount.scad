//parameters
mount_diameter = 40;
mount_hole_size = 3.35;
hook_diameter = 2;

difference() {
    union() {
    cylinder(5,mount_diameter,mount_diameter - 5);
    cylinder(9,9,4);
    }
    translate([mount_diameter - mount_diameter / 4,0,0]) cylinder(5.1,mount_hole_size,mount_hole_size - 1);
    translate([(mount_diameter - mount_diameter / 4) * -1,0,0]) cylinder(5.1,mount_hole_size,mount_hole_size - 1);
    translate([0,(mount_diameter - mount_diameter / 4) * -1,0]) cylinder(5.1,mount_hole_size,mount_hole_size - 1);
    translate([0,mount_diameter - mount_diameter / 4,0]) cylinder(5.1,mount_hole_size,mount_hole_size - 1);
    cylinder(9,hook_diameter,hook_diameter);
}
