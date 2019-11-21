// Box with rouned corners, by Clif Cox 04/09/2013
// Uses outside mesurements in function calls

include </home/clif/src/openscad/boxes.scad>;
use <MCAD/boxes.scad>;

// preview[view:south west, tilt:top diagonal]

/* [Main] */

// Inside width
width=12;
// Inside Length
length=12;
// Inside Height
height=12;
// Wall Thickness
wall=1;
// Corner Radius
radius=2;
// Percetage of total height for lid
lidp= 20;
// Percetage of total height for lip
lipp= 5;

// Get outside mesurments
w = width + 2*wall; l = length + 2*wall; h = height + 2*wall; r = (radius > 0 ? radius + wall:0);
// Get actuall lid measurments
lidh=h*lidp/100; liph= h*lipp/100;

/* [Advanced] */

// Only round the sides of the box?
sidesonly=1; // [0:No, 1:Yes]

// How snugly should the parts fit?
fit = 0; // [0:Super fit, 0.2:Force fit, 0.3:Hold fit, 0.4:Slide fit, 0.5:Free fit]

// Should there be a gap inside so the outside lips fit flush? (This does not change the hight of the box)
gap= 0; // [0:No gap, 0.1:Small gap, 0.3:Medium gap, 0.5:Large gap]

// How far to seperate the pices when printing both
seperation = 2;

// Number of segments in a circle
$fn = 50;

/* [Hidden] */

// Fudge Factor
x= 0.1;

// translate([0,0, 5]) boxlip(width, length, height, wall/2, radius, lidh, lidh+liph); // Test lip

boxWithLid(w, l, h, wall, r, sidesonly, 1);
boxWithLid(w, l, h, wall, r, sidesonly, 2);

// Make a hollow box with a lid
module boxWithLid(width, length, height, wall, radius, sidesonly, part) {
	w = 2*wall;
	// This just flips the top upside down to print side by side with the bottom
	translate([(part < 3 ? (part-1.5):0)*(width+seperation), 0, 0]) rotate(a=[(part==1 ? 1:0)*180, 0, 0]) {
		difference() {
    	    		hollowbox(width, length, height, wall, radius, sidesonly=sidesonly);
			if (part == 1) difference() {		// Subtrack bottom of box to make top
				cube([width+x, length+x, height+x], center=true);
				translate([0, 0, (height-lidh+x)/2]) cube([width+x, length+x, lidh+x], center=true);
				boxlip(width+x, length+x, height+x, (wall-fit+x)/2, radius+x, lidh, liph);
			}
			if (part == 2) {			// Subtrack top of box to make bottom
				translate([0, 0, (height-lidh-gap+x)/2]) cube([width+x, length+x, lidh+gap+x], center=true);
				boxlip(width+x, length+x, height+x, (wall+fit+x)/2, radius+x, lidh, liph);
			} 					// Else Make the whole box
		}
	}
}


// Make a hollow box
module hollowbox(width, length, height, wall, radius) {
    w = 2*wall;

	if (radius > 0) difference() {
		roundedBox([width, length, height], radius, sidesonly=sidesonly);
		roundedBox([width-w, length-w, height-w], radius-wall, sidesonly=sidesonly);
	} else difference() {
        cube([width, length, height], center=true);
        cube([width-w, length-w, height-w], center=true);
	}
}


// Make the lip btween the top and bottom
module boxlip(width, length, height, wall, radius, top, thick) {
	w = 2*wall;

	intersection() {
		hollowbox(width, length, height, wall, radius);
		translate([0,0,(height-thick)/2-top]) cube([width+x, length+x, thick], center=true);
	}
}
