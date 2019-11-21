/* bezier.scad */

function flatten(l) = [ for (a = l) for (b = a) b ] ;
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PtOnBez2D(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]
];

function PtOnBez3d(cps, u) = 
	[BEZ03(u)*cps[0][0]+BEZ13(u)*cps[1][0]+BEZ23(u)*cps[2][0]+BEZ33(u)*cps[3][0],
	BEZ03(u)*cps[0][1]+BEZ13(u)*cps[1][1]+BEZ23(u)*cps[2][1]+BEZ33(u)*cps[3][1],
	BEZ03(u)*cps[0][2]+BEZ13(u)*cps[1][2]+BEZ23(u)*cps[2][2]+BEZ33(u)*cps[3][2]];


function BezierCurve(points, steps=10) =
    flatten([
        for (p = points)
            (len(p) == 2) ? [p] :
            (len(p) == 3) ? BezierPoints([p[0], p[1], p[1], p[2]], steps) :
            (len(p) == 4) ? BezierPoints([p[0], p[1], p[2], p[3]], steps) :
            []
    ]);

function BezierPoints(c, steps) =
    [ for(step = [0:steps])
        PtOnBez2D(c[0], c[1], c[2], c[3], step/steps)
    ];





/* [General] */

// Pick a phone, I added a few recent ones. If you look up dimensions for your phone please drop me a note and I'll add it
PHONE_TYPE = "iph6s"; // [iph6:iPhone 6, iph6p:iPhone 6 Plus, iph6s:iPhone 6[s], iph6sp: iPhone 6[s] Plus, ss6:Samsung Galaxy s6, ss6e:Samsung Galaxy s6 edge, ss7:Samsung Galaxy s7, ss7e:Samsung Galaxy s7 edge, other:Other (see "Custom" below")]

// If the case is a bit too thin or thick, or if you have an existing case and want to just use this as a mount add some positive or negative padding here (in mm)
CASE_PADDING = 0;

// Would you like the top corners to be closed or side-only? slide-in only cases are great if you plan to remove the phone frequently
CORNERS_CLOSED = 1; // [0:Slide-In, 1:Closed Top Corners]

// Case thickness (in mm)
CASE_THICKNESS = 3;

// Prints a space for your to glue a mount to (I can't print it on the model without tons of supports, etc)
PRINT_MOUNT = 0;

// The width of the lip that curls over the top edge of the phone
LIP_DEPTH = 2;

// The legth of the clips on the sides
SIDE_CLIP_LENGTH = 25;

// The width of the center panel as a % of total width
CENTER_WIDTHP = 40; // [10:100]

// The height of the center panel as a % of total height
CENTER_LENGTHP = 40; // [10:100]

// The width of the arms (in mm)
ARM_WIDTH = 9;

// The width that each corner comes out from the corner (in mm)
CORNER_WIDTH = 20;

// How far to drop the top corners.  Ignored if CORNERS_CLOSED
// is set
TOP_CORNER_DROP_DISTANCE = 10;

/* [Custom] */

// All sizes are in mm
PHONE_WIDTH   = 74.5;
PHONE_LENGTH  = 146;
PHONE_HEIGHT  = 10;
INNER_RADIUS  = 2;
OUTER_RADIUS  = 2;
CORNER_RADIUS = 10;
MOUNT_WIDTH   = 23;
MOUNT_LENGTH  = 45;
MOUNT_DEPTH   = 1;

/* [HIDDEN] */

p_iph6   = [67,   138.1, 6.9, 5, 2, 2];
p_iph6p  = [77.8, 158.1, 7.1, 5, 2, 2];
p_iph6s  = [67.1, 138.3, 7.1, 5, 2, 2];
p_iph6sp = [77.9, 158.2, 7.3, 5, 2, 2];
p_ss6    = [70.5, 143.4, 6.8, 5, 2, 2];
p_ss6e   = [70.1, 142.1, 7,   5, 2, 2];
p_ss7    = [69.6, 142.4, 7.9, 5, 2, 2];
p_ss7e   = [72.6, 150.9, 7.7, 5, 2, 2];
p_custom = [PHONE_WIDTH, PHONE_LENGTH, PHONE_HEIGHT, CORNER_RADIUS, INNER_RADIUS, OUTER_RADIUS];

dimensions = PHONE_TYPE == "iph6"   ? p_iph6   :
             PHONE_TYPE == "iph6p"  ? p_iph6p  :
             PHONE_TYPE == "iph6s"  ? p_iph6s  :
             PHONE_TYPE == "iph6sp" ? p_iph6sp :
             PHONE_TYPE == "ss6"    ? p_ss6    :
             PHONE_TYPE == "ss6e"   ? p_ss6    :
             PHONE_TYPE == "ss7"    ? p_ss7    :
             PHONE_TYPE == "ss7e"   ? p_ss7e   :
             p_custom;

