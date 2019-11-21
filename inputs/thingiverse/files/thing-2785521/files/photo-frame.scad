$fn = 60;

// model selector, possible values:
//   "all" (default), "frame", "stop", "holder", "title", "expander", "heart" or "tester"
MODEL = "all";

// photo width
PHOTO_WIDTH = 100;
// photo height
PHOTO_HEIGHT = 148;
// white border of the photo
PHOTO_BORDER = 4.5;

// the golden ratio, the split ratio should be greater than 0.5
// to make it assemblable
FRAME_SPLIT = 0.618;

// the frame border
FRAME_BORDER = 10;
// the frame thickness
FRAME_THICKNESS = 10;

// the frame inner corner radius
FRAME_INNER_CORNER_RADIUS = 3;
// the calculated frame outer corner radius
FRAME_OUTER_CORNER_RADIUS = FRAME_INNER_CORNER_RADIUS + FRAME_BORDER;

// the calculated frame inner width
FRAME_INNER_WIDTH = PHOTO_WIDTH - 2 * PHOTO_BORDER;
// the calculated frame inner height
FRAME_INNER_HEIGHT = PHOTO_HEIGHT - 2 * PHOTO_BORDER;

// the calculated frame outer width
FRAME_OUTER_WIDTH = FRAME_INNER_WIDTH + 2 * FRAME_BORDER;
// the calculated frame outer height
FRAME_OUTER_HEIGHT = FRAME_INNER_HEIGHT + 2 * FRAME_BORDER;

// the calculated splitted frame inner height part 1
FRAME_INNER_HEIGHT1 = round(FRAME_INNER_HEIGHT * FRAME_SPLIT);
// the calculated splitted frame inner height part 2
FRAME_INNER_HEIGHT2 = FRAME_INNER_HEIGHT - FRAME_INNER_HEIGHT1;

// the calculated splitted frame outer height part 1
FRAME_OUTER_HEIGHT1 = FRAME_BORDER + FRAME_INNER_HEIGHT1;
// the calculated splitted frame outer height part 2
FRAME_OUTER_HEIGHT2 = FRAME_BORDER + FRAME_INNER_HEIGHT2;

// the horizontal part width of the frame
FRAME_HORZ_WIDTH = FRAME_INNER_WIDTH - 2 * FRAME_INNER_CORNER_RADIUS;
// the vertical part height1 of the frame
FRAME_VERT_HEIGHT1 = FRAME_INNER_HEIGHT1 - FRAME_INNER_CORNER_RADIUS;
// the vertical part height2 of the frame
FRAME_VERT_HEIGHT2 = FRAME_INNER_HEIGHT2 - FRAME_INNER_CORNER_RADIUS;

// frame back horizontal ratio
BACK_HORZ_RATIO = 0.22;
// calculated back horizontal part width
BACK_HORZ_WIDTH = round(FRAME_INNER_WIDTH * BACK_HORZ_RATIO);
// frame back thickness
BACK_THICKNESS = 4;

// frame connector width
CNX_WIDTH = 5;
// frame connector height
CNX_HEIGHT = 6;
// compensation for inner connector width
CNX_WIDTH_COMP = 0.1;
// compensation for inner connector height
CNX_HEIGHT_COMP = 0.1;
// sloping down angle of the frame connector top face
CNX_SLOPING_ANGLE = 60;
// frame connector z-center offset from frame's z-center
CNX_ZOFFSET = 0.4;
// calculated short height for frame connector
CNX_HEIGHT2 = CNX_HEIGHT - CNX_WIDTH / tan(CNX_SLOPING_ANGLE);

// photo slot margin
SLOT_WIDTH_MARGIN = 1;
// photo slot width, the slot will go throught the whole height
SLOT_WIDTH = PHOTO_WIDTH + SLOT_WIDTH_MARGIN;
// photo slot thickness
SLOT_THICKNESS = 1;
// photo slot z-offset from bottom
SLOT_Z0 = BACK_THICKNESS;

// stop slot width
STOP_WIDTH = 30;
// stop slot height
STOP_HEIGHT = 3;
// stop slot depth
STOP_DEPTH = 5.5;
// width compensation for stop block
STOP_BLOCK_WIDTH_COMP = 0;
// height compensation for stop block
STOP_BLOCK_HEIGHT_COMP = -0.1;
// depth compensation for stop block
STOP_BLOCK_DEPTH_COMP = -0.2;
// calculated stop block width
STOP_BLOCK_WIDTH = STOP_WIDTH + STOP_BLOCK_WIDTH_COMP;
// calculated stop block height
STOP_BLOCK_HEIGHT = STOP_HEIGHT + STOP_BLOCK_HEIGHT_COMP;
// calculated stop block depth
STOP_BLOCK_DEPTH = STOP_DEPTH + STOP_BLOCK_DEPTH_COMP;

