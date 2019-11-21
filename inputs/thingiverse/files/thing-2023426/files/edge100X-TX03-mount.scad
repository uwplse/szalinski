/* [Camera box] */

// Camera box angle
CAMERABOX_ANGLE = 25;
// Camera box height
CAMERABOX_HEIGHT = 12;
// Camera box wall thickness
CAMERABOX_WALL_THICKNESS = 1.5;
// Extra height at bottom of the box
CAMERABOX_ZOFFSET = 1.25;

/* [Customize camera] */
// Draw camera (debug mode)
CAMERA_DEBUG="false";

// Camera width
CAMERA_WIDTH = 20.25;
// Camera depth
CAMERA_DEPTH = 8.5;
// Camera height
CAMERA_HEIGHT = 14;

// Lens width
CAMERA_LENS_WIDTH = 9;
// Lens height
CAMERA_LENS_HEIGHT = 7;
// Lens depth
CAMERA_LENS_DEPTH = 7;
// Lens cutout offset X from center of camera
CAMERA_LENS_XOFFSET = 0;
// Lens offset Z from center of camera
CAMERA_LENS_ZOFFSET = 0;

// Front capacitor width
CAMERA_CAP_WIDTH=4.5;
// Front capacitor height
CAMERA_CAP_HEIGHT = 2.5;
// Front capacitor depth
CAMERA_CAP_DEPTH = 1.5;
// Front capacitor X offset from center of lens
CAMERA_CAP_XOFFSET = -1.3;
// Front capacitor Y offset from center of the lens
CAMERA_CAP_ZOFFSET = -4.75;

// Rear LCD width
CAMERA_LCD_WIDTH = 7.75;
// Rear LCD height
CAMERA_LCD_HEIGHT = 9;
// Rear LCD depth
CAMERA_LCD_DEPTH = 2;
// Rear LCD X offset
CAMERA_LCD_XOFFSET = -6;
// Rear LCD Z offset
CAMERA_LCD_ZOFFSET = 1.5;

// Power cord's connector width
CAMERA_POWERCORD_WIDTH=3.5;
// Power cord's connector height
CAMERA_POWERCORD_HEIGHT=2;
// Power cord's connector depth
CAMERA_POWERCORD_DEPTH=1.5;
// Power cord's hole X offset
CAMERA_POWERCORD_XOFFSET = -8.25;
// Power cord's hole z offset
CAMERA_POWERCORD_ZOFFSET = -5;

/* [Customize Camera box (advanced)] */
// Custom camera box width (empty is default)
CAMERABOX_WIDTH = CAMERA_WIDTH + CAMERABOX_WALL_THICKNESS;
// Custom camera box depth (empty is default)
CAMERABOX_DEPTH = CAMERA_DEPTH + CAMERABOX_WALL_THICKNESS;;

/* [Customize support plate] */
// Spacing between frame's holes
PLATE_HOLE_SPACING = 47;
// Hole's diameter
PLATE_HOLE_DIAMETER = 3;
// Extra width between frame's holes center and the support plate's outer edge
PLATE_INNER_WIDTH = 2.5;
// height of the plate
PLATE_THICKNESS = 2;
// Yaw offset, use 45 for "X" frame, 0 for "+" frame
PLATE_YAW_OFFSET = 0;
// X offset for the plate
PLATE_XOFFSET = 0;
// y offset for the plate
PLATE_YOFFSET = 0;
// z offset for the plate
PLATE_ZOFFSET = 1;

/* [Customize support plate (advanced)] */
// Radius of the plate
PLATE_RADIUS = (PLATE_HOLE_SPACING + (PLATE_INNER_WIDTH * 2)) / 2.0;

// Outer cut's radius
PLATE_OUTERCUT_RADIUS = 0.7 * PLATE_RADIUS;
// Outer cut's distance from the plate's center
PLATE_OUTERCUT_CENTER_DISTANCE = 0.82 * PLATE_RADIUS;

// Inner radius
PLATE_INNER_RADIUS = (PLATE_HOLE_SPACING - (PLATE_INNER_WIDTH * 2)) / 2.0;
// Inner cut's radius
PLATE_INNERCUT_RADIUS = 0.85 * PLATE_INNER_RADIUS;
// Inner cut's distance from the plate's center
PLATE_INNERCUT_CENTER_DISTANCE = 0.95 * PLATE_INNER_RADIUS;

// Adjustment coefficient for the hole's diameter (makes the hole a bit larger to accomodate higher flow rate)
PLATE_HOLE_DIAMETER_ADJUST = 0.15;

/* RENDER EVERYTHING */
camerabox();
plate();

/* DRAW PLATE */
module plate() {
    translate([PLATE_XOFFSET, PLATE_YOFFSET, PLATE_ZOFFSET])
        rotate([0, 0, PLATE_YAW_OFFSET])
            difference() {
                // Outer
                partialPlate(PLATE_RADIUS, PLATE_THICKNESS, PLATE_OUTERCUT_RADIUS, PLATE_OUTERCUT_CENTER_DISTANCE);
                // Inner
                partialPlate(PLATE_INNER_RADIUS, 1.1 * PLATE_THICKNESS, PLATE_INNERCUT_RADIUS, PLATE_INNERCUT_CENTER_DISTANCE);
                // Holes
                PLATE_HOLE_RADIUS = ((PLATE_HOLE_DIAMETER * PLATE_HOLE_DIAMETER_ADJUST) + PLATE_HOLE_DIAMETER) / 2;
                translate([-PLATE_HOLE_SPACING / 2.0, 0, 0])        
                    cylinder(r=PLATE_HOLE_RADIUS, h=1.1*PLATE_THICKNESS, center=true, $fn=16);
                translate([PLATE_HOLE_SPACING / 2.0, 0, 0])
                    cylinder(r=PLATE_HOLE_RADIUS, h=1.1*PLATE_THICKNESS, center=true, $fn=16);
                translate([0, -PLATE_HOLE_SPACING / 2.0, 0])
                    cylinder(r=PLATE_HOLE_RADIUS, h=1.1*PLATE_THICKNESS, center=true, $fn=16);
                translate([0, PLATE_HOLE_SPACING / 2.0, 0])
                    cylinder(r=PLATE_HOLE_RADIUS, h=1.1*PLATE_THICKNESS, center=true, $fn=16);
            }
}
        
