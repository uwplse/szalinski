use <Write.scad>

// at the rim, in mm; 39.5 fits many large bore mouthpieces.
mouthpiece_outside_diameter = 39.6; // [ 37: 1.457in / 37mm, 37.5: 1.476in / 37.5mm, 38: 1.496in / 38mm, 38.5: 1.516in / 38.5mm (12C), 39: 1.535in / 39mm, 39.5: 1.555in / 39.5mm (large-bore), 40: 1.575in / 40mm, 40.5: 1.594in / 40.5mm, 41: 1.614in / 41mm, 41.5: 1.634in / 41.5mm, 42: 1.654in / 42mm, 42.5: 1.673in / 42.5mm (Wedge 1G), 43: 1.693in / 43mm, 43.5: 1.713in / 43.5mm, 44: 1.732in / 44mm ]

// in mm. 
mouthpiece_height = 83; // [ 75: 2.953in / 75mm, 76: 2.992in / 76mm, 77: 3.031in / 77mm, 78: 3.071in / 78mm (12C), 79: 3.110in / 79mm, 80: 3.150in / 80mm, 81: 3.189in / 81mm, 82: 3.228in / 82mm, 83: 3.268in / 83mm (most large-bore MPs), 84: 3.307in / 84mm, 85: 3.346in / 85mm, 86: 3.386in / 86mm (Doug Elliott large-bore) ]

shank = "large"; // [large, small]

design = 0; // [0:5]

your_name = "";

mouthpiece_name = "";

/* [Hidden] */

mmIn = 25.4;
taper = 0.5 * 1/20;
botR = ((shank == "large") ? 12.7 : 11)/2 + 0.42;
taperLen = (shank == "large") ? 32 : 30;
topR = botR + taper*taperLen;
wallThickness = 0.42 * 5;

cupY = 13;

mpMaxR = 0.5 * mouthpiece_outside_diameter;

$fa = 4;

bezPts = [
  [10, cupY],
  [mpMaxR, cupY + mpMaxR - 10],
  [mpMaxR + 0.75, mouthpiece_height - taperLen - 20],
  [mpMaxR + 0.75, mouthpiece_height - taperLen],
];

capOffset = addPt(PerpAlongBez4(bezPts, 10/12, wallThickness), [1, 0]);

body();
cap();
capThreads();
capDesign(design);

module basePoly() {
  polygon([
    [botR-3, -taperLen-4],
    [botR-1, -taperLen],
    [botR, -taperLen],
    [topR, 0],
    [10, cupY],
    [10 + wallThickness, cupY],
    [topR + wallThickness, 0],
    [1.5*botR, -taperLen-2],
    [1.5*botR-1, -taperLen-4],
  ]);
}

module bodyPoly() {
  polygon([
    PointAlongBez4(bezPts, 0/12),
    PointAlongBez4(bezPts, 1/12),
    PointAlongBez4(bezPts, 2/12),
    PointAlongBez4(bezPts, 3/12),
    PointAlongBez4(bezPts, 4/12),
    PointAlongBez4(bezPts, 5/12),
    PointAlongBez4(bezPts, 6/12),
    PointAlongBez4(bezPts, 7/12),
    PointAlongBez4(bezPts, 8/12),
    PointAlongBez4(bezPts, 9/12),
    PointAlongBez4(bezPts, 10/12),
    PointAlongBez4(bezPts, 11/12),
    PointAlongBez4(bezPts, 12/12),

    PerpAlongBez4(bezPts, 12/12, wallThickness),
    PerpAlongBez4(bezPts, 11/12, wallThickness),
    PerpAlongBez4(bezPts, 10/12, wallThickness),
    PerpAlongBez4(bezPts, 9.5/12, wallThickness),
    PerpAlongBez4(bezPts, 9/12, wallThickness + 9/8*0.82),
    PerpAlongBez4(bezPts, 8/12, wallThickness + 9/8*0.82),
    PerpAlongBez4(bezPts, 7/12, wallThickness + 8/8*0.82),
    PerpAlongBez4(bezPts, 6/12, wallThickness + 8/8*0.82),
    PerpAlongBez4(bezPts, 5/12, wallThickness + 8/8*0.82),
    PerpAlongBez4(bezPts, 4/12, wallThickness + 2/8*0.82),
    PerpAlongBez4(bezPts, 3/12, wallThickness + 5/8*0.82),
    PerpAlongBez4(bezPts, 2/12, wallThickness + 0/8*0.82),
    PerpAlongBez4(bezPts, 1/12, wallThickness + 3/8*0.82),
    PerpAlongBez4(bezPts, 0/12, wallThickness + 0/8*0.82),
    [10+1, cupY-2],
  ]);
}

