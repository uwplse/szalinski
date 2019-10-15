/* [Support Dimensions] */
// - Support/padding height (excluding the skirt height)
support_height = 17.5;
// - Width of the motor - 42.3mm for NEMA 17
width = 42.3; // NEMA 17s are 42.3 x 42.3 x motor_height
// - Chamfer width of the motor. Set it to the same as width if the motor body isn't chamfered
chamfer_width = 33;

/* [Skirt Dimensions] */
// - Skirt Height
skirt_height = 4;
// - Thickness in addition to motor dimensions, which primarily shows up as the skirt thickness in the model
thickness = 1;

/* [Connector Dimensions] */
// - Width of the motor connector
connector_width = 16;

/* [Tolerances] */
// - Additional spacing for holes, to compensate for material shrinkage after printing
shrink_buffer = 0.5;
// - Buffer to avoid zero thickness planes in intersections and differences. Doesn't have to be customized in most cases.
hole_buffer = 1; // Hole shapes need to be slightly bigger than the objects they're cutting through

difference(){
    motor_support(width + shrink_buffer, chamfer_width + shrink_buffer, support_height, skirt_height, thickness);
    translate([width / 2, 0, support_height / 2]) {
        connector_hole(connector_width + shrink_buffer, thickness, skirt_height);
    };
}

module connector_hole(width, thickness, height) {
    cube([(thickness * 2) + hole_buffer, width, height + hole_buffer], center = true);
}

module motor_support(width, chamfer_width, support_height, skirt_height, thickness) {
    difference() {
        motor_body(width + (thickness * 2), chamfer_width + (thickness * 2), support_height + skirt_height);
        translate([0, 0, support_height / 2]) {
            motor_body(width, chamfer_width, skirt_height + hole_buffer);
        };
    };
}

module motor_body(width, chamfer_width, height) {
    hull() {
        cube([width, chamfer_width, height], center = true);
        rotate([0, 0, 90]){
            cube([width, chamfer_width, height], center = true);
        };
    };
}
