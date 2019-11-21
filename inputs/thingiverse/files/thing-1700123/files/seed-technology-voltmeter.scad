/**
 * Available displays:
 * 
 * Seed Technology:
 * + http://media.digikey.com/pdf/Data%20Sheets/Seeed%20Technology/114990163_Web.pdf
 */

/* [Settings] */

// Height of the border
height = 4;

// Wall thickness border top and bottom.
walls = 1.5;
// Wall thickness border left and right.
wallsSide = 5;
// Wall thickness lid.
wallsLid = 1;

// Tolerance for the display.
spacing = 0.25;
// Tolerance for the lid.
spacingLid = 0.025;

/* [Display measurements] */

// Display length
displayLength = 22.6;
// Display width.
displayWidth = 10;
// Display height without the board.
displayHeight = 6.3;

// Board length.
boardLength = 30;
// Board width.
boardWidth = 11;
// Board height including components on the back.
boardHeight = 2.5;

/* [Hidden] */

$fn = 360;

screwHoleDiameter = 2;

segmentLength = 7;
paddingSegment = 2.2;

//seedVoltMeter(displayColor, "green", holes);
//seedVoltMeter(displayColor, "yellow", holes);
//seedVoltMeter(displayColor, "red", holes);
//seedVoltMeter(displayColor, "blue", holes);
holder(height);

module holder(height) {
  heightLid = wallsLid + height + boardHeight + 1;

  outerLength = displayLength + (wallsSide + spacing ) * 2;
  outerWidth = displayWidth + (walls + spacing ) * 2;
  
  innerLength = displayLength + spacing * 2;
  innerWidth = displayWidth + spacing * 2;

  outerLengthTop = outerLength + (wallsLid + spacing + spacingLid ) * 2;
  outerWidthTop = outerWidth + (wallsLid + spacing + spacingLid) * 2;
  innerLengthTop = outerLengthTop - wallsLid * 2;
  innerWidthTop = outerWidthTop - wallsLid * 2;

  outletWidth = 4;
  xOffsetOutlet = outerLength + spacing + walls - outletWidth - 4.75;

  module bottom() {
    difference() {
      cube([outerLength, outerWidth, height]);

      translate([wallsSide, walls, -1])
        cube([innerLength, innerWidth, height + 2]);
    }
  }

  module top() {
    difference() {
      cube([outerLengthTop, outerWidthTop, heightLid]);

      translate([wallsLid, wallsLid, wallsLid])
        cube([innerLengthTop, innerWidthTop, heightLid  + 1]);

      translate([xOffsetOutlet, -1, wallsLid])
        cube([outletWidth, walls + 2, heightLid + 1]);
    }
  }

  translate([-outerLengthTop / 2, -outerWidthTop - 1, 0])
    top();

  translate([-outerLengthTop / 2, 1, 0])
    bottom();
}

module seedVoltMeter(displayColor="white", ledColor="green", holes=true) {
  screwHoleRadius = screwHoleDiameter /2 ;
  padding = (boardLength - displayLength) / 2;

  segmentWidth = (displayLength - paddingSegment * 4) / 3;

  segments = [
    [padding + 1.5, 1.5, boardHeight],
    [padding + segmentWidth + paddingSegment * 2, 1.5, boardHeight],
    [padding + (segmentWidth + paddingSegment) * 2 + paddingSegment, 1.5, boardHeight]
  ];

  translate([-boardLength / 2, -displayWidth / 2, 0]) {
    color("green") {
      difference() {
        cube([boardLength, boardWidth, boardHeight]);
        
        width = boardWidth / 3 + 1;
        length = (boardLength - displayLength) / 2 + 1;

        translate([-1, -1, -1])
          cube([length, width, boardHeight + 2]);

        translate([boardLength - length + 1, -1, -1])
          cube([length, width, boardHeight + 2]);
        
        translate([boardLength - length + 1, boardWidth -width + 1, -1])
          cube([length, width, boardHeight + 2]);
        
        translate([-1, boardWidth -width + 1, -1])
          cube([length, width, boardHeight + 2]);
        
        translate([length / 2 - 0.5, boardWidth / 2, -1])
          cylinder(r=screwHoleRadius, h = boardHeight + 2);
        translate([boardLength -length / 2 + 0.5, boardWidth / 2, -1])
          cylinder(r=screwHoleRadius, h = boardHeight + 2);
      }
    }
    color(displayColor)
      group() {
        difference() {
          translate([padding, 0, boardHeight])
            cube([displayLength, displayWidth, displayHeight]);

          if(holes)
            for(pos=segments)
              translate(pos)
                segment(displayHeight + 1);
        }
      }

      if(holes)
        for(pos=segments)
          translate(pos)
            color(ledColor)
              segment(displayHeight);
  }

  module segment(height, color="white") {
    length = segmentWidth - 2;
    width = 0.5;
    horizontal = [
      [1, 0, 0],
      [1, (segmentLength - width) / 2, 0],
      [1, segmentLength - width, 0]
    ];

    vertical = [
      [0, width, 0],
      [segmentWidth - width, width, 0],
      [0, width + (segmentLength - width * 3) / 2 +width, 0],
      [segmentWidth - width, width + (segmentLength - width * 3) / 2 +width, 0]
    ];

    group() {
      for(pos=horizontal)
        translate(pos)
          cube([length, width, height]);

      for(pos=vertical)
        translate(pos)
          cube([width, (segmentLength - width * 3) / 2, height]);

      translate([segmentWidth + width * 1.5, 0, 0])
        cube([width, width, height]);
    }
  }
}