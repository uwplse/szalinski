/* [General Dimensions] */
bracketType = 1; //[0:Solid,1:Hollow]
// Length of side
sideLength = 40;
// How many multiples of extrusion size, for width of bracket
extrusionUnits = 1; //[1:4]
// How much material under bolt head
thicknessUnderBolt = 3;
// How far from edge to first hole (ignored if only 1 bolt per side)
holeEdgeOffset = 12.5;
// How many bolts along each side
boltCountPerSide = 2; //[1:4]
// Enable fillet around holes on the face of the diagonal
fillet = 1; // [0:1]
// Fillet radius
rFillet = 2.5;
// Fillet "fudge factor" to produce a smooth transition
rScale = 1.14;
// Display Assembly, for visual inspection only
showAssembly = 0; //[0:No,1:Yes]

/* [Hollow Brace Settings] */
// Thickness of brace
braceThickness = 5;
// Cutout fillet radius
rCutout = 2;

/* [Extrusion Dimensions] */
// Base unit for extrusion
unitWidth = 20;
// Bolt shank diameter
dBolt = 5;
// Bolt shank hole clearance
boltClearance = 0.4;
// Bolt Head diameter
dBoltHead = 8.5;
// Bolt Head counterbore
dCounterbore = 9.75;

// Height of Bolt head, only for assembly view
boltHeadHeight = 5;
// Length of bolt, only for assembly view
boltLength = 8;

/* [Hidden] */
$fn = 100;

// space bolt holes so that the perpendicular holes intersect along the face of the diagonal
holeEdgeOffset2 = (boltCountPerSide == 1) ? (sideLength - thicknessUnderBolt) / 2 + thicknessUnderBolt : holeEdgeOffset;
boltSpacing = (boltCountPerSide > 1) ? 
  (sideLength - holeEdgeOffset2*2 + thicknessUnderBolt) / (boltCountPerSide - 1) : 0;

echo(BoltSpacing=boltSpacing);

if (bracketType==1)
  hollowBracket(showAssembly);
else
  solidBracket(showAssembly);


module holeFillet(r) {
  rotate([-90,0,-45]) scale([sqrt(2),1,1]) rotate_extrude() translate([-dCounterbore/2,-r,0]) 
  translate([-r,0]) fil_2d_i(r=r,angle=90,extendX=1,extendY=1);
}

// 2d primitive for fillets.
module fil_2d_i(r, angle=90, extendX=0, extendY=0) {
  x1 = r + extendX;
  y1 = r + extendY;
  x2 = r * sin(angle);
  y2 = r * cos(angle);
  difference() {
    polygon((angle > 180) ?
      [[0,0],[0,y1],[x1,y1],[x1,-r],[x2,-r]]:  
      [[0,0],[0,y1],[x1,y1],[x1,y2],[x2,y2]]
    );
    scale([rScale,1]) circle(r=r);
  }
}

module solidBracket(showAssembly){
  difference() {
    linear_extrude(unitWidth*extrusionUnits) {
      polygon([
        [0,0],
        [sideLength,0],
        [sideLength,thicknessUnderBolt],
        [thicknessUnderBolt,sideLength],
        [0,sideLength]
      ]);
    }
    for(j = [0 : 2 : 2*(extrusionUnits-1)])
      for(i = [0 : boltCountPerSide-1]) {
        pos = holeEdgeOffset2 + i*boltSpacing;
        translate([pos,0,(j+1)*unitWidth/2]) rotate([-90,0,0])
          boltHole(dBolt + boltClearance, dCounterbore, sideLength, thicknessUnderBolt);
        translate([0,pos,(j+1)*unitWidth/2]) rotate([0,90,0])
          boltHole(dBolt + boltClearance, dCounterbore, sideLength, thicknessUnderBolt);
        if (fillet) translate([pos,holeEdgeOffset2 + (boltCountPerSide-1-i)*boltSpacing,(j+1)*unitWidth/2])
            holeFillet(rFillet);
      }
  }

  if (showAssembly) {
    color([0.2,0.2,0.2,1])
    for(j = [0 : 2 : 2*(extrusionUnits-1)])
      for(i = [0 : boltCountPerSide-1]) {
        translate([holeEdgeOffset2 + i*boltSpacing,0,(j+1)*unitWidth/2]) rotate([-90,0,0])
          bolt(dBolt, dBoltHead, boltLength, thicknessUnderBolt, boltHeadHeight);
        translate([0,holeEdgeOffset2 + i*boltSpacing,(j+1)*unitWidth/2]) rotate([0,90,0])
          bolt(dBolt, dBoltHead, boltLength, thicknessUnderBolt, boltHeadHeight);
      }
  }
}

module hollowBracket(showAssembly){
  th = thicknessUnderBolt;
  th2= braceThickness;
  r2 = rCutout;
  
  difference() {
    linear_extrude(unitWidth*extrusionUnits, convexity=3) {
      difference() {
        polygon([
          [0,0],
          [sideLength,0],
          [sideLength,th],
          [th,sideLength],
          [0,sideLength],
        ]);
        hull() {
          translate([th2+r2,th2+r2]) circle(r=r2);
          translate([sideLength+th-th2*(1+sqrt(2))-r2*(1+sqrt(2)),th2+r2]) circle(r=r2);
          translate([th2+r2,sideLength+th-th2*(1+sqrt(2))-r2*(1+sqrt(2))]) circle(r=r2);
        }
      }
    }
    for(j = [0 : 2 : 2*(extrusionUnits-1)])
      for(i = [0 : boltCountPerSide-1]) {
        pos = holeEdgeOffset2 + i*boltSpacing;
        translate([pos,0,(j+1)*unitWidth/2]) rotate([-90,0,0])
          boltHole(dBolt + boltClearance, dCounterbore, sideLength, th);
        translate([0,pos,(j+1)*unitWidth/2]) rotate([0,90,0])
          boltHole(dBolt + boltClearance, dCounterbore, sideLength, th);
        if (fillet) translate([pos,holeEdgeOffset2 + (boltCountPerSide-1-i)*boltSpacing,(j+1)*unitWidth/2])
            holeFillet(rFillet);
      }
  }

  if (showAssembly) {
    color([0.2,0.2,0.2,1])
    for(j = [0 : 2 : 2*(extrusionUnits-1)])
      for(i = [0 : boltCountPerSide-1]) {
        translate([holeEdgeOffset2 + i*boltSpacing,0,(j+1)*unitWidth/2]) rotate([-90,0,0])
          bolt(dBolt, dBoltHead, boltLength, th, boltHeadHeight);
        translate([0,holeEdgeOffset2 + i*boltSpacing,(j+1)*unitWidth/2]) rotate([0,90,0])
          bolt(dBolt, dBoltHead, boltLength, th, boltHeadHeight);
      }
  }
}

module boltHole(dBolt, dCounterbore, height, headOffset) {
  translate([0,0,-0.1]) 
    cylinder(d=dBolt,h=height);
  translate([0,0,headOffset]) 
    cylinder(d=dCounterbore,h=height);
}

module bolt(dBolt, dBoltHead, length, headOffset, headHeight) {
  translate([0,0,headOffset-length+0.1]) 
    cylinder(d=dBolt,h=length+0.2);
  translate([0,0,headOffset]) 
    cylinder(d=dBoltHead,h=headHeight);
}
