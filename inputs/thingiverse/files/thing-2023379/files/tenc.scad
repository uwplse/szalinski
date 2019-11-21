/* [Text] */
text = "ENVIRONMENT";
text_size = 4.5;
// (mm)
text_height = 0.4;

/* [Module dimensions] */
// (mm)
module_width = 45;
// (mm)
module_height = 26.5;
// (mm)
depth = 30;
// (mm)
cable_hole_diameter = 4.5;

/* [Other] */
// (mm)
stand_height = 10;
// (mm)
wall_thickness = 2;
// (degrees)
incline = 15;
// (mm)
edge_radius = 1.5;

/* [Hidden] */
tx = module_width + 2 * wall_thickness;
ty = depth + wall_thickness;
tz = module_height + 2 * wall_thickness;
$fn = 32;

translate([0, 0, ty]) {
    rotate(a = [-90 + incline, 0, 0]) difference() {
        rotate(a = [-incline, 0, 0]) difference() {
            // Main body
            hull() {
                translate([edge_radius, edge_radius, stand_height + tz - edge_radius]) sphere(r = edge_radius);
                translate([edge_radius, ty - edge_radius, stand_height + tz - edge_radius]) sphere(r = edge_radius);
                translate([tx - edge_radius, edge_radius, stand_height + tz - edge_radius]) sphere(r = edge_radius);
                translate([tx - edge_radius, ty - edge_radius, stand_height + tz - edge_radius]) sphere(r = edge_radius);
                cube([tx, ty, stand_height]);
            }

            // Module hole
            translate([wall_thickness, -1, wall_thickness + stand_height]) 
                cube([module_width, depth + 1, module_height]);

            // Cable hole
            translate([tx - wall_thickness - cable_hole_diameter, ty - wall_thickness, stand_height + wall_thickness + cable_hole_diameter]) 
                rotate(a = [90, 0, 0]) 
                cylinder(h = wall_thickness * 3, d = cable_hole_diameter, center = true);
        }
        // Make incline
        translate([-1, 0, -tz]) cube([tx + 2, ty * 2, tz]);
    }

    // Text under the sensor
    if(text != "") {
        translate([tx / 2, stand_height / 2, 0]) 
            linear_extrude(text_height) 
                text(text = text, size = text_size, font = "Arial", halign = "center", valign = "center");
    }
}