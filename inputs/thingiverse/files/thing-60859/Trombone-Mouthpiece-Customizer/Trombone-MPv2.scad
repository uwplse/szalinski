// use <Write.scad>

// preview[view:south, tilt:top diagonal]

/*
12C:   23    / 22.5 / 23-AS
6.5AL: 24    / 25   / 20-EL
5G:    24.5  / 28   / 25-JS
4G:    25    / 29.5 / 23-JL
1.5G:  26.5  / 30   / 22-JS
S59:   27.25 / 30.5 / 21-MS
*/

/* [Basic] */
// measured from the lower end of the inside bite curve. Most commercial mouthpieces are measured somewhere along the bite curve, and the published diameters are consequently 0.5-1mm larger than this rim diameter parameter. 
rim_diameter = 25; // [ 20: 0.787in / 20mm, 20.5: 0.807in / 20.5mm, 21: 0.827in / 21mm, 21.5: 0.846in / 21.5mm, 22: 0.866in / 22mm, 22.5: 0.886in / 22.5mm, 23: 0.906in / 23mm (12C), 23.5: 0.925in / 23.5mm, 24: 0.945in / 24mm (6.5AL), 24.5: 0.965in / 24.5mm (5G), 25: 0.984in / 25mm (4G), 25.5: 1.004in / 25.5mm (3G), 26: 1.024in / 26mm (2G), 26.5: 1.043in / 26.5mm (1.5G), 27: 1.063in / 27mm (S59), 27.5: 1.083in / 27.5mm, 28: 1.102in / 28mm, 28.5: 1.122in / 28.5mm, 29: 1.142in / 29mm, 29.5: 1.161in / 29.5mm, 30: 1.181in / 30mm ]

// specifies the distance from the bottom of the inner bite curve to the venturi along the Z axis.
cup_depth = 29.5; // [20: 0.787in / 20mm, 20.5: 0.807in / 20.5mm, 21: 0.827in / 21mm, 21.5: 0.846in / 21.5mm, 22: 0.866in / 22mm, 22.5: 0.886in / 22.5mm (12C), 23: 0.906in / 23mm, 23.5: 0.925in / 23.5mm, 24: 0.945in / 24mm, 24.5: 0.965in / 24.5mm, 25: 0.984in / 25mm (6.5AL), 25.5: 1.004in / 25.5mm, 26: 1.024in / 26mm, 26.5: 1.043in / 26.5mm, 27: 1.063in / 27mm, 27.5: 1.083in / 27.5mm, 28: 1.102in / 28mm (5G), 28.5: 1.122in / 28.5mm, 29: 1.142in / 29mm, 29.5: 1.161in / 29.5mm (4G), 30: 1.181in / 30mm (1.5G), 30.5: 1.201in / 30.5mm (S59), 31: 1.22in / 31mm, 31.5: 1.24in / 31.5mm, 32: 1.26in / 32mm]

// specifies the location of a control point for the inner cup curve. Large values mean a more bowl-shaped cup.
cup_curve = 23; // [ 15: 0.591in / 15mm, 16: 0.63in / 16mm, 17: 0.669in / 17mm, 18: 0.709in / 18mm, 19: 0.748in / 19mm, 20: 0.787in / 20mm (6.5AL), 21: 0.827in / 21mm (S59), 22: 0.866in / 22mm (1.5G), 23: 0.906in / 23mm (12C/4G), 24: 0.945in / 24mm, 25: 0.984in / 25mm (5G), 26: 1.024in / 26mm, 27: 1.063in / 27mm, 28: 1.102in / 28mm, 29: 1.142in / 29mm ]

