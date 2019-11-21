// Custom Spider Robot
// http://www.thingiverse.com/thing:2759294
// Customize body and legs for Regis Hsu's Spider robot
// http://www.thingiverse.com/thing:1009659
// This will create all pieces for the body and legs for the spider robot.
// All measurements are in millimeters

//CUSTOMIZER VARIABLES

// Select robot part to see (body, leg 1, leg 2)
part = "body"; // [body:Body,leg_1:Leg 1,leg_2:Leg 2]

// servo
servo_type = 1; // [0:custom,1:Tower Pro SG90,2:Tower Pro MG90S,3:Futaba S3150,4:HXT900,5:Emax ES9051,6:Emax ES08MAII]

/* [battery dimensions] */
battery_length = 87.9; // [40:0.1:120]
battery_width = 43.4; // [20:0.1:80]
battery_height = 16.5; // [5:0.1:30]

// clearance (distance) from battery to plastic sides
battery_clearance = 0.6; // [0:0.1:2]
// distance from edge to cutout for battery switch
switch_cutout_distance = 4.0; // [0:0.1:20]
// distance from edge to cutout for battery cord
cord_cutout_distance = 0.75; // [0:0.1:20]
// distance of support under battery
battery_base_support = 8.0; // [3:0.5:12]
// type of battery access
battery_access = 0; // [0:FIXED (e.g. DC12300),1:REMOVABLE (e.g. 4xAA)]

/* [leg dimensions] */
coxa_length = 27.5; //[10:0.5:100]
femur_length = 55.0; //[10:0.5:200]
tibia_length = 77.5; //[10:0.5:200]
// radius of s_hold screw hole
s_hold_screw_radius = 0.8;
// clearance from s_hold knob to bracket hole
s_hold_knob_clearance = 0.1; // [0.0:0.05:0.5]

/* [custom servo dimensions] */
// if servo should be surrounded on all sides
servo_surround = 0; //[0:false,1:true]
// radius of servo screw hole
servo_screw_radius = 0.8;  // [0:0.1:3]
// clearance (distance) from servo to plastic sides
servo_clearance = 0.6; // [0:0.1:3]

// length of servo
servo_length = 22.6; // [10:0.1:40]
// width of servo
servo_width = 12.2; // [0:0.1:40]
// from bottom of servo to bottom of shelf
servo_under_height = 15.6;  // [5:0.1:40]
// from bottom of shelf to top of rotor base
servo_over_height = 10.8;  // [5:0.1:40]
// distance from end of servo to rotor center
servo_rotor_distance = 6.5; // [0:0.1:20]
// screw hole center distance from edge
servo_screw_distance = 2.6;  // [0:0.1:10]
// number of screws (2 or 4)
servo_screw_count = 2; // [2:2:4]
// if four screws, how far apart are the screws on the same side
servo_screws_apart = 0;  // [0:0.1:10]

/* [custom horn dimensions] */
horn_rotor_radius = 3.75; // [2.0:0.1:6.0]
horn_small_radius = 2.0; // [1.0:0.1:4.0]
horn_length = 16.0; // [10.0:0.5:25.0]
horn_depth = 1.9; // [1.0:0.1:4.0]
horn_rotor_depth = 4.7; // [2.0:0.1:7.0]

/* [Hidden] */
INSIGNIFICANT_DISTANCE = 0.1;
FILLET_DELTA = INSIGNIFICANT_DISTANCE;
USE_FONT_NAME = "Open Sans:style=Bold";
USE_FONT_SIZE = 4;
SLIDER_RIDGE_COUNT = 4;
SLIDER_SUPPORT_PERCENT = 0.25;

// battery types
FIXED = 0;
REMOVABLE = 1;

// common servos
custom_index = 0;
Tower_Pro_SG90_index = 1;
Tower_Pro_MG90S_index = 2;
Futaba_S3150_index = 3;
HXT900_index = 4;
Emax_ES9051_index = 5;
Emax_ES08MAII_index = 6;

servo_length_index = 0; // servo length
servo_width_index = 1; // servo width
servo_under_height_index = 2; // from bottom to bottom of shelf
servo_over_height_index = 3; // from bottom of shelf to top of rotor base
servo_rotor_distance_index = 4; // rotor center from edge (lengthwise)
servo_screw_distance_index = 5; // hole distance from edge
servo_screws_apart_index = 6; // hole distance from edge
SERVO_DIMENSIONS = [
    [0,0,0,0,0,0,0], // custom
    [22.6,12.2,15.6,10.8,6.5,2.6,0], // Tower Pro SG90
    [22.5,12.0,21.0,10.0,6.0,2.6,0], // Tower Pro MG90S
    [30.0,10.8,19.8,9.2,7.3,3.4,0], // Futaba S3150
    [22.225,11.1125,15.875,10.32,5.365,2.3,0], // HXT900
    [19.76,8.34,14.7,8.15,4.0,1.9,0], // Emax ES9051
    [23,11.5,15,9,5.4,2.3,0] // Emax ES08MAII
];

