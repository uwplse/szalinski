vial_diameter   = 16.2;
flange_diameter = 50;
flange_height   = 20;
wall_thickness  = 0.6;

vial_radius = vial_diameter / 2;
flange_radius = flange_diameter / 2;

rotate_extrude($fn=100) {
difference() {
    square(size=[flange_radius, flange_height]);
    union() {
        translate([wall_thickness + vial_radius + flange_height, flange_height])
            circle(r=flange_height);
        translate([0,1]) square(size=[vial_radius, 50]);
    };
}
}