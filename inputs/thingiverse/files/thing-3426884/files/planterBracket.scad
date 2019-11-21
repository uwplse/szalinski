// Planter Bracket: attach a planter atop a cubicle partition.
// by David Pnhillip Oster
//
// Version 1.2  9/04/2019
//
// https://www.thingiverse.com/thing:3426884

// Size out of the plane.
bracketZ = 25.4;  // [0.5:0.5:100]

// length of the finger of the bracket gripping the planter.
planterFinger = 33.02;  // [0.5:0.5:100]

// Width of the planter
planterWidth = 101.6;  // [0.5:0.5:100]

// Slop to allow easy removal of the planter.
planterPadding = 2;  // [0:0.5:3]

bracketStyle = "simple";  // [sampler,  chamfered, sloped, simple]

// Treatment of partition top.
supportStyle = "circle";  // [circle, square]

// Width of the partition the planter will sit on.
partitionWidth = 28.5;  // [0.5:0.5:40]

// length of the finger of the bracket gripping the partition.
partitionFinger = 76.2; // [0.5:0.5:100]

// Thickness of the silhouette of the partition and planter fingers.
wallThick = 10; // [0.5:0.5:100]

// Thickness of the silhouette under the planter.
bottomWallThick = 10; // [0.5:0.5:100]

// Round rect radius at the top of the partition in square mode.
chamferRadius = 5;

/* [Hidden] */

// OpenSCAD can show graphic artifacts in preview mode when solids exactly touch.
// `epsilon` allows adjustment to prevent that but is too small to show in a print.
epsilon = 0.01;

planterTotalWidth = planterWidth + planterPadding;

// the left upper arm of the bracket. it grips the planter
module leftHalfBracket(bottomWallThick=bottomWallThick, wallThick=wallThick) {
  origin = [-epsilon, bottomWallThick];
  innerBottom = [planterTotalWidth/2, bottomWallThick];
  innerTop = [planterTotalWidth/2, planterFinger];
  outerTop = [planterTotalWidth/2+wallThick, planterFinger];
  outerBottom = [planterTotalWidth/2+wallThick, 0];
  originBottom = [-epsilon, -3*wallThick];
  polygon(points = [origin, innerBottom, innerTop, outerTop, outerBottom, originBottom]);
}

// the right upper arm of the bracket. it grips the planter
module rightHalfBracket(bottomWallThick=bottomWallThick, wallThick=wallThick) {
  scale([-1, 1, 1]){
    leftHalfBracket(bottomWallThick, wallThick);
  }
}

// solidPartitionFingers - partitionHole is the partition fingers.
module solidPartitionFingers(wallThick=wallThick) {
  translate([-(wallThick*2 + partitionWidth)/2, -(partitionFinger + wallThick/3)]) {
    square([wallThick*2 + partitionWidth, partitionFinger + wallThick/3]);
  }
}

// The bracket minus the hole for the partition.
module solidBracket(bottomWallThick=bottomWallThick, wallThick=wallThick) {
  leftHalfBracket(bottomWallThick, wallThick);
  rightHalfBracket(bottomWallThick, wallThick);
  solidPartitionFingers(wallThick);
}

// The hole for the partition partition. Top of the hole is at the origin.
module partitionHole() {
  translate([0, -(partitionWidth/2)]) {
    translate([-partitionWidth/2, -(partitionFinger+epsilon)]) {
      square([partitionWidth, partitionFinger+epsilon]);
    }
    if (supportStyle == "circle") {
      circle(d=partitionWidth, $fn=30);
    } else {
      hull() {
        for (j =  [-1:2:1]) {
          for (i = [-1:2:1]) {
            translate([i * ((partitionWidth-chamferRadius)/2),
                       j * ((partitionWidth-chamferRadius)/2)]) {
              circle(d=chamferRadius);
            }
          }
        }
      }
    }
  }
}

// complete simple style bracket.
module completeSimpleBracket(bottomWallThick=bottomWallThick, wallThick=wallThick, bracketZ=bracketZ) {
  linear_extrude(height = bracketZ) {
    difference() {
      solidBracket(bottomWallThick, wallThick);
      partitionHole();
    }
  }
}

module slopedSolidBracket() {
  hull() {
    completeSimpleBracket(bottomWallThick, wallThick/2, bracketZ + wallThick);
    translate([0, 0, wallThick/2]) {
      completeSimpleBracket(bottomWallThick, wallThick, bracketZ);
    }
  }
}

module chamferSolidBracket() {
  hull() {
    linear_extrude(height = bracketZ+wallThick) {
      leftHalfBracket(bottomWallThick, wallThick/2);
      rightHalfBracket(bottomWallThick, wallThick/2);
    }
    translate([0, 0, wallThick/2]) {
      linear_extrude(height = bracketZ) {
        leftHalfBracket(bottomWallThick, wallThick);
        rightHalfBracket(bottomWallThick, wallThick);
      }
    }
  }
  hull() {
    linear_extrude(height = bracketZ+wallThick) {
      solidPartitionFingers(wallThick/2);
    }
    translate([0, 0, wallThick/2]) {
      linear_extrude(height = bracketZ) {
        solidPartitionFingers(wallThick);
      }
    }
  }
}

module solidPartitionHole() {
  translate([0, 0, -wallThick/2]) {
    linear_extrude(height = bracketZ + 3*wallThick) {
      partitionHole();
    }
  }
}

module solidPlanerHole() {
  translate([-planterTotalWidth/2, bottomWallThick, -wallThick/2]) {
    cube([planterTotalWidth, 3*planterTotalWidth, bracketZ + 3*wallThick]);
  }
}

// complete slope-sided style bracket.
module completeSlopedBracket() {
  difference() {
    slopedSolidBracket();
    solidPartitionHole();
    solidPlanerHole();
  }
}


// complete chamfered style bracket.
module completeChamferBracket() {
  difference() {
    chamferSolidBracket();
    solidPartitionHole();
    solidPlanerHole();
  }
}

if (bracketStyle == "chamfered") {
  completeChamferBracket();
} else if (bracketStyle == "sloped") {
  completeSlopedBracket();
} else if (bracketStyle == "sampler"){
  completeSimpleBracket();
  translate([0, 0, bracketZ + 6*wallThick]) {
    completeChamferBracket();
  }
  translate([0, 0, 2*(bracketZ + 6*wallThick)]) {
    completeSlopedBracket();
  }
} else {  // i.e simple.
  completeSimpleBracket();
}
