//!OpenSCAD
// Customizable tube cap

// Resolution
$fn = 80;
cap_inside_diameter = 50;
wall_thickness = 0.5;
floor_thickness = 0.5;
cap_height = 10;

difference() {
    cylinder(r = cap_inside_diameter  / 2 + wall_thickness, h = cap_height);
    translate([0, 0, floor_thickness])
        cylinder(r = cap_inside_diameter / 2, h = cap_height);
}