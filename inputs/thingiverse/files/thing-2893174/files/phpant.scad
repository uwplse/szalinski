difference() {
    union() {
        difference() {
            scale([10, 10, 10]) import("elephpant_bottom_cut.stl");
            translate([-28, -5.0, 10]) rotate([75, 0, 0]) linear_extrude(height = 5) text(text = "php",font="DejaVu Sans Mono:style=Bold", size=15);
            translate([8, 37.5, 10]) rotate([70, 0, 180]) linear_extrude(height = 5) text(text = "php",font="DejaVu Sans Mono:style=Bold", size=15);
    
            translate([40, 29, 13]) rotate([0, 50, -30]) scale([3, 1, 2.5]) sphere(2, $fn = 50); // eyehole #1
            translate([40, 2.5, 13]) rotate([0, 50, +30]) scale([3, 1, 2.5]) sphere(2, $fn = 50); // eyehole #2
        }
        translate([40, 27.5, 12]) rotate([0, 30, -35]) scale([3, 1, 2.5]) sphere(2, $fn = 50); // eye #1
        translate([40, 4.2, 12]) rotate([0, 30, +35]) scale([3, 1, 2.5]) sphere(2, $fn = 50); // eye #2

        translate([-46.3, 16, 10]) rotate([0, 10, 0]) scale([1.2, 1.2, 3.5]) sphere(2, $fn = 50); // tail

        // manual support...
        translate([57, 16.5, -32.5]) cylinder(h = 9, r1 = 8, r2 = 0, center = true);
        translate([41, 16.5, -23]) rotate([0, 23, 0]) cylinder(h = 42, r1 = 8, r2 = 0, center = true);
        translate([46, 16.5, -30]) rotate([0, 20, 0]) cylinder(h = 22, r1 = 8, r2 = 0, center = true);
    }

    // cut bottom plane
    translate([0, 0, -41.5]) cube([150, 100, 10], center = true);
}