// values used in program
servo_length__ = (servo_type == 0) ? servo_length : SERVO_DIMENSIONS[servo_type][servo_length_index];
servo_width__ = (servo_type == 0) ? servo_width : SERVO_DIMENSIONS[servo_type][servo_width_index];
servo_under_height__ = (servo_type == 0) ? servo_under_height : SERVO_DIMENSIONS[servo_type][servo_under_height_index];
servo_over_height__ = (servo_type == 0) ? servo_over_height : SERVO_DIMENSIONS[servo_type][servo_over_height_index];
servo_rotor_distance__ = (servo_type == 0) ? servo_rotor_distance : SERVO_DIMENSIONS[servo_type][servo_rotor_distance_index];
servo_screw_distance__ = (servo_type == 0) ? servo_screw_distance : SERVO_DIMENSIONS[servo_type][servo_screw_distance_index];
servo_screws_apart__ = (servo_type == 0) ? servo_screws_apart : SERVO_DIMENSIONS[servo_type][servo_screws_apart_index];

s_hold_shallow_thickness = 1.2;
// bracket dimensions
bracket_narrow_thickness = 2.5;
bracket_height = 12.0;
bracket_fillet_radius = 2;
bracket_wide_thickness = horn_rotor_depth - servo_clearance;
coxa_bracket_width = servo_under_height__ + servo_over_height__ + 2 * servo_clearance;

// servo holder dimensions
servo_holder_length = servo_length__ + 2 * servo_clearance;
servo_holder_side_length = (coxa_bracket_width + 2 * bracket_wide_thickness - servo_holder_length) / 2;
servo_holder_outer_length = servo_holder_length + 2 * servo_holder_side_length;
servo_holder_width = servo_width__ + 2 * servo_clearance;
servo_holder_thickness = 4.5;
servo_holder_fillet_radius = 3.0;
servo_holder_closer_width = 3.5;
servo_holder_end_part_radius = servo_holder_side_length/2;
servo_holder_main_part_width = servo_holder_width - servo_holder_end_part_radius;
servo_holder_width_center = servo_holder_end_part_radius/2;
servo_holder_center_distance_min = 2.0;

// create fillet
module Fillet(radius,xSign,ySign) {
    translate([-xSign*FILLET_DELTA,-ySign*FILLET_DELTA,0])
    offset(r=-(radius-FILLET_DELTA),$fn = 90)
    offset(delta=(radius-FILLET_DELTA),$fn = 90)
    polygon([[0,0],[xSign*radius,0],[xSign*radius,ySign*FILLET_DELTA],[xSign*FILLET_DELTA,ySign*FILLET_DELTA],[xSign*FILLET_DELTA,ySign*radius],[0,ySign*radius]],[[0,1,2,3,4,5,0]]);
}

// create one side of servo holder
module ServoHolderSide(side,servo_holder_center_distance,isFillet) {
    signMult = (side == "left") ? +1 : -1;
    difference() {
        union() {
            translate([0,(-servo_surround*servo_holder_center_distance/2) + INSIGNIFICANT_DISTANCE/2])
            square([servo_holder_side_length, servo_holder_width+(servo_surround*servo_holder_center_distance)+INSIGNIFICANT_DISTANCE],center=true);
            // base fillet
            if (isFillet) {
                translate([signMult*servo_holder_side_length / 2,servo_holder_center_distance+servo_holder_width / 2])
                Fillet(servo_holder_fillet_radius,signMult,-1);
            }
        };
        union() {
            // small screw hole(s)
            screw_distance = signMult*(servo_length__/2+servo_screw_distance__-((servo_holder_length + servo_holder_side_length) / 2));
            if (servo_screw_count == 4) {
                translate([screw_distance,-servo_screws_apart__/2])
                circle(r=servo_screw_radius,center=true,$fn = 90);
                translate([screw_distance,servo_screws_apart__/2])
                circle(r=servo_screw_radius,center=true,$fn = 90);
            } else {
                translate([screw_distance,0])
                circle(r=servo_screw_radius,center=true,$fn = 90);
            }
            // end fillet
            translate([signMult*servo_holder_side_length/2,-(servo_holder_width/2+(servo_surround*servo_holder_center_distance))])
            Fillet(servo_holder_fillet_radius,-signMult,+1);
        }
    };
}

// create servo holder
module ServoHolder(servo_holder_center_distance,isFillet=false) {
    linear_extrude(height = servo_holder_thickness, center = false, convexity = 10, twist = 0)
    union() {
        // left side
        translate([(servo_holder_length + servo_holder_side_length) / 2, 0])
        ServoHolderSide("left",servo_holder_center_distance,isFillet);
        // right side
        translate([-(servo_holder_length + servo_holder_side_length) / 2, 0])
        ServoHolderSide("right",servo_holder_center_distance,isFillet);
        // center
        translate([0,(servo_holder_width+servo_holder_center_distance)/2])
        square([servo_holder_outer_length, servo_holder_center_distance],center=true);
        if (servo_surround) {
            // surround end
            translate([0,-(servo_holder_width+servo_holder_center_distance)/2 +INSIGNIFICANT_DISTANCE/2])
            square([servo_holder_length+INSIGNIFICANT_DISTANCE, servo_holder_center_distance],center=true);
        }
    }
}

//***********************************************
//***********************************************
//                BODY                         //
//***********************************************
//***********************************************

// body has two parts, top and bottom

// m3 x 25 screws
large_screw_radius = 1.5;
large_screw_length = 25;

// thickness of sides
battery_holder_thickness = 2.5;

// circle around large screw
large_screw_holder_radius = 3.0;

// height of top section
top_height = 9.6;

// height of bottom section
bottom_height = 10.0;

