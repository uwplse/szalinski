
/* [Global] */

// which part to display?
part = "assembled"; // [assembled:Assembled,base:Hub Base,top:Hub Top Plate,fork:Spoke Fork Base,finger:Spoke Fork Finger]

/* [Basic] */

// number of spokes in spool (suggested: 3)
numSpokes = 3; // [2:12]

// bolt diameter for mounting spokes (diameter in mm, default=M4)
boltSize = 4; // [2:10]

/* [Advanced] */

wallThick = 4;
hubOD = 85;
hubID = 40;
hubDepth = 21;
spokeOD = 150;
spokeID = 90;
forkDepth = 60;
ridgeHeight = 1;
boltLength = 25;

/* [Hidden] */

echo(version());

/*** BEGIN: from common_hardware.scad ***/

//include <common_hardware.scad>;

/* from http://hydraraptor.blogspot.com/2011/02/polyholes.html */
module polyhole(h, d, center = false) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), center = center, $fn = n);
}
/* from MCAD/units.scad */
epsilon = 0.001;
/* from MCAD/nuts_and_bolts.scad */
//Based on: http://www.roymech.co.uk/Useful_Tables/Screws/Hex_Screws.htm
METRIC_NUT_AC_WIDTHS =
[
	-1,-1,4.2,//m2
	6.40,//m3
	8.10,//m4
	9.20,//m5
	11.50,//m6
	-1,15.00,//m8
	-1,19.60,//m10
	-1,22.10,//m12
	-1,-1,-1,27.70,//m16
	-1,-1,-1,34.60,//m20
	-1,-1,-1,41.60,//m24
	-1,-1,-1,-1,-1,53.1,//m30
	-1,-1,-1,-1,-1,63.5//m36
];
METRIC_NUT_THICKNESS =
[
	-1,-1,1.60,//m2
	2.40,//m3
	3.20,//m4
	4.00,//m5
	5.00,//m6
	-1,6.50,//m8
	-1,8.00,//m10
	-1,10.00,//m12
	-1,-1,-1,13.00,//m16
	-1,-1,-1,16.00,//m20
	-1,-1,-1,19.00,//m24
	-1,-1,-1,-1,-1,24.00,//m30
	-1,-1,-1,-1,-1,29.00//m36
];
COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS =
[//based on max values
	-1,-1,1.99,//m2
	2.98,//m3
	3.978,//m4
	4.976,//m5
	5.974,//m6
	-1,7.972,//m8
	-1,9.968,//m10
	-1,11.966,//m12
	-1,-1,-1,15.962,//m16
	-1,-1,-1,19.958,//m20
	-1,-1,-1,23.952,//m24
	-1,-1,-1,-1,-1,29.947,//m30
	-1,-1,-1,-1,-1,35.940//m36
];
module nutHole(size, tolerance = epsilon, proj = -1)
{
	//takes a metric screw/nut size and looksup nut dimensions
	radius = METRIC_NUT_AC_WIDTHS[size]/2+tolerance;
	height = METRIC_NUT_THICKNESS[size]+tolerance;
	if (proj == -1)
	{
		//polyhole(h=height, d=radius*2);
		cylinder(r= radius, h=height, $fn = 6, center=[0,0]);
	}
	if (proj == 1)
	{
		polycircle(d=radius*2);
		//circle(r= radius, $fn = 6);
	}
	if (proj == 2)
	{
		translate([-radius/2, 0])
			square([radius*2, height]);
	}
}
module boltHole(size, length, tolerance = epsilon, proj = -1)
{
	radius = COURSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[size]/2+tolerance;
//TODO: proper screw cap values
	capHeight = METRIC_NUT_THICKNESS[size]+tolerance; //METRIC_BOLT_CAP_HEIGHTS[size]+tolerance;
	capRadius = METRIC_NUT_AC_WIDTHS[size]/2+tolerance; //METRIC_BOLT_CAP_RADIUS[size]+tolerance;