// expander width
EXPANDER_WIDTH = 8;
// expander height
EXPANDER_HEIGHT = 2;
// expander sloping angle
EXPANDER_SLOPING_ANGLE = 45;
// expander stop width at back
EXPANDER_STOP_WIDTH = 10;
// expander ensurence for difference
EXPANDER_ENSURENCE_DIMENSION = 1;
// calculated expected expander triangle height
EXPANDER_HEIGHT0 = EXPANDER_WIDTH*tan(EXPANDER_SLOPING_ANGLE)/2;
// calculated expander offset from the frame edge
EXPANDER_YOFFSET = round(FRAME_OUTER_HEIGHT / 3);

// expander block width compensation
EXPANDER_BLOCK_WIDTH_COMP = -0.5;
// expander block height compensation
EXPANDER_BLOCK_HEIGHT_COMP = -0.2;
// expander block and frame contact size
EXPANDER_BLOCK_CONTACT = 0.3;
// calculated expander block width
EXPANDER_BLOCK_WIDTH = EXPANDER_WIDTH + EXPANDER_BLOCK_WIDTH_COMP;
// calculated expander block height
EXPANDER_BLOCK_HEIGHT = EXPANDER_HEIGHT + EXPANDER_BLOCK_HEIGHT_COMP;
// calculated expander block top width
EXPANDER_BLOCK_WIDTH0 = EXPANDER_BLOCK_WIDTH-2*EXPANDER_BLOCK_HEIGHT/tan(EXPANDER_SLOPING_ANGLE);

// holder straight length
HOLDER_LENGTH = 80;
// holder radius
HOLDER_RADIUS = 6.8;
// holder border width
HOLDER_BORDER = 3;
// holder thickness
HOLDER_THICKNESS = 8;

// brim outside width, brim is used to hold the support for connector
BRIM_EXTRA_WIDTH = 3;
// brim outside height
BRIM_EXTRA_HEIGHT = 3;
// distance from brim edge to the frame edge
BRIM_TO_FRAME = 0.5;
// brim and frame contact point size
BRIM_CONTACT = 0.5;
// brim thickness
BRIM_THICKNESS = 0.5;

// title thickness
TITLE_THICKNESS = 4;
// title underline width
TITLE_UNDERLINE_WIDTH = 80;
// title underline height
TITLE_UNDERLINE_HEIGHT = 2;
// the overlapped dimension of the underline and the text
TITLE_UNDERLINE_OVERLAP = 0.1;
// the title text
TITLE_TEXT = "SPRING 2018";
// the font name
TITLE_FONT_NAME = "Arial";
// the font size
TITLE_FONT_SIZE = 9;

// thickness of the big heart
HEART_BIG_THICKNESS = 2;
// size of the big heart
HEART_BIG_SIZE = 16;
// rotation of the big heart
HEART_BIG_ROTATION = -30;
// thickness of the small heart
HEART_SMALL_THICKNESS = 3;
// size of the small heart
HEART_SMALL_SIZE = 12;
// rotation of the small heart
HEART_SMALL_ROTATION = 30;
// distance between two heart
HEART_DISTANCE_X = 10;
HEART_DISTANCE_Y = 1;

// tester length
TESTER_LENGTH = 30;
// tester cut width
TESTER_CUT_WIDTH = 1;
// tester cut left thickness
TESTER_CUT_LEFT = 1;

// fast coords
X1 = FRAME_HORZ_WIDTH / 2;
X2 = FRAME_INNER_WIDTH / 2;
X3 = FRAME_OUTER_WIDTH / 2;
Y1 = FRAME_BORDER;
Y2 = FRAME_OUTER_CORNER_RADIUS;
Y3 = FRAME_OUTER_HEIGHT1;
Y4 = FRAME_OUTER_HEIGHT2;
OR = FRAME_OUTER_CORNER_RADIUS;
IR = FRAME_INNER_CORNER_RADIUS;

echo(x1=X1, x2=X2, x3=X3, y1=Y1, y2=Y2, y3=Y3, y4=Y4, or=OR, ir=IR);