module body() {
  translate([mpMaxR+botR*1.5+2*wallThickness+5,0, taperLen+4]) 
  union() {
    rotate_extrude() 
      basePoly();

    difference() {
      union() {
        rotate_extrude()
          bodyPoly();
        bodyThreads();
      }
      bodyCutouts();
    }
  }
}

module bodyCutouts() {
  translate([0,0,bezPts[3][1]-5]) cutout();
  translate([0,0,bezPts[3][1]-5]) cutout(180);
  // ease the edges
  translate([sin(-38)*(mpMaxR),cos(-38)*mpMaxR,bezPts[3][1]]) rotate([0,0,38]) lip();
  translate([sin(-38+180)*(mpMaxR),cos(-38+180)*mpMaxR,bezPts[3][1]]) rotate([0,0,38+180]) lip();
  translate([sin(38+0)*(mpMaxR),cos(38+0)*mpMaxR,bezPts[3][1]]) rotate([0,0,-38+0]) lip(-1);
  translate([sin(38+180)*(mpMaxR),cos(38+180)*mpMaxR,bezPts[3][1]]) rotate([0,0,-38+180]) lip(-1);
}

module cutout(a=0) {
  rotate([90,0,a]) union() {
    hull() {
        translate([0,-6, mpMaxR+wallThickness+1.75]) linear_extrude(height = 0.0001) circle(r=12);
        translate([0, 6, mpMaxR+wallThickness+1.75]) linear_extrude(height = 0.0001) circle(r=15);
        translate([0,-6, 0]) scale([0.01,1,1]) linear_extrude(height = 0.0001) circle(r=12);
        translate([0, 6, 0]) scale([0.01,1,1]) linear_extrude(height = 0.0001) circle(r=15);
      }
    }
}
rd = 5;
module lip(a=1) {
  rotate([90,0,0]) 
  translate([-rd*a/2,-rd+0.1,-mpMaxR]) 
  linear_extrude(height=mpMaxR*2) 
  polygon([ 
      [rd*1.5*a, rd*-1.5],
      [rd*2*a, rd*-1.5],
      [rd*2*a, rd*2],
      [sin(0*a)*rd-5*a, cos(0*a)*rd+3],
      [sin(0*a)*rd-5*a, cos(0*a)*rd+0.1],
      [sin(10*a)*rd, cos(10*a)*rd],
      [sin(20*a)*rd, cos(20*a)*rd],
      [sin(30*a)*rd, cos(30*a)*rd],
      [sin(40*a)*rd, cos(40*a)*rd],
      [sin(50*a)*rd, cos(50*a)*rd],
      [sin(60*a)*rd, cos(60*a)*rd],
      [sin(70*a)*rd, cos(70*a)*rd],
      ]
    );
}
threadHeight = 5;
offset = 0.0;
capY = bezPts[3][1]+offset + 2;
function linlin(x, start, end) =  threadHeight * (x-start)/(end-start);
module threadTriangle(a, start, end, flip) {
  begw = max(0.1, pow(min(1,(a-start)/(end-start) * 20),0.35));
  endw = max(0.1, pow(min(1,((end-a)/(end-start)) * 20),0.35));
  widAdj = (flip == 1 ? 1  : -1) * begw * endw;
  translate([0, 0,  -linlin(a, start, end)])
  rotate([90,0,a]) 
  translate([ bezPts[3][0]+wallThickness + (flip==1 ? 0 : 1+offset), 0, 0]) 
  linear_extrude(height=0.0001) 
  polygon([
    [0,          1*abs(widAdj)],
    [0.8*widAdj, 0.2],
    [0.8*widAdj,-0.2],
    [0,         -1*abs(widAdj)],
  ]);
}
module threadArc(startA = 85, flip=1) {
endA = startA - 110;
for (i=[startA : $fa : endA]) {
  hull() {
    threadTriangle(i, startA, endA, flip);
    threadTriangle(i+$fa, startA, endA, flip);
    }
  }
}

