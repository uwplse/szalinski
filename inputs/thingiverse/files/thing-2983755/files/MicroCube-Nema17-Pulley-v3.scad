// 3 - 4 loops recommended

difference() {
    union() {
        // join with the original pulley
        translate([-8.5, -8.5, 0]) import("Pulle_Nema17_15mm.STL");

        difference() {
            // create a tighter slope / grip for the pulley
            union() {
                translate([0, 0, 0]) cylinder(2.5, 8.5, 8.5, $fn = 90);
                translate([0, 0, 4.2]) cylinder(2.8, 8.5, 8.5, $fn = 90);
        
                translate([0, 0, 2.5]) cylinder(3.2, 8.5, 3, $fn = 90);
                translate([0, 0, 1.0]) cylinder(3.2, 3, 8.5, $fn = 90);
            }
            // cut out the middle section
            translate([0, 0, -1]) cylinder(20, 6, 6, $fn = 90);
        }
        
        // add a guide for the notch of the rod
        translate([0, -2.9, 4.5]) cube([5, 2, 9], center=true);
        translate([0, -2.9, 14]) cube([5, 2, 2], center=true);
    }
    // cut out a wider area for the locking nut
    translate([0, -4.4, 12.5]) cube([6.2, 2.8, 10], center = true);
}
