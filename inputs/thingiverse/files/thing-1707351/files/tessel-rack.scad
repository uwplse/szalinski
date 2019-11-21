
slotDepth = 5;

boardLength = 69;
boardWidth = 2;

boardLeftPadding = 3;
boardRightPadding = 20;

baseHeight = 2;
baseLengthPadding = 4;

numberOfTessels = 4;

module piece() {
  color("grey")
  linear_extrude( baseHeight )
  square([ boardLeftPadding + boardRightPadding + boardWidth, boardLength + ( baseLengthPadding * 2 ) ], center = true);

  translate([0,0,baseHeight])
  linear_extrude( slotDepth )

  difference() {
    square([ boardLeftPadding + boardRightPadding + boardWidth, boardLength + ( baseLengthPadding * 2 ) ], center = true);

    translate([ boardRightPadding/2 - boardWidth/2 ,0,0])
    square([ boardWidth, boardLength ], center = true);
  }
}

for( i = [0:numberOfTessels-1]) {
  translate([i* ( boardRightPadding + boardLeftPadding + boardWidth ), 0,0])
  piece();
}