// body dimensions
battery_inner_length = battery_length + 2 * battery_clearance;
battery_outer_length = battery_inner_length + 2 * battery_holder_thickness;
battery_inner_width = battery_width + 2 * battery_clearance;
battery_outer_width = battery_inner_width + 2 * (battery_access == FIXED ? battery_holder_thickness : 2 * large_screw_holder_radius);
battery_inner_height = battery_height + 2 * battery_clearance;
battery_outer_height = battery_inner_height + 2 * battery_holder_thickness;
slider_height = battery_outer_height - battery_holder_thickness * (1 - SLIDER_SUPPORT_PERCENT);
grip_tab_length = battery_width/8;
grip_tab_height = slider_height/4;

// length_side calculation - choose larger value)
length_length_side = battery_outer_length-2*(servo_holder_fillet_radius+servo_holder_side_length+servo_rotor_distance__);
width_length_side = battery_outer_width+2*(servo_holder_center_distance_min+servo_holder_width/2);
length_side_use_length = length_length_side > width_length_side;
length_side = length_side_use_length ? length_length_side : width_length_side;
display_length_side = round(100*length_side)/100;

// z_absolute calculation
z_absolute = -(battery_outer_height + (servo_over_height__ + servo_clearance + bracket_wide_thickness) - (servo_rotor_distance__+ servo_clearance + servo_holder_side_length));
display_z_absolute = round(100*z_absolute)/100;

// if need a second length holder to place servo rotors in correct position
extend_inner_length = length_side + 2 * (servo_holder_fillet_radius+servo_holder_side_length+servo_rotor_distance__ - battery_holder_thickness);
extend_outer_length = extend_inner_length + 2 * battery_holder_thickness;

// height of bottom screw holders
bottom_screw_holder_height = battery_outer_height - top_height;

// cutout side for battery switch/cord
cutout_length = 9.5;
cutout_height = 4.5;

// distance between parts on printer bed
PARTS_SEPARATOR = 8;

// 4 x servo base on bottom
servo_base_fillet_radius = 3.0;
// first level
servo_base1_height = 4.0;
servo_base1_radius = 6.0;
// second level
servo_base2_radius = 2.8;
servo_base2_clearance = 1.6;
servo_base2_height = top_height + bottom_screw_holder_height - (servo_under_height__ + servo_clearance + servo_base1_height + servo_base2_clearance);
// third level
servo_base3_height = 1.2;
servo_base3_radius = 1.5;
servo_base_width_distance = length_side / 2 - battery_outer_width/2;
servo_holder_connector_width = servo_holder_outer_length+2*servo_holder_fillet_radius;
servo_base_connector_width = servo_holder_connector_width;//2*servo_base1_radius+2*servo_base_fillet_radius;

use_outer_length = length_side_use_length ? battery_outer_length : extend_outer_length;
large_screw_x = use_outer_length/2+large_screw_holder_radius;
large_screw_plus_y = battery_outer_width/2+large_screw_holder_radius;
large_screw_minus_y = battery_outer_width/2-large_screw_holder_radius;

// create walls section for body - battery container sides
module Walls(wallHeight) {
    battery_holder_points =[[-battery_outer_length/2,-battery_outer_width/2],[battery_outer_length/2,-battery_outer_width/2],[battery_outer_length/2,battery_outer_width/2],[-battery_outer_length/2,battery_outer_width/2],[-battery_inner_length/2,-battery_inner_width/2],[battery_inner_length/2,-battery_inner_width/2],[battery_inner_length/2,battery_inner_width/2],[-battery_inner_length/2,battery_inner_width/2]];
    battery_holder_paths = (battery_access == FIXED) ? [[0,1,2,3],[4,5,6,7]] : [[0,1,2,3,7,6,5,4]];
    linear_extrude(height = wallHeight, center = false, convexity = 10, twist = 0)
    polygon(battery_holder_points,battery_holder_paths,10);
    if (!length_side_use_length) {
        main_points = [
            [-extend_outer_length/2,-battery_outer_width/2],
            [extend_outer_length/2,-battery_outer_width/2],
            [extend_outer_length/2,battery_outer_width/2],
            [-extend_outer_length/2,battery_outer_width/2],
            [-extend_inner_length/2,-battery_inner_width/2],
            [extend_inner_length/2,-battery_inner_width/2],
            [extend_inner_length/2,battery_inner_width/2],
            [-extend_inner_length/2,battery_inner_width/2],
            [-extend_outer_length/2,-battery_inner_width/2],
            [-extend_outer_length/2,battery_inner_width/2]
        ];
        main_paths = (battery_access == FIXED) ? [[0,1,2,3],[4,5,6,7]] : [[0,1,2,3,9,6,5,8]];
        linear_extrude(height = wallHeight, center = false, convexity = 10, twist = 0)
        polygon(main_points,main_paths,10);
    }
}

