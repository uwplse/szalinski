//Pokewalker_Case.scad by MegaSaturnv

/////////////////////////////
// Customizable Parameters //
/////////////////////////////
/* [Basic] */
//Choose which side to render. Values: upper, lower, both
RENDER_SIDE              = "both";   // [both: Render both halves, upper: Upper half only, lower: Lower half only]
//Choose weather to include a hole for IR communication
IR_PORT                  = true;     // Choose weather to include a port for IR communication
//Choose weather to include a hoel to view the screen
SCREEN                   = true;     // Choose to cut away a rectangle for viewing the screen

//Choose to cover the buttons and how. Values: none, caps, base
//"none" = Buttons are exposed and can be pressed
//"caps" = Choose to include individual caps over the buttons for protection. You won't be able to press the buttons. Will be harder to print.
//"base" = Create a flat base for the upper half that covers the buttons and is easier to print. Screen is still visible unless SCREEN = false
BUTTON_COVER             = "none"; // [none, caps, base]

//Custom modification to be added to the back of the Pokewalker case. Type selection. Options = "none", "avatar", "text"
CUSTOM_MODIFICATION      = "avatar"; // [none, avatar, text]

// Scale the size of the custom modification
CUSTOM_MODIFICATION_SIZE = 1.25;     

// If text is the modification, specify the text here
CUSTOM_TEXT              = "3D";    


///////////////////////////////
// Pokewaler Size Parameters //
///////////////////////////////
/* [Advanced] */
//Radius of the Pokewalker
POKEWALKER_RADIUS = 24.5;
//Height of the Pokewalker
POKEWALKER_HEIGHT = 14.0;

//Amount of clip segments per side
POKEWALKER_CLIP_SEGMENTS           = 6;
//Reduce clip width by this angle in degrees (of the full circle) to account for tolerances in the printer
POKEWALKER_CLIP_SEGMENTS_TOLERANCE = 1;

//Radius of the circle used to cut out the IR port
POKEWALKER_IR_PORT_RADIUS = 10;
//IR port Z position
POKEWALKER_IR_PORT_Z      = POKEWALKER_IR_PORT_RADIUS/2;
//IR port Y position
POKEWALKER_IR_PORT_Y      = POKEWALKER_RADIUS + 5;

//Screen Height
POKEWALKER_SCREEN_HEIGHT     = 18;
//Screen Width
POKEWALKER_SCREEN_WIDTH      = 26;
//Screen vertical position from the centre
POKEWALKER_SCREEN_POSITION_Y = 2;

//Radius of the small buttons
POKEWALKER_BUTTON_SMALL_RADIUS = 2.8;
//Height of the small buttons
POKEWALKER_BUTTON_SMALL_HEIGHT = 1.7;
//Radius of the large button
POKEWALKER_BUTTON_LARGE_RADIUS = 3.5;
//Height of the large button
POKEWALKER_BUTTON_LARGE_HEIGHT = 1.7;

//Left-Right X-position of the small buttons from the centre Y-axis line
POKEWALKER_BUTTON_SMALL_POSITION_X = 10.5;
//Up-Down Y-position of the small buttons from the centre X-axis line
POKEWALKER_BUTTON_SMALL_POSITION_Y = 13;
//Up-Down Y-position of the large button from the centre X-axis line
POKEWALKER_BUTTON_LARGE_POSITION_Y = 15;

//Increase this number to produce a smoother curve
$fn = 96;


/////////////
// Modules //
/////////////
module drawAvatar(pxSize=1, thickness=1) {
    avatar = [
    " X X ",
    "XX XX",
    " XXX ",
    "  X  ",
    "X X X"];
    for (i = [0 : len(avatar)-1], j = [0 : len(avatar[i])-1]) {
        if (avatar[i][j] == "X") {
            translate([i*pxSize, j*pxSize, 0])
            cube([pxSize, pxSize, thickness]);
        }
    }
}

module drawAvatarCentered(pxSize=1, thickness=1, imageX=5, imageY=5) {
	translate([-(imageX*pxSize)/2, -(imageY*pxSize)/2, 0]) drawAvatar(pxSize, thickness);
}

module pokewalkerHalf(height, radius) {
	union () {
		rotate_extrude() translate([radius - height/2, 0, 0])
		intersection() {
			circle(r=height/2);
			square([height/2, height/2]);
		}

		cylinder(r=radius - height/2 + 0.1, h=height/2);
	}
}