function arc(cx, cy, r, a0, a1) =
	[
		for(i = [0:$fn], a = (a1 - a0) * i / $fn + a0)
			[cx, cy] + r * [cos(a), sin(a)]
	];

// the basic border
module frame_border()
	linear_extrude(height=FRAME_THICKNESS)
		polygon(
			concat(
				[ [-X1, 0] ],
				arc(-X1, Y2, OR, 270, 180),
				[ [-X3, Y2], [-X3, Y3] ],
				[ [-X2, Y3], [-X2, Y2] ],
				arc(-X1, Y2, IR, 180, 270),
				[ [-X1, Y1], [X1, Y1] ],
				arc(X1, Y2, IR, 270, 360),
				[ [X2, Y2], [X2, Y4] ],
				[ [X3, Y4], [X3, Y2] ],
				arc(X1, Y2, OR, 360, 270),
				[ [X1, 0] ]
			)
		);

module frame_back()
	linear_extrude(height=BACK_THICKNESS)
		polygon(
			concat(
				[ [-X1, Y1] ],
				arc(-X1, Y2, IR, 270, 180),
				[ [-X2, Y3-CNX_WIDTH], [-X2+BACK_HORZ_WIDTH, Y3-CNX_WIDTH] ],
				[ [X2-BACK_HORZ_WIDTH, Y4+CNX_WIDTH], [X2, Y4+CNX_WIDTH] ],
				[ [X2, Y2] ],
				arc(X1, Y2, IR, 360, 270),
				[ [X1, Y1] ]
			)
		);

module frame_connector_common(wcomp, hcomp, zr)
	translate([0, 0, CNX_ZOFFSET+(FRAME_THICKNESS-CNX_HEIGHT-hcomp)/2])
		rotate([0, 0, zr])
		translate([FRAME_BORDER/2, CNX_WIDTH/2, 0])
		rotate([90, 0, -90])
		translate([-CNX_WIDTH/2, 0, -FRAME_BORDER/2])
			linear_extrude(height=FRAME_BORDER)
				polygon([
					[0,0],
					[CNX_WIDTH+wcomp, 0],
					[CNX_WIDTH+wcomp,
						CNX_HEIGHT+hcomp-(CNX_WIDTH+wcomp)/tan(CNX_SLOPING_ANGLE)],
					[0, CNX_HEIGHT+hcomp]
				]);

module frame_connector_outer()
	frame_connector_common(0, 0, 0);

module frame_connector_inner()
	frame_connector_common(CNX_WIDTH_COMP, CNX_HEIGHT_COMP, 180);

module frame_slot()
	translate([-SLOT_WIDTH/2, 0, SLOT_Z0])
		cube([SLOT_WIDTH, FRAME_OUTER_HEIGHT, SLOT_THICKNESS]);
module frame_stop()
	translate([-STOP_WIDTH/2, 0, SLOT_Z0 + SLOT_THICKNESS/2 - STOP_HEIGHT/2])
		cube([STOP_WIDTH, STOP_DEPTH, STOP_HEIGHT]);

module frame_expander_polygon(w)
	translate([0, -EXPANDER_HEIGHT/2, -w/2])
		linear_extrude(height=w)
			polygon([
				[-EXPANDER_WIDTH/2, 0],
				[0,EXPANDER_HEIGHT0],
				[EXPANDER_WIDTH/2,0]
			]);

module frame_expander_common(z0=0, xr=0, stop_width=EXPANDER_STOP_WIDTH)
	translate([0, 0, z0])
	rotate([xr,0,0])
		translate([0, 0, EXPANDER_HEIGHT/2])
		rotate([-90,0,90])
		difference() {
			frame_expander_polygon(FRAME_OUTER_WIDTH+EXPANDER_ENSURENCE_DIMENSION);
			frame_expander_polygon(stop_width);
		}
module frame_expander_top(stop_width=EXPANDER_STOP_WIDTH)
	frame_expander_common(FRAME_THICKNESS, 180, stop_width);

module frame_expander_bottom(stop_width=EXPANDER_STOP_WIDTH)
	frame_expander_common(0, 0, stop_width);
	
module frame_back_holes()
	union() {
		translate([20, 35])
			cylinder(r=13, h=FRAME_THICKNESS*2, center=true);
		translate([-25, 30])
			cylinder(r=18, h=FRAME_THICKNESS*2, center=true);
		translate([-10, 70])
			cylinder(r=10, h=FRAME_THICKNESS*2, center=true);
	};
	
