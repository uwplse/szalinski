//.scad by MegaSaturnv 2019-06-04
//Please include A10M_Geetech_Logo.stl in the same folder as this scad file. An stl of the logo by Kanawati can be downloaded from here: https://www.thingiverse.com/thing:3163963

$fn = 96;

/* [Basic] */
//Vertical distance between the screws
COVER_SCREW_SEPARATION_WIDTH = 31;

//Horizonal distance between the screws
COVER_SCREW_SEPARATION_HEIGHT = 31;

//Distance from centre of screw hole to the edge
COVER_SCREW_MARGIN = 5;

//Thickness of the cover
COVER_THICKNESS = 1.2;

//Scale the logo in the vertical axis
LOGO_SCALE_VERTICAL = 2;

/* [Advanced] */
//Radius of the curves at the corners
COVER_CURVE_RADIUS = 5;

//Diameter of the screw holes
COVER_SCREW_M = 3;

//Diameter of the countersink holes
COVER_SCREW_COUNTERSINK_RADIUS = COVER_SCREW_M/2 + 1.7;

//Depth of the countersink holes
COVER_SCREW_COUNTERSINK_DEPTH = 2.5;

//Distance to lower the logo so its base is on the XY plane. Arbitrary.
LOGO_DROP_TO_0Z = 0.337183;

//66.7mm Measured from A10M_Geetech_Logo.stl file
LOGO_WIDTH = 66.7;

//50.4mm Measured from A10M_Geetech_Logo.stl file
LOGO_HEIGHT = 50.4;

//Scale of the logo. number at the end represents a proportion of the cover width. e.g. 0.8 = 80% of the cover width.
LOGO_SCALE = (COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN*2) / LOGO_WIDTH * 0.75;

//Logo X position offset. 0 = centre
LOGO_POS_OFFSET_X = 0;

//Logo Y position offset. 0 = centre
LOGO_POS_OFFSET_Y = 0;

module antiCorner(radius=1, height=1) {
	difference() {
		cube([radius+0.01, radius, height]);
		translate([radius, radius, 0]) cylinder(r=radius, h=height);
	}
}

difference() {
	union() {
		//Main body
		cube([COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN*2, COVER_SCREW_SEPARATION_HEIGHT + COVER_SCREW_MARGIN*2, COVER_THICKNESS]);
		
		//Logo
		translate([LOGO_WIDTH*LOGO_SCALE/-2,          LOGO_HEIGHT*LOGO_SCALE/-2,         COVER_THICKNESS-(LOGO_DROP_TO_0Z*LOGO_SCALE_VERTICAL)])
		translate([(COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN*2)/2 + LOGO_POS_OFFSET_X, (COVER_SCREW_SEPARATION_HEIGHT + COVER_SCREW_MARGIN*2)/2 + LOGO_POS_OFFSET_Y, 0])
		scale(LOGO_SCALE) scale([1, 1, LOGO_SCALE_VERTICAL])
		import("A10M_Geetech_Logo.stl");
	}
	//Rounded corners
	//Bottom left
	antiCorner(COVER_CURVE_RADIUS, COVER_THICKNESS);
	//Bottom right
	translate([COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN*2, 0, 0]) rotate([0, 0, 90]) antiCorner(COVER_CURVE_RADIUS, COVER_THICKNESS);
	//Top left
	translate([0, COVER_SCREW_SEPARATION_HEIGHT + COVER_SCREW_MARGIN*2, 0]) rotate([0, 0, 270]) antiCorner(COVER_CURVE_RADIUS, COVER_THICKNESS);
	//Top right
	translate([COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN*2, COVER_SCREW_SEPARATION_HEIGHT + COVER_SCREW_MARGIN*2, 0]) rotate([0, 0, 180]) antiCorner(COVER_CURVE_RADIUS, COVER_THICKNESS);

	//Screw holes
	//Bottom left
	translate([COVER_SCREW_MARGIN, COVER_SCREW_MARGIN, 0]) cylinder(r=COVER_SCREW_M/2, h=COVER_THICKNESS);
	//Bottom right
	translate([COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN, COVER_SCREW_MARGIN, 0]) cylinder(r=COVER_SCREW_M/2, h=COVER_THICKNESS);
	//Top left
	translate([COVER_SCREW_MARGIN, COVER_SCREW_SEPARATION_HEIGHT + COVER_SCREW_MARGIN, 0]) cylinder(r=COVER_SCREW_M/2, h=COVER_THICKNESS);
	//Top right
	translate([COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN, COVER_SCREW_SEPARATION_HEIGHT + COVER_SCREW_MARGIN, 0]) cylinder(r=COVER_SCREW_M/2, h=COVER_THICKNESS);

	//Screw countersink holes
	//Bottom left
	translate([COVER_SCREW_MARGIN, COVER_SCREW_MARGIN, COVER_THICKNESS - COVER_SCREW_COUNTERSINK_DEPTH]) cylinder(h=COVER_SCREW_COUNTERSINK_DEPTH, r1=COVER_SCREW_M/2, r2=COVER_SCREW_COUNTERSINK_RADIUS);
	//Bottom right
	translate([COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN, COVER_SCREW_MARGIN, COVER_THICKNESS - COVER_SCREW_COUNTERSINK_DEPTH]) cylinder(h=COVER_SCREW_COUNTERSINK_DEPTH, r1=COVER_SCREW_M/2, r2=COVER_SCREW_COUNTERSINK_RADIUS);
	//Top left
	translate([COVER_SCREW_MARGIN, COVER_SCREW_SEPARATION_HEIGHT + COVER_SCREW_MARGIN, COVER_THICKNESS - COVER_SCREW_COUNTERSINK_DEPTH]) cylinder(h=COVER_SCREW_COUNTERSINK_DEPTH, r1=COVER_SCREW_M/2, r2=COVER_SCREW_COUNTERSINK_RADIUS);
	//Top right
	translate([COVER_SCREW_SEPARATION_WIDTH + COVER_SCREW_MARGIN, COVER_SCREW_SEPARATION_HEIGHT + COVER_SCREW_MARGIN, COVER_THICKNESS - COVER_SCREW_COUNTERSINK_DEPTH]) cylinder(h=COVER_SCREW_COUNTERSINK_DEPTH, r1=COVER_SCREW_M/2, r2=COVER_SCREW_COUNTERSINK_RADIUS);
}