module pokewalkerClips(curveHeight, curveRadius, ClipSegmentTolerance=1, clipHeightDivisor=6, extraInnerWidth=0) {
	union () {
		for ( i = [1 : POKEWALKER_CLIP_SEGMENTS] ){
				rotate([0, 0, i * (360 / POKEWALKER_CLIP_SEGMENTS)]) rotate_extrude(angle=(180 / POKEWALKER_CLIP_SEGMENTS) + ClipSegmentTolerance)

			translate([curveRadius - curveHeight/2, 0, 0])
			difference() {
				scale(1.4) intersection() {
					circle(r=curveHeight/2);
					square([curveHeight/2, curveHeight/clipHeightDivisor]);
				}
				intersection() {
					circle(r=curveHeight/2 - extraInnerWidth);
					square([curveHeight/2, curveHeight/2]);
				}
			}
		}
	}
}


////////////////
// Main Model //
////////////////
//Pokewalker lower half
if (RENDER_SIDE == "lower" || RENDER_SIDE == "both") {
	rotate([180, 0, 0])  translate([-POKEWALKER_RADIUS * 1.5, 0, 0])
	difference() {
		union() {
			//Create outer shell
			scale(1.2) pokewalkerHalf(POKEWALKER_HEIGHT, POKEWALKER_RADIUS);

			//Solid Clips
			rotate([180, 0, 0]) pokewalkerClips(POKEWALKER_HEIGHT, POKEWALKER_RADIUS, -POKEWALKER_CLIP_SEGMENTS_TOLERANCE, 7);
		}
		//Remove inner Shell
		pokewalkerHalf(POKEWALKER_HEIGHT, POKEWALKER_RADIUS);

		//Clips socket
		pokewalkerClips(POKEWALKER_HEIGHT, POKEWALKER_RADIUS, POKEWALKER_CLIP_SEGMENTS_TOLERANCE, 5, 0.5);

		//IR port
		if (IR_PORT) {
			translate([0, POKEWALKER_IR_PORT_Y, -POKEWALKER_IR_PORT_Z]) rotate([90, 0, 0]) cylinder(h=10, r=POKEWALKER_IR_PORT_RADIUS);
		}

		//Custom modification
		if (CUSTOM_MODIFICATION == "avatar") {
			translate([0, 0, ((POKEWALKER_HEIGHT/2)*1.2) - 0.7]) rotate([0, 0, 270]) scale(CUSTOM_MODIFICATION_SIZE) drawAvatarCentered(4, 1);
		} else if (CUSTOM_MODIFICATION == "text") {
			 translate([0, 0, ((POKEWALKER_HEIGHT/2)*1.2) - 0.7]) linear_extrude(1) scale(CUSTOM_MODIFICATION_SIZE) text(CUSTOM_TEXT, halign="center", valign="center");
		}
	}
}

