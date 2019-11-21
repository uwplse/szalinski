//------------------------------------------------------------
// Parametric altoids storage racks 
//
// http://www.thingiverse.com/wardwouts
// 
//
//------------------------------------------------------------

// What type of storage do you want?
style = "fullwide"; // [full,fullwide, singleleft, singleright, middle]

// Number of tins to store
tins = 5;

// in the sides for easier tin grabbing?
cutouts = "yes"; // [yes,no]

screw_holes = "yes"; // [yes,no]

closed_ends = "no"; // [yes,no]

// For stacking multiple racks you may not want a bottom shelf
with_bottom_shelf = "yes"; // [yes,no]

// Side depth (how deep is a shelf in mm)
depth = 40;

// Side width (how wide is a shelf in mm)
width = 20;

wall_thickness = 2;
bottom_thickness = 1;

// Amount of play a tin should have at its sides
width_play = 0.5;

// Amount of play a tin should have between shelves
height_play = 0.5;

//////////////////////////////////////////////////////////////////
// Some tin measurements; these shouldn't need editing
// Thickness of an altoids tin as measured
tin_thickness = 21.5;
// as measured
tin_width = 62; 
// as measured
tin_length = 97.5;

//////////////////////////////////////////////////////////////////
// Code starts here

wtn = wall_thickness;
btn = bottom_thickness;

// the sace betwee 2 shelves
spacing = tin_thickness + height_play;

tin_tot_width = tin_width + width_play;
tin_tot_length = tin_length + width_play;

length=tins*spacing + tins*wtn;

module base() {
	// Draw the base wall thickness offset from origin
	translate([0,wtn,0]){
		if ( screw_holes == "yes"){
			difference(){
				cube([length,width,btn]);
				union() {
					translate([wtn+spacing/2,width/2,0]){
						screw_hole();
					}
					translate([length - spacing/2,width/2,0]){
						screw_hole();
					}
				}
			}
		} else {
			cube([length,width,btn]);
		}
	}
}

module side() {
	if (cutouts == "yes") {
		difference(){
			cube([length,wtn,depth+btn]);
			union(){
				for (i = [0 : tins - 1]){
					translate([wtn + (spacing/2) + (spacing+wtn)*i, -wtn, depth+btn]){
						rotate([270,0,0]){
							// if I aim for an exact cutout, some material remains,
							// so cutout 3*wtn
							cylinder(h=wtn*3,r=spacing/2);
						}
					}
				}
			}
		}
	} else {
		cube([length,wtn,depth+btn]);
	}
}

module shelf() {
	// Draws a single shelf with one rounded corner
	// To draw this it draws 2 rectangles and one cilinder like:
	// +--+-
	// |  |	 \
	// |  |+-+
	// +--++-+
	// As the circle may get to big it cuts everything off at the surrouning rectangle
	// Draw the base wall thickness and base thickness offset from origin
	translate([0,wtn,btn]){
		intersection() {
			cube([wtn,width,depth]);
			union() {
				translate([0,width/2,depth-width/2]){
					rotate([0,90,0]){
						cylinder(h=wtn, r=width/2);
					}
				}
				cube([wtn,width/2,depth]);
				translate([0,width/2,0]){
					cube([wtn,width/2,depth-width/2]);
				}
			}
		}
	}
}

module shelves() {
	// Draw the same number of shelves as there are tins
	// If with_bottom_shelf was chosen, draw one more
	for (i = [0 : tins - 1]){
		translate([(spacing+wtn)*i,0,0]){
			shelf();
		}
	}
	if (with_bottom_shelf == "yes"){
		translate([length,0,0]){
			shelf();
			// the end tray needs a bit more side and base too
			cube([wtn,wtn,btn+depth]);
			cube([wtn,width+wtn,btn]);
		}
	}
}

module spacer() {
	// If a full rack was chosen we need material to hold the two sides together
	// this module draws that bit
	if (style == "full" || style == "fullwide") {
		if (style == "full") {
			translate([0,width+wtn,0]){	
				if (with_bottom_shelf == "yes"){
					cube([length + wtn, tin_tot_width/2 - width, btn]);
				} else {
					cube([length, tin_tot_width/2 - width, btn]);
				}
			}
		} else {
			translate([0,width+wtn,0]){
				if (with_bottom_shelf == "yes"){
					cube([length + wtn, tin_tot_length/2 - width, btn]);
				} else {
					cube([length, tin_tot_length/2 - width, btn]);
				}
			}
		}
	}
}

module ends() {
	// It can be nice to have closed top and bottom shelves
	// If closed_ends have been chosen, fill up the ends
	if (closed_ends == "yes"){
		if (style == "full") {
			cube([wtn, tin_tot_width/2+wtn, depth+btn]);
		} else if (style == "fullwide") {
			cube([wtn, tin_tot_length/2+wtn, depth+btn]);
		}
		if (with_bottom_shelf == "yes"){
			translate([length,0,0]){
				if (style == "full") {
					cube([wtn, tin_tot_width/2+wtn, depth+btn]);
				} else if (style == "fullwide") {
					cube([wtn, tin_tot_length/2+wtn, depth+btn]);
				}
			}
		}
	}
}

module screw_hole() {
	// screw head that I measured maxes at 7mm
	// screw thread is 3.5 mm
	head = 7;
	thread = 3.5 + 0.5;

	translate([0,0,-20]){
		cylinder(h=30, r=thread/2, $fn=20);
	}
	translate([0,0,btn-(thread/2)]){
		cylinder(h=head-(thread/2), r1=thread/2, r2=head);
	}
}

module rack() {
	base();
	side();
	shelves();
	spacer();
	ends();
}

if (style == "singleright"){
	mirror([0,1,0]){
		rack();
	}
} else {
	rack();
}

if (style == "full") {
	translate([0, tin_tot_width+2*wtn,0]){
		mirror([0,1,0]){
			rack();
		}
	}
} else if (style == "fullwide") {
	translate([0, tin_tot_length+2*wtn,0]){
		mirror([0,1,0]){
			rack();
		}
	}
} else if (style == "middle") {
	translate([0, wtn, 0]){
		mirror([0,1,0]){
			rack();
		}
	}	
}
