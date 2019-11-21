leg_diameter = 14.4;

collar_length = 10;
collar_thickness = 1.5;
flare_diameter = 30;

nozzle_diameter = 0.4;

$fn = 360;

rotate([0, 0, 180])
difference() {
    union() {
        resize([0, 0, collar_length]) sphere(d = flare_diameter);
        cylinder(d1 = flare_diameter, d2 = leg_diameter + (2 * collar_thickness), h = collar_length);
    }
    cylinder(d = leg_diameter + nozzle_diameter, h = collar_length);
} 