// create base section for body - battery container top / bottom
module Base(slideHoleThickness) {
    base_length = battery_inner_length/2 - battery_base_support;
    base_width = battery_inner_width/2 - battery_base_support;
    base_points = [
        [-extend_outer_length/2,-battery_outer_width/2],
        [extend_outer_length/2,-battery_outer_width/2],
        [extend_outer_length/2,battery_outer_width/2],
        [-extend_outer_length/2,battery_outer_width/2],
        [-base_length,-base_width],
	[base_length,-base_width],
        [base_length,base_width],
        [-base_length,base_width]
    ];
    base_paths = [[0,1,2,3],[4,5,6,7]];
    slideHole_points = [
        [-(battery_outer_length/2+battery_clearance),battery_inner_width/2],
        [-(battery_inner_length/2-battery_clearance),battery_inner_width/2],
        [-(battery_inner_length/2-battery_clearance),-battery_inner_width/2],
        [-(battery_outer_length/2+battery_clearance),-battery_inner_width/2]
    ];
    slideHole_path = (slideHoleThickness == 0) ? [[]] : [[0,1,2,3]];
    difference() {
        linear_extrude(height = battery_holder_thickness, center = false, convexity = 10, twist = 0)
        polygon(base_points,base_paths,10);
        translate([0,0,-INSIGNIFICANT_DISTANCE+battery_holder_thickness-slideHoleThickness])
        linear_extrude(height = slideHoleThickness+2*INSIGNIFICANT_DISTANCE, center = false, convexity = 10, twist = 0)
        polygon(slideHole_points,slideHole_path,10);
    }
}

// create holder for large screw
module LargeScrew(isLeftFillet=false, isRightFillet=false, angle=0) {
    difference() {
        union() {
            circle(r=large_screw_holder_radius,$fn = 90);
            square([large_screw_holder_radius,large_screw_holder_radius]);
            translate([0,-large_screw_holder_radius,0])
            square([large_screw_holder_radius,large_screw_holder_radius]);
            if (isLeftFillet) {
                Fillet(large_screw_holder_radius,-1,-1);
            }
            if (isRightFillet) {
                Fillet(large_screw_holder_radius,-1,+1);
            }
        }
        circle(r=large_screw_radius,$fn = 90);
    }
}

// create large screw holes for screws to connect body top and bottom
module LargeScrews(screwHeight,isFillets=false) {
    linear_extrude(height = screwHeight, center = false, convexity = 10, twist = 0)
    union() {
        translate([large_screw_x,large_screw_minus_y,0])
        rotate([0,0,180])
        LargeScrew(isRightFillet=isFillets);
        translate([large_screw_x,-large_screw_minus_y,0])
        rotate([0,0,180])
        LargeScrew(isLeftFillet=isFillets);
        translate([0,large_screw_plus_y,0])
        rotate([0,0,270])
        LargeScrew(isLeftFillet=isFillets,isRightFillet=isFillets);
        translate([0,-large_screw_plus_y,0])
        rotate([0,0,90])
        LargeScrew(isLeftFillet=isFillets,isRightFillet=isFillets);
        translate([-large_screw_x,large_screw_minus_y,0])
        LargeScrew(isLeftFillet=isFillets,angle=0);
        translate([-large_screw_x,-large_screw_minus_y,0])
        LargeScrew(isRightFillet=isFillets,angle=0);
    }
}

// create servo holders on body top
module ServoHolders(servo_holder_center_distance) {
    translate([length_side/2-servo_rotor_distance__,-length_side/2,0])
    ServoHolder(servo_holder_center_distance,isFillet=true);
    translate([-(length_side/2-servo_rotor_distance__),-length_side/2,0])
    ServoHolder(servo_holder_center_distance,isFillet=true);
    translate([-(length_side/2-servo_rotor_distance__),length_side/2,0])
    rotate([0,0,180])
    ServoHolder(servo_holder_center_distance,isFillet=true);
    translate([length_side/2-servo_rotor_distance__,length_side/2,0])
    rotate([0,0,180])
    ServoHolder(servo_holder_center_distance,isFillet=true);
}

// create servo base
module ServoBase() {
    union() {
        linear_extrude(height = servo_base1_height, center = false, convexity = 10, twist = 0)
        union() {
            translate([0,servo_base_width_distance/2])
            square([2*servo_base1_radius,servo_base_width_distance + INSIGNIFICANT_DISTANCE],center=true);
            circle(servo_base1_radius,center=true,$fn = 90);
            translate([-servo_base1_radius,servo_base_width_distance])
            Fillet(servo_base_fillet_radius,-1,-1);
            translate([servo_base1_radius,servo_base_width_distance])
            Fillet(servo_base_fillet_radius,+1,-1);
        };
        linear_extrude(height = servo_base1_height+servo_base2_height, center = false, convexity = 10, twist = 0)
        circle(servo_base2_radius,center=true,$fn = 90);
        linear_extrude(height = servo_base1_height+servo_base2_height+servo_base3_height, center = false, convexity = 10, twist = 0)
        circle(servo_base3_radius,center=true,$fn = 90);
    }
}
// create servo bases on body bottom
module ServoBases() {
    translate([length_side/2,-length_side/2,0])
    ServoBase();
    translate([-(length_side/2),-length_side/2,0])
    ServoBase();
    translate([length_side/2,length_side/2,0])
    rotate([0,0,180])
    ServoBase();
    translate([-(length_side/2),length_side/2,0])
    rotate([0,0,180])
    ServoBase();
}

// cut out wall for battery switch/cord
module Cutout(isRight,wallHeight,cutoutDistance) {
    ySign = isRight ? +1 : -1;
    translate([-(battery_outer_length/2-(battery_holder_thickness+cutoutDistance+cutout_length/2)),ySign * (battery_outer_width/2 - battery_holder_thickness/2),wallHeight - cutout_height])
    linear_extrude(height = cutout_height + INSIGNIFICANT_DISTANCE, center = false, convexity = 10, twist = 0)
    square([cutout_length,battery_holder_thickness + INSIGNIFICANT_DISTANCE],center=true);
}