//Pokewalker Upper Half
if (RENDER_SIDE == "upper" || RENDER_SIDE == "both") {
	rotate([180, 0, 0]) translate([POKEWALKER_RADIUS * 1.5, 0, 0])
	difference() {
		union() {
			//Create outer shell
			scale(1.2) pokewalkerHalf(POKEWALKER_HEIGHT, POKEWALKER_RADIUS);

			//Solid clips
			rotate([180, 0, 0]) pokewalkerClips(POKEWALKER_HEIGHT, POKEWALKER_RADIUS, -POKEWALKER_CLIP_SEGMENTS_TOLERANCE);

			//If specified, generate button caps to block all button presses
			if (BUTTON_COVER == "caps") {
				translate([-POKEWALKER_BUTTON_SMALL_POSITION_X, -POKEWALKER_BUTTON_SMALL_POSITION_Y, POKEWALKER_HEIGHT/2 + POKEWALKER_BUTTON_SMALL_HEIGHT/2]) scale(1.4) cylinder(r=POKEWALKER_BUTTON_SMALL_RADIUS,h=POKEWALKER_BUTTON_SMALL_HEIGHT);
				translate([POKEWALKER_BUTTON_SMALL_POSITION_X, -POKEWALKER_BUTTON_SMALL_POSITION_Y, POKEWALKER_HEIGHT/2 + POKEWALKER_BUTTON_SMALL_HEIGHT/2]) scale(1.4) cylinder(r=POKEWALKER_BUTTON_SMALL_RADIUS,h=POKEWALKER_BUTTON_SMALL_HEIGHT);
				translate([0, -POKEWALKER_BUTTON_LARGE_POSITION_Y, POKEWALKER_HEIGHT/2 + POKEWALKER_BUTTON_LARGE_HEIGHT/2]) scale(1.4) cylinder(r=POKEWALKER_BUTTON_LARGE_RADIUS,h=POKEWALKER_BUTTON_LARGE_HEIGHT);
			}

			//If specified, generate a flat base
			if (BUTTON_COVER == "base") {
				translate([0, 0, POKEWALKER_HEIGHT/2 + POKEWALKER_BUTTON_LARGE_HEIGHT/2]) cylinder(r=POKEWALKER_RADIUS*0.9,h=POKEWALKER_BUTTON_LARGE_HEIGHT*1.4);
			}
		}
		//Remove inner shell
		pokewalkerHalf(POKEWALKER_HEIGHT, POKEWALKER_RADIUS);

		//Clips socket
		pokewalkerClips(POKEWALKER_HEIGHT, POKEWALKER_RADIUS, POKEWALKER_CLIP_SEGMENTS_TOLERANCE, 5, 0.5);

		//Screen cutout
		if (SCREEN) {
			translate([0, POKEWALKER_SCREEN_POSITION_Y, POKEWALKER_HEIGHT/2]) cube([POKEWALKER_SCREEN_WIDTH, POKEWALKER_SCREEN_HEIGHT, POKEWALKER_HEIGHT], center=true);
		}

		//IR port
		if (IR_PORT) {
			translate([0, POKEWALKER_IR_PORT_Y, POKEWALKER_IR_PORT_Z]) intersection() {
				rotate([90, 0, 0]) cylinder(h=10, r=POKEWALKER_IR_PORT_RADIUS+0.25);
				translate([-POKEWALKER_IR_PORT_RADIUS, -10, -2*POKEWALKER_IR_PORT_RADIUS - POKEWALKER_IR_PORT_Z]) cube([POKEWALKER_IR_PORT_RADIUS*2, 10, 2*POKEWALKER_IR_PORT_RADIUS]);
			}
		}

		//Button holes. Used for access and to stop pokewalker spinning in case. use BUTTON_COVER to protect them.
		translate([-POKEWALKER_BUTTON_SMALL_POSITION_X, -POKEWALKER_BUTTON_SMALL_POSITION_Y, POKEWALKER_HEIGHT/2 - POKEWALKER_BUTTON_SMALL_HEIGHT]) scale(1.2) cylinder(r=POKEWALKER_BUTTON_SMALL_RADIUS,h=POKEWALKER_BUTTON_SMALL_HEIGHT*2);
		translate([POKEWALKER_BUTTON_SMALL_POSITION_X, -POKEWALKER_BUTTON_SMALL_POSITION_Y, POKEWALKER_HEIGHT/2 - POKEWALKER_BUTTON_SMALL_HEIGHT]) scale(1.2) cylinder(r=POKEWALKER_BUTTON_SMALL_RADIUS,h=POKEWALKER_BUTTON_SMALL_HEIGHT*2);
		translate([0, -POKEWALKER_BUTTON_LARGE_POSITION_Y, POKEWALKER_HEIGHT/2 - POKEWALKER_BUTTON_LARGE_HEIGHT]) scale(1.2) cylinder(r=POKEWALKER_BUTTON_LARGE_RADIUS,h=POKEWALKER_BUTTON_LARGE_HEIGHT*2);

		////If BUTTON_COVER is none, cut away a cone to make button presses easier
		if (BUTTON_COVER == "none") {
			translate([-POKEWALKER_BUTTON_SMALL_POSITION_X, -POKEWALKER_BUTTON_SMALL_POSITION_Y, (POKEWALKER_HEIGHT/2) * 1.2]) rotate([180, 0, 0]) cylinder(h=POKEWALKER_BUTTON_SMALL_HEIGHT*2.5, r1=POKEWALKER_BUTTON_SMALL_RADIUS*1.8, r2=0);
			translate([POKEWALKER_BUTTON_SMALL_POSITION_X, -POKEWALKER_BUTTON_SMALL_POSITION_Y, (POKEWALKER_HEIGHT/2) * 1.2]) rotate([180, 0, 0]) cylinder(h=POKEWALKER_BUTTON_SMALL_HEIGHT*2.5, r1=POKEWALKER_BUTTON_SMALL_RADIUS*1.8, r2=0);
			translate([0, -POKEWALKER_BUTTON_LARGE_POSITION_Y, (POKEWALKER_HEIGHT/2) * 1.2]) rotate([180, 0, 0]) cylinder(h=POKEWALKER_BUTTON_LARGE_HEIGHT*2, r1=POKEWALKER_BUTTON_LARGE_RADIUS*1.8, r2=0);
		}
	}
}
