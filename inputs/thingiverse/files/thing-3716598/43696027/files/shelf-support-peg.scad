// Detail level
$fn = 50;

pin_depth = 7.5;
pin_diameter = 5;

support_thickness_upper = 2;
support_thickness_lower = 1.4;
support_thickness_taper_upper = 0;

support_rib_size = 6;
support_rib_thickness = 1.15;

support_depth = 11;
support_depth_lower = 8.5;

support_length_upper = 8.6;
support_length_lower = 9.6;
edge_radius = 1.5;

union() {
    rotate([0, 90, -90]) {
        cylinder(r=(pin_diameter/2), h=pin_depth);
    }
    translate([-support_depth/2, 0, pin_diameter/2 - support_thickness_upper]) {
        union() {
            cube([support_depth, support_thickness_lower, support_thickness_upper]);
            hull() {
                    translate([edge_radius, edge_radius, 0]) {
                        cylinder(r=(edge_radius), h=support_thickness_upper);
                    };
                    translate([support_depth - edge_radius, edge_radius, 0]) {
                        cylinder(r=(edge_radius), h=support_thickness_upper);
                    };
                    translate([edge_radius, support_length_upper - edge_radius, support_thickness_taper_upper]) {
                        cylinder(r=(edge_radius), h=support_thickness_upper - support_thickness_taper_upper);
                    };
                    translate([support_depth - edge_radius, support_length_upper - edge_radius, support_thickness_taper_upper]) {
                        cylinder(r=(edge_radius), h=support_thickness_upper - support_thickness_taper_upper);
                    };
                }
            rotate([-90, 0, 0]) {
                hull() {
                    translate([edge_radius, 0, 0]) {
                        cylinder(r=(edge_radius), h=support_thickness_lower);
                    };
                    translate([support_depth - edge_radius, 0, 0]) {
                        cylinder(r=(edge_radius), h=support_thickness_lower);
                    };
                    translate([edge_radius + ((support_depth - support_depth_lower) / 2), support_length_lower - edge_radius - support_thickness_upper, 0]) {
                        cylinder(r=(edge_radius), h=support_thickness_lower);
                    };
                    translate([support_depth_lower + ((support_depth - support_depth_lower) / 2) - edge_radius, support_length_lower - edge_radius - support_thickness_upper, 0]) {
                        cylinder(r=(edge_radius), h=support_thickness_lower);
                    };
                }
            }
        }
    }
    intersection() {
        hull() {
            translate([0, 0, pin_diameter/2]) {
                sphere(support_rib_thickness / 2);
            }
            translate([0, 0, pin_diameter/2 - support_rib_size]) {
                sphere(support_rib_thickness / 2);
            }
            translate([0, support_rib_size, pin_diameter/2]) {
                sphere(support_rib_thickness / 2);
            }
        }
        translate([-support_depth/2, 0, pin_diameter/2-support_length_lower]) {
            cube([support_depth, support_length_upper, support_length_lower]);
        }
    }
}