	if (proj == -1)
	{
		translate([0, 0, -capHeight])
			polyhole(h=capHeight, d=capRadius*2);
			//cylinder(r= capRadius, h=capHeight);
		polyhole(h=length, d=radius*2);
		//cylinder(r = radius, h = length);
	}
	if (proj == 1)
	{
		polycircle(d=radius*2);
		//circle(r = radius);
	}
	if (proj == 2)
	{
		translate([-capRadius/2, -capHeight])
			square([capRadius*2, capHeight]);
		square([radius*2, length]);
	}
}
function mm_to_inch(v) = v / 25.4;
function inch_to_mm(v) = v * 25.4;
function cutout_tolerance(keepout=false) = keepout ? 0.2 : epsilon;
module bolt_and_nut(size=2, length=10, keepout=false, nut_offset=0, extra_nut_keepout=10, extra_cap_keepout=2) {
	t = cutout_tolerance(keepout);
	union() {
		boltHole(size=size, length=length, tolerance=t, $fn=20);
		translate([0, 0, length-METRIC_NUT_THICKNESS[size]-t-nut_offset]) {
			if (keepout) {
				cylinder(r=(METRIC_NUT_AC_WIDTHS[size]/2+t), h=extra_nut_keepout, $fn = 6, center=[0,0]);
			} else {
				nutHole(size=size, tolerance=t);
			}
		}
		if (keepout)
			translate([0, 0, -(size+t+extra_cap_keepout)+0.01])
				cylinder(r=METRIC_NUT_AC_WIDTHS[size]/2+t, h=size+t+extra_cap_keepout, $fn=20, center=[0,0]);
	}
}
module manual_support(fillCube=[1, 1, 1], supportDir=2, supportWidth=0.4, supportSpacing=2, center=false) {
	supportNormal = (supportDir==0) ? [1, 2, 0] : (supportDir==1) ? [0, 2, 1] : [0, 1, 2];
	rot = (supportDir==0) ? [0, 90, 0] : (supportDir==1) ? [90, 0, 0] : [0, 0, 90];
	widthIx = supportNormal[0];
	depthIx = supportNormal[1];
	supptIx = supportNormal[2];
	a = fillCube[widthIx] + 0.2;
	b = fillCube[depthIx] + 0.2;
	t = a + b;
	u = a - b;
	d = (a > b) ? a : b;
	shft = (supportDir==0) ? [0, 0, d] : (supportDir==1) ? [0, fillCube[supptIx], 0] : [b, b-a, 0];
	v = sqrt(d*d*2);
	translate(center ? fillCube / 2 : [0, 0, 0])
		intersection() {
			translate(shft) rotate(rot)
					for (x = [u:supportSpacing:t])
						translate([x + 0.8, 0, 0])
							rotate([0, 0, 45])
								translate([-0.1, -0.1, -0.1])
									cube([supportWidth, v, fillCube[supptIx]+0.2]);
			cube(fillCube);
		}
}
module nut_printing_support(size=2, bolt_length=10, nut_offset=0, extra_nut_keepout=10, supportDir=2, supportWidth=0.4, supportSpacing=2) {
	t = cutout_tolerance(true);
	translate([0, 0, bolt_length-METRIC_NUT_THICKNESS[size]-nut_offset])
		intersection() {
			cylinder(r=(METRIC_NUT_AC_WIDTHS[size]/2-0.5), h=METRIC_NUT_THICKNESS[size]+extra_nut_keepout, $fn = 6, center=[0,0]);
			translate([-METRIC_NUT_AC_WIDTHS[size]/2, -METRIC_NUT_AC_WIDTHS[size]/2, 0])
				manual_support(fillCube=[METRIC_NUT_AC_WIDTHS[size], METRIC_NUT_AC_WIDTHS[size], extra_nut_keepout+nut_offset], supportDir=supportDir, supportWidth=supportWidth, supportSpacing=supportSpacing);
		}
}

/*** END: from common_hardware.scad ***/



print_parts();

module print_parts() {
	if (part == "assembled") {
		hub_base();
		hub_cap();
		#replicate_and_position_spokes()
			spoke_bolt(keepout=false);
		replicate_and_position_spokes()
			spoke_position() {
				spoke();
				spoke_finger();
			}
	}
	
	if (part == "base")
		hub_base();
	
	if (part == "top")
		translate([0, 0, -hubDepth+wallThick])
			hub_cap();
	
	if (part == "fork")
		translate([0, 0, (hubDepth - (wallThick * 2))/2])
			spoke_position()
				spoke();
	
	if (part == "finger")
		rotate([180, 0, 0])
		translate([-45, -40, -(hubDepth - (wallThick * 2))/2])
			spoke_position()
				spoke_finger();
}