write = (your_name != "" || mouthpiece_name != "");

function ia(i) = pow(i, 0.55);
capHeight = capY - threadHeight - 5;
capOR = bezPts[3][0]+wallThickness+1;
d = 1/4;

module capDesign(design) {
  wallWid = 1.26;
  if (design == 0) {
    for (i = [-30 : 15 : 30]) {
      wall(
        scalePt([sin(i), cos(i)], capOR),
        scalePt([sin(i), -cos(i)], capOR),
        wallWid
      );
      wall(
        scalePt([sin(i+90), cos(i+90)], capOR),
        scalePt([-sin(i+90), cos(i+90)], capOR),
        wallWid
      );
    }    
  } else if (design == 1) {
    for (i = [1/4 : 1/4 : 1]) {
      wall(
        scalePt([sin(i*180), cos(i*180)], capOR),
        scalePt([sin(i*180+135), cos(i*180+135)], capOR),
        wallWid
      );
      wall(
        scalePt([sin(i*180+180), cos(i*180+180)], capOR),
        scalePt([sin(i*180+315), cos(i*180+315)], capOR),
        wallWid
      );
      wall(
        scalePt([sin(i*180), cos(i*180)], capOR),
        scalePt([sin(i*180+180), cos(i*180+180)], capOR),
        wallWid
      );
    }    
  } else if (design == 2) {
    for (i = [1/8 : 1/8 : 2]) {
      wall(
        scalePt([sin(i*180+90), cos(i*180+90)], capOR),
        scalePt([sin(i*180), cos(i*180)], capOR/5),
        wallWid
      );
     }
  } else if (design == 3) {
    for (i = [1/20 : 1/20 : 1]) {
      wall(
        scalePt([sin(i*360), cos(i*360)], capOR),
        scalePt([sin(i*360%90), cos(i*360%90)], capOR*0.25),
        wallWid
      );
     }
  } else if (design == 4) {
    for (i = [30 : 30 : 330]) {
      wall(
        scalePt([sin(i), cos(i)], capOR-2),
        scalePt([sin(-i), cos(-i)], capOR * 0.27),
        wallWid
      );
      wall(
        scalePt([sin(i-90), cos(i-90)], capOR-2),
        scalePt([sin(-i-90), cos(-i-90)], capOR * 0.31),
        wallWid
      );
    }
  } else if (design == 5) {
    difference() {
      cylinder(r=capOR-5, h=wallThickness, center=false);
      cylinder(r=3, h=wallThickness, center=false, $fn = 6);
      for (i = [60 : 60 : 360]) {
        translate(scalePt([sin(i), cos(i), 0], 7.5)) cylinder(r=3, h=wallThickness, center=false, $fn = 6);
      }
      for (i = [30 : 30 : 360]) {
        translate(scalePt([sin(i), cos(i), 0], i%60 == 0 ? 14.5 : 13)) cylinder(r=3, h=wallThickness, center=false, $fn = 6);
      }
    }
  }
}

