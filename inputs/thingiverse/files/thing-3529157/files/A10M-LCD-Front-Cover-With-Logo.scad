//A10M_LCD_Front_Cover_With_Logo.scad by MegaSaturnv 2019-06-04
//Please include A10M_Geetech_Logo.stl in the same folder as this scad file. An stl of the logo by Kanawati can be downloaded from here: https://www.thingiverse.com/thing:3163963

/* [Basic] */
//Width of the cover. X-axis
COVER_WIDTH              = 97;

//Length of the cover. Y-axis
COVER_FRONT_PLATE_LENGTH = 59;

//Thickness of the cover
COVER_THICKNESS          = 2;

//Lenth the back hook entends downwards to hook onto the back of the LCD mounting plate
COVER_BACK_HOOK_LENGTH   = 5;


/* [Advanced] */
//Set to false to disable logo
LOGO_ENABLE            = true; // [true, false]

//66.7mm Measured from A10M_Geetech_Logo.stl file
LOGO_WIDTH             = 66.7;

//50.4mm Measured from A10M_Geetech_Logo.stl file
LOGO_LENGTH            = 50.4;

//The distance from the top of the logo to the angled 'back hook'. Aligns with top of LCD.
LOGO_DISTANCE_FROM_TOP = 25.5;

//The distance (minus the cover thickness) required to lower the imported A10M_Geetech_Logo.stl file so it just touches the bottom of the model. Arbitrary.
LOGO_DROP_TO_SURFACE   = 6.74364424;

//The distance to lower the logo down inside the model
LOGO_DEPTH_IN_MODEL    = 1.75;

//Descrease the size of the logo so it is all illuminated by the LCD. LCD = 26mm high
LOGO_SCALE             = 26 / LOGO_LENGTH;

module frontPlate() {
    cube([COVER_WIDTH, COVER_FRONT_PLATE_LENGTH, COVER_THICKNESS]);
}

module backHook() {
    cube([COVER_WIDTH, COVER_BACK_HOOK_LENGTH + COVER_THICKNESS, COVER_THICKNESS]);
}

difference() {
    union() {
        frontPlate();
        translate([0, COVER_FRONT_PLATE_LENGTH + COVER_THICKNESS, 0]) rotate([90, 0, 0]) backHook();
    }
    
    if (LOGO_ENABLE) {
        translate([
            (COVER_WIDTH + (LOGO_WIDTH * LOGO_SCALE))/2,
            COVER_FRONT_PLATE_LENGTH - (LOGO_LENGTH * LOGO_SCALE) - LOGO_DISTANCE_FROM_TOP,
            LOGO_DROP_TO_SURFACE + COVER_THICKNESS - LOGO_DEPTH_IN_MODEL
        ]) scale([LOGO_SCALE, LOGO_SCALE, 2]) mirror([0, 0, 1]) mirror([1, 0, 0]) import("A10M_Geetech_Logo.stl");
    }
}
