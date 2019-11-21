// ************************
// * Adjustable variables *
// ************************
motor_diameter = 6;
body_l = 80;
body_w = 60;
body_h = 2;
wall_thickness = 2;

center_hole_length = 24;
center_hole_width = 24;
battery_width = 10.5;
battery_height = 6.5;
battery_holder_slope_length = wall_thickness * 2;

// Curve radius for the sides. Smaller radius = deeper sidecut.
// These values must fit the following requirements:
//    body_length_curve_radius >= (body_l - motor_diameter)/2
//    body_width_curve_radius >= (body_w - motor_diameter)/2
body_length_curve_radius = body_l * 0.8;
body_width_curve_radius = body_w * 0.6;

// Whether or not you want a full circle around your motors
closed_motor_holder = false;

// ************************
// * Calculated variables *
// ************************
length_arc_length = body_l - motor_diameter;
width_arc_length = body_w - motor_diameter;

length_angle = asin((length_arc_length/2)/body_length_curve_radius);
length_circle_center_translation = cos(length_angle) * body_length_curve_radius;
length_sidecut_depth = body_length_curve_radius - length_circle_center_translation;

width_angle = asin((width_arc_length/2)/body_width_curve_radius);
width_circle_center_translation = cos(width_angle) * body_width_curve_radius;
width_sidecut_depth = body_width_curve_radius - width_circle_center_translation;

$fn = 100;

// build the frame body without motor holders
module frame_body() {
    union(){
        frame_side(circle_translation=[body_l/2, -length_circle_center_translation, 0], circle_radius=body_length_curve_radius);
        frame_side(circle_translation=[body_l/2, body_w + length_circle_center_translation, 0], circle_radius=body_length_curve_radius);
        frame_side(circle_translation=[body_l + width_circle_center_translation, body_w/2, 0], circle_radius=body_width_curve_radius);
        frame_side(circle_translation=[-width_circle_center_translation, body_w/2, 0], circle_radius=body_width_curve_radius);
        inner_frame();
    }
}

// build an internal lattice to support the flight controller and battery
module inner_frame() {
    width_contact_point_angle = asin((center_hole_width/2 + wall_thickness/2)/body_width_curve_radius);
    width_contact_point_translation = cos(width_contact_point_angle) * body_width_curve_radius;

    length_contact_point_angle = asin((center_hole_length/2 + wall_thickness/2)/body_length_curve_radius);
    length_contact_point_translation = cos(length_contact_point_angle) * body_length_curve_radius;

    inner_frame_length = body_l - (width_contact_point_translation - width_circle_center_translation) * 2 + wall_thickness;
    inner_frame_width = body_w - (length_contact_point_translation - length_circle_center_translation) * 2 +  wall_thickness;

    union() {
        // Width cross-frame
        translate([body_l/2 - center_hole_length/2 - wall_thickness, length_contact_point_translation - length_circle_center_translation - wall_thickness/2, 0])
            cube([wall_thickness, inner_frame_width, body_h]);
        translate([body_l/2 + center_hole_length/2, length_contact_point_translation - length_circle_center_translation - wall_thickness/2, 0])
            cube([wall_thickness, inner_frame_width, body_h]);

        // Length cross-frame
        translate([width_contact_point_translation - width_circle_center_translation - wall_thickness/2, body_w/2 - center_hole_width/2 - wall_thickness, 0])
            cube([inner_frame_length, wall_thickness, body_h]);
        translate([width_contact_point_translation - width_circle_center_translation - wall_thickness/2, body_w/2 + center_hole_width/2, 0])
            cube([inner_frame_length, wall_thickness, body_h]);

        battery_holder();
    }
}

// build both brackets for the battery
module battery_holder() {
    translate([body_l/2 - center_hole_length/2 - wall_thickness, body_w/2 - (battery_width + wall_thickness * 2)/2, body_h])
        battery_holder_bracket();
    translate([body_l/2 + center_hole_length/2, body_w/2 - (battery_width + wall_thickness * 2)/2, body_h])
        battery_holder_bracket();
}

// build a single bracket for the battery
module battery_holder_bracket() {
    difference() {
        union() {
            cube([wall_thickness, battery_width + wall_thickness * 2, battery_height + wall_thickness]);
            difference() {
                difference() {
                    translate([0, -battery_holder_slope_length, 0])
                        cube([wall_thickness, battery_width + wall_thickness * 2 + battery_holder_slope_length * 2, battery_holder_slope_length]);
                    translate([0, -battery_holder_slope_length, battery_holder_slope_length])
                        rotate([0, 90, 0])
                            cylinder(h = wall_thickness + 2, r = battery_holder_slope_length);
                }
                translate([0, battery_width + wall_thickness * 2 + battery_holder_slope_length, battery_holder_slope_length])
                    rotate([0, 90, 0])
                        cylinder(h = wall_thickness + 2, r = battery_holder_slope_length);
            }
        }
        translate([-1, wall_thickness, 0])
            cube([wall_thickness + 2, battery_width, battery_height]);
    }
}

// build a single arching frame side
module frame_side(circle_translation, circle_radius) {
    intersection() {
            // base rectangle for the frame
            translate([-motor_diameter/2, -motor_diameter/2, 0])
                cube([body_l + motor_diameter, body_w + motor_diameter, body_h]);
            // circle to create arching side
            translate(circle_translation)
                difference() {
                    translate([0,0,0])
                        cylinder(h=body_h, r=circle_radius);
                    translate([0,0,-1])
                        cylinder(h=body_h + 2, r=circle_radius-wall_thickness);
                }
        }
}

// build a single motor holder
module motor_holder() {
    difference() {
        cylinder(h=body_h, r=motor_diameter/2 + wall_thickness);
        if (!closed_motor_holder) {
            translate([0, 0, -1])
                cube([motor_diameter, motor_diameter, body_h + 2]);
        }
    }
}

module motor_holders() {
    motor_holder();
    translate([body_l, 0, 0])
        rotate([0, 0, 90])
            motor_holder();
    translate([body_l, body_w, 0])
        rotate([0, 0, 180])
            motor_holder();
    translate([0, body_w, 0])
        rotate([0, 0, 270])
        motor_holder();
}

// build all motor holes
// this is used for final "drilling" of the motor holes
module motor_holes() {
    translate([0, 0, -1])
        cylinder(h=body_h + 2, r=motor_diameter/2);
    translate([body_l, 0, -1])
        cylinder(h=body_h + 2, r=motor_diameter/2);
    translate([body_l, body_w, -1])
        cylinder(h=body_h + 2, r=motor_diameter/2);
    translate([0, body_w, -1])
        cylinder(h=body_h + 2, r=motor_diameter/2);
}

// put all the components together
module build_frame() {
    difference() {
        union() {
            frame_body();   
            motor_holders();
        }
        motor_holes();
    }
}

build_frame();