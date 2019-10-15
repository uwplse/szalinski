$fn = 64;

thickness = 4.5;

difference() {
    union() {
        translate([-10, 0, 0]) cube([10, 30, thickness]);
        cube([3, 6, 3 + thickness]);
        translate([0, 3, 3 + thickness]) rotate([0, 90, 0]) cylinder(r = 3, h = 3);
    }
    translate([0, 3, 3 + thickness]) 
        rotate([0, 90, 0]) 
            cylinder(d = 2.8, h = 20, center = true);
}