/* DRILL */
// or venturi specifies the diameter of the narrowest portion of the mouthpiece.
drill = 7.036; //   [5.309: 4 0.209 in / 5.309 mm, 5.410: 3 0.213 in / 5.410 mm, 5.613: 2 0.221 in / 5.613 mm, 5.791: 1 0.228 in / 5.791 mm, 5.944: A 0.234 in / 5.944 mm (12C), 6.045: B 0.238 in / 6.045 mm, 6.147: C 0.242 in / 6.147 mm, 6.248: D 0.246 in / 6.248 mm, E 0.250 in / 6.350 mm (6-1/2AL), 6.528: F 0.257 in / 6.528 mm,         6.629: G 0.261 in / 6.629 mm (Bach 5GS),    6.756: H 0.266 in / 6.756 mm,         6.909: I 0.272 in / 6.909 mm,               7.036: J 0.277 in / 7.036 mm (1.5G/4G/5G), 7.137: K 0.281 in / 7.137 mm,             7.366: L 0.290 in / 7.366 mm,                        7.493: M 0.295 in / 7.493 mm (S59), 7.671: N 0.302 in / 7.671 mm,                        8.026: O 0.316 in / 8.026 mm,     8.204: P 0.323 in / 8.204 mm,                        8.433: Q 0.332 in / 8.433 mm,               8.611: R 0.339 in / 8.611 mm ]

shank = "large"; // [large, small]
shank_backbore = 2; // [2: Large, 3: medium, 4: small]

/* [Rim Details] */
// sets the position of a couple bezier control points on the rim curve (higher value means that the surface that meets your embouchure is more rounded):
rim_curvature = 2.5; // [1.5:flat, 2.5:normal, 3.5:curved]

// is also affected by the rim curvature.
inside_bite = 0.3; // [0.1:very sharp, 0.2:sharp, 0.3:medium, 0.4: soft]

// and the following parameters control the profile of the outer portion of the rim
rim_thickness = 7; // [6.5:narrow, 7:normal, 7.5: slightly wide, 8:wide]
outside_bite = 0.4; // [0.2:sharp, 0.3:medium, 0.4:soft]

/* [Misc] */

part = "two_piece"; // [two_piece: Two-piece Cup and Shank, one_piece: One-piece Cup and Shank, cup_only: Cup only, shank_only: Shank only, profiles_only: Just profiles (do not extrude)]

// in mm*100. This value is added to venturi and rim ID values to try and make the critical dimensions of the printed mouthpiece match the desired values.
printer_spooge_factor = 21;//[0:50]

cup_hex_nut = 1; // [1:yes, 0:no]
shank_hex_nut = 1; // [1:yes, 0:no]

// when printing in two pieces. Don't taper if you want to use the cup with a Elliott shsnk.
taper_cup_interface = 1; // [1:yes, 0:no]

// must be sturdy enough to support the mouthpiece without sagging if you're printing in two pieces and finishing with an acetone vapor bath.
cup_base_thickness = 2.52; // [ 1.68: 4 walls,  2.1: 5 walls,  2.52: 6 walls,  2.94: 7 walls,  3.36: 8 walls,  3.78: 9 walls,  4.2: 10 walls ]

// if printing two pieces to accommodate the 90 deg overhang, or if printing in one piece, print a raft.
print_support = 1; // [0:no, 1:yes]

my_name = "Kirby";

// is just used when printing support.
layer_height = 0.1;

// controls how smooth the rotate_extrude is.
$fn = 90;


/* [Hidden] */
// onto the outside of the cup
write_parameters = 0; // [0:no, 1:yes]


overallHeight = (shank == "small") ? 78 : 83;

// in mm of the tapered portion of the shank:
shank_length = (shank == "small") ? 33 : 38; // [30:50]

cupOZ = 35;

cupShankTransitionZ = overallHeight - shank_length - cupOZ;

outer_rim_height = 4;

outside_shoulder_slope = 0.0; // [0:not sloped, 0.3:slight slope, 0.65:sloped, 0.99:very sloped]

// 0.025 is the standard Morse taper. You probably dont want to change this.
taper = 0.025;

twoPiece = (part == "one_piece") ? 0 : 1;

venturiR = drill/2 + printer_spooge_factor/100;
rimIR = rim_diameter/2 + printer_spooge_factor/100;
rimOR = rimIR + rim_thickness;

insideX = rim_thickness*inside_bite;
outsideX = rim_thickness*outside_bite;

cupIZ = cupOZ; 

rimWid = rim_thickness * (1 - inside_bite - outside_bite) * 0.25;

extY = (cupIZ - insideX) - cup_depth;

cupCtlY1 = (cupIZ - insideX) - cup_curve; 
cupCtlY2 =  11; 