module frame_brim()
	linear_extrude(height=BRIM_THICKNESS)
		polygon([
			[BRIM_TO_FRAME, BRIM_TO_FRAME],
			[FRAME_BORDER+BRIM_EXTRA_WIDTH, BRIM_TO_FRAME],
			[FRAME_BORDER+BRIM_EXTRA_WIDTH, CNX_WIDTH+BRIM_EXTRA_HEIGHT],
			[BRIM_TO_FRAME, CNX_WIDTH+BRIM_EXTRA_HEIGHT],
			[BRIM_TO_FRAME, CNX_WIDTH],
			[0, CNX_WIDTH],
			[0, CNX_WIDTH-BRIM_CONTACT],
			[BRIM_TO_FRAME, CNX_WIDTH-BRIM_CONTACT]
		]);

module model_frame(with_brim=true)
	// frame with both connectors
	difference() {
		// frame with outer connector
		union() {
			frame_border();
			difference() {
				frame_back();
				// back hole
				//frame_back_holes();
			}
			translate([X2,Y4])
				frame_connector_outer();
			// brim for support
			if(with_brim)
				translate([X2, Y4, 0])
					frame_brim();
		};
		// inner connector to remove
		translate([-X2,Y3])
			frame_connector_inner();
		// slot to remove
		frame_slot();
		// stop slot to remove
		frame_stop();
		// expanders
		translate([0, EXPANDER_YOFFSET, 0])
			frame_expander_top();
		translate([0, EXPANDER_YOFFSET, 0])
			frame_expander_bottom();
	}

module model_stop()
	translate([-STOP_BLOCK_WIDTH/2, -STOP_BLOCK_DEPTH, 0])
		cube([STOP_BLOCK_WIDTH, STOP_BLOCK_DEPTH, STOP_BLOCK_HEIGHT]);

module expander_block_head(h)
	linear_extrude(height=h)
		polygon([
			[-EXPANDER_BLOCK_WIDTH0/2, 0],
			[-EXPANDER_BLOCK_WIDTH0/2, -EXPANDER_BLOCK_CONTACT],
			[-EXPANDER_BLOCK_WIDTH/2, -EXPANDER_BLOCK_CONTACT-EXPANDER_BLOCK_HEIGHT],
			[EXPANDER_BLOCK_WIDTH/2, -EXPANDER_BLOCK_CONTACT-EXPANDER_BLOCK_HEIGHT],
			[EXPANDER_BLOCK_WIDTH0/2, -EXPANDER_BLOCK_CONTACT],
			[EXPANDER_BLOCK_WIDTH0/2, 0]
		]);

module expander_block_head_horz(h)
	translate([0, 0, EXPANDER_BLOCK_HEIGHT+EXPANDER_BLOCK_CONTACT])
		rotate([90,0,0])
			expander_block_head(h=FRAME_BORDER);

module model_holder()
	union() {
		expander_block_head(HOLDER_THICKNESS);
		linear_extrude(height=HOLDER_THICKNESS)
			difference() {
				polygon(
					concat(
					[ [-HOLDER_RADIUS, 0], [-HOLDER_RADIUS, HOLDER_LENGTH], ],
					arc(0, HOLDER_LENGTH, HOLDER_RADIUS, 180, 0),
					[ [HOLDER_RADIUS, HOLDER_LENGTH], [HOLDER_RADIUS, 0] ]
				));
				polygon(
					concat(
						[
							[-HOLDER_RADIUS+HOLDER_BORDER, HOLDER_BORDER],
							[-HOLDER_RADIUS+HOLDER_BORDER, HOLDER_LENGTH-HOLDER_BORDER]
						],
						arc(0, HOLDER_LENGTH, HOLDER_RADIUS-HOLDER_BORDER, 180, 0),
						[
							[HOLDER_RADIUS-HOLDER_BORDER, HOLDER_LENGTH-HOLDER_BORDER],
							[HOLDER_RADIUS-HOLDER_BORDER, HOLDER_BORDER]
						]
					)
				);
			}
	}

