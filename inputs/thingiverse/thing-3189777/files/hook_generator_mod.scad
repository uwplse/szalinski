/* ********************************************************************
 * Space Invader Hooks
 * 
 * Generate your own cloth hooks. Tweak parameters, create your own
 * hooks or use the predefined modules.
 *
 * ******************************************************************** */
/* changes by Cuanu:
- adopted countersink for metric coungtersink (45° slope)
- indented screw hole by 1mm to be able to put a cap on
- generate a cap for the screw hole
- made the pixel_connection_strength derived from the pixel size

*/
// preview[view:south, tilt:top]

// ------------------------------------------------------------------
// --- parameter ----------------------------------------------------
// ------------------------------------------------------------------

/* [Global] */



/* [Basic] */

// choose a space invader
spaceInvader = 6; // [1,2,3,4,5,6,7,8,9,10]

// pixel size
edgeLength = 8;

// thickness of the hook
strength = 6;

// radius of the hole
holeRadius = 3.0;

// adjust the strength of the connections of otherwise unconnected pixel
pixel_connection_strength = edgeLength/10;


/* [Advanced] */

// resolution
$fn=50;

// make a hole or not
make_hole = "yes"; // [yes,no]

// make a hook or just the base space invader
make_hook = "yes"; // [yes,no]

// use to avoid loonely pixel
 minkowski_factor=10;

translate([0,0,0])cylinder(r=2*holeRadius-0.2,h=1);

/* [Hidden] */

// ------------------------------------------------------------------
// --- space invader versions ---------------------------------------
// --- a vector of 2d coordinates; hole and hook position -----------
// ------------------------------------------------------------------

// space invader 1 parameter
si_1=[[0,0,1,0,1,0,0],[0,1,1,1,1,1,0],[0,1,0,1,0,1,0],[1,1,1,1,1,1,1],[1,0,1,0,1,0,1],[1,0,0,0,0,0,1]];
si_1_hole=[3,2];
si_1_hook=[3,4];

// space invader 2 parameter
si_2=[[0,0,1,0,1,0,0],[0,1,1,1,1,1,0],[0,1,0,1,0,1,0],[1,1,1,1,1,1,1],[1,0,1,1,1,0,1],[1,0,0,1,0,0,1]];
si_2_hole=[3,3];
si_2_hook=[3,5];

// space invader 3 parameter
si_3=[[0,0,1,0,1,0,0],[0,1,1,1,1,1,0],[0,1,0,1,0,1,0],[1,1,1,1,1,1,1],[1,0,1,1,1,0,1],[1,0,0,1,0,0,1],[0,0,0,1,0,0,0]];
si_3_hole=[3,3];
si_3_hook=[3,6];

// space invader 5 parameter
si_4=[[0,0,1,0,1,0,0],[0,1,1,1,1,1,0],[0,1,0,1,0,1,0],[1,1,1,1,1,1,1],[1,0,1,1,1,0,1],[1,0,0,1,0,0,1],[1,1,0,1,0,1,1]];
si_4_hole=[3,3];
si_4_hook=[3,6];

// space invader 5 parameter
si_5=[[0,0,1,1,0,1,1,0,0],[0,1,1,1,1,1,1,1,0],[0,1,0,0,1,0,0,1,0],[1,1,0,0,1,0,0,1,1],[1,1,1,1,1,1,1,1,1],[0,0,1,1,1,1,1,0,0],[0,1,1,0,1,0,1,1,0],[1,1,0,0,0,0,0,1,1]];
si_5_hole=[4,4];
si_5_hook=[4,6];

// space invader 6 parameter
si_6=[[0,0,1,0,0,0,0,0,1,0,0],[0,0,0,1,0,0,0,1,0,0,0],[0,0,1,1,1,1,1,1,1,0,0],[0,1,1,0,1,1,1,0,1,1,0],[1,1,1,1,1,1,1,1,1,1,1],[1,0,1,1,1,1,1,1,1,0,1],[1,0,1,0,0,0,0,0,1,0,1],[0,0,0,1,1,0,1,1,0,0,0]];
si_6_hole=[5,3];
si_6_hook=[5,5];
si_6_cons=[[0,0,2,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,1,0,0,0],[0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0],[0,0,2,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,1,0,0,0]];

// space invader 7 parameter
si_7=[[0,0,0,1,1,0,0,0],[0,0,1,1,1,1,0,0],[0,1,1,1,1,1,1,0],[1,1,0,1,1,0,1,1],[1,1,1,1,1,1,1,1],[0,1,0,1,1,0,1,0],[1,0,0,0,0,0,0,1],[0,1,0,0,0,0,1,0]];
si_7_hole=[3.5,3];
si_7_hook=[3.5,5];
si_7_cons=[[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,2,0],[3,0,0,0,0,0,0,0],[0,0,0,0,0,0,1,0]];

// space invader 8 parameter
si_8=[[0,0,0,1,1,0,0,0],[0,0,1,1,1,1,0,0],[0,1,1,1,1,1,1,0],[1,1,0,1,1,0,1,1],[1,1,1,1,1,1,1,1],[0,1,0,1,1,0,1,0],[1,0,1,0,0,1,0,1],[0,1,0,1,1,0,1,0]];
si_8_hole=[3.5,3];
si_8_hook=[3.5,5];
si_8_cons=[[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,2,0,0,2,0,2,0],[3,0,3,0,0,3,0,0],[0,1,0,0,1,0,1,0]];