pCup = [
  [rimIR, (cupIZ - insideX)],
  [rimIR, cupCtlY1+extY],
  [venturiR, cupCtlY2+extY],
  [venturiR, extY]
];

pRim = [
  [rimOR, cupIZ - outsideX], // 0
  [rimOR - (outsideX*outside_shoulder_slope), cupIZ+rim_curvature/2], // 1
  [rimIR + insideX, cupIZ+rim_curvature/2], // 2
  [rimIR, cupIZ], // 3
  [rimIR, cupIZ+(1-inside_bite)*1], // 4
  [rimIR, cupIZ-insideX] // 5
];

shankTopOR = ((shank == "large") ? 6 : 5);
shankEndOR = ((shank == "large") ? 12.7 : 11)/2;
shankTaperOR = shankEndOR+(shank_length * taper);

outerBot = PointAlongBez4(pCup, 0.85);
outerBotX = outerBot[0] + cup_base_thickness;
outerBotY = min(outerBot[1], 7); 

outerTopX = pRim[0][0] - rim_thickness * 0.4;
outerTopY = pRim[0][1] - outer_rim_height - rim_thickness * 0.41;

midPt = PointAlongBez4(pCup, 0.6);
pOuter = [
  [outerBotX, outerBotY],
  [midPt[0] + cup_base_thickness*2, min( midPt[1], outerTopY - 6) ], 
  [outerTopX, min(midPt[1]*1.2, outerTopY - 5)],
  [outerTopX, outerTopY],
];

print_part();

module cup_profile() {
  polygon([
    PointAlongBez6(pRim, 0/25),
    PointAlongBez6(pRim, 1/25),
    PointAlongBez6(pRim, 2/25),
    PointAlongBez6(pRim, 3/25),
    PointAlongBez6(pRim, 4/25),
    PointAlongBez6(pRim, 5/25),
    PointAlongBez6(pRim, 6/25),
    PointAlongBez6(pRim, 7/25),
    PointAlongBez6(pRim, 8/25),
    PointAlongBez6(pRim, 9/25),
    PointAlongBez6(pRim, 10/25),
    PointAlongBez6(pRim, 11/25),
    PointAlongBez6(pRim, 12/25),
    PointAlongBez6(pRim, 13/25),
    PointAlongBez6(pRim, 14/25),
    PointAlongBez6(pRim, 15/25),
    PointAlongBez6(pRim, 16/25),
    PointAlongBez6(pRim, 17/25),
    PointAlongBez6(pRim, 18/25),
    PointAlongBez6(pRim, 19/25),
    PointAlongBez6(pRim, 20/25),
    PointAlongBez6(pRim, 21/25),
    PointAlongBez6(pRim, 22/25),
    PointAlongBez6(pRim, 23/25),
    PointAlongBez6(pRim, 24/25),
    PointAlongBez6(pRim, 25/25),

    PointAlongBez4(pCup, 0/25),
    PointAlongBez4(pCup, 1/25),
    PointAlongBez4(pCup, 2/25),
    PointAlongBez4(pCup, 3/25),
    PointAlongBez4(pCup, 4/25),
    PointAlongBez4(pCup, 5/25),
    PointAlongBez4(pCup, 6/25),
    PointAlongBez4(pCup, 7/25),
    PointAlongBez4(pCup, 8/25),
    PointAlongBez4(pCup, 9/25),
    PointAlongBez4(pCup, 10/25),
    PointAlongBez4(pCup, 11/25),
    PointAlongBez4(pCup, 12/25),
    PointAlongBez4(pCup, 13/25),
    PointAlongBez4(pCup, 14/25),
    PointAlongBez4(pCup, 15/25),
    PointAlongBez4(pCup, 16/25),
    PointAlongBez4(pCup, 17/25),
    PointAlongBez4(pCup, 18/25),
    PointAlongBez4(pCup, 19/25),
    PointAlongBez4(pCup, 20/25),
    PointAlongBez4(pCup, 21/25),
    PointAlongBez4(pCup, 22/25),
    PointAlongBez4(pCup, 23/25),
    PointAlongBez4(pCup, 24/25),
    PointAlongBez4(pCup, 25/25),
    [venturiR, 0],

    PointAlongBez4(pOuter, 0/10),
    PointAlongBez4(pOuter, 1/10),
    PointAlongBez4(pOuter, 2/10),
    PointAlongBez4(pOuter, 3/10),
    PointAlongBez4(pOuter, 4/10),
    PointAlongBez4(pOuter, 5/10),
    PointAlongBez4(pOuter, 6/10),
    PointAlongBez4(pOuter, 7/10),
    PointAlongBez4(pOuter, 8/10),
    PointAlongBez4(pOuter, 9/10),
    PointAlongBez4(pOuter, 10/10),

    [pRim[0][0], pRim[0][1] - outer_rim_height], 
//    [rimOR, cupIZ - outsideX - rim_thickness*0.3],
  ]);
}
  // outscribeR = shankInterfaceWidePoint[0]/cos(180/fn);