// print out value for "length_side" and "z_absolute" variables in arduino code
module DistanceDisplay() {
    translate([-battery_length/2,-battery_width/2,3*battery_holder_thickness/4])
    linear_extrude(height = battery_holder_thickness/4 + INSIGNIFICANT_DISTANCE, center = false, convexity = 10, twist = 0)
    text(str("ls=",display_length_side,", za=",display_z_absolute), font=USE_FONT_NAME,size=USE_FONT_SIZE);
}

//////////////////////////////////
// main body
//////////////////////////////////

// print battery slider
module battery_slider() {
    union() {
        linear_extrude(height = battery_holder_thickness, center = true, convexity = 10, twist = 0)
        union() {
            // main rectangle of slider
            square([slider_height, battery_width],center=true);
            // grip tab
            translate([slider_height/2,battery_width/2 - grip_tab_length])
            square([grip_tab_height, grip_tab_length],center=false);
            translate([slider_height/2,battery_width/2 - grip_tab_length])
            Fillet(grip_tab_height/2,+1,-1);
        }
        // ridges on grip tab
        ridge_radius = battery_holder_thickness / 8;
        for (ridge = [1:SLIDER_RIDGE_COUNT]) {
            translate([slider_height/2 + ridge * (grip_tab_height/(SLIDER_RIDGE_COUNT+1)),battery_width/2 - grip_tab_length/2,-battery_holder_thickness/2 + battery_holder_thickness])
            rotate([90,0,0])
            cylinder(h = grip_tab_length, r1 = ridge_radius, r2 = ridge_radius, $fn=90, center = true);
        }
    }
}
// print body top
module body_top(servo_holder_center_distance) {
    difference() {
        union() {
            Walls(wallHeight=top_height);
            Base(battery_access == FIXED ? 0 : battery_holder_thickness);
            LargeScrews(screwHeight=top_height,isFillets=true);
            ServoHolders(servo_holder_center_distance);
        };
        if (battery_access == FIXED) {
            Cutout(isRight=true,wallHeight=top_height,cutoutDistance=switch_cutout_distance);
            Cutout(isRight=false,wallHeight=top_height,cutoutDistance=cord_cutout_distance);
        }
    }
}
// print body bottom
module body_bottom() {
    difference() {
        union() {
            Walls(wallHeight=bottom_height);
            Base(battery_access == FIXED ? 0 : battery_holder_thickness * SLIDER_SUPPORT_PERCENT);
            LargeScrews(screwHeight=bottom_screw_holder_height,isFillets=false);
            ServoBases();
        };
        if (battery_access == FIXED) {
            Cutout(isRight=true,wallHeight=bottom_height,cutoutDistance=cord_cutout_distance);
            Cutout(isRight=false,wallHeight=bottom_height,cutoutDistance=switch_cutout_distance);
        }
        DistanceDisplay();
    }
}
// print body section
module body() {
    top_servo_holder_center_distance = length_side/2 - (battery_outer_width/2+servo_holder_width/2);
    top_separator = PARTS_SEPARATOR + 
        battery_outer_width/2 + servo_holder_width + top_servo_holder_center_distance;
    translate([0,top_separator,0])
    body_top(top_servo_holder_center_distance);
    bottom_separator = PARTS_SEPARATOR + length_side / 2 + servo_base1_radius;
    translate([0,-bottom_separator,0])
    body_bottom();
    if (battery_access == REMOVABLE) {
        slider_separator = PARTS_SEPARATOR + extend_outer_length / 2 + 2 * large_screw_holder_radius + slider_height/2 + battery_clearance;
        translate([slider_separator,0,battery_holder_thickness/2])
        battery_slider();
    }
}
//***********************************************
//***********************************************
//                    LEGS                     //
//***********************************************
//***********************************************

// legs have four parts - coxa (connects body to femur), femur (connects coxa to tibia),
// tibia (connects to femur and touchs floor), 2 x s_hold (connects pieces)

// stump dimensions
stump_length = 12.0;
stump_length_distance = 0.5;
stump_width = 3.5;

// to connect part to s_hold
module stump(stump_height) {
    difference() {
        cube([stump_width,stump_length,stump_height],center=true);
        union() {
            // screw holes
            translate([0, s_hold_micro_screw_radius_length_distance, INSIGNIFICANT_DISTANCE+stump_height/2 - s_hold_micro_screw_length/2])
            cylinder(h = s_hold_micro_screw_length, r1 = s_hold_screw_radius, r2 = s_hold_screw_radius, center = true, $fn=90);
            translate([0,-s_hold_micro_screw_radius_length_distance, INSIGNIFICANT_DISTANCE+stump_height/2 - s_hold_micro_screw_length/2])
            cylinder(h = s_hold_micro_screw_length, r1 = s_hold_screw_radius, r2 = s_hold_screw_radius, center = true, $fn=90);
        };
    }
}

// s_hold dimensions

s_hold_main_thickness = 1.8;
s_hold_micro_screw_radius_length_distance = 3.0;
s_hold_micro_screw_length = 5.0;
s_hold_knob_radius = 2.9;
s_hold_knob_thickness = 6.0;
s_hold_wide_distance = 6.5;
s_hold_outer_radius = stump_length/2;
s_hold_screw_distance = 3.0;
s_hold_separator_width = PARTS_SEPARATOR + s_hold_outer_radius;
s_hold_separator_length = PARTS_SEPARATOR + s_hold_outer_radius;
s_hold_separator_length_2 = PARTS_SEPARATOR + s_hold_separator_length+s_hold_outer_radius+s_hold_wide_distance+stump_width;

