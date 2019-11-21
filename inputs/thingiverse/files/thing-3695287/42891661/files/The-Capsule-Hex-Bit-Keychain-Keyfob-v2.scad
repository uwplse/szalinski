//The_Capsule_Hex_Bit_Keychain_Keyfob_v2.scad by MegaSaturnv
use <ISOThread.scad>
//NOTE: This openSCAD model requires RevK's ISO/UTS thread OpenSCAD library here: https://www.thingiverse.com/thing:2158656

////////////////
// Parameters //
////////////////
/* [Basic] */
//Radius of the capsule
CAPSULE_RADIUS = 17;
//Choose which side of the capsule to render. Values: upper, lower, both
RENDER_SIDE = "both";   // [both: Render both halves, upper: Upper half only, lower: Lower half only]
//Include avatar?
AVATAR = true; // [true, false]
//Might not work in customizer - use OpenSCAD client instead. Strings for each row of pixels in the avatar / custom image. Can be any resolution. Adjust AVATAR_PIXEL_SIZE and AVATAR_PIXEL_THICKNESS in advanced section if needed.
AVATAR_PIXEL_DATA = [
	" X X ",
	"XX XX",
	" XXX ",
	"  X  ",
	"X X X"];

//Diameter of the key ring used. Measured value.
KEY_RING_DIAMETER = 22.5;
//Extra space given to the key ring. I.e. Key ring hole thickness.
KEY_RING_GAP = 2.5;

//The amount of hex bits in storage
HEX_STORAGE_QUANTITY = 9;
//Layers of hex storage
HEX_STORAGE_LAYERS = 1;

/* [Advanced] */
//Enable or disable the access hole at the bottom of each stoarage slot. Enabling this may only enlarge the hole.
HEX_STORAGE_ACCESS_HOLE = true; // [true, false]
//Rotate the location of the hex bits around the centre
HEX_STORAGE_ANGLE_ROTATE_OFFSET = 360 / 12;
//Rotate the hex bits around the hex bit's centre
HEX_STORAGE_ANGLE_FINAL_OFFSET = 360 / 12;

//Diameter of the hex bits. From tip to tip. Not flat edge to flat edge.
HEX_DIAMETER = 7.9;
//Height of the hex bits
HEX_HEIGHT = 25;

//The height of the threads in the centre
HEX_CENTRE_PROTRUSION = 6;
//The depth of the centre hex bit
HEX_CENTRE_HEIGHT = 12;
//The centre hex bit hole is thinner towards the bottom, to grip the bit. Default 0.95 = 95% smaller at the bottom
HEX_CENTRE_TAPERING = 0.93;
//Additional size tolerance added to threads (socket only) when printing
HEX_CENTRE_THREAD_TOLERANCE = 0.3;

//Width and Height (X and Y) of a pixel in mm
AVATAR_PIXEL_SIZE = 1;
//Thickness (Z) of a pixel in mm
AVATAR_PIXEL_THICKNESS = 1;

//Use $fn = 24 if it's a preview. $fn = 96 for the render. Increase 96 to produce a smoother curve
$fn = $preview ? 24 : 96;

/* [Calculated values] */
//Hex height times the storage layers for the bottom half, minus half a hex height. The rest is extra height taken off which is saved in the curved area
//Minus CAPSULE_RADIUS/4, because hex storage is lowered by CAPSULE_RADIUS/2. See "//Hex Bit Storage Holes"
//Minus a CAPSULE_RADIUS/12, because hollow 'ring' in top half is lowered by CAPSULE_RADIUS/6. See "//Hollow ring for storage bits"
bodyCylinderHeight = HEX_HEIGHT * HEX_STORAGE_LAYERS - HEX_HEIGHT/2 - CAPSULE_RADIUS/4 - CAPSULE_RADIUS/12;
headCylinderHeight = HEX_HEIGHT/2 - CAPSULE_RADIUS/4 - CAPSULE_RADIUS/12; 
//Thread size is calulated from previous parameters
ISOThreadM = (CAPSULE_RADIUS - HEX_DIAMETER)*2 - 3.2;
//Size of avatar's pixel width (not the size of each pixel) are calculated from the avatar data. The calculated resolution of the avatar is used to centre the image.
avatarWidthInPixels = len(AVATAR_PIXEL_DATA[0]);
avatarHeightInPixels = len(AVATAR_PIXEL_DATA);

/////////////
// Modules //
/////////////
module hemisphere(radius) {
	difference() {
		sphere(r=radius);
		translate([0, 0, -radius]) cylinder(r=radius, h=radius);
	}
}

module ring(innerRadius, outerRadius, heightZ, centerArg=false) {
	difference() {
		cylinder(r=outerRadius, h=heightZ, center=centerArg); //Outer cylinder
		cylinder(r=innerRadius, h=heightZ, center=centerArg); //Inner cylinder
	}
}

module drawAvatar(pxSize=1, thickness=1) {
	for (i = [0 : len(AVATAR_PIXEL_DATA)-1], j = [0 : len(AVATAR_PIXEL_DATA[i])-1]) {
		if (AVATAR_PIXEL_DATA[i][j] == "X") {
			translate([i*pxSize, j*pxSize, 0])
			cube([pxSize, pxSize, thickness]);
		}
	}
}