// space invader 9 parameter
si_9=[[0,0,0,0,1,1,1,1,0,0,0,0],[0,1,1,1,1,1,1,1,1,1,1,0],[1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,0,0,1,1,0,0,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1],[0,0,1,1,1,0,0,1,1,1,0,0],[0,1,1,0,0,1,1,0,0,1,1,0],[0,0,1,1,0,0,0,0,1,1,0,0]];
si_9_hole=[5.5,2];
si_9_hook=[5.5,4];
si_9_cons=[[0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,2,0,0,0,0,0,0,0],[0,0,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0]];

si_10=[[0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0],[0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0],[0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0],[0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[0,0,1,1,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0]];
si_10_hole=[7.5,3];
si_10_hook=[7.5,5];
si_10_cons=[];




// ------------------------------------------------------------------
// --- programm -----------------------------------------------------
// ------------------------------------------------------------------

if (spaceInvader == 1) {
	complete_hook(si_1, [], si_1_hole, si_1_hook);
} else if (spaceInvader == 2) {
	complete_hook(si_2, [], si_2_hole, si_2_hook);
} else if (spaceInvader == 3) {
	complete_hook(si_3, [], si_3_hole, si_3_hook);
} else if (spaceInvader == 4) {
	complete_hook(si_4, [], si_4_hole, si_4_hook);
} else if (spaceInvader == 5) {
	complete_hook(si_5, [], si_5_hole, si_5_hook);
} else if (spaceInvader == 6) {
	complete_hook(si_6, si_6_cons, si_6_hole, si_6_hook);
} else if (spaceInvader == 7) {
	complete_hook(si_7, si_7_cons, si_7_hole, si_7_hook);
} else if (spaceInvader == 8) {
	complete_hook(si_8, si_8_cons, si_8_hole, si_8_hook);
} else if (spaceInvader == 9) {
	complete_hook(si_9, si_9_cons, si_9_hole, si_9_hook);
} else if (spaceInvader == 10) {
	complete_hook(si_10, si_10_cons, si_10_hole, si_10_hook);
}




// ------------------------------------------------------------------
// --- modules ------------------------------------------------------
// ------------------------------------------------------------------



module complete_hook(matrix, cons, hole, hook) {
	difference() {
		union() {
			hook_base(matrix);
			connections(cons);
			if (make_hook == "yes") {
				hook(hook[0], hook[1]);
			}
		}
		if (make_hole == "yes") {
			hook_hole_positive(hole[0], hole[1], 1);
		}
	}
}


module hook_base(data) {
	for (y = [0:len(data)]) {
		for(x = [0:len(data[y])]) {
			pixel(x,y,data[y][x]);
		}
	}
}

module connections(data) {
	for (y = [0:len(data)]) {
		for(x = [0:len(data[y])]) {
			if (data[y][x] > 0) {
				pixel_connection(x,y,data[y][x]);
			}
		}
	}
}

// builds a cube at specified position
//
module pixel(x, y, h) {
	translate([x*edgeLength, -y*edgeLength, 0]) {
		if (h > 0) {
			cube([edgeLength, edgeLength, strength*h]);
			/*
			minkowski()
			{
				cube([edgeLength, edgeLength, strength*h-(strength/5)]);
 				cylinder(r=strength/10,h=strength*h-(strength/5));
			}
			*/
		}
	}
}

// build a connection
module pixel_connection(x,y,direction) {
	translate([(x+0.5)*edgeLength,-(y-0.5)*edgeLength,0]) {
		if (direction == 3) {
			union() {
				hull() {
					cylinder(r=pixel_connection_strength, h=strength);
					translate([edgeLength,edgeLength,0]) {
						cylinder(r=pixel_connection_strength, h=strength);
					}
				}
				hull() {
					cylinder(r=pixel_connection_strength, h=strength);
					translate([edgeLength,-edgeLength,0]) {
						cylinder(r=pixel_connection_strength, h=strength);
					}
				}
			}
		}
		hull() {
			cylinder(r=pixel_connection_strength, h=strength);
			if (direction == 1) {
				translate([edgeLength,edgeLength,0]) {
					cylinder(r=pixel_connection_strength, h=strength);
				}
			}
			if (direction == 2) {
				translate([edgeLength,-edgeLength,0]) {
					cylinder(r=pixel_connection_strength, h=strength);
				}
			}
		}
	}
}

// make the positives for the holes
//
module hook_hole_positive(x,y,h) {
	translate([x*edgeLength+edgeLength/2, -y*edgeLength+edgeLength/2, 0]) {
		cylinder(h=strength*h, r=holeRadius);
		hull() {
			translate([0, 0, strength*h-holeRadius-1]) cylinder(h=0.1, r=holeRadius);
			translate([0, 0, strength-1]) cylinder(h=1, r=holeRadius*2);
		}
	}
}

// builds the hook at specified position
//
module hook(x, y) {
	translate([x*edgeLength, -y*edgeLength, 0]) {
		union() {
			cube([edgeLength, edgeLength, 0.5*edgeLength+strength]);
			hull() {
				translate([0, 0, 0.5*edgeLength+strength]) {
					cube([edgeLength, edgeLength, 0.5*edgeLength]);
				}
				translate([0, 0.5*edgeLength, 0.5*edgeLength+2*strength]) {
					cube([edgeLength, edgeLength, 0.5*edgeLength]);
				}
			}
		}
	}
}
