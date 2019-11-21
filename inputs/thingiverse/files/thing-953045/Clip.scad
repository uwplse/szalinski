/* [General] */

// Diameter of the grip
diameter = 15;

// Angle open between the arms
angle = 120;

// Thickness of the arms
arm_thickness = 2; 

// Distance from standoff to centerline of grip (x direction)
standoff = 20;

// Width of the standoff (y direction)
standoff_width = 10;

// Height of the clip (z direction)
height = 20;

// Number of screws
num_screws = 2;

// Diameter of screws
screw_diameter = 4;

// Diameter of head of screws
screw_head_diameter = 6;

// Screw head counter-bore depth
screw_head_depth = 2;

// Lip length
lip_length = 1;

// Lip depth (zero for no lip)
lip_depth = 0;

/* [Hidden] */
$fn = 100;
radius = diameter/2;
rounded_angle = asin((arm_thickness/2)/(radius+arm_thickness/2));

module letter_c(radius, thickness, angle) {
    difference() {
        circle(radius+thickness);
        circle(radius);
        polygon([ // polygon to cut thing to angle
            [0, 0],
            (radius+thickness+1)*[sin(90-angle/2), cos(90-angle/2)],
            (radius+thickness+1)*[sin(90-angle/2), 2],
            [radius+thickness+2, radius+thickness+2],
            [radius+thickness+2, -radius-thickness-2],
            (radius+thickness+1)*[sin(90+angle/2), -2],
            (radius+thickness+1)*[sin(90+angle/2), cos(90+angle/2)]]);
    }
}

module lip(lip_depth, lip_length) {
    linear_extrude(lip_length) {
        rounded_angle_lip = asin((arm_thickness/2)/(radius-lip_depth+arm_thickness/2));
        letter_c(radius-lip_depth, arm_thickness, angle+rounded_angle_lip*2);
        rotate(angle/2+rounded_angle_lip) translate([radius-lip_depth+arm_thickness/2, 0]) circle(arm_thickness/2);
        polygon([
            (radius-lip_depth+arm_thickness/2)*[cos(angle/2+rounded_angle_lip), sin(angle/2+rounded_angle_lip)],
            (radius+arm_thickness/2)*[cos(angle/2+rounded_angle), sin(angle/2+rounded_angle)],
            (radius+arm_thickness/2)*[cos(angle/2), sin(angle/2)],
            (radius-lip_depth+arm_thickness/2)*[cos(angle/2), sin(angle/2)]
        ]);
        rotate(-angle/2-rounded_angle_lip) translate([radius-lip_depth+arm_thickness/2, 0]) circle(arm_thickness/2);
        polygon([
            (radius-lip_depth+arm_thickness/2)*[cos(angle/2+rounded_angle_lip), -sin(angle/2+rounded_angle_lip)],
            (radius+arm_thickness/2)*[cos(angle/2+rounded_angle), -sin(angle/2+rounded_angle)],
            (radius+arm_thickness/2)*[cos(angle/2), -sin(angle/2)],
            (radius-lip_depth+arm_thickness/2)*[cos(angle/2), -sin(angle/2)]
        ]);
    }
}

difference() { // remove screw holes
    union() { // add lips
        linear_extrude(height) { // extrude basic shape
            difference() {
                translate([-standoff, -standoff_width/2]) square([standoff, standoff_width]);
                circle(radius);
            }
            letter_c(radius, arm_thickness, angle+rounded_angle*2);
            rotate(angle/2+rounded_angle) translate([radius+arm_thickness/2, 0]) circle(arm_thickness/2);
            rotate(-angle/2-rounded_angle) translate([radius+arm_thickness/2, 0]) circle(arm_thickness/2);
        }
        lip(lip_depth, lip_length);
        translate([0, 0, height-lip_length]) lip(lip_depth, lip_length);
    }
    for(i = [1:num_screws]) translate([0, 0, height/(num_screws*2)*(i*2-1)]) {
        rotate([0, -90, 0]) {
            cylinder(h=standoff+1, d=screw_diameter);
            cylinder(h=radius+screw_head_depth, d=screw_head_diameter);
        }
    }
}