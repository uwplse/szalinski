// Base
base_diameter = 30;
base_height = 1;

cylinder(h=base_height, r=(base_diameter/2));

// Tabs
tab_height = 10;
tab_thickness = 1;
tab_space = 1;
tab_angle = 1;

translate([-(base_diameter/2), -(tab_thickness/2), base_height]){
    rotate([-tab_angle, 0, 0]) {
        translate([0, -(tab_space), 0]) {
            cube([base_diameter, tab_thickness, tab_height]);
        }
    }
    rotate([tab_angle, 0, 0]) {
        translate([0, tab_space, 0]) {
            cube([base_diameter, tab_thickness, tab_height]);
        }
    }
}