DIMENSIONS = [
  dimensions[0] + CASE_PADDING,
  dimensions[1] + CASE_PADDING,
  dimensions[2] + CASE_PADDING
];

OUTER_DIMENSIONS = [
  DIMENSIONS[0] + 2 * CASE_THICKNESS,
  DIMENSIONS[1] + 2 * CASE_THICKNESS,
  DIMENSIONS[2] + 2 * CASE_THICKNESS
];

CENTER_W = OUTER_DIMENSIONS[0] * CENTER_WIDTHP  / 100;
CENTER_L = OUTER_DIMENSIONS[1] * CENTER_LENGTHP / 100;
CENTER_X0 = (100 - CENTER_WIDTHP)  / 200 * OUTER_DIMENSIONS[0];
CENTER_Y0 = (100 - CENTER_LENGTHP) / 200 * OUTER_DIMENSIONS[1];
CENTER_X1 = CENTER_X0 + CENTER_W;
CENTER_Y1 = CENTER_Y0 + CENTER_L;
echo(OUTER_DIMENSIONS, [CENTER_X0, CENTER_Y0], [CENTER_X1, CENTER_Y1]);

ARM_ANGLE    = atan((CENTER_X0 - CASE_THICKNESS) / (CENTER_Y0 - CASE_THICKNESS));
ARM_Y_THICK  = ARM_WIDTH / sin(ARM_ANGLE); // how wide any corner arm is in the Y direction
ARM_X_THICK  = ARM_WIDTH / cos(ARM_ANGLE); // how wide any corner arm is in the X direction

CTRL_PT_X  = CASE_THICKNESS + ARM_X_THICK;
CTRL_PT_Y  = CASE_THICKNESS + ARM_Y_THICK;
CTRL_PT_X2 = CASE_THICKNESS + ARM_X_THICK/2;
CTRL_PT_Y2 = CASE_THICKNESS + ARM_Y_THICK/2;

INX0  = CASE_THICKNESS;
INX1  = CASE_THICKNESS + DIMENSIONS[0];
INY0  = CASE_THICKNESS;
INY1  = CASE_THICKNESS + DIMENSIONS[1];
OUTX0 = 0;
OUTX1 = OUTER_DIMENSIONS[0];
OUTY0 = 0;
OUTY1 = OUTER_DIMENSIONS[1];

MID_Y1 = OUTER_DIMENSIONS[1]/2 - ARM_WIDTH/2;
MID_Y2 = MID_Y1 + ARM_WIDTH;
MID_Y0 = MID_Y1 - SIDE_CLIP_LENGTH/2 + ARM_WIDTH/2;
MID_Y3 = MID_Y2 + SIDE_CLIP_LENGTH/2 - ARM_WIDTH/2;

