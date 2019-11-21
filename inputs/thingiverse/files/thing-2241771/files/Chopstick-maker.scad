// chopstick (hashi) maker
// Neon22 - github

// User chooses:
//	- length of sticks,
//	- desired start and end diameters (taper)
//	- angle of end cut (45)
//	- amount of tolerance in initial blank for first cut operation

// Instructions:
//  - Assuming a taper from 7mm end to 5mm head (actually adjustable)
// Side1 
//		- planes oversize blank to 7mm thickness
//		- user rotates blank by 90 and so planes two adjacent sides to get to 7mm
// Side2
//		- puts taper onto two sides
// 		- goes from 7-6mm
//		- user planes first two adjacent sides of blank
// Side3
//		- puts taper onto the other two sides
//		- goes from 7mm to 5mm final resulting in equal taper on all sides
//		- user planes remaining two adjacent sides of blank to final taper
// Side4
//		- v cut to bring into octagonal shape approximating round (sanding)
//		- user does all four diagonals of blank
// End cut
//		- end cut does diamond shape at handle end of chopstick(hashi)
//		- user attaches guide and inserts chopstick through top plate guide, 
//		  cuts and rotates 4 times to get pointed (octagonal) end

// Lengths:
// - typically 210mm to 270mm, cooking chopsticks are longer.
// chinese 	- (kuaizi) longer (270) and thicker - do not taper as much as other two.
// korean 	- (jeotgarak, sujeo-with spoon) toughest and heaviest of them all. Medium taper.
// Japanese - (hashi-eating, ryoribashi-cooking, saibashi-serving)
//			- shortest, tapers more than others, taper closer to the end.
//			- can be ribbed near tip to grab fish.
//			- 23cm male, 21cm female, 30cm cooking.
// Perfect length is 1.5 times the distance between tip of your extended thumb and forefiner.



/* [Show] */
//Show part(s) (Print Main, Plane, and Guides)
parts = "all";  // [block:Main unit, plane:Plane holder, guide:Guides, all:All]

// Show guide Chopstick and metal parts
Assembled = "yes"; //[yes,no]

/* [Chopstick dimensions] */

//Length(mm)
chop_len   = 270;  // [200:400]

//base width
chop_maxX  = 7;    // [5:10]

//nose width
chop_minX  = 5;    // [2:10]

//End Prism angle
end_angle  = 30;   // [0:60]

//Max blank size(mm)
blank_max = 10;    // [6:15]


/* [Block dimensions] */

//shoulder width to guide plane
border     = 20;     // [10:60]

//Lead distance (before plane cuts)
lead_distance = 70;  // [30:100]

//Marker lines (depth)
marker_depth = 2;    // [1:3]


/* [Plane block] */

//Width of Plane body
plane_width = 70;         // [20:100]

//Distance from plane nose to blade
plane_nose_to_blade = 70; // [20:100]

//Width of the pane support block
plane_block_width = 180;  // [60:250]

//printing slop for smooth sliding (use wax)
slop = 1;                 // [0:0.25:2]

//Metal washer thickness(end stop)
endstop_thick = 1;        // [1:3]


/* [Hidden] */
cyl_res = 80;
Delta = 0.1;
label_height = 3;  // printed length on end of Block
core_hole  = 7;    // M6 dia of central hole for threaded rod.
M6_height = 5;     // used for dist calc for end stop
visualize = Assembled == "yes" ? true : false;


// full length of device including lead_distance at end
function full_length() = chop_len + lead_distance;
// full width of device including borders
function full_width() = border*4 + chop_maxX;
// sides 1,2 cut halfway to end size (chop_minX)
function half_width() = chop_minX + (chop_maxX-chop_minX) / 2;

function block_width()  = max(full_width()+border*4, plane_block_width);//plane_nose_to_blade * 3 + sin(45)*plane_width; // support the plane
function block_length() = plane_width*2 + lead_distance + border*2;
// want the disk halfway up the end so as to hold the chopstick while planing.
function disc_dia() = full_width()-chop_minX/2;

// rails at each corner of block, running the length of the device
module support_cutaway (offset, thickness=border) {
	translate([offset,-Delta,offset])
		cube(size=[thickness, full_length()+Delta*2, thickness]);
}

// marks the distance to start of the chopstick.
module start_marker(x_offset) {
	translate([x_offset, lead_distance/2-Delta, (full_width()-marker_depth+Delta)/2])
		cube(size=[marker_depth, lead_distance, marker_depth], center=true);
}

module drill_core_hole(distance) {
	rotate([90,0,0])
		cylinder(h=distance, d=core_hole, center=true, $fn=cyl_res);
}

