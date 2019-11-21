// Tutor diameter
TUTOR_DIAMETER = 8; // [4:30]
// Thickness of the cylinders 
HOOK_THICKNESS = 2; // [1:10]
// Thickness of the hook
THICKNESS = 5; // [2:20]
// Length of the neck between the two hooks
TUTOR_LENGTH = 20; // [1:100]
// Width of the neck
TUTOR_WIDTH = 4; // [1:20]
// Plant hook diameter
HOOK_DIAMETER = 20; // [10:100]
// Opened space to insert the plant inside the hook
HOOK_SPACING = 4; // [2:20]

$fn = 50;
difference() {
    cylinder(h = THICKNESS, d = TUTOR_DIAMETER + 2 * HOOK_THICKNESS, center = true);
    cylinder(h = THICKNESS, d = TUTOR_DIAMETER, center = true);
    translate([TUTOR_DIAMETER/2, 0, 0]) cylinder(h = THICKNESS, d = TUTOR_DIAMETER, center = true);
}
translate([-(TUTOR_LENGTH/2 + TUTOR_DIAMETER/2), 0, 0]) cube([TUTOR_LENGTH, TUTOR_WIDTH, THICKNESS], center = true);

translate([-(TUTOR_LENGTH + TUTOR_DIAMETER/2 + HOOK_DIAMETER / 2), 0, 0])  
difference() {
    cylinder(h = THICKNESS, d = HOOK_DIAMETER + 2 * HOOK_THICKNESS, center = true);
    cylinder(h = THICKNESS, d = HOOK_DIAMETER, center = true);
    color("green") translate([-(HOOK_DIAMETER / 2), 0, 0]) cube([THICKNESS, HOOK_SPACING, THICKNESS], center = true);
}