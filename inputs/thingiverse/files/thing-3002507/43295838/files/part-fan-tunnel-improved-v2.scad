opening_width = 8;

difference() {
    
    union() {
        translate([0, 0, 0]) rotate([180, 0, 0]) import("part_fan_tunnel-export.STL");
        translate([0, 6, -57.2]) rotate([-3, 0, 0]) cube([opening_width + 1, 9, 1], center = true);
    }
    translate([0, 12, -56.8]) rotate([-30, 0, 0]) cube([opening_width, 10, 3], center = true);
    translate([0, 12, -56.4]) rotate([-15, 0, 0]) cube([opening_width / 2, 20, 3], center = true);
    translate([0, 4, -58.83]) rotate([-7, 0, 0]) cube([opening_width + 2, 10, 3], center = true);
}    