// The main block of the device
module Block() {
	difference () {
		// block
		translate([0,full_length()/2,0])
			cube(size=[full_width(), full_length(), full_width()], center=true);
		//
		for (i=[0:3]) {
			// 4x support borders
			rotate([0,i*90,0]) {
				support_cutaway(full_width()/2 - border+Delta);
			// length markers
			start_marker(full_width()/2-border*1.5+marker_depth/2);
			start_marker(-(full_width()/2-border*1.5+marker_depth/2));
			}
		}
		// central hole
		translate([0,full_length()/2,0])
			drill_core_hole(full_length()+Delta*2);
		// label
		translate([-label_height/2,2,full_width()/2-chop_maxX-label_height*1.5])
		rotate([90,0,0])
		linear_extrude(height=label_height, convexity=6)
			text(str(chop_len), size=label_height);
		// chopstick guide for endstop
		chopstick(chop_maxX, slop);
		// clamp spot for end planing
		chop_clamp();
	}
}

module washer(dia) {
	intersection() {
		translate([0,-border,0])
			Block();
		rotate([90,0,0])
			cylinder(h=endstop_thick,d=dia, center=true, $fn=cyl_res);
		
	}
}


module metal(dia) {
	color([0.8,0.5,0]) {
		// bolt
		translate([0,full_length()/2,0])
			drill_core_hole(full_length()+border*2);
		// vice_tag
		translate([0,-1,-full_width()/2])
			cube(size=[core_hole*3, endstop_thick, full_width()*1.5], center=true);
		// disc
		translate([0,full_length()+endstop_thick+Delta,0])
			washer(dia);
	}
}

// first side is the correct depth for the blank
module side1() {
	translate([-(blank_max)/2,-Delta,full_width()/2-chop_maxX+Delta])
		cube(size=[blank_max, full_length()+Delta*2, chop_maxX]);
}

// second side trims nose down to half_width
// - angles up at the nose
module side2() {
	up = 90 - atan2(chop_len,(chop_maxX-chop_minX)/2);
	translate([0, lead_distance-Delta, full_width()/2-chop_maxX])
	rotate([up,0,0])
	translate([-chop_maxX/2,-lead_distance,0])
		cube(size=[chop_maxX, full_length()+Delta*2, chop_maxX]);
	// cut for lead excess
	translate([-chop_maxX/2,0,full_width()/2-chop_maxX/2])
		cube(size=[chop_maxX, lead_distance, chop_maxX]);
}

// third side trims nose down to final size 
module side3() {
	up = 90 - atan2(chop_len,chop_maxX-chop_minX);
	translate([0, lead_distance-Delta, full_width()/2-chop_maxX])
	rotate([up,0,0])
	translate([-chop_maxX/2,-lead_distance,0])
		cube(size=[chop_maxX, full_length()+Delta*2, chop_maxX]);
	// cut for lead excess
	translate([-chop_maxX/2,0,full_width()/2-chop_maxX/2])
		cube(size=[chop_maxX, lead_distance, chop_maxX]);
}

// side 4 is on a diagonal and takes the four corners off to an octagon.
module side4() {
	up = 90 - atan2(chop_len,chop_maxX-chop_minX);
	translate([0,lead_distance, full_width()/2-chop_maxX/1.7])
	rotate([up,0,0])
	translate([0,-lead_distance,0])
	rotate([-90,0,0])
	rotate([0,0,45])
	translate([0,0,-Delta*2])
	linear_extrude(height=full_length()+Delta*4, scale=chop_minX/chop_maxX)
		square(size=[chop_maxX,chop_maxX], center=true);
}


module Chopstick_maker(show) {
	difference() {
		Block();
		// the sides
		side1();
		rotate([0,90,0])
			side2();
		rotate([0,180,0])
			side3();
		rotate([0,-90,0])
			hull() { // for clearance
				side4();
				translate([0,0,chop_maxX])
					side4();
			}
	}
	// disc on end(as a stop), bolt, vice tab
	dia = disc_dia();
	echo(str("Washer dia= ",dia,"mm (thick)"));
	echo(str("Cut/File Washer (or metal blank) to shape."));
	if (show) {
		metal(dia);
	}
}


// The main block shape but with slop used as a negative to make the plane_block
module block_negative()  {
	difference () {
		// block
		translate([-full_width()/2,0,0])
			cube(size=[full_width()+slop*2, full_length(), full_width()/2]);
		//
		translate([0,0,-slop])
		for (i=[0:1]) {
			rotate([0,-i*90,0])
			translate([0,0,slop])
				support_cutaway(full_width()/2 - border+Delta, border+slop*2);
		}
	}
}

