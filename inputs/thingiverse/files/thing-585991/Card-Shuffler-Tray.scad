/**
 * A replacement card tray for a card shuffler.
 * All measurements are in mm.
 */

// The width of the tray.
width = 64;

// The thickness of the tray sides.
base_thickness = 1.9;

// The length of the tray base.
base_length = 90;

// The height of the tray front.
end_height = 47.5;

// The thickness of the tray front, including the ridges.
end_thickness_max = 3.4;

end_thickness_min = end_thickness_max / 2;

end_ridge_radius = end_thickness_max - end_thickness_min;

ridges = floor( width / ( end_ridge_radius * 2 ) );

// Calculate a width that will allow for an exact number of ridges.
even_width = (ridges * end_ridge_radius * 2 );   

$fs = 1;
$fa = 1;

// Base
translate([end_thickness_max, 0, 0]) union() {
    linear_extrude(base_thickness) difference() {
        square([base_length, even_width]);
        translate([base_length / 2, 0, 0]) circle(r=even_width / 4);
        translate([base_length / 2, even_width, 0]) circle(r=even_width / 4);
    };
};

// End
difference() {
    union() {
        translate([end_ridge_radius, 0, 0]) cube([end_thickness_min, even_width, end_height]);
        for (i = [0 : ridges - 1]) {
            translate([end_ridge_radius, end_ridge_radius + (i * end_ridge_radius * 2), 0]) cylinder(h=end_height, r=end_ridge_radius);
        }
    };
    
    translate([0, 0, end_height]) rotate([0, 90, 0]) cylinder(h=end_thickness_max, r=width / 3);
    translate([0, even_width, end_height]) rotate([0, 90, 0]) cylinder(h=end_thickness_max, r=width / 3);
};