module hub_base() {
	angleSize = (360/numSpokes)/2;
	difference() {
		union() {
			HubPlate();
			HubCore();
			rotate([0, 0, angleSize])
				replicate_and_position_spokes()
					hub_key(keepout=false);
		}
		translate([0, 0, -1])
			polyhole(d=hubID,h=400);
		replicate_and_position_spokes()
			spoke_bolt(keepout=true);
	}
}

module hub_cap() {
	angleSize = (360/numSpokes)/2;
	difference() {
		HubPlate([0, 0, hubDepth-wallThick]);
		rotate([0, 0, angleSize])
			replicate_and_position_spokes()
				hub_key(keepout=true);
		translate([0, 0, -1])
			polyhole(d=hubID+wallThick*2,h=400);
		replicate_and_position_spokes()
			spoke_bolt(keepout=true);
	}
}

module hub_key(keepout) {
	translate([-7.5, -1, 0])
		rotate([90, 0, 0])
			polyhole(d=(keepout?8.5:8), h=(hubDepth+wallThick+(keepout?2:-2)));
}

module HubPlate(tx=[0,0,0]) {
	translate(tx)
		polyhole(d=hubOD,h=wallThick);
}

module HubCore() {
	polyhole(d=hubID+wallThick*2,h=hubDepth+wallThick);
}

module replicate_and_position_spokes() {
	angleSize = 360/numSpokes;
	distance = (hubID + hubOD) / 4;
	for(angle = [0 : numSpokes])
		translate([distance*cos(angle*angleSize), distance*sin(angle*angleSize), 0])
			rotate([0, 0, angle*angleSize])
				rotate([-90, 0, 0])
					if (version()[0] >= 2014) {
						children();
					} else {
						child();
					}
}

module spoke_bolt(keepout) {
	rotate([90, 0, 0])
		bolt_and_nut(size=boltSize,length=boltLength,keepout=keepout);
}

module fork_template() {
	A = hubDepth - (wallThick * 2);
	B = forkDepth;
	C = B + 2 * A;
	boltMargin = A / 2;
	distance = ((hubID + hubOD) / 4) - boltMargin;
	D = spokeOD - distance;
	E = spokeID - distance;
	F = C / 3;
	G = E / 2;
	points = [
		// top surface
		[0,   A+F, A], // 0
		[E-G, A+F, A], // 1
		[E-G/2.5,   C,   A], // 2
		[D,   C,   A], // 3
		[D,   C-A, A], // 4
		[E,   C-A, A], // 5
		[E-G+A*1.75,   A+F, A], // 6
		[E-G+A*1.75,   F,   A], // 7
		[E,   A,   A], // 8
		[D,   A,   A], // 9
		[D,   0,   A], // 10
		[E-G/2.5,   0,   A], // 11
		[E-G, F,   A], // 12
		[0,   F,   A], // 13

		// bottom surface
		[0,   A+F, 0], // 14
		[E-G, A+F, 0], // 15
		[E-G/2.5,   C,   0], // 16
		[D,   C,   0], // 17
		[D,   C-A, 0], // 18
		[E,   C-A, 0], // 19
		[E-G+A*1.75,   A+F, 0], // 20
		[E-G+A*1.75,   F,   0], // 21
		[E,   A,   0], // 22
		[D,   A,   0], // 23
		[D,   0,   0], // 24
		[E-G/2.5,   0,   0], // 25
		[E-G, F,   0], // 26
		[0,   F,   0]  // 27
		];
	faces = [
		// top surface
		[0, 1, 2, 5, 6, 7, 8, 11, 12, 13],
		[2, 3, 4, 5],
		[8, 9, 10, 11],
		// bottom surface
		[27, 26, 25, 22, 21, 20, 19, 16, 15, 14],
		[25, 24, 23, 22],
		[19, 18, 17, 16],
		// sides
		[0,  13, 27, 14],
		[1,  0,  14, 15],
		[2,  1,  15, 16],
		[3,  2,  16, 17],
		[4,  3,  17, 18],
		[5,  4,  18, 19],
		[6,  5,  19, 20],
		[7,  6,  20, 21],
		[8,  7,  21, 22],
		[9,  8,  22, 23],
		[10, 9,  23, 24],
		[11, 10, 24, 25],
		[12, 11, 25, 26],
		[13, 12, 26, 27]
		];
	intersection() {
		union() {
			translate([boltMargin, C+1, boltMargin])
				rotate([90,0,0])
					cylinder(d=A, h=C + 2);
			translate([boltMargin-1, -1, 0])
				cube([D + 2 -boltMargin, C + 2, A]);
		}
		difference() {
			union() {
				polyhedron(points=points, faces=faces);
				translate([-distance, F-wallThick+(wallThick-ridgeHeight)+epsilon, boltMargin])
					rotate([-90, 0, 0]) {
						ridge();
						translate([0, 0, A+ridgeHeight*2-epsilon*2])
							rotate([180, 0, 0])
								ridge();
					}
			}
			translate([47, 29.25, -1])
				polyhole(d=4, h=A+2);
			translate([112.25, boltMargin, -1])
				polyhole(d=4, h=A+2);
			translate([boltMargin, F+A+2, boltMargin])
				spoke_bolt(keepout=true);
			translate([45+A, C-A+boltMargin, (A+2)-1])
				rotate([0, 180, 0])
					bolt_and_nut(size=3,length=A+1,keepout=true); //bolt for attaching finger
			translate([45+A, C-A+boltMargin, A-0.75])
					polyhole(d=9,h=2); // washer under bolt (reduce friction)
			translate([45+A, C-A+boltMargin, boltMargin-0.75])
					polyhole(d=9,h=1.5); // space for two washers between parts (reduce friction)
		}
	}
	// add supports where needed
	if (part != "assembled"){
		translate([45+A, C-A+boltMargin, (A+2)-1])
			rotate([0, 180, 0])
				nut_printing_support(size=3,bolt_length=A+1,supportSpacing=1.6,extra_nut_keepout=METRIC_NUT_THICKNESS[3]); //support for nut hole on fork
	}
}