// hole that is shape of the plane
module plane_negative() {
	off = (plane_nose_to_blade-plane_width/2)*sin(45);
	extra = plane_nose_to_blade*3;
	translate([-off, block_length()-border, full_width()/2-Delta*2])
	rotate([0,0,45])
	translate([-plane_width,-plane_nose_to_blade-extra,0])
	union() { // plane and line where blade is
		cube(size=[plane_width, plane_nose_to_blade+extra, block_width()/2] );
		translate([-plane_width*0.25, extra, block_width()/5])
			cube(size=[plane_width*1.5, marker_depth*2, block_width()/2]);
	}
}

// Block for holding the Plane.
module Chopstick_plane() {
	difference() {
		// Plane block
		translate([0,block_length()/2,full_width()/2])
			cube(size=[block_width(), block_length(), full_width()], center=true);
		// sloppy block_negative
		translate([0,-Delta,-Delta])
			block_negative();
		// hole for plane
		plane_negative();
	}
}

// positions the chopstick for prism cut on end
module End_stop() {
	vert_len = (chop_len+chop_maxX/2)*cos(end_angle)-full_width()/2;
	color([0.8,0.8,0.3]) {
		translate([0,-(endstop_thick*2+M6_height),0]) 
		difference() {
			union() {
				// endplate
				cube(size=[full_width()+endstop_thick*2+Delta*2, endstop_thick, core_hole*3], center=true);
				// left
				translate([-full_width()/2-endstop_thick-Delta,-endstop_thick/2,-core_hole*1.5])
					cube(size=[endstop_thick, border,core_hole*3,]);
				// right
				translate([full_width()/2+Delta,-endstop_thick/2,-core_hole*1.5]) {
					cube(size=[endstop_thick, border*2,core_hole*3]);
					// cube right
					translate([-chop_maxX+Delta*2, 0, chop_maxX+Delta])
						cube(size=[chop_maxX-Delta, border*2, chop_maxX-Delta*2]);
				}
			}
			// core_hole
			drill_core_hole(border);
		}
		// vertical hang
		difference() {
			translate([-core_hole*1.5,-(endstop_thick*3.5+M6_height),-full_width()/2]) 
				cube(size=[core_hole*3, endstop_thick, full_width()/2+core_hole*1.5]);
			// core_hole
			drill_core_hole(border);
		}
		translate([-core_hole*1.5+chop_maxX*2,-(endstop_thick*3.5+M6_height),-(vert_len)]) 
			cube(size=[core_hole*3, endstop_thick, vert_len+core_hole*1.5]);
		// foot
		translate([-core_hole*1.5+chop_maxX*2,-(endstop_thick*3.5+M6_height),-(vert_len)]) 
			cube(size=[core_hole*3, chop_maxX*2, endstop_thick]);
		translate([-core_hole*1.5+chop_maxX*2+endstop_thick,-(endstop_thick*3.5+M6_height),-(vert_len)]) 
		rotate([0,-90,0])
			cube(size=[core_hole*3, chop_maxX*2, endstop_thick]);
		translate([core_hole*1.5+chop_maxX*2,-(endstop_thick*3.5+M6_height),-(vert_len)]) 
		rotate([0,-90,0])
			cube(size=[core_hole*3, chop_maxX*2, endstop_thick]);
	}
}

// A standin chopstick to visualise endstop position.
// - visually useful as a reference
module chopstick(extra_len=0, extra_width=0) {
	// extra_len is for the negative hole_cut and extends hole
	color([1,0,1])
	translate([chop_maxX*2,-(chop_maxX+endstop_thick)*sin(end_angle),-chop_len*cos(end_angle)+full_width()/2])
	rotate([90-end_angle,0,0])
	translate([-chop_maxX/2,0,-chop_maxX/2-extra_width/2])
		cube(size=[chop_maxX+extra_width, chop_len+extra_len, chop_maxX+extra_width]);
}

// small pin to clamp the chopstick when doing final end prism.
module chop_clamp() {
	hole_Z = full_width()/2-border-chop_maxX*2;
	hole_y = (chop_len-full_width()/2-chop_maxX*2) * sin(end_angle);
	translate([chop_maxX*2, hole_y, hole_Z])
	cube(size=[full_width()/2-chop_maxX*2+Delta*2, chop_maxX*2+Delta*2, chop_maxX+Delta*2]);
}


// final assembly
module maker() {
	if ((parts == "block") || (parts == "all")) {
		Chopstick_maker(visualize);
	}
	if ((parts == "plane") || (parts == "all")) {
		translate([-block_width(),0,0])
			Chopstick_plane();
	}
	if ((parts == "guide") || (parts == "all")) {
		End_stop();
	}
	if (visualize) {
		chopstick();
		if (parts == "guide") {
			translate([0,-border,0]) {
				washer(disc_dia());
				translate([core_hole,0,0])
				rotate([90,0,0])
				linear_extrude(height=label_height/2, convexity=6)
					text(str(disc_dia()), size=label_height*1.5);
			}
		}
	}
}

maker();