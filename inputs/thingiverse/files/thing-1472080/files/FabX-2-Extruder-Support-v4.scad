upper_plate_radius = 19.75;
screw_distance_from_center = 16.5;
screw_hole_diameter = 6; // M3 head is usually 5.5mm
ptfe_hole_diameter = 4.5;
height = 10;
hotend_ptfe_diameter = 6.5;
hotend_ptfe_protrusion = 3.7;
extruder_gear_length = 11.1;
extruder_gear_diameter = 12;
extruder_idler_length = 16;
extruder_idler_diameter = 13;
HOLE_BUFFER_HEIGHT = 1;
$fn = 100;

extruder_support();

module extruder_support() {
    difference() {
        union() {
            hotend_ptfe_support(
                hotend_ptfe_protrusion,
                hotend_ptfe_diameter,
                upper_plate_radius,
                screw_hole_diameter,
                screw_distance_from_center
            );

            translate([0, 0, hotend_ptfe_protrusion])
                extruder_support_with_ptfe_hole(
                    height,
                    upper_plate_radius,
                    screw_distance_from_center,
                    screw_hole_diameter,
                    ptfe_hole_diameter
                );
        }
        union() {
            // Dent for the extruder gear
            translate([-5, 6, height + hotend_ptfe_protrusion + 4]) {
                rotate([120, 90, 0]) {
                    cylinder(h = extruder_gear_length, d = extruder_gear_diameter);
                }
            }
            // Dent for the extruder idler
            translate([11, 0, height + hotend_ptfe_protrusion + 4]) {
                rotate([120, 90, 0]) {
                    cylinder(h = extruder_idler_length, d = extruder_idler_diameter);
                }
            }
        }

    }
}

module hotend_ptfe_support(hotend_ptfe_protrusion, hotend_ptfe_diameter, upper_plate_radius, screw_hole_diameter, screw_distance_from_center) {
    // Additional support to hold hotend ptfe protrusion
    difference() {
        extruder_support_with_ptfe_hole(
            hotend_ptfe_protrusion,
            upper_plate_radius,
            screw_distance_from_center,
            screw_hole_diameter,
            hotend_ptfe_diameter
        );
        translate([-((hotend_ptfe_diameter / 2) + 0.5), 0, -HOLE_BUFFER_HEIGHT]) {
            rotate([0, 0, -30]) {
                cube([hotend_ptfe_diameter, upper_plate_radius, hotend_ptfe_protrusion + HOLE_BUFFER_HEIGHT]);
            }
        }
    }
}

module extruder_support_with_ptfe_hole(height, uper_plate_radius, screw_distance_from_center, screw_hole_diameter, ptfe_hole_diameter) {
    height_with_hole_buffer = height + (HOLE_BUFFER_HEIGHT * 2);

    intersection(){
        difference(){
            cylinder(r = upper_plate_radius, h = height);
            
            // Screw Holes
            for(angle=[0:120:359]){
                polar_translate(screw_distance_from_center, angle, -HOLE_BUFFER_HEIGHT)
                    cylinder(d = screw_hole_diameter, h = height_with_hole_buffer, $fn = 60);
            }
            
            // PTFE Tube/Filament Hole
            translate([0, 0, -HOLE_BUFFER_HEIGHT])
                cylinder(d = ptfe_hole_diameter, h = height_with_hole_buffer, $fn = 60);
        }
        // Trianguar Cut
        translate([0, 0, -HOLE_BUFFER_HEIGHT])
            polar_equilateral(screw_distance_from_center + 3, height_with_hole_buffer);
    }
}

function polar_to_cartesian(distance_from_center, angle) =
    [distance_from_center * cos(angle), distance_from_center * sin(angle)];

module polar_translate(distance_from_center, angle, z=0) {
    xy = polar_to_cartesian(distance_from_center, angle);
    translate([xy[0], xy[1], z]) children();
}

module polar_equilateral(distance_from_center, height){
    linear_extrude(height = height){
        triangle_points = [
            polar_to_cartesian(distance_from_center, 0),
            polar_to_cartesian(distance_from_center, 120),
            polar_to_cartesian(distance_from_center, 240)
        ];
        polygon(triangle_points);
    };
}