module spoke(){
	difference() {
		fork_template();
		fork_prong(for_cutout=true);
	}
}

module spoke_finger(){
	A = hubDepth - (wallThick * 2);
	B = forkDepth;
	C = B + 2 * A;
	boltMargin = A / 2;
	fork_start = 45;

	intersection(){
		fork_template();
		fork_prong(for_cutout=false);
	}

	if (part != "assembled"){
		translate([45+A, C-A+boltMargin, A-0.75])
			intersection(){
				polyhole(d=8,h=2); // washer under bolt (reduce friction)
				rotate([0, 0, 45]) translate([-4, -4, 0])
					manual_support(fillCube=[8, 8, 0.75], supportSpacing=1.6);
			}
	}
}

module fork_prong(for_cutout){
	A = hubDepth - (wallThick * 2);
	B = forkDepth;
	C = B + 2 * A;
	boltMargin = A / 2;
	distance = ((hubID + hubOD) / 4) - boltMargin;
	D = spokeOD - distance;
	E = spokeID - distance;
	F = C / 3;
	G = E / 2;
	fork_start = 45;

	translate([fork_start+A, C-A+boltMargin, boltMargin])
		polyhole(d=A, h=boltMargin + 1);
	if (for_cutout) {
		translate([fork_start, C-A, boltMargin])
			cube([spokeOD-fork_start, A+2, boltMargin + 1]);
		translate([fork_start+20-1, C-A-5, -1])
			cube([spokeOD-fork_start, A+6, A + 2]);
	} else {
		translate([fork_start+A, C-A, boltMargin])
			cube([spokeOD-fork_start, A, boltMargin + 1]);
		translate([fork_start+20, C-A, -1])
			cube([spokeOD-fork_start, A, boltMargin + 2]);
	}
	if (for_cutout){
		difference() {
			translate([fork_start+A, C-A+boltMargin, -1])
				cube([boltMargin+1, boltMargin+1, A+2]);
			translate([fork_start+A, C-A+boltMargin, -1])
				polyhole(d=A, h=A + 2);
		}
	}
}

module spoke_position(){
	A = hubDepth - (wallThick * 2);
	B = forkDepth;
	C = B + 2 * A;
	boltMargin = A / 2;
	F = C / 3;
	translate([0, -boltMargin-wallThick, 0])
		translate([-boltMargin, -F-boltMargin, -boltMargin])
			if (version()[0] >= 2014) {
				children();
			} else {
				child();
			}
}

module ridge() {
	difference() {
		hull() {
			polyhole(d=hubOD+3, h=ridgeHeight);
			translate([0, 0, ridgeHeight])
				polyhole(d=hubOD+20, h=0.01);
		}
		translate([0, 0, -1])
			polyhole(d=hubOD+0.25, h=ridgeHeight+2);
	}
}