// Draw the base
pts = [
    // TOP LEFT
    [
        [CENTER_X0, CENTER_Y0 + ARM_Y_THICK],
        [CENTER_X0, CENTER_Y0 + ARM_Y_THICK/2],
        [CENTER_X0 - ARM_X_THICK/2, CENTER_Y0],
    ],
    [
      [INX0 + ARM_X_THICK/2, INY0 + ARM_Y_THICK],
      [INX0, INY0 + ARM_Y_THICK/2],
      [INX0, min(INY0 + ARM_Y_THICK, OUTY0 + CORNER_WIDTH)],
    ],
    [INX0, OUTY0 + CORNER_WIDTH],
    [OUTX0, OUTY0 + CORNER_WIDTH],
    [OUTX0, OUTY0],
    [OUTX0 + CORNER_WIDTH, OUTY0],
    [OUTX0 + CORNER_WIDTH, INY0],
    [
      [min(INX0 + ARM_X_THICK, OUTX0 + CORNER_WIDTH), INY0],
      [INX0 + ARM_X_THICK/2, INY0],
      [INX0 + ARM_X_THICK, INY0 + ARM_Y_THICK/2],
    ],
    [
      [CENTER_X0, CENTER_Y0 - ARM_Y_THICK/2],
      [CENTER_X0 + ARM_X_THICK/2, CENTER_Y0],
      [CENTER_X0 + ARM_X_THICK, CENTER_Y0],
    ],
    
    // TOP RIGHT
    [
      [CENTER_X1 - ARM_X_THICK, CENTER_Y0],
      [CENTER_X1 - ARM_X_THICK/2, CENTER_Y0],
      [CENTER_X1, CENTER_Y0 - ARM_Y_THICK/2],
    ],
    [
      [INX1 - ARM_X_THICK, INY0 + ARM_Y_THICK/2],
      [INX1 - ARM_X_THICK/2, INY0],
      [max(INX1 - ARM_X_THICK, OUTX1 - CORNER_WIDTH), INY0],
    ],
    [OUTX1 - CORNER_WIDTH, INY0],
    [OUTX1 - CORNER_WIDTH, OUTY0],
    [OUTX1, OUTY0],
    [OUTX1, OUTY0 + CORNER_WIDTH],
    [INX1, OUTY0 + CORNER_WIDTH],
    [
      [INX1, min(INY0 + ARM_Y_THICK, OUTY0 + CORNER_WIDTH)],
      [INX1, INY0 + ARM_Y_THICK/2],
      [INX1 - ARM_X_THICK/2, INY0 + ARM_Y_THICK],
    ],
    [
        [CENTER_X1 + ARM_X_THICK/2, CENTER_Y0],
        [CENTER_X1, CENTER_Y0 + ARM_Y_THICK/2],
        [CENTER_X1, CENTER_Y0 + ARM_Y_THICK],
    ],
    
    // RIGHT
    [
        [CENTER_X1, MID_Y1 - ARM_WIDTH/2],
        [CENTER_X1, MID_Y1],
        [CENTER_X1 + ARM_WIDTH/2, MID_Y1],
    ],
    [
        [INX1 - ARM_WIDTH/2, MID_Y1],
        [INX1, MID_Y1],
        [INX1, MID_Y1 - ARM_WIDTH/2],
    ],
    [INX1, MID_Y0],
    [OUTX1, MID_Y0],
    [OUTX1, MID_Y3],
    [INX1, MID_Y3],
    [
        [INX1, MID_Y2 + ARM_WIDTH/2],
        [INX1, MID_Y2],
        [INX1 - ARM_WIDTH/2, MID_Y2],
    ],
    [
        [CENTER_X1 + ARM_WIDTH/2, MID_Y2],
        [CENTER_X1, MID_Y2],
        [CENTER_X1, MID_Y2 + ARM_WIDTH/2],
    ],
    
    // BOTTOM RIGHT
    [
        [CENTER_X1, CENTER_Y1 - ARM_Y_THICK],
        [CENTER_X1, CENTER_Y1 - ARM_Y_THICK/2],
        [CENTER_X1 + ARM_X_THICK/2, CENTER_Y1],
    ],
    [
        [INX1 - ARM_X_THICK/2, INY1 - ARM_Y_THICK],
        [INX1, INY1 - ARM_Y_THICK/2],
        [INX1, max(INY1 - ARM_Y_THICK, OUTY1 - CORNER_WIDTH)],
    ],
    [INX1, OUTY1 - CORNER_WIDTH],
    [OUTX1, OUTY1 - CORNER_WIDTH],
    [OUTX1, OUTY1],
    [OUTX1 - CORNER_WIDTH, OUTY1],
    [OUTX1 - CORNER_WIDTH, INY1],
    [
        [max(INX1 - ARM_X_THICK, OUTX1 - CORNER_WIDTH), INY1],
        [INX1 - ARM_X_THICK/2, INY1],
        [INX1 - ARM_X_THICK, INY1 - ARM_Y_THICK/2],
    ],
    [
        [CENTER_X1, CENTER_Y1 + ARM_Y_THICK/2],
        [CENTER_X1 - ARM_X_THICK/2, CENTER_Y1],
        [CENTER_X1 - ARM_X_THICK, CENTER_Y1],
    ],
    
    // BOTTOM LEFT
    [
        [CENTER_X0 + ARM_X_THICK, CENTER_Y1],
        [CENTER_X0 + ARM_X_THICK/2, CENTER_Y1],
        [CENTER_X0, CENTER_Y1 + ARM_Y_THICK/2],
    ],
    [
        [INX0 + ARM_X_THICK, INY1 - ARM_Y_THICK/2],
        [INX0 + ARM_X_THICK/2, INY1],
        [min(INX0 + ARM_X_THICK, OUTX0 + CORNER_WIDTH), INY1],
    ],
    [OUTX0 + CORNER_WIDTH, INY1],
    [OUTX0 + CORNER_WIDTH, OUTY1],
    [OUTX0, OUTY1],
    [OUTX0, OUTY1 - CORNER_WIDTH],
    [INX0, OUTY1 - CORNER_WIDTH],
    [
        [INX0, max(INY1 - ARM_Y_THICK, OUTY1 - CORNER_WIDTH)],
        [INX0, INY1 - ARM_Y_THICK/2],
        [INX0 + ARM_X_THICK/2, INY1 - ARM_Y_THICK],
    ],
    [
      [CENTER_X0 - ARM_X_THICK/2, CENTER_Y1],
      [CENTER_X0, CENTER_Y1 - ARM_Y_THICK/2],
      [CENTER_X0, CENTER_Y1 - ARM_Y_THICK],
    ],

    // RIGHT
    [
      [CENTER_X0, MID_Y2 + ARM_WIDTH/2],
      [CENTER_X0, MID_Y2],
      [CENTER_X0 - ARM_WIDTH/2, MID_Y2],
    ],
    [
      [INX0 + ARM_WIDTH/2, MID_Y2],
      [INX0, MID_Y2],
      [INX0, MID_Y2 + ARM_WIDTH/2],
    ],
    [INX0, MID_Y3],
    [OUTX0, MID_Y3],
    [OUTX0, MID_Y0],
    [INX0, MID_Y0],
    [
      [INX0, MID_Y1 - ARM_WIDTH/2],
      [INX0, MID_Y1],
      [INX0 + ARM_WIDTH/2, MID_Y1],
    ],
    [
        [CENTER_X0 - ARM_WIDTH/2, MID_Y1],
        [CENTER_X0, MID_Y1],
        [CENTER_X0, MID_Y1 - ARM_WIDTH/2],
    ],
];