////////////////
// Main Model //
////////////////
//Head - upper half
if (RENDER_SIDE == "upper" || RENDER_SIDE == "both") {
	translate([CAPSULE_RADIUS + 5, 0, headCylinderHeight + 0.85 * CAPSULE_RADIUS])
	rotate([180, 0, 0])
	difference() {
		union() {
			translate([0, 0, headCylinderHeight])
			hemisphere(CAPSULE_RADIUS);

			cylinder(r=CAPSULE_RADIUS, h=headCylinderHeight);
		}
		union() {
			//Flat top
			translate([0, 0, headCylinderHeight + 0.85 * CAPSULE_RADIUS])
			cylinder(r=CAPSULE_RADIUS, h=headCylinderHeight);

			//Key ring Loop
			translate([0, 0, headCylinderHeight + 0.85 * CAPSULE_RADIUS + 8])
			rotate([90, 0, 0])
			ring(KEY_RING_DIAMETER/2 - KEY_RING_GAP/2, KEY_RING_DIAMETER/2 + KEY_RING_GAP/2, KEY_RING_GAP, true);

			//Hole and cone for centre bit during storage
			translate([0, 0, HEX_CENTRE_PROTRUSION])
			cylinder(r=HEX_DIAMETER/2, h=HEX_HEIGHT-HEX_CENTRE_HEIGHT);
			translate([0, 0, (HEX_HEIGHT-HEX_CENTRE_HEIGHT) + HEX_CENTRE_PROTRUSION])
			cylinder(r1=HEX_DIAMETER/2, r2=HEX_DIAMETER/4, h=HEX_DIAMETER/8);

			//Hollow ring for storage bits
			translate([0, 0, 0])
			ring(CAPSULE_RADIUS - HEX_DIAMETER - 0.4, CAPSULE_RADIUS - 1.2, headCylinderHeight + CAPSULE_RADIUS/6);

			//Centre hex bit holder protrusion Hole
			//Larger at both ends by 1mm. 1mm below to ensure lid can screw all the way down. 1mm above to create a clean cut of the threads into the top of the solid cylinder.
			translate([0, 0, -1])
			iso_thread(m=ISOThreadM, l=HEX_CENTRE_PROTRUSION+2, t=HEX_CENTRE_THREAD_TOLERANCE);
		}
	}
}


//Body - lower half
if (RENDER_SIDE == "lower" || RENDER_SIDE == "both") {
	translate([-CAPSULE_RADIUS - 5, 0, bodyCylinderHeight+0.85 * CAPSULE_RADIUS])
	rotate([180, 0, 0])
	difference() {
		union()  {
			//Body core
			translate([0, 0, bodyCylinderHeight])
			hemisphere(CAPSULE_RADIUS);

			cylinder(r=CAPSULE_RADIUS, h=bodyCylinderHeight);

			//Centre hex bit holder protrusion
			translate([0, 0, -HEX_CENTRE_PROTRUSION])
			rotate([0, 0, -45]) //Rotate the screw so it aligns with the top half. Not essential.
			iso_thread(m=ISOThreadM, l=HEX_CENTRE_PROTRUSION);
		}
		union() {
			//Flat top
			translate([0, 0, bodyCylinderHeight + 0.85 * CAPSULE_RADIUS])
			cylinder(r=CAPSULE_RADIUS, h=bodyCylinderHeight);

			//Key ring loop
			translate([0, 0, bodyCylinderHeight + 0.85 * CAPSULE_RADIUS + 8])
			rotate([90, 0, 0])
			ring(KEY_RING_DIAMETER/2 - KEY_RING_GAP/2, KEY_RING_DIAMETER/2 + KEY_RING_GAP/2, KEY_RING_GAP, true);

			//Centre hex bit holder hole
			translate([0, 0, -HEX_CENTRE_PROTRUSION])
			cylinder($fn=6, r1=HEX_DIAMETER/2, r2=HEX_DIAMETER/2 * HEX_CENTRE_TAPERING, h=HEX_CENTRE_HEIGHT + 2); //+2 for a little extra room

			//Avatar at the bottom of the centre hex bit holder hole
			if(AVATAR) translate([-avatarHeightInPixels/2, avatarWidthInPixels/2, HEX_CENTRE_HEIGHT-HEX_CENTRE_PROTRUSION+2.99]) rotate([180, 0, 0]) drawAvatar(AVATAR_PIXEL_SIZE, AVATAR_PIXEL_THICKNESS);

			//Hex bit storage holes
			for( i = [0 : HEX_STORAGE_QUANTITY] ) {
				rotate([0, 0, i * 360/HEX_STORAGE_QUANTITY + HEX_STORAGE_ANGLE_ROTATE_OFFSET])
				translate([CAPSULE_RADIUS - (HEX_DIAMETER/2) - 1.2, 0, 0])
				rotate([0, 0, HEX_STORAGE_ANGLE_FINAL_OFFSET])
				cylinder($fn=6, r=HEX_DIAMETER/2, h=bodyCylinderHeight + CAPSULE_RADIUS/2);
			}

			//Hex bit storage holes access hole
			if (HEX_STORAGE_ACCESS_HOLE) {
				for( i = [0 : HEX_STORAGE_QUANTITY] ) {
					rotate([0, 0, i * 360/HEX_STORAGE_QUANTITY + HEX_STORAGE_ANGLE_ROTATE_OFFSET])
					translate([CAPSULE_RADIUS - (HEX_DIAMETER/2) - 1.2 +(HEX_DIAMETER/2)*sqrt(3), 0, bodyCylinderHeight + CAPSULE_RADIUS/2 - 3])
					rotate([0, 0, HEX_STORAGE_ANGLE_FINAL_OFFSET])
					cylinder($fn=6, r=HEX_DIAMETER/2, h=bodyCylinderHeight + CAPSULE_RADIUS/2);
				}
			}
		}
	}
}