//////////////////////////////////
// s-hold/hinge
//////////////////////////////////

// print s_hold
module s_hold() {
    linear_extrude(height = s_hold_main_thickness, center = false, convexity = 10, twist = 0)
    union() {
        circle(r=s_hold_outer_radius, center = true, $fn=90);
        translate([-(s_hold_wide_distance)/2,0])
        square([s_hold_wide_distance, 2 * s_hold_outer_radius],center = true);
    };
    // screw extension
    linear_extrude(height = s_hold_shallow_thickness, center = false, convexity = 10, twist = 0)
    difference() {
        translate([-(stump_width/2+s_hold_wide_distance),0])
        square([stump_width, 2 * s_hold_outer_radius],center = true);
        union() {
            // screw holes
            translate([-(stump_width/2+s_hold_wide_distance),s_hold_outer_radius-s_hold_screw_distance])
            circle(r=s_hold_screw_radius, center = true, $fn=90);
            translate([-(stump_width/2+s_hold_wide_distance),-(s_hold_outer_radius-s_hold_screw_distance)])
            circle(r=s_hold_screw_radius, center = true, $fn=90);
        };
    }
    linear_extrude(height = s_hold_knob_thickness, center = false, convexity = 10, twist = 0)
    circle(r=s_hold_knob_radius, center = true, $fn=90);
}

// create hole for horn rotor
module horn_rotor_hole() {
    translate([-horn_length/2,0,0])
    cylinder(h = bracket_wide_thickness + INSIGNIFICANT_DISTANCE, r1 = horn_rotor_radius, r2 = horn_rotor_radius, center = true,$fn=90);
    translate([0,0,bracket_wide_thickness/2 - horn_depth])
    linear_extrude(height = horn_depth + INSIGNIFICANT_DISTANCE, center = false, convexity = 10, twist = 0)
    union() {
        translate([-horn_length/2,0,0])
        circle(horn_rotor_radius,center=true,$fn=90);
        translate([+horn_length/2,0,0])
        circle(r=horn_small_radius,center=true,$fn=90);
        polygon([[-horn_length/2,-horn_rotor_radius],[-horn_length/2,+horn_rotor_radius],[+horn_length/2,+horn_small_radius],[+horn_length/2,-horn_small_radius]], paths=[[0,1,2,3]]);
    }
}

bracket_hole_radius = s_hold_knob_radius + s_hold_knob_clearance;

// print out bracket for connecting servo
module bracket(bracket_length,bracket_width,hasSHold) {
    bracket_width__ = bracket_width + (hasSHold ? s_hold_main_thickness : 0);
    difference() {
        union() {
            linear_extrude(height = bracket_height, center = false, convexity = 10, twist = 0)
            union() {
                // sides
                translate([+(bracket_length/2),-(bracket_width/2+bracket_wide_thickness/2),0])
                square([bracket_length,bracket_wide_thickness],center=true);
                translate([bracket_length/2,bracket_width/2+bracket_wide_thickness/2,0])
                square([bracket_length,bracket_wide_thickness],center=true);
                translate([bracket_narrow_thickness/2,0,0])
                square([bracket_narrow_thickness,bracket_width],center=true);
                // fillets
                translate([+(bracket_narrow_thickness),bracket_width/2,0])
                Fillet(bracket_fillet_radius,+1,-1);
                translate([+(bracket_narrow_thickness),-(bracket_width/2),0])
                Fillet(bracket_fillet_radius,+1,+1);
            };
            // round side ends
            translate([+(bracket_length),-(bracket_width/2+bracket_wide_thickness/2),bracket_height/2])
            rotate([90,0,0])
            cylinder(h = bracket_wide_thickness, r1 = bracket_height/2, r2 = bracket_height/2, center = true,$fn=90);
            translate([+(bracket_length),+(bracket_width/2+bracket_wide_thickness/2),bracket_height/2])
            rotate([90,0,0])
            cylinder(h = bracket_wide_thickness, r1 = bracket_height/2, r2 = bracket_height/2, center = true,$fn=90);
        };
        union() {
            // servo axis holes
            translate([bracket_length,+(bracket_width/2+bracket_wide_thickness/2),bracket_height/2])
            rotate([90,0,0])
            cylinder(h = bracket_wide_thickness + INSIGNIFICANT_DISTANCE, r1 = bracket_hole_radius, r2 = bracket_hole_radius, center = true,$fn=90);
            // servo rotor holes
            translate([+(bracket_length - horn_length/2),-(bracket_width/2+bracket_wide_thickness/2),bracket_height/2])
            rotate([90,180,0])
            horn_rotor_hole();
        }
    }
}

//////////////////////////////////
// femur
//////////////////////////////////

// femur dimensions
femur_connector_length = 16.0;
femur_connector_width = 6.0;
femur_connector_distance = 6.75;
femur_long_length = 29;
femur_short_length = femur_length - (femur_long_length + femur_connector_width);
femur_separator_length = PARTS_SEPARATOR + femur_long_length + femur_connector_width / 2 + bracket_height/2;
femur_separator_width = PARTS_SEPARATOR + femur_connector_length + bracket_wide_thickness/2;
femur_bracket_width = servo_under_height__ + servo_over_height__ + s_hold_shallow_thickness + 3 * servo_clearance;

