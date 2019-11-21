// Matthew Sparks
// 2016-02-05
//
// units in 1mm
// Punch set case for the following size punches:
//  1/16
//  3/32
//  1/8
//  5/32
//  3/16
//  7/32
//  1/4
//  5/16

// Tool length
toolLength = 102.5;
// Determines thickness of outer walls
outsideThickness = 3;
// Determines divider thickness
divider = 2;
// Determines additional depth
depth = 1;
// Determine thickness of bottom
bottomThickness = 3;
// Determines vertical room
verticalMargin = 5.5;
// Determines horizontal margin
horizontalMargin = 1;
// whether to include labels
includeText = true;

label1 = "1/16";
label2 = "3/32";
label3 = "1/8";
label4 = "5/32";
label5 = "3/16";
label6 = "7/32";
label7 = "1/4";
label8 = "5/16";

font = "Arial";


union(){
// define extra piece for text labels
if (includeText) {
    difference(){
        // add section for labels
        translate([-20,0,0]){
            cube([(20),(7*divider + 2*outsideThickness + 8*horizontalMargin + 68),(depth+bottomThickness+12)],false);
        }
        // engrave 1/16 label
        translate([-17,outsideThickness+1,bottomThickness+12]){
            linear_extrude(height=1){ text(label1,font,size=6); }
        }
        // engrave 3/32 label
        translate([-17,outsideThickness+1+1*divider+1*horizontalMargin+7,bottomThickness+12]){
            linear_extrude(height=1){ text(label2,font,size=6); }
        }
        // engrave 1/8 label
        translate([-17,outsideThickness+2+2*divider+2*horizontalMargin+7+7,bottomThickness+12]){
            linear_extrude(height=1){ text(label3,font,size=6); }
        }
        // engrave 5/32 label
        translate([-17,outsideThickness+2+3*divider+3*horizontalMargin+7+7+8,bottomThickness+12]){
            linear_extrude(height=1){ text(label4,font,size=6); }
        }
        // engrave 3/16 label
        translate([-17,outsideThickness+2+4*divider+4*horizontalMargin+7+7+8+8,bottomThickness+12]){
            linear_extrude(height=1){ text(label5,font,size=6); }
        }
        // engrave 7/32 label
        translate([-17,outsideThickness+2+5*divider+5*horizontalMargin+7+7+8+8+8,bottomThickness+12]){
            linear_extrude(height=1){ text(label6,font,size=6); }
        }
        // engrave 1/4 label
        translate([-17,outsideThickness+3+6*divider+6*horizontalMargin+7+7+8+8+8+8,bottomThickness+12]){
            linear_extrude(height=1){ text(label7,font,size=6); }
        }
        // engrave 5/16 label
        translate([-17,outsideThickness+3+7*divider+7*horizontalMargin+7+7+8+8+8+8+10,bottomThickness+12]){
            linear_extrude(height=1){ text(label8,font,size=6); }
        }
    }
}
// define tray
difference(){
    // General shape
    cube([(2*outsideThickness + verticalMargin + toolLength),(7*divider + 2*outsideThickness + 8*horizontalMargin + 68),(depth+bottomThickness+12)],false);
    // Remove slots
    // Slot 1
    translate([outsideThickness,outsideThickness,bottomThickness+(12-(7))]) {
        cube([verticalMargin + toolLength,7+horizontalMargin,7+depth],false);
    }
    // Slot 2
    translate([outsideThickness,outsideThickness+1*divider+1*horizontalMargin+7,bottomThickness+(12-(7))]) {
        cube([verticalMargin + toolLength,7+horizontalMargin,7+depth],false);
    }
    // Slot 3
    translate([outsideThickness,outsideThickness+2*divider+2*horizontalMargin+7+7,bottomThickness+(12-(8))]) {
        cube([verticalMargin + toolLength,8+horizontalMargin,8+depth],false);
    }
    // Slot 4
    translate([outsideThickness,outsideThickness+3*divider+3*horizontalMargin+7+7+8,bottomThickness+(12-(8))]) {
        cube([verticalMargin + toolLength,8+horizontalMargin,8+depth],false);
    }
    // Slot 5
    translate([outsideThickness,outsideThickness+4*divider+4*horizontalMargin+7+7+8+8,bottomThickness+(12-(8))]) {
        cube([verticalMargin + toolLength,8+horizontalMargin,8+depth],false);
    }
    // Slot 6
    translate([outsideThickness,outsideThickness+5*divider+5*horizontalMargin+7+7+8+8+8,bottomThickness+(12-(8))]) {
        cube([verticalMargin + toolLength,8+horizontalMargin,8+depth],false);
    }
    // Slot 7
    translate([outsideThickness,outsideThickness+6*divider+6*horizontalMargin+7+7+8+8+8+8,bottomThickness+(12-(10))]) {
        cube([verticalMargin + toolLength,10+horizontalMargin,10+depth],false);
    }
    // Slot 8
    translate([outsideThickness,outsideThickness+7*divider+7*horizontalMargin+7+7+8+8+8+8+10,bottomThickness+(12-(12))]) {
        cube([verticalMargin + toolLength,12+horizontalMargin,12+depth],false);
    }
}
}