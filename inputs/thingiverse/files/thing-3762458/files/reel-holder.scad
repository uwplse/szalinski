/*
 * Reel holder - replacement for standard FlashForge Inventor
 * to work with reel hubs and hub adapters to accommodate a
 * wide range of standard reels.  Handles up to 200mm diameter
 * reels of up to 1kg mass.
 */

$fa = 1;
$fs = 1;

// Base Plate dimensions.
BPWidth = 50;
BPDepth = 25;
BPHeight = 10;
PinDiameter = 4;
HoleDiameter = 3.2;
PinSep = 23;
HoleSep = 35;
PinOff = 5;
HoleOff = 17;
PinH = 6;
Wall = 4;

FudgeFactor = 2;

in = 25.4;

// Standoff dimensions
SOHeight = 58;
SOWidth = 25;
SODepth = 20;
SOHoleDiameter = 6.4; // The width of the bolt used.
SOOffset = 2;
SOCollarDiameter = 12; // Max width of the inner bushing of the bearing

// Nut head
NHDepth = 5;
NHWidth = 7/16*in;
NHDiameter = NHWidth / cos(30);
NHR = NHDiameter * (1 + FudgeFactor/100) / 2;

// Various adjusted radii
PinR = PinDiameter/2*(1+FudgeFactor/100);
HoleR = HoleDiameter/2*(1+FudgeFactor/100);
SOHoleR = SOHoleDiameter/2*(1+FudgeFactor/100);
SOCollarR = SOCollarDiameter/2*(1+FudgeFactor/100);

// Base Plate
difference(){
  translate([-1*BPWidth/2,0,0]){
    cube([BPWidth,BPDepth,BPHeight]);
  }
  translate([-1*PinSep/2,PinOff,0]){
    cylinder(r=PinR,h=PinH);
  }
  translate([PinSep/2,PinOff,0]){
    cylinder(r=PinR,h=PinH);
  }
  translate([-1*HoleSep/2,HoleOff,0]) {
    cylinder(r=HoleR, h=BPHeight);
  }
  translate([HoleSep/2,HoleOff,0]) {
    cylinder(r=HoleR, h=BPHeight);
  }
}

// Nut Holder
translate([0,0,SOHeight+BPHeight]){
    difference() {
            rotate(a=-90, v=[1,0,0]) {
        cylinder(r=SOWidth/2,h=SODepth);
            }
            rotate(a=-90, v=[1,0,0]){
        cylinder(r=SOHoleR,h=SODepth);
            }
       translate([0,SODepth-NHDepth,0]){
            rotate(a=-90, v=[1,0,0]){
            cylinder(r=NHR, h=NHDepth, $fn=6);
        }
    }
    }
    translate([0,-1*SOOffset,0]){
        rotate(a=-90,v=[1,0,0]) {
        difference(){
          cylinder(r=SOCollarR, h=SOOffset);
          cylinder(r=SOHoleR, h=SOOffset);
        }
    }
}
}

// Standoff
// Front plate
difference(){
    union(){
    polyhedron(points=[
     [-1*BPWidth/2,0,BPHeight], // 0
     [BPWidth/2,0,BPHeight], // 1
     [BPWidth/2,Wall, BPHeight], // 2
     [-1*BPWidth/2,Wall,BPHeight], // 3
     [-1*SOWidth/2,0,BPHeight+SOHeight], // 4
     [SOWidth/2, 0, BPHeight+SOHeight], // 5
     [SOWidth/2, Wall, BPHeight+SOHeight], // 6
     [-1*SOWidth/2, Wall, BPHeight+SOHeight] // 7
    ],
    faces=[
    [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3] // left
    ]);
    translate([-1*Wall/2, 0, BPHeight]){
        cube([Wall, SODepth, SOHeight + Wall/2 - SOWidth/2]);
    }
    polyhedron(points=[
    [BPWidth/2,Wall, BPHeight],
    [BPWidth/2,BPDepth/2, BPHeight],
    [BPWidth/2-Wall,BPDepth/2,BPHeight],
    [BPWidth/2-Wall, Wall, BPHeight],
    [SOWidth/2,Wall, BPHeight+SOHeight],
    [SOWidth/2,BPDepth/2, BPHeight+SOHeight],
    [SOWidth/2-Wall,BPDepth/2,BPHeight+SOHeight],
    [SOWidth/2-Wall, Wall, BPHeight+SOHeight]
    ],
    faces=[
        [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3] // left
    ]);
       polyhedron(points=[
    [-1*BPWidth/2,Wall, BPHeight],
    [-1*BPWidth/2,BPDepth/2, BPHeight],
    [-1*(BPWidth/2-Wall),BPDepth/2,BPHeight],
    [-1*(BPWidth/2-Wall), Wall, BPHeight],
    [-1*SOWidth/2,Wall, BPHeight+SOHeight],
    [-1*SOWidth/2,BPDepth/2, BPHeight+SOHeight],
    [-1*(SOWidth/2-Wall),BPDepth/2,BPHeight+SOHeight],
    [-1*(SOWidth/2-Wall), Wall, BPHeight+SOHeight]
    ],
    faces=[
        [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3] // left
    ]);
}
    translate([0,0,BPHeight+SOHeight]){
      rotate(a=-90,v=[1,0,0]){
        cylinder(r=SOWidth/2,h=Wall);
      }
    }
}