// connector for two femur brackets
module femur_connector() {
    union() {
        linear_extrude(height = bracket_height, center = false, convexity = 10, twist = 0)
        union() {
            difference() {
                // center connector
                square([femur_connector_width,femur_connector_length],center=true);
                // center connector hole
                square([femur_connector_width,femur_connector_length - bracket_narrow_thickness],center=true);
            };
            // fillets
            translate([-(femur_connector_width/2),-(femur_connector_length/2),0])
            Fillet(bracket_fillet_radius,+1,-1);
            translate([+(femur_connector_width/2),-(femur_connector_length/2),0])
            Fillet(bracket_fillet_radius,-1,-1);
            translate([-(femur_connector_width/2),-(femur_connector_length/2 - bracket_narrow_thickness/2),0])
            Fillet(bracket_fillet_radius,+1,+1);
            translate([+(femur_connector_width/2),-(femur_connector_length/2 - bracket_narrow_thickness/2),0])
            Fillet(bracket_fillet_radius,-1,+1);

            translate([-(femur_connector_width/2),+(femur_connector_length/2),0])
            Fillet(bracket_fillet_radius,+1,+1);
            translate([+(femur_connector_width/2),+(femur_connector_length/2),0])
            Fillet(bracket_fillet_radius,-1,+1);
            translate([-(femur_connector_width/2),+(femur_connector_length/2 - bracket_narrow_thickness/2),0])
            Fillet(bracket_fillet_radius,+1,-1);
            translate([+(femur_connector_width/2),+(femur_connector_length/2 - bracket_narrow_thickness/2),0])
            Fillet(bracket_fillet_radius,-1,-1);
        };
    }
}
// print femur
module femur() {
    union() {
        translate([-femur_connector_width/2,0,bracket_height])
        rotate([0,180,0])
        bracket(femur_long_length,femur_bracket_width,hasSHold=true);
        femur_connector();
        translate([femur_connector_width/2,0,0])
        bracket(femur_short_length,femur_bracket_width,hasSHold=true);
    }
};

//////////////////////////////////
// tibia
//////////////////////////////////

// tibia dimensions
tibia_servo_length = 23.5;
tibia_servo_width = 13.0;
tibia_servo_outer_fillet_radius = 3.21;
tibia_servo_screw_center_length_distance = 2.24;

// cap
tibia_cap_length = 8; // just for separator
tibia_cap_non_surround_delta_y = 1.7;
tibia_cap_thick = 2.5;

tibia_cap_A_radius = 9.44;
tibia_cap_A_center = [15.498,-4.771];
tibia_cap_A_angle_1 = 33.103;
tibia_cap_A_angle_2 = 80.348;

tibia_cap_B_radius = 11.19;
tibia_cap_B_center = [28.504 , -9.029];
tibia_cap_B_angle_1 = 105.6;
tibia_cap_B_angle_2 = 169.553;

// base
tibia_tip_radius = 2.5;
tibia_tip_distance = (tibia_length - (servo_length__/2 - servo_rotor_distance__)) - tibia_tip_radius;
tibia_tip_point = [-tibia_tip_distance,0];

tibia_base_thick = 4.0;
tibia_base_A_point = [-(servo_holder_length/2+servo_holder_side_length),(servo_holder_width/2 + tibia_base_thick)];

tibia_base_A_radius = 3.241 * tibia_length;
tibia_base_A_center = center(tibia_base_A_point[0], tibia_base_A_point[1], tibia_tip_point[0], tibia_tip_point[1] + tibia_tip_radius, tibia_base_A_radius, +1);
tibia_base_A_angle_1 = atan2(tibia_base_A_point[1]-tibia_base_A_center[1],tibia_base_A_point[0]-tibia_base_A_center[0]);
tibia_base_A_angle_2 = atan2(tibia_tip_point[1]-tibia_base_A_center[1],tibia_tip_point[0]-tibia_base_A_center[0]);

tibia_base_B_radius = 4.517 * tibia_length;
tibia_base_B_point = [-(servo_holder_length+servo_holder_side_length)/2,-(servo_holder_width/2)];
tibia_base_B_center = center(tibia_base_B_point[0], tibia_base_B_point[1], tibia_tip_point[0], tibia_tip_point[1] - tibia_tip_radius / 4, tibia_base_B_radius, +1);
tibia_base_B_angle_1 = atan2(tibia_base_B_point[1]-tibia_base_B_center[1],tibia_base_B_point[0]-tibia_base_B_center[0]);
tibia_base_B_angle_2 = atan2(tibia_tip_point[1]-tibia_base_B_center[1],tibia_tip_point[0]-tibia_base_B_center[0]);

tibia_stump_height = servo_under_height__ + servo_clearance - servo_holder_thickness;
tibia_separator_length = PARTS_SEPARATOR + servo_holder_length/2 + servo_holder_side_length + tibia_cap_length;
tibia_separator_width = PARTS_SEPARATOR + servo_holder_width/2 + ((servo_surround == 1 || part == "leg_1") ? tibia_base_thick : 0);

// https://stackoverflow.com/questions/36211171/finding-arc-circle-center-given-2-points-and-radius
// get center of circle given radius and two points on circumference
function center(x1, y1, x2, y2, radius, sign_) =
    let (
        radsq = radius * radius,
        q = sqrt(((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1))),
        x3 = (x1 + x2) / 2,
        xcenter = x3 + sign_ * sqrt(radsq - ((q / 2) * (q / 2))) * ((y1 - y2) / q),
        y3 = (y1 + y2) / 2,
        ycenter = y3 + sign_ * sqrt(radsq - ((q / 2) * (q / 2))) * ((x2 - x1) / q)
    )
    [xcenter,ycenter]