shankInterfaceWidePoint = (taper_cup_interface && twoPiece) ? 
  [shankTopOR+0.75+cup_base_thickness+7*taper*4   , -7 ] : 
  [(twoPiece ? shankTopOR+cup_base_thickness : shankTopOR) , -7 ]; //shankTaperOR

module cupShankInterface() {
  if (taper_cup_interface && twoPiece) {
    polygon([
      [venturiR,0],
      [shankTopOR+0.75, 0],
      [shankInterfaceWidePoint[0]-cup_base_thickness, shankInterfaceWidePoint[1] ],
      shankInterfaceWidePoint,
      [shankInterfaceWidePoint[0], shankInterfaceWidePoint[1] + outerBotY], 
      [outerBotX, outerBotY]
      ]);
  } else {
    polygon([
      [venturiR,0],
      [shankTopOR+(twoPiece ? printer_spooge_factor/100 : 0), 0],
      [shankTopOR+(twoPiece ? printer_spooge_factor/100 : 0), shankInterfaceWidePoint[1]],
      shankInterfaceWidePoint,
      [shankInterfaceWidePoint[0], shankInterfaceWidePoint[1] + outerBotY], 
      [outerBotX, outerBotY],
      ]);
  }
}

shankCupInterfaceTaperLen = (taper_cup_interface && twoPiece) ? 9 : (twoPiece) ? 8 : 0.1;
shankTaper = (taper_cup_interface && twoPiece) ? shankCupInterfaceTaperLen*taper*4 : 0;
shankWidePoint = [shankTaperOR, -shankCupInterfaceTaperLen - (shankTaperOR-(shankTopOR+shankTaper))];
shankFlatLen = 7;
shankSpooge = (taper_cup_interface && twoPiece) ? 0 : printer_spooge_factor/100;

pShank = [
    [venturiR, 0],
    [shankTopOR - shankSpooge, 0],
    [shankTopOR + shankTaper - shankSpooge, -shankCupInterfaceTaperLen ],
     shankWidePoint,
    [shankWidePoint[0],                      shankWidePoint[1] - shankFlatLen],
    [shankEndOR,                             shankWidePoint[1] - shankFlatLen - shank_length],
    [shankEndOR - (0.42*shank_backbore),     shankWidePoint[1] - shankFlatLen - shank_length],
  ];

module shank_profile() {
  polygon(pShank);
}

dl = (drill == 5.309) ? "4" :
  (drill == 5.410) ? "3" :
  (drill == 5.613) ? "2" :
  (drill == 5.791) ? "1" :
  (drill == 5.944) ? "A" : 
  (drill == 6.045) ? "B" : 
  (drill == 6.147) ? "C" : 
  (drill == 6.248) ? "D" : 
  (drill == 6.350) ? "E" : 
  (drill == 6.528) ? "F" : 
  (drill == 6.629) ? "G" : 
  (drill == 6.756) ? "H" : 
  (drill == 6.909) ? "I" : 
  (drill == 7.036) ? "J" : 
  (drill == 7.137) ? "K" : 
  (drill == 7.366) ? "L" : 
  (drill == 7.493) ? "M" : 
  (drill == 7.671) ? "N" : 
  (drill == 8.026) ? "O" : 
  (drill == 8.204) ? "P" : 
  (drill == 8.433) ? "Q" : 
  (drill == 8.611) ? "R" : 
  (drill == 8.839) ? "S" : 
  (drill == 9.093) ? "T" : 
  "X";