$fn = 50;

module rounded_cube(w,h,d,dia){
    hull(){
        d2 = dia/2;
        translate([d2,d2,d2]) sphere(d=dia);
        translate([d2,h-d2,d-d2]) sphere(d=dia);
        translate([w-d2,d2,d-d2]) sphere(d=dia);
        translate([w-d2,h-d2,d2]) sphere(d=dia);
        translate([w-d2,h-d2,d-d2]) sphere(d=dia);
        translate([d2,d2,d-d2]) sphere(d=dia);
        translate([w-d2,d2,d2]) sphere(d=dia);
        translate([d2,h-d2,d2]) sphere(d=dia);
    }
}

bPts = BezierCurve(pts, 50);

intersection() {
    difference() {
        union() {
            linear_extrude(height = OUTER_DIMENSIONS[2]) {
                polygon(points=bPts);
            }
            translate([0, 0, CASE_THICKNESS + dimensions[2] - dimensions[4]]) {
                cube([OUTER_DIMENSIONS[0], OUTER_DIMENSIONS[1], CASE_THICKNESS + dimensions[4]]);
            }
        }
        translate([CASE_THICKNESS, CASE_THICKNESS, CASE_THICKNESS]) {
            rounded_cube(dimensions[0], dimensions[1], dimensions[2], dimensions[4]);
        }
        translate([CASE_THICKNESS + LIP_DEPTH, CASE_THICKNESS + LIP_DEPTH, CASE_THICKNESS]) {
            cube([dimensions[0] - 2*LIP_DEPTH, dimensions[1] - 2*LIP_DEPTH, OUTER_DIMENSIONS[2]]);
        }
        difference() {
            translate([-1, CORNER_WIDTH, CASE_THICKNESS]) {
                difference() {
                    cube([OUTER_DIMENSIONS[0] + 2, OUTER_DIMENSIONS[1] - 2*CORNER_WIDTH, OUTER_DIMENSIONS[2]]);
                }
            }
            translate([0, OUTER_DIMENSIONS[1]/2 - SIDE_CLIP_LENGTH/2, 0]){
                cube([OUTER_DIMENSIONS[0] + 2, SIDE_CLIP_LENGTH, OUTER_DIMENSIONS[2]]);
            }
        }
        translate([CORNER_WIDTH, -1, CASE_THICKNESS]) {
            cube([OUTER_DIMENSIONS[0] - 2 * CORNER_WIDTH, OUTER_DIMENSIONS[1] + 2, OUTER_DIMENSIONS[2]]);
        }
        if (CORNERS_CLOSED == 0) {
            translate([-1, -1, -1]) {
                cube([OUTER_DIMENSIONS[0] + 2, dimensions[4] + CASE_THICKNESS + LIP_DEPTH + 1, OUTER_DIMENSIONS[2] + 2]);
            }
        }
        if (PRINT_MOUNT) {
            translate([OUTER_DIMENSIONS[0]/2 - MOUNT_WIDTH/2, OUTER_DIMENSIONS[1]/2 - MOUNT_LENGTH/2, -1]) {
                cube([MOUNT_WIDTH, MOUNT_LENGTH, MOUNT_DEPTH+1]);
            }
        }
    }
    rounded_cube(OUTER_DIMENSIONS[0], OUTER_DIMENSIONS[1], OUTER_DIMENSIONS[2], dimensions[4]);
}