;

// compute one arc for tibia
module arc(radius, thick, angle1, angle2) {
    outer_radius = radius+thick;
    p0 = [0,0];
    p1 = [2 * outer_radius * cos(angle1), 2 * outer_radius * sin(angle1)];
    p2 = [2 * outer_radius * cos(angle2), 2 * outer_radius * sin(angle2)];
    intersection(){
        difference(){
            circle(outer_radius,center=true,$fn = 360);
            circle(radius,center=true,$fn = 360);
        };
        polygon(points = [ p0, p1, p2 ], paths = [ [0, 1, 2]], convexity = 10);
    }
}
// compute two arcs for tibia
module arc2(A_center,A_radius,A_thick,A_angle_1,A_angle_2,B_center,B_radius,B_thick,B_angle_1,B_angle_2) {
    difference() {
        intersection() {
            union() {
                translate(A_center)
                arc(A_radius, A_thick, A_angle_1, A_angle_2);
                translate(B_center)
                arc(B_radius, B_thick, B_angle_1, B_angle_2);
            };
            translate(A_center)
            circle(A_radius + A_thick,center=true,$fn = 360);
        };
        translate(B_center)
        circle(B_radius,center=true,$fn = 360);
    }
}
// print tibia cap - small part on top of servo holder
module tibia_cap() {
    arc2(tibia_cap_A_center,tibia_cap_A_radius,tibia_cap_thick,tibia_cap_A_angle_1,tibia_cap_A_angle_2,tibia_cap_B_center,tibia_cap_B_radius,tibia_cap_thick,tibia_cap_B_angle_1,tibia_cap_B_angle_2);
}
// print tibia base - main part of tibia below servo holder
module tibia_base() {
    union() {
        arc2(tibia_base_A_center,tibia_base_A_radius-tibia_base_thick,tibia_base_thick,tibia_base_A_angle_1,tibia_base_A_angle_2,tibia_base_B_center,tibia_base_B_radius,tibia_base_thick,tibia_base_B_angle_1,tibia_base_B_angle_2);
        // tip
        translate([-tibia_tip_distance,0])
        circle(tibia_tip_radius,center=true,$fn = 90);
    }
}
// print tibia
module tibia(orientation) {
    mirror([0,orientation,0])
    union() {
        linear_extrude(height = servo_holder_thickness, center = false, convexity = 10, twist = 0)
        union() {
            translate([0,(1-servo_surround)*1.7])
            tibia_cap();
            tibia_base();
        }
        difference() {
            ServoHolder(tibia_base_thick,isFillet=false);
            translate([servo_holder_outer_length/2,(servo_holder_width/2+tibia_base_thick),servo_holder_thickness/2])
            linear_extrude(height = servo_holder_thickness+INSIGNIFICANT_DISTANCE, center = true, convexity = 10, twist = 0)
            Fillet(servo_holder_fillet_radius,-1,-1);
        }
        translate([(servo_holder_length/2-stump_length/2)-stump_length_distance,servo_holder_width/2 +tibia_base_thick - stump_width/2,servo_holder_thickness+tibia_stump_height/2])
        rotate([0,0,90])
        stump(tibia_stump_height);
    }
}

//////////////////////////////////
// coxa
//////////////////////////////////

// coxa dimensions
coxa_connector_length = 16.0;
coxa_connector_width = 6.0;
coxa_connector_distance = 6.75;
coxa_long_length = 29;
coxa_bracket_length = coxa_length - (servo_holder_width/2 + stump_width - bracket_narrow_thickness);
coxa_stump_height = servo_under_height__ + servo_clearance;
coxa_separator_length = PARTS_SEPARATOR + servo_holder_width;
coxa_separator_width = PARTS_SEPARATOR + servo_holder_outer_length/2;

// print coxa
module coxa(orientation) {
    mirror([0,orientation,0])
    union() {
        translate([0,0,bracket_height])
        rotate([180,0,0])
        bracket(coxa_bracket_length,coxa_bracket_width,hasSHold=false);

        translate([bracket_narrow_thickness -servo_holder_width/2 - stump_width,0])
        rotate([0,0,-90])
        ServoHolder(stump_width,isFillet=false);

        translate([bracket_narrow_thickness - stump_width/2,servo_holder_length/2 - (stump_length/2 + stump_length_distance),coxa_stump_height/2])
        stump(coxa_stump_height);
    }
};

//////////////////////////////////
// main leg
//////////////////////////////////

// print leg - left or right
module leg(orientation) {
    union() {
        translate([coxa_separator_length,-coxa_separator_width,0])
        coxa(orientation);

        translate([femur_separator_length,femur_separator_width,0])
        femur();

        translate([-s_hold_separator_length,s_hold_separator_width,0])
        s_hold();

        translate([-s_hold_separator_length_2,s_hold_separator_width,0])
        s_hold();

        translate([-tibia_separator_length,-tibia_separator_width,0])
        tibia(orientation);
    };
}

//***********************************************
//***********************************************
//                   MAIN                      //
//***********************************************
//***********************************************

print_part();

// print one section of Spider Robot
module print_part() {
    if (part == "body") {
        body();
    } else if (part == "leg_1") {
        leg(0);
    } else if (part == "leg_2") {
        leg(1);
    }
}