module bodyThreads() {
  union() {
    translate([0,0,mouthpiece_height - taperLen - 2]) threadArc(50);
    translate([0,0,mouthpiece_height - taperLen - 2]) threadArc(50+90);
    translate([0,0,mouthpiece_height - taperLen - 2]) threadArc(50+180);
    translate([0,0,mouthpiece_height - taperLen - 2]) threadArc(50+270);
  }
}
module capThreads() {
  union() {
    translate([0,0, threadHeight + wallThickness + 2]) threadArc(50, -1);
    translate([0,0, threadHeight + wallThickness + 2]) threadArc(50+90, -1);
    translate([0,0, threadHeight + wallThickness + 2]) threadArc(50+180, -1);
    translate([0,0, threadHeight + wallThickness + 2]) threadArc(50+270, -1);
  }
}
module cap() {
  txtHeight = capY - capHeight - 4;// capY - capOffset[1] - 1;
  difference() {
    rotate([180,0,0]) translate([0,0, -capY - wallThickness +0]) rotate_extrude() 
    polygon([
      [ mpMaxR-2, capY + wallThickness],
      [ mpMaxR-2, capY],
      [capOR+offset, capY],
      [capOR+offset, capHeight],
      [capOffset[0] + offset + 1, capHeight],
      [capOffset[0] + offset + wallThickness, capHeight + (write ? 2 : 5+threadHeight/3)],
      [capOffset[0] + offset + wallThickness, capY + wallThickness/3],
      [capOffset[0] + offset + wallThickness/3, capY + wallThickness],
    ]);

    if (write) {
      rotate([0,180,0]) writecylinder(
          str(
            your_name, 
            ((your_name != "" && mouthpiece_name != "") ? " :: " : ""), 
            mouthpiece_name
          ),
          where=[0,0,capY - capOffset[1] - 1],
          down=txtHeight + 13,
          radius=capOffset[0] + offset + wallThickness,
          height=txtHeight, h=txtHeight, t = wallThickness
        );    
    }
  }
}
module wall(p1, p2, width, height=wallThickness) {
  translate([p1[0],p1[1],0]) 
  rotate([0, 0, atan2(dy(p2,p1), dx(p2,p1))])
  translate([-width/2,-width/2,0])
  cube(size=[dist(p1, p2), width, height], center=false);
}

function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p,u) = [
  BEZ03(u)*p[0][0]+BEZ13(u)*p[1][0]+BEZ23(u)*p[2][0]+BEZ33(u)*p[3][0],
  BEZ03(u)*p[0][1]+BEZ13(u)*p[1][1]+BEZ23(u)*p[2][1]+BEZ33(u)*p[3][1]
  ];

function BEZT3(p, t, n) = 
  -3*pow(1-t, 2) * p[0][n] + 3*pow(1-t, 2) * p[1][n] - 6*t*(1-t) * p[1][n] - 3*t*t * p[2][n] + 6*t*(1-t) * p[2][n] + 3*t*t * p[3][n];

function TangentAlongBez4(p, t) = [BEZT3(p, t, 0), BEZT3(p, t, 1)];

function PerpAlongBez4(p, t, d=1) = addPt( 
  PointAlongBez4(p, t), 
  rot90cw( 
    normPt( TangentAlongBez4(p, t), d )
  ) 
);

function dx(p1, p2) = p1[0] - p2[0];
function dy(p1, p2) = p1[1] - p2[1];
function dist(p1, p2 = [0,0]) = sqrt(pow( dx(p1,p2), 2) + pow( dy(p1,p2), 2));
function normPt(p, n = 1) = scalePt( p, n / dist( p ) );

function addPt(p1, p2) = [p1[0]+p2[0], p1[1]+p2[1]];
function subPt(p1, p2) = [p1[0]-p2[0], p1[1]-p2[1]];
function rot90cw(p) = [p[1], -p[0]];
function rot90ccw(p) = [-p[1], p[0]];
function rot(p, a) = [
  p[0] * cos(a) - p[1] * sin(a),
  p[0] * sin(a) - p[1] * cos(a),
];
function rotAbout(p1, p2, a) = addPt(rot(subPt(p1, p2), a), p2); // rotate p1 about p2
function scalePt(p, v) = [p[0]*v, p[1]*v];
