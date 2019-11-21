use <MCAD/regular_shapes.scad>

/* [ Basic ] */
WHEEL_DIAMETER=125;
HUB_DIAMETER=40;
HUB_THICKNESS=4;

/* [ Handle ] */
HANDLE_THICKNESS=6;
OUTDENT_COUNT=24;
OUTDENT_DIAMETER=8;

/* [ Spokes ] */
SPOKE_COUNT=6;
SPOKE_ANGLE_SPAN=20;

/* [ D-Cutout ] */
ENCODER_SHAFT_DIAMETER=6;
D_WIDTH=5.5;
CUTOUT_FIT_ALLOWANCE=0.2;

/* [ Bolt ] */
BOLT_DIAMETER=3;
BOLT_HEAD_DIAMETER=5.6;
NUT_WIDTH=5.4;
NUT_THICKNESS=1.7;
NUT_CLEARANCE=0.2;


/* [ Hidden ] */
HANDLE_OUTDENT_RADIUS=OUTDENT_DIAMETER / 2;
WHEEL_RADIUS=WHEEL_DIAMETER / 2;
HUB_RADIUS=HUB_DIAMETER / 2;
$fn=64;
ENCODER_SHAFT_RADIUS=ENCODER_SHAFT_DIAMETER/2;
BOLT_RADIUS=BOLT_DIAMETER/2;
BOLT_HEAD_RADIUS=BOLT_HEAD_DIAMETER/2;

BOLT_SHAFT_LENGTH=max(BOLT_HEAD_DIAMETER, NUT_WIDTH) * 1.5;
echo("Bolt shaft length: ", BOLT_SHAFT_LENGTH, "mm");
echo("Total object length: ", BOLT_SHAFT_LENGTH + HUB_THICKNESS, "mm");
BOLT_SHAFT_RADIUS=ENCODER_SHAFT_RADIUS + 3 * NUT_THICKNESS;

echo("Bolt shaft radius:", BOLT_SHAFT_RADIUS, " mm");
echo("A bolt of length:", BOLT_SHAFT_RADIUS - (D_WIDTH - ENCODER_SHAFT_RADIUS),  "mm will be required");

TOTAL_D_CUTOUT_HEIGHT=BOLT_SHAFT_LENGTH+HUB_THICKNESS;


module cylinder_outer(height,radius,fn) {
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

// handle
translate([0,0,HANDLE_THICKNESS/2]) torus2(WHEEL_RADIUS, HANDLE_THICKNESS/2);
// outdents
outdent_degrees = 360 / OUTDENT_COUNT;
for(sector = [1 : OUTDENT_COUNT]) {
    angle = outdent_degrees * sector;
    x_pos = WHEEL_RADIUS * sin(angle);
    y_pos = WHEEL_RADIUS * cos(angle);
    translate([x_pos,y_pos,HANDLE_OUTDENT_RADIUS]){
        sphere(HANDLE_OUTDENT_RADIUS, center=true);
    }
}

// spokes
spoke_angle_half_span=SPOKE_ANGLE_SPAN/2;
spoke_degrees = 360 / SPOKE_COUNT;
for(sector = [1 : SPOKE_COUNT]) {
    angle_mid = spoke_degrees * sector;
    angle_min = angle_mid - spoke_angle_half_span;
    angle_max = angle_mid + spoke_angle_half_span;
    // points near handle bar
    x1_pos = WHEEL_RADIUS * sin(angle_min);
    y1_pos = WHEEL_RADIUS * cos(angle_min);
    x2_pos = WHEEL_RADIUS * sin(angle_max);
    y2_pos = WHEEL_RADIUS * cos(angle_max);
    // points at hub
    x3_pos = HUB_RADIUS * sin(angle_min);
    y3_pos = HUB_RADIUS * cos(angle_min);
    x4_pos = HUB_RADIUS * sin(angle_max);
    y4_pos = HUB_RADIUS * cos(angle_max);
    translate([0,0,0]) linear_extrude(HUB_THICKNESS) polygon(points=[
        [x1_pos, y1_pos],
        [x2_pos, y2_pos],
        [x4_pos, y4_pos],
        [x3_pos, y3_pos]
    ]);

}

// hub
actual_d_radius=ENCODER_SHAFT_RADIUS + CUTOUT_FIT_ALLOWANCE;
actual_d_width=D_WIDTH + CUTOUT_FIT_ALLOWANCE;

module DCutout() {
    intersection() {
        cylinder_outer(TOTAL_D_CUTOUT_HEIGHT, actual_d_radius, 64);
        translate([-actual_d_radius, -actual_d_radius, 0]) cube([actual_d_width, actual_d_radius * 2, TOTAL_D_CUTOUT_HEIGHT]);
    }
}

// HUB
difference() {
    cylinder_outer(HUB_THICKNESS, HUB_RADIUS, $fn);
    //D cutout
    DCutout();
}

// BOLT SHAFT
actual_nut_thickness = NUT_THICKNESS + NUT_CLEARANCE;
actual_nut_width = NUT_WIDTH + NUT_CLEARANCE;

difference() {
    translate([0, 0, HUB_THICKNESS]) difference() {
        cylinder_outer(BOLT_SHAFT_LENGTH, BOLT_SHAFT_RADIUS, $fn);
        // bolt hole
        translate([1, 0, BOLT_SHAFT_LENGTH / 2]) rotate([0, 90, 0]) cylinder_outer(BOLT_SHAFT_RADIUS, BOLT_RADIUS, $fn);
        // recess for nut
        translate([
            -(ENCODER_SHAFT_RADIUS - D_WIDTH) + actual_nut_thickness,
            - actual_nut_width / 2,
            (BOLT_SHAFT_LENGTH / 2) - (actual_nut_width / 2)
        ]) cube([actual_nut_thickness, actual_nut_width, BOLT_SHAFT_LENGTH]);
    }

    DCutout();
}