module model_title()
	union() {
		model_stop();
		
		linear_extrude(height=TITLE_THICKNESS)
			union() {
				translate([-TITLE_UNDERLINE_WIDTH/2, 0, 0])
					square(size=[TITLE_UNDERLINE_WIDTH, TITLE_UNDERLINE_HEIGHT]);
				translate([0, TITLE_UNDERLINE_HEIGHT-TITLE_UNDERLINE_OVERLAP, 0])
					text(text=TITLE_TEXT,
						size=TITLE_FONT_SIZE,
						font=TITLE_FONT_NAME,
						halign="center");
			}
	}

module model_expander()
	expander_block_head_horz();

module heart(size)
	rotate([0, 0, 45])
		translate([-size/2, -size/2])
			union() {
				square(size);

				translate([size/2, size, 0])
					circle(size/2);

				translate([size, size/2, 0])
					circle(size/2);
			}

module heart_big()
	translate([HEART_DISTANCE_X, HEART_DISTANCE_Y, 0])
		rotate([0, 0, HEART_BIG_ROTATION])
			difference() {
				heart(HEART_BIG_SIZE);
				heart(HEART_SMALL_SIZE);
			}

module heart_small()
	translate([0, 0, 0])
		rotate([0, 0, HEART_SMALL_ROTATION])
			heart(HEART_SMALL_SIZE);
		
module model_heart()
	union() {
		linear_extrude(height=HEART_BIG_THICKNESS)
			difference() {
				heart_big();
				heart_small();
			}

		linear_extrude(height=HEART_SMALL_THICKNESS)
			heart_small();

		translate([EXPANDER_WIDTH/2, 0, -EXPANDER_HEIGHT])
			rotate([0, 0, -90])
				expander_block_head_horz();
	}

module model_tester()
	difference() {
		union() {
			// base shape
			cube([FRAME_BORDER, TESTER_LENGTH, FRAME_THICKNESS]);
			// outer connector
			translate([0, TESTER_LENGTH, 0])
				frame_connector_outer();
			// brim
			translate([0, TESTER_LENGTH, 0])
				union() {
					frame_brim();
					translate([BRIM_TO_FRAME, 0, 0])
					cube([BRIM_CONTACT, BRIM_TO_FRAME, BRIM_THICKNESS]);
				}
			// expander block header
			translate([0, CNX_WIDTH+EXPANDER_BLOCK_WIDTH/2, 0])
				rotate([0, 0, -90])
					expander_block_head_horz(h=FRAME_BORDER);
		}

		// cut
		translate([-1, TESTER_LENGTH/2, TESTER_CUT_LEFT])
			cube([FRAME_BORDER+1, TESTER_CUT_WIDTH, FRAME_THICKNESS-TESTER_CUT_LEFT+1]);
		// inner connector
		rotate([0, 0, 180])
			frame_connector_inner();
		
		// expander slot
		translate([0, TESTER_LENGTH*0.75, 0])
			frame_expander_top(0);
		translate([0, TESTER_LENGTH*0.75, 0])
			frame_expander_bottom(0);
	}

module model_all()
	union() {
		// frame part 1
		color("lightgrey")
			model_frame(false);
		// frame part 2
		color("orange")
			translate([0, FRAME_OUTER_HEIGHT, 0])
				rotate([0, 0, 180])
					model_frame(false);
		// title
		color("orange")
			translate([0, 0, SLOT_Z0 + SLOT_THICKNESS/2 - STOP_BLOCK_HEIGHT/2])
				rotate([0, 0, 180])
					model_title();
		
		// stop
		color("lightgrey")
			translate([0, FRAME_OUTER_HEIGHT, SLOT_Z0 + SLOT_THICKNESS/2 - STOP_BLOCK_HEIGHT/2])
				rotate([0, 0, 0])
					model_stop();
		// holder
		color("lightgrey")
			translate([-EXPANDER_STOP_WIDTH/2, FRAME_OUTER_HEIGHT-EXPANDER_YOFFSET, 0])
				rotate([-90, 0, 90])
					model_holder();
		// heart
		color("orange")
			translate([-FRAME_OUTER_WIDTH/2+EXPANDER_WIDTH/2, EXPANDER_YOFFSET, FRAME_THICKNESS])
				rotate([0, 0, 180])
					model_heart();
	}
	
if(MODEL == "frame")
	model_frame();
else if(MODEL == "stop")
	model_stop();
else if(MODEL == "holder")
	model_holder();
else if(MODEL == "title")
	model_title();
else if(MODEL == "expander")
	model_expander();
else if(MODEL == "heart")
	model_heart();
else if(MODEL == "tester")
	model_tester();
else
	model_all();
