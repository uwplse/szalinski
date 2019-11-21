// Customizable components drawer
// V1.0 - 2017/03/30
//
// timfou - Mitch Fournier

/* [BOX SPECS] */
// ---------------------
// Box exterior width (mm) DEFAULT:54.4
box_width = 54.4;
// Box exterior length (mm, without handle) DEFAULT:122.4
box_length = 122.4;
// Box exterior height (mm) DEFAULT:36.8
box_height = 36.8;
// Box exterior corner radius (mm) DEFAULT:5
box_corner_radius = 5; // [0.5:0.5:10]
// Box wall width (mm) DEFAULT:1.5
box_wall_width = 1.5;

/* [DIVIDER SPECS] */
// ---------------------
// Divider wall width (mm) DEFAULT:1.5
div_wall_width = 1.5;
// Amount to shave off divider heights (mm) DEFAULT:0
div_height_offset = 0;
// How many dividers to print? DEFAULT:3
number_of_divs = 3;
// Divider fudge factor, amount to shave of each divider to insure fit (mm, each side) DEFAULT:0.2
div_fudge_factor = 0.2;

/* [SLOT SPECS] */
// ------------------
// Slot positions (mm, from Y=0 to the center) DEFAULT:[41.0, 62.0, 83.0]
slot_positions = [41.0, 62.0, 83.0];
// Slot fudge factor, amount to pad the slots to insure fit (mm, each side) DEFAULT:0.1
slot_fudge_factor = 0.1;

/* [HANDLE SPECS] */
// --------------------
// Handle width (mm) DEFAULT:28
handle_width = 28;
// Handle length (mm) DEFAULT:10
handle_length = 10;
// Handle thickness (mm) DEFAULT:1.5
handle_thickness = 1.5;
// Handle z-position (% up the box height) DEFAULT:0.50
handle_z_pct = 0.50; // [0:0.1:1]

// Number of facets in an arc (best if divisible by 4 and less than 48)
$fn = 36*1;


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//	Draw ***ALL THE PARTS***
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
difference() {
	drawBoxVolume(box_corner_radius, box_length, box_height, box_width);
	drawBoxVoid(box_corner_radius, box_length, box_height, box_width, box_wall_width);
}
drawSlots(slot_positions, box_width, box_wall_width, box_corner_radius, box_height, div_wall_width, slot_fudge_factor);
drawDividers(box_wall_width, div_wall_width, div_height_offset, number_of_divs, div_fudge_factor);
drawHandle(handle_width, handle_length, handle_thickness, handle_z_pct);


// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
//	debug helpers (*:hide, %:ghost, #:hilite)
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
*translate([0,0,0]) cube([box_width, box_length, box_height]); // check box H-W-L
*translate([0,0,0]) cube(box_wall_width); // check wall width
*translate([box_width-box_wall_width, box_length-box_wall_width, 0]) cube(box_wall_width); // check wall width


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//	Draw the *BOX VOLUME*
//
//  drawBoxVolume(box_corner_radius, box_length, box_height, box_width);
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module drawBoxVolume(r,l,h,w) {
	// The rounded corners
	hull() {
		translate([r,		r,		r]) sphere(r);
		translate([r,		l-r,	r]) sphere(r);
		translate([w-r,		l-r,	r]) sphere(r);
		translate([w-r,		r,		r]) sphere(r);
	}

	// The extruded rounded rectangle box
	translate([0,0,r]) linear_extrude(h-r) hull() {
		translate([r,		r,		0]) circle(r);
		translate([r,		l-r,	0]) circle(r);
		translate([w-r,		l-r,	0]) circle(r);
		translate([w-r,		r,		0]) circle(r);
	}
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//	Draw the *BOX VOID*
//
//  drawBoxVoid(box_corner_radius, box_length, box_height, box_width, box_wall_width);
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module drawBoxVoid(r,l,h,w,ww) {
	// A sphere or circle with <=0 radius won't draw
	inside_r = max(r-ww, 0.001); // r == ww + inside_r
	
	// The rounded corners
	hull() {
		translate([ww+inside_r,		ww+inside_r,		ww+inside_r]) sphere(inside_r);
		translate([ww+inside_r,		l-inside_r-ww,		ww+inside_r]) sphere(inside_r);
		translate([w-inside_r-ww,	l-inside_r-ww,		ww+inside_r]) sphere(inside_r);
		translate([w-inside_r-ww,	ww+inside_r,		ww+inside_r]) sphere(inside_r);
	}
	
	// The extruded rounded rectangle box
	translate([0,0,ww+inside_r]) linear_extrude(1.2*h) hull() {
		translate([ww+inside_r,		ww+inside_r,		0]) circle(inside_r);
		translate([ww+inside_r,		l-inside_r-ww,		0]) circle(inside_r);
		translate([w-inside_r-ww,	l-inside_r-ww,		0]) circle(inside_r);
		translate([w-inside_r-ww,	ww+inside_r,		0]) circle(inside_r);
	}
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//	Draw the *DIVIDER SLOTS*
//
//  drawSlots(slot_positions, box_width, box_wall_width, box_corner_radius, box_height, 
//            div_wall_width, slot_fudge_factor);
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module drawSlots(pos,bw,bww,br,bh,dww,sff) {
	translate([0,0,br/2])
	linear_extrude(bh-br/2) 
	for (i=[0:len(pos)-1]) {
        // Left side
		translate([bww, 		pos[i]-dww/2-sff-1, 	0]) square(1); // Front slot ridge
        translate([bww, 		pos[i]+dww/2+sff, 		0]) square(1); // Back slot ridge
		// Right side
		translate([bw-bww-1, 	pos[i]-dww/2-sff-1, 	0]) square(1); // Front slot ridge
        translate([bw-bww-1, 	pos[i]+dww/2+sff, 		0]) square(1); // Back slot ridge
	}
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//	Draw the *DIVIDERS*
//
//  drawDividers(box_wall_width, div_wall_width, div_height_offset, number_of_divs, 
//               div_fudge_factor);
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module drawDividers(bww,dww,ho,no,dff) {
	// Where in the model to draw the dividers
	x = 1.2*box_width;
	y = 1.1*box_height;
	
	// A sphere or circle with <=0 radius won't draw
	inside_r = max(box_corner_radius-box_wall_width, 0.001);
	h = box_height - box_wall_width - div_height_offset; // Height of the divider
	w = box_width - 2*box_wall_width; // Width of the divider (sans fudge)
	
	for (i =[1:1:no])
		linear_extrude(dww) 
		translate([x,y*(i-1),0]) 
		hull() {
			translate([inside_r+dff, 	inside_r, 	0]) circle(inside_r);
			translate([1+dff, 			h-1-dff, 	0]) square(2, center=true);
			translate([w-1-dff, 		h-1-dff, 	0]) square(2, center=true);
			translate([w-inside_r-dff, 	inside_r, 	0]) circle(inside_r);
		}		
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//	Draw the *HANDLE*
//
//  drawHandle(handle_width, handle_length, handle_thickness, handle_z_pct);
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module drawHandle(w,l,t,pc) {	
	translate([box_width/2-w/2,-l,pc*box_height-t/2]) 
	linear_extrude(t) 
	hull() {
		translate([2,		2,		0]) circle(2);
		translate([1,		l-1,	0]) square(2, center=true);
		translate([w-1,		l-1,	0]) square(2, center=true);
		translate([w-2,		2,		0]) circle(2);
	}
}