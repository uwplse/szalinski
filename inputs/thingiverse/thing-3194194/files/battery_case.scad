/* [General] */
// Which part to display
part = "both"; // [bottom, top, both]
// Amount of rows
rows = 5;
// Amount of columns
cols = 4;

// Length of the compartment
length = 17.5;
// Width of the compartment
width = 14;
// Height of the compartment
height = 46.5;

// Outer thickness
outerWall = 3;
// Top and bottom thickness
bottomHeight = 1.25;
// Wall thickness between compartments
innerWalls = 0.8;

// Roundness of the corners
roundness = 2.5;

/* [Top Cover] */
// Height of above the height of the compartment
paddingTop = 17;
// Height of the connecting wall
outerWallTopHeight = 15;
// Extra height of the top piece
extraHeightTop = 7;

// Thickness of the conecting wall on bottom piece
outerWallTop = 1.5;
// Tollerance on the top piece
tolerance = 0.12;

/* [Hidden] */
$fn = 180;
totalWidthOuter = outerWall * 2 + rows * width + (rows -1) * innerWalls;
totalWidth = rows * width + (rows -1) * innerWalls;
totalLengthOuter = outerWall * 2 + cols * length + (cols -1) * innerWalls;
totalLength = cols * length + (cols -1) * innerWalls;

bottomHeightTotal = bottomHeight + height + paddingTop;

if (part == "bottom") {
  bottom();
}
if (part == "top") {
  top();
}
if (part == "both") {
  both();
}

module both() {
  bottom();
  translate([0, totalWidthOuter + 5, 0])
    top();
}

module top() {
  difference() {
    group() {
      //cube([totalLengthOuter, totalWidthOuter, bottomHeight + outerWallTopHeight + extraHeightTop]);
      hull() {
        translate([roundness, roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([totalLengthOuter - roundness, roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([totalLengthOuter - roundness, totalWidthOuter - roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([roundness, totalWidthOuter - roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
      }
    }
    translate([outerWall - outerWallTop - tolerance, outerWall - outerWallTop - tolerance, bottomHeight + extraHeightTop]) {
      //cube([totalLength + (outerWallTop + tolerance) * 2, totalWidth + (outerWallTop + tolerance) * 2, outerWallTopHeight + 1]);
      
      hull() {
        translate([roundness, roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([totalLength + (outerWallTop + tolerance) * 2 - roundness, roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([totalLength + (outerWallTop + tolerance) * 2 - roundness, totalWidth + (outerWallTop + tolerance) * 2 - roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([roundness, totalWidth + (outerWallTop + tolerance) * 2 - roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
      }
    }

    translate([outerWall, outerWall, bottomHeight]) {
      cube([totalLength, totalWidth, bottomHeightTotal]);
      /*
      hull() {
        translate([roundness, roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([totalLength - roundness, roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([totalLength - roundness, totalWidth - roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
        translate([roundness, totalWidth - roundness, 0])
          cylinder(r = roundness, h = bottomHeight + outerWallTopHeight + extraHeightTop);
      }
      */
    }
  }
}

module bottom() {
  difference() {
    group() {
      //cube([totalLengthOuter, totalWidthOuter, bottomHeightTotal - outerWallTopHeight]);
      hull() {
        translate([roundness, roundness, 0])
          cylinder(r = roundness, h = bottomHeightTotal - outerWallTopHeight);
        translate([totalLengthOuter - roundness, roundness, 0])
          cylinder(r = roundness, h = bottomHeightTotal - outerWallTopHeight);
        translate([totalLengthOuter - roundness, totalWidthOuter - roundness, 0])
          cylinder(r = roundness, h = bottomHeightTotal - outerWallTopHeight);
        translate([roundness, totalWidthOuter - roundness, 0])
          cylinder(r = roundness, h = bottomHeightTotal - outerWallTopHeight);
      }
      translate([outerWall-outerWallTop, outerWall-outerWallTop, 0]) {
        //cube([totalLengthOuter - (outerWall-outerWallTop) * 2, totalWidthOuter - (outerWall-outerWallTop) * 2, bottomHeightTotal]);
        hull() {
          translate([roundness, roundness, 0])
            cylinder(r = roundness, h = bottomHeightTotal);
          translate([totalLength + outerWallTop * 2 - roundness, roundness, 0])
            cylinder(r = roundness, h = bottomHeightTotal);
          translate([totalLength + outerWallTop* 2 - roundness, totalWidth + outerWallTop * 2 - roundness, 0])
            cylinder(r = roundness, h = bottomHeightTotal);
          translate([roundness, totalWidth + outerWallTop * 2 - roundness, 0])
            cylinder(r = roundness, h = bottomHeightTotal);
        }
      }
    }

    translate([outerWall, outerWall, bottomHeight + height])
      cube([totalLength, totalWidth, bottomHeightTotal]);
    
    translate([outerWall, outerWall, bottomHeight]) {
      for(row=[0:1:(rows - 1)]) {
        for(col=[0:1:(cols - 1)]) {
          translate([(length+innerWalls) * col, (width + innerWalls) * row, 0])
            cube([length, width, bottomHeightTotal]);
        }
      }
    }
  }
}