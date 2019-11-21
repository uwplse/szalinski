
// psWidth of power supply
psWidth=100;

// height of power supply
psHeight=33;

// depth of shield box
psBoxDepth=45;

// sides thickness
thickness=2.5;

// euro connector width
euroConnWidth=27.5;

// euro connector height
euroConnHeight=20;

// euro connector holes distance
euroConnHolesDistance=39;

// euro connector hole diameter
euroConnHoleDiameter=3.5;

// euro connector offset from center X
euroConnOffset=25;

// diameter of output voltage hole
outputHoleDiameter=16;

// offset of output voltage hole from center X
outputHoleOffset=-30;

// position of left mount hole (list of [x,y]) from right bottom corner as you see from left side of power supply
leftMountHoles=[[25,6.5]];

// position of right mount hole (list of [x,y]) from left bottom corner as you see from right side of power supply
rightMountHoles=[[25,6.5], [25,15.5]];

// diameter of mount hole
mountHoleDiameter=4.8;

module euroConn() {
  union() {
    square ([euroConnWidth, euroConnHeight], center=true);
    translate ([-euroConnHolesDistance/2,0]) circle (d=euroConnHoleDiameter, center=true, $fn=100);
    translate ([euroConnHolesDistance/2,0]) circle (d=euroConnHoleDiameter, center=true, $fn=100);
  }
}

module rect() {
  square ([psWidth,psHeight-2*thickness], center=true);
}

module box() {
  union() {
    translate ([0,0,thickness])
    linear_extrude (height=psBoxDepth)
    difference() {
      offset (r=thickness, $fn=100) rect();
      rect();
    }
    
    linear_extrude (height=thickness)
    difference() {  
      offset (r=thickness, $fn=100) square ([psWidth,psHeight-2*thickness], center=true);
      translate([-euroConnOffset,0]) euroConn();
      translate([-outputHoleOffset,0]) circle (d=outputHoleDiameter, $fn=100);
    }
  }
}

function calcMaxX (v, i, curMax) =
     i == len(v) ?  curMax  : (v[i][0] > curMax ?  calcMaxX (v, i + 1, v[i][0]) : calcMaxX (v, i + 1, curMax));

module clampPlate (coords) {
  maxX = calcMaxX (coords,0, -999999);
  
  linear_extrude (height=thickness)
  difference() {
    square ([maxX + mountHoleDiameter * 1.5, psHeight-2*thickness]);
    
    for (c = [0 : len(coords) - 1]) translate ([coords[c][0],coords[c][1]]) circle (d=mountHoleDiameter, $fn=100);
  }
}

union() {
  box();
  translate([-psWidth/2-thickness,(psHeight-2*thickness)/2,psBoxDepth+thickness]) rotate ([180,270,0]) clampPlate (leftMountHoles);
  
  translate ([psWidth/2, (psHeight-2*thickness)/2, psBoxDepth+thickness])
  rotate ([180,270,0])
  clampPlate (rightMountHoles);
}