string = str(my_name, " ", rim_diameter, "/", cup_depth, , "/", cup_curve, "-", dl, (shank == "small" ? "S" : "L"));
echo(str("Name = ", string));

module rotatedCup() {
  txtHeight = 3; // 4.5 - 2.5*cup_shape;
  difference() {
    rotate_extrude() union() {cup_profile();     cupShankInterface();}
    if (write_parameters) {
      writecylinder(
        text=string,
        where=[0,0,outerTopY],
        down=txtHeight+1,
        radius=outerTopX,
        height=txtHeight, h=txtHeight, t = 1.75);
    }
  }
  fn = 6;
  outscribeR = shankInterfaceWidePoint[0]/cos(180/fn);
  if (cup_hex_nut) {
    rotate_extrude($fn = fn) polygon([
      shankInterfaceWidePoint,
      [outscribeR, shankInterfaceWidePoint[1] + 2],
      [outscribeR, shankInterfaceWidePoint[1] + (part == "one_piece" ? 10 : 8)],
      [outscribeR-2, shankInterfaceWidePoint[1] + (part == "one_piece" ? 12: 10)],

    ]);
  }
}

module rotatedShank() {
  rotate_extrude() shank_profile();
  fn = 6;
  outscribeR = shankWidePoint[0]/cos(180/fn);
  if (shank_hex_nut) {
    rotate_extrude($fn = fn) polygon([
      shankWidePoint,
      [outscribeR, shankWidePoint[1] - 1.2],
      [outscribeR, shankWidePoint[1] - shankFlatLen+1.2],
      [shankWidePoint[0], shankWidePoint[1] - shankFlatLen],
    ]);
  }
}

module print_part() {
  // include <4G.scad>;
  if (part == "two_piece") {
    rotatedCup();
    if (print_support) {
      support();
    }
    translate([rim_diameter + 5,  0,  -7 ])
    rotate([  0,       180,      0])
      rotatedShank();

  } else if (part == "one_piece") {
    rotatedCup();
    rotatedShank();
    if (print_support) {
      raft();
    }

  } else if (part == "cup_only") {
    rotatedCup();
    if (print_support) {
      support();
    }

  } else if (part == "shank_only") {
    rotate([  0,       180,      0])
      rotatedShank();

  } else if (part == "profiles_only") {
    rotate([90,0,0]) union() {cup_profile();     cupShankInterface();}
    translate([rim_diameter + 5,  0,  -7 ])
    rotate([  0,       180,      0])
    rotate([90,0,0]) shank_profile();
    for ( i = [0 : 3] ) {
      rotate([90,0,0]) translate(pCup[i]) color("Blue",0.5) circle(r = 0.3);
    }
    for ( i = [0 : 3] ) {
      rotate([90,0,0]) translate(pOuter[i]) color("Red",0.5) circle(r = 0.3);
    }
    for ( i = [0 : 5] ) {
      rotate([90,0,0]) translate(pRim[i]) color("Green",0.5) circle(r = 0.2);
    }
    for (i = [0.25:0.25:1-0.25]) {
    rotate([90,0,0]) translate(PointAlongBez4(pCup, i)) color("Purple",0.5) circle(r = 0.3);
    }
  }
}

module support() {
  supportR = shankTopOR - 0.3;
  for ( i = [0 : 45 : 180] )
  {
    rotate([0,0,i])
    translate([0,0,-7/2])
    cube([0.3, (supportR)*2, 7 - layer_height*1.25], center = true);
  }
  translate([0,0,-7])  cylinder(r = supportR, h = 0.3);
}

module raft() {
  rx = pShank[6][0];
  ry = pShank[6][1];
  rotate_extrude()
  polygon([
    pShank[6],
    pShank[5],
    [pShank[5][0], pShank[5][1] - 1],
    [rim_diameter/1.75, pShank[5][1] - 1],
    [rim_diameter/1.75, pShank[5][1] - 2],
    [pShank[6][0], pShank[6][1] - 2],
  ]);
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

