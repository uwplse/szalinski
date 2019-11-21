
//CUSTOMIZER VARIABLES
/* [Rim] */
// measured from the lower end of the inside bite curve. 
rim_diameter = 29; // [ 25: 0.984in / 25mm,   25.5: 1.004in / 25.5mm,   26: 1.024in / 26mm,   26.5: 1.043in / 26.5mm,   27: 1.063in / 27mm,   27.5: 1.083in / 27.5mm,   28: 1.102in / 28mm,   28.5: 1.122in / 28.5mm,   29: 1.142in / 29mm,   29.5: 1.161in / 29.5mm,   30: 1.181in / 30mm,   30.5: 1.201in / 30.5mm,   31: 1.220in / 31mm,   31.5: 1.240in / 31.5mm,   32: 1.260in / 32mm ]

// sets the position of a couple bezier control points on the rim curve (higher value means that the surface that meets your embouchure is more rounded):
rim_curvature = 3; // [1:6]

// is also affected by the rim curvature.
inside_bite = 0.1; // [0.0:super-sharp, 0.05:sharp, 0.1:medium, 0.2:soft]

// and the following parameters control the profile of the outer portion of the rim
rim_thickness = 6; // [3: ouch!, 4:narrow, 5:normal, 6:wide, 7:that's a thick rim!]
outside_bite = 0.35; // [0.1:super-sharp, 0.2:sharp, 0.35:medium, 0.5:soft]
outside_shoulder_slope = 0.3; // [0:not sloped, 0.3:slight slope, 0.65:sloped, 0.99:very sloped]


rimInnerDiameter = rim_diameter;

/* [Shank] */


// distance from the rim to the top of the didj pipe
transitionLength = 25;//[10:75]

// outer diameter of pipe
didjOuterDiameter = 48.3;

// inner diameter of pipe
didjInnerDiameter = 40;

shankWallThickness = 3.36; // [ 1.68: 4 layers,  2.1: 5 layers,  2.52: 6 layers,  2.94: 7 layers,  3.36: 8 layers,  3.78: 9 layers,  4.2: 10 layers ]

// length of portion that overlaps the outside of the pipe
shankLen = 15;//[10:30]

/* [Printer] */

// adjust inside diameters to compensate for printer ooze
printer_spooge_factor = 0.35;//[0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5]

// generate easy-to-remove supports in the model; otherwise limit to 45 deg overhangs
printSupport = 0; // [0:no, 1:yes]

// only used when printing with support
layerHeight = 0.3;//[0.1, 0.15, 0.2, 0.25, 0.3]

$fn = 90;


/* [Hidden] */

didjOR = didjOuterDiameter/2 + printer_spooge_factor;
didjIR = didjInnerDiameter/2 + printer_spooge_factor;
rimIR = rimInnerDiameter/2 + printer_spooge_factor;
rimOR = rimIR + rim_thickness;

rimIR = rim_diameter/2 + printer_spooge_factor;
rimOR = rimIR + rim_thickness;

insideX = rim_thickness*inside_bite;
outsideX = rim_thickness*outside_bite;
bite=1;
rimWid = rim_thickness * (1 - inside_bite - outside_bite) * 0.25;

pRim = [
  [rimOR, transitionLength - outsideX], // 0
  [rimOR - (outsideX*outside_shoulder_slope), transitionLength+rim_curvature/2], // 1
  [rimIR + insideX, transitionLength+rim_curvature/2], // 2
  [rimIR, transitionLength], // 3
  [rimIR, transitionLength], // 4
  [rimIR, transitionLength-insideX] // 5
];

bottomY = printSupport ? 0 : didjOR-didjIR;

rotate_extrude() 
  polygon([
    [didjOR,0],
  	[didjIR, bottomY],
  	[rimIR, pRim[0][1]-0.25],

    PointAlongBez6(pRim, (25-0)/25),
    PointAlongBez6(pRim, (25-1)/25),
    PointAlongBez6(pRim, (25-2)/25),
    PointAlongBez6(pRim, (25-3)/25),
    PointAlongBez6(pRim, (25-4)/25),
    PointAlongBez6(pRim, (25-5)/25),
    PointAlongBez6(pRim, (25-6)/25),
    PointAlongBez6(pRim, (25-7)/25),
    PointAlongBez6(pRim, (25-8)/25),
    PointAlongBez6(pRim, (25-9)/25),
    PointAlongBez6(pRim, (25-10)/25),
    PointAlongBez6(pRim, (25-11)/25),
    PointAlongBez6(pRim, (25-12)/25),
    PointAlongBez6(pRim, (25-13)/25),
    PointAlongBez6(pRim, (25-14)/25),
    PointAlongBez6(pRim, (25-15)/25),
    PointAlongBez6(pRim, (25-16)/25),
    PointAlongBez6(pRim, (25-17)/25),
    PointAlongBez6(pRim, (25-18)/25),
    PointAlongBez6(pRim, (25-19)/25),
    PointAlongBez6(pRim, (25-20)/25),
    PointAlongBez6(pRim, (25-21)/25),
    PointAlongBez6(pRim, (25-22)/25),
    PointAlongBez6(pRim, (25-23)/25),
    PointAlongBez6(pRim, (25-24)/25),
    PointAlongBez6(pRim, (25-25)/25),

    [rimIR+(didjIR-rimIR)/2+shankWallThickness, transitionLength/2],
    [didjOR + shankWallThickness, 0]
  ]);

rotate_extrude() 
  polygon([
    [didjOR,-shankLen],
    [didjOR,0],
    [didjOR + shankWallThickness, 0],
    [didjOR + shankWallThickness, -shankLen]
]);

if (printSupport)
{
  for ( i = [0 : 30 : 360] )
  {
    rotate([0,0,i])
    translate([0,0,-shankLen])
    cube([0.25, didjOR - 0.4, shankLen - layerHeight]);
  }
}



//=======================================
// Functions
//=======================================
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p,u) = [
  BEZ03(u)*p[0][0]+BEZ13(u)*p[1][0]+BEZ23(u)*p[2][0]+BEZ33(u)*p[3][0],
  BEZ03(u)*p[0][1]+BEZ13(u)*p[1][1]+BEZ23(u)*p[2][1]+BEZ33(u)*p[3][1]
  ];

function Bez06(t) =            pow(1-t, 5);
function Bez16(t) = 5*pow(t,1)*pow(1-t, 4);
function Bez26(t) = 10*pow(t,2)*pow(1-t, 3);
function Bez36(t) = 10*pow(t,3)*pow(1-t, 2);
function Bez46(t) = 5*pow(t,4)*pow(1-t, 1);
function Bez56(t) =   pow(t,5);
function PointAlongBez6(p,u) = [
  Bez06(u)*p[0][0]+Bez16(u)*p[1][0]+Bez26(u)*p[2][0]+Bez36(u)*p[3][0]+Bez46(u)*p[4][0]+Bez56(u)*p[5][0],
  Bez06(u)*p[0][1]+Bez16(u)*p[1][1]+Bez26(u)*p[2][1]+Bez36(u)*p[3][1]+Bez46(u)*p[4][1]+Bez56(u)*p[5][1]
  ];









