//------------------------------------------------------------
//	Construction Kit
//	(with cd case by default)
//
//	http://thingiverse.com/Benjamin
//	http://www.thingiverse.com/thing:59260
//------------------------------------------------------------

/* [Global] */
show = "assembly"; // [assembly:display assembly, plate:prepare for printing]

/* [Corners] */
number = 8; // [1:1, 2:2, 4:4, 8:8]

sphere_radius = 12;
//flatten the sphere
cut = 3;
brick_length = 142;
brick_width = 125;
brick_thickness = 10;
clearance = 0.25;

/* [Triangular] */
tri_base = 50;
tri_base_thick = 3.5;
tri_clearance = 0.12;
//height of the structure
tri_length = 100;

/* [Settings] */
// number of segments to draw a circle (used for rounding)
precision = 12;


/* [Hidden] */
preview_tab = "Triangular";


module dumb() {}
clr = clearance;
nbo = 1+sqrt(5)/2;

tri_side = tri_base / sqrt(2);
tri_height = tri_base/2;
tri_corner_radius = 1.5*tri_base_thick;
tri_inner_radius = 0.4 * tri_base_thick;



//-------------------------------------------------------------------------
if (show == "assembly") {
	if (preview_tab=="Corners") {
		translate([-brick_length/2, -brick_width/2]) cdCube();
	}

	if (preview_tab=="Triangular") {
		color("LightGrey") tri_assembly();
	}
}
//-------------------------------------------------------------------------
if (show == "plate") {
	//-------------------------------------------------------------------
	if (preview_tab=="Corners") {
		if (number == 1) {color("orange") BLF_joint();}
	
		if (number == 2) {color("orange") pairPrint();}
	
		if (number == 4) {color("orange") facePrint();}
	
		if (number == 8) {
			color("orange") {
				translate([-2.5*sphere_radius, 0, 0])
				facePrint();
				translate([2.5*sphere_radius, 0, 0])
				facePrint();
			}
		}

	}
	//-------------------------------------------------------------------
	if (preview_tab=="Triangular") {
		translate([-tri_base/2, 0, 0]) color("LightGrey") tri_plate();
	}
	//-------------------------------------------------------------------

}
//-------------------------------------------------------------------------





//-----------------------------------------------------------------------
module tri_assembly() {
	translate([0, -tri_corner_radius, 0]) tri_base();
	translate([0, -tri_corner_radius, tri_length]) tri_base();
	translate([0, tri_height, tri_length/2 + tri_base_thick/2]) tri_connect(0, tri_length);
	translate([0, 0, tri_length/2 + tri_base_thick/2]) rotate([90, 0, 0])  tri_echelle();
}
//-----------------------------------------------------------------------
module tri_plate() {

	tri_base();

	translate([tri_base/2 + 2.5 * tri_base_thick, 0, tri_base_thick/2])
	rotate([90, 0, 0]) tri_connect(0, tri_length);
	
	translate([tri_base + 4 * tri_base_thick, 0, 0]) tri_echelle();
	
	translate ([0, -3, 0]) rotate([0, 0, 180]) tri_base();
}
//-----------------------------------------------------------------------
module tri_echelle() {
	union() {
		translate([tri_base/2, 0, tri_base_thick/2])
		rotate([90, 0, 0]) tri_connect(0, tri_length);
	
		translate([-tri_base/2, 0, tri_base_thick/2])
		rotate([90, 0, 0]) tri_connect(0, tri_length);
	
		translate([0, 0, tri_base_thick/2])
		rotate([90, 0, 90]) tri_connect(0, tri_base);
		
		translate([0, tri_length/2 - tri_base_thick, tri_base_thick/2])
		rotate([90, 0, 90]) tri_connect(0, tri_base);

		translate([0, -tri_length/2 + tri_base_thick, tri_base_thick/2])
		rotate([90, 0, 90]) tri_connect(0, tri_base);

		difference() {
			translate([0, (-tri_length/2 + tri_base_thick)/2, tri_base_thick/2])
			rotate([90, 0, atan(tri_base/(tri_length/2))])
			tri_connect(0, ((tri_length)/2)/cos(atan(tri_base/(tri_length/2))- 3));

			translate([tri_base/2 - tri_base_thick, (-tri_length/2 ), tri_base_thick/2])
			cube([tri_base_thick, tri_base_thick, 2*tri_base_thick], center=true);
		}

		difference() {
			translate([0, (tri_length/2 - tri_base_thick)/2, tri_base_thick/2])
			rotate([90, 0, atan(tri_base/(tri_length/2))])
			tri_connect(0, ((tri_length)/2)/cos(atan(tri_base/(tri_length/2))- 3));
		
			translate([-tri_base/2 + tri_base_thick, tri_length/2, tri_base_thick/2])
			cube([tri_base_thick, tri_base_thick, 2*tri_base_thick], center=true);
		}


	}
}
//-----------------------------------------------------------------------
module tri_connect(pClear=0, pLength=30) {
	//translate([0, 0, (2*tri_height + tri_base_thick)/2])
	cube([tri_base_thick+2*pClear, tri_base_thick+2*pClear, pLength + tri_base_thick], center=true);
}
//-----------------------------------------------------------------------
module tri_base() {
	translate([0, tri_corner_radius, tri_base_thick/2]) {

		difference() {
			tri_frame();
			translate([tri_base/2, 0, 0]) tri_connect(tri_clearance, 2*tri_base_thick);
			translate([-tri_base/2, 0, 0]) tri_connect(tri_clearance, 2*tri_base_thick);
			translate([0, tri_height, 0]) tri_connect(tri_clearance, 2*tri_base_thick);
		}
	}
}
//-----------------------------------------------------------------------
module tri_frame() {
	translate([tri_base/2, 0, 0]) cylinder(r=tri_corner_radius*0.9, h=tri_base_thick, center = true, $fn=precision);
	translate([-tri_base/2, 0, 0]) cylinder(r=tri_corner_radius*0.9, h=tri_base_thick, center = true, $fn=precision);
	translate([0, tri_height, 0]) cylinder(r=tri_corner_radius*0.9, h=tri_base_thick, center = true, $fn=precision);

difference () {
	hull() {
		translate([tri_base/2, 0, 0])
		cylinder(r=tri_corner_radius, h=tri_base_thick, center = true, $fn=precision);
		translate([-tri_base/2, 0, 0])
		cylinder(r=tri_corner_radius, h=tri_base_thick, center = true, $fn=precision);
		translate([0, tri_height, 0])
		cylinder(r=tri_corner_radius, h=tri_base_thick, center = true, $fn=precision);
	}
	hull() {
		translate([tri_base/2, 0, 0])
		cylinder(r=tri_inner_radius, h=tri_base_thick*2, center = true, $fn=precision);
		translate([-tri_base/2, 0, 0])
		cylinder(r=tri_inner_radius, h=tri_base_thick*2, center = true, $fn=precision);
		translate([0, tri_height, 0])
		cylinder(r=tri_inner_radius, h=tri_base_thick*2, center = true, $fn=precision);
	}						
}
}
//-----------------------------------------------------------------------



//-----------------------------------------------------------------------------------------------
module facePrint() {
	translate([0, -1.5*sphere_radius, sphere_radius - brick_thickness/2 - cut]) {
	pairPrint();
	translate([0,3*sphere_radius, 0])
	scale ([-1, -1, 1]) 
	pairPrint();

	}
}
//-----------------------------------------------------------------------------------------------
module pairPrint() {
	translate([-1.5*sphere_radius, 0, 0])
	BLF_joint();

	translate([1.5*sphere_radius, 0, 0])
	scale ([-1, 1, 1]) 
	BLF_joint();
}
//-----------------------------------------------------------------------------------------------
module cdCube() {
	color("orange") {

	front();
	translate([0, brick_length, 0])
	scale([1, -1, 1])
	front();
	}
	TRBL(0);
}
//-----------------------------------------------------------------------------------------------
module front() {
	pair();
	translate([0, 0, brick_width])
	scale([1, 1, -1])
	pair();
}
//-----------------------------------------------------------------------------------------------
module pair() {
	BLF_joint();
	translate([brick_width + 2*brick_thickness, 0, 0])
	scale ([-1, 1, 1]) 
	BLF_joint();
}
//-----------------------------------------------------------------------------------------------
module BLF_joint () {
	difference () {
		translate([brick_thickness/nbo, brick_thickness/nbo, brick_thickness/2])
		sphere(r=sphere_radius, $fn= 4*precision);

		TRBL(clr);

		translate([0, 0, brick_thickness/2 - sphere_radius - 1.1*sphere_radius + cut])
		cube([2.2*sphere_radius, 2.2*sphere_radius, 2.2*sphere_radius], center=true);
	}
}
//-----------------------------------------------------------------------------------------------
module TRBL(pClear) {
	translate([0, 0, 0])
	rotate([90, 0, 90])
	 {
		cdCase(pClear, "GhostWhite");

		translate([0, 0, brick_thickness + brick_width ])
		cdCase(pClear, "GhostWhite");

		translate([0, brick_thickness, brick_thickness ])
		rotate([90, 0, 0])
		cdCase(pClear, "GhostWhite");

		translate([0, brick_width, brick_thickness ])
		rotate([90, 0, 0])
		cdCase(pClear, "GhostWhite");
	}
}
//-----------------------------------------------------------------------------------------------
module cdCase(pClear=0, pColor="orange") {
	color(pColor)
	cube([brick_length+pClear, brick_width+pClear, brick_thickness+pClear]);
}
//-----------------------------------------------------------------------------------------------