module partialPlate(RADIUS, THICKNESS, CUT_RADIUS, CUT_DISTANCE) {
    difference() {
		cylinder(r=RADIUS, h=THICKNESS, center=true, $fn=16);        
		translate([CUT_DISTANCE, CUT_DISTANCE, 0])
			cylinder(r=CUT_RADIUS, h=THICKNESS + 1, center=true);
		translate([CUT_DISTANCE, -CUT_DISTANCE, 0])
			cylinder(r=CUT_RADIUS, h=THICKNESS + 1, center=true);
		translate([-CUT_DISTANCE, -CUT_DISTANCE, 0])
			cylinder(r=CUT_RADIUS, h=THICKNESS + 1, center=true);        
		translate([-CUT_DISTANCE, CUT_DISTANCE, 0])
			cylinder(r=CUT_RADIUS, h=THICKNESS + 1, center=true);
	}
}

/* DRAW CAMERA BOX */
module camerabox() {
    translate([-CAMERABOX_WIDTH/2, -CAMERABOX_DEPTH/2, 0]) { // Center model
        /* Draw camera box */
        difference() {
            rotate ([CAMERABOX_ANGLE, 0, 0]) {
                difference() {
                    undersideExtraHeight = (CAMERABOX_ANGLE + 1) / 3;
                    translate([0, 0, -undersideExtraHeight])
                    cube([CAMERABOX_WIDTH, CAMERABOX_DEPTH, CAMERABOX_HEIGHT + CAMERABOX_ZOFFSET + undersideExtraHeight]);
                    translate([CAMERABOX_WIDTH / 2 - CAMERA_WIDTH / 2, CAMERABOX_DEPTH / 2 - CAMERA_DEPTH / 2, CAMERABOX_ZOFFSET])
                        for(z = [CAMERABOX_HEIGHT : 0]) translate([0,0,z]) camera();
                }
                
            }
            /* Cut bottom flat */
            translate ([-1, -CAMERABOX_HEIGHT, -CAMERABOX_HEIGHT*2])
                cube([ CAMERABOX_WIDTH + 2, CAMERABOX_DEPTH*3, CAMERABOX_HEIGHT*2]);
        }

        /* Draw camera (debug) */
        if (CAMERA_DEBUG == "true") {
            rotate ([CAMERABOX_ANGLE, 0, 0]) 
                translate([CAMERABOX_WIDTH / 2 - CAMERA_WIDTH / 2, CAMERABOX_DEPTH / 2 - CAMERA_DEPTH / 2, CAMERABOX_ZOFFSET])
                    camera();
        }
    }
}

/* DRAW CAMERA */
module camera() {
    translate([CAMERA_WIDTH / 2, CAMERA_DEPTH / 2, CAMERA_HEIGHT / 2]) {
        /* Body */
        color("darkgreen") cube([CAMERA_WIDTH, CAMERA_DEPTH, CAMERA_HEIGHT], center = true);
        /* Lens */
        translate([CAMERA_LENS_XOFFSET, 0, CAMERA_LENS_ZOFFSET])
            translate([0, CAMERA_DEPTH / 2 + CAMERA_LENS_DEPTH / 2, 0])
                color("darkgrey") cube([CAMERA_LENS_WIDTH, CAMERA_LENS_DEPTH, CAMERA_LENS_HEIGHT], center = true);
        /* Capacitor */
        translate([CAMERA_CAP_XOFFSET, 0, CAMERA_CAP_ZOFFSET])
            translate([0, CAMERA_DEPTH / 2 + CAMERA_CAP_DEPTH / 2, 0])
                color("yellow") cube([CAMERA_CAP_WIDTH, CAMERA_CAP_DEPTH, CAMERA_CAP_HEIGHT], center = true);
        /* Rear LCD */
        translate([CAMERA_LCD_XOFFSET, 0, CAMERA_LCD_ZOFFSET])
            translate([0, -  (CAMERA_DEPTH / 2 + CAMERA_LCD_DEPTH / 2), 0])
                color("grey") cube([CAMERA_LCD_WIDTH, CAMERA_LCD_DEPTH, CAMERA_LCD_HEIGHT], center = true);
        /* Power cord */
        translate([CAMERA_POWERCORD_XOFFSET, 0, CAMERA_POWERCORD_ZOFFSET])
            translate([0, -  (CAMERA_DEPTH / 2 + CAMERA_POWERCORD_DEPTH / 2), 0])
                color("black") cube([CAMERA_POWERCORD_WIDTH, CAMERA_POWERCORD_DEPTH, CAMERA_POWERCORD_HEIGHT], center = true);
    }
}
