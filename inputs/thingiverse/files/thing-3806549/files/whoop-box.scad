part = "both";//[both, bottom, top]

// Diameter of the hoops
hoopDiameter = 36.2;
// Spacing between motor centers, side to side not diagonal
hoopSpacing = 46;
// Height of bottom piece - this should be from the table till the top of the hoops
whoopHeight = 18;
// Height from the top of the hoops to the top of the canopy
whoopHeightTop = 23;

// Wall thickness
walls = 2.0;
// Bottom thickness
bottom = 1.2;
// Top thickness
top = 1.2;

/* [Batteries] */
batteryHeight = 61;
batteryWidth = 6.6;
batteryLength = 11.2;
batterySlotDepth = 13;
batterySlotDepthOuter = 26  ;
batterySpacing = 1;
batteryOffsetY = 2;

/* [Magnet] */
magnetShape = "square"; // [square, round]
// Width of the magnet - used as diameter when round magnet is chosen
magnetWidth = 8;
// Length of the magnet - ignored when round magnet is chosen
magnetLength = 3;
// Height of the magnet
magnetHeight = 2;
// Offset from the wall
magnetOffsetX = 1;

/* [Hinge] */
hingeWall = 2;
hingeHole = 2;
hingeLengthBottom = 20;
hingeLengthTop = 30;

/* Misc */
topWidth = 31;
squareWidth = 54;
squareLength = 60;
squareLengthTop = 60;

/* [Hidden] */
hoopRadius = hoopDiameter / 2;
bottomHeight = bottom + whoopHeight;
topHeight = top + whoopHeightTop;
totalLength = hoopDiameter + hoopSpacing;
outerLength = totalLength + walls * 2;
squareOffsetX = (totalLength - squareWidth) / 2 - 3;
squareOffsetY = (totalLength - squareWidth) / 2;
magnetOffsetY = (totalLength - magnetWidth) / 2;
magnetRadius = magnetWidth / 2;

$fn = 90;

if(part == "bottom") {
  bottom();
}

if(part == "top") {
  top();
}

if(part == "both") {
  bottom();
  
  translate([0, outerLength + 5, 0])
    top();
}

module base(height) {
  hull() {
    cylinder(r=hoopRadius + walls, h = height);
    translate([hoopSpacing, 0, 0])
      cylinder(r=hoopRadius + walls, h = height);
    translate([hoopSpacing, hoopSpacing, 0])
      cylinder(r=hoopRadius + walls, h = height);
    translate([0, hoopSpacing, 0])
      cylinder(r=hoopRadius + walls, h = height);
  }
}

module magnetCutout(zOffset) {
  if(magnetShape == "square") {
    translate([-hoopRadius + magnetOffsetX, -hoopRadius + magnetOffsetY, zOffset])
      cube([magnetLength, magnetWidth, magnetHeight + 0.1]);
  }

  if(magnetShape == "round") {
    translate([-hoopRadius + magnetOffsetX + magnetRadius, -hoopRadius + totalLength / 2, zOffset])
      cylinder(r = magnetRadius, h = magnetHeight + 0.1);
  }
}

module batterySlots() {
  translate([-hoopRadius + totalLength - batteryHeight - 10, -hoopRadius+ batteryOffsetY, topHeight - batteryLength - batterySpacing])
    cube([batteryHeight, batteryWidth, batteryLength]);

  translate([-hoopRadius + totalLength - batteryHeight - 2, -hoopRadius+ batteryOffsetY + batteryWidth + batterySpacing, topHeight - batteryLength - batterySpacing])
    cube([batteryHeight, batteryWidth, batteryLength]);

  translate([-hoopRadius + totalLength - batteryHeight - 2, -hoopRadius+ batteryOffsetY + (batteryWidth + batterySpacing) * 2, topHeight - batteryLength - batterySpacing])
    cube([batteryHeight, batteryWidth, batteryLength]);
}

module batteryBlock() {
  hull() {
    translate([-hoopRadius + totalLength - batterySlotDepth, -hoopRadius - walls, 0])
      cube([batterySlotDepth, (outerLength - topWidth) / 2, topHeight]);
    translate([-hoopRadius + totalLength - batterySlotDepthOuter, -hoopRadius - walls, 0])
      cube([batterySlotDepthOuter, 0.1, topHeight]);
  }
}

module top() {
  difference() {

    group() {
      base(topHeight);

      translate([-hoopRadius + totalLength + walls + hingeHole / 2, -hoopRadius + (totalLength - hingeLengthTop) / 2 + 0.1, topHeight])
        rotate([-90, 0, 0])
          cylinder(r=hingeHole / 2 + hingeWall, h = hingeLengthTop - 0.2);
    }
    
    translate([0, 0, top]) {
      cylinder(r=hoopRadius, h = topHeight);
      translate([hoopSpacing, 0, 0])
        cylinder(r=hoopRadius, h = topHeight);
      translate([hoopSpacing, hoopSpacing, 0])
        cylinder(r=hoopRadius, h = topHeight);
      translate([0, hoopSpacing, 0])
        cylinder(r=hoopRadius, h = topHeight);
    }
    
    
    translate([-hoopRadius + totalLength + walls + hingeHole / 2, -hoopRadius - walls - 1, topHeight])
    rotate([-90, 0, 0])
      cylinder(r=hingeHole / 2, h = outerLength + 2);

    translate([-hoopRadius + totalLength + walls + hingeHole / 2, -hoopRadius + (totalLength - hingeLengthBottom) / 2 - 0.1, topHeight])
      rotate([-90, 0, 0])
        cylinder(r=hingeHole / 2 + hingeWall + 0.1, h = hingeLengthBottom + 0.2);
    
    translate([-hoopRadius + squareOffsetX, -hoopRadius + squareOffsetY, bottom])
      cube([squareLengthTop, squareWidth, topHeight]);
    
    translate([0, -hoopRadius, bottom])
      cube([hoopSpacing, totalLength, topHeight]);

    translate([0, 0, bottom])
      cube([totalLength - hoopRadius, hoopSpacing, topHeight]);

    magnetCutout(topHeight - magnetHeight);
  }      
  intersection() {
    base(topHeight);
    difference() {
      group() {
        batteryBlock();
        
        translate([0, hoopSpacing, 0])
          mirror([0,1,0])
            batteryBlock();
      }
      
      translate([-hoopRadius + totalLength - batterySlotDepth - 1, -hoopRadius - walls + (outerLength - topWidth) / 2, 0])
        cube([outerLength, topWidth, topHeight + 2]);

      batterySlots();
      translate([0, hoopSpacing, 0])
        mirror([0,1,0])
          batterySlots();
    }
  }
}

module bottom() {
  difference() {
    group() {
      hull() {
        cylinder(r=hoopRadius + walls, h = bottomHeight);
        translate([hoopSpacing, 0, 0])
          cylinder(r=hoopRadius + walls, h = bottomHeight);
        translate([hoopSpacing, hoopSpacing, 0])
          cylinder(r=hoopRadius + walls, h = bottomHeight);
        translate([0, hoopSpacing, 0])
          cylinder(r=hoopRadius + walls, h = bottomHeight);
      }

      translate([-hoopRadius + totalLength + walls + hingeHole / 2, -hoopRadius + (outerLength - hingeLengthBottom) / 2 - walls, bottomHeight])
        rotate([-90, 0, 0])
          cylinder(r=hingeHole / 2 + hingeWall, h = hingeLengthBottom);
    }

    translate([0, 0, bottom]) {
      cylinder(r=hoopRadius, h = bottomHeight);
      translate([hoopSpacing, 0, 0])
        cylinder(r=hoopRadius, h = bottomHeight);
      translate([hoopSpacing, hoopSpacing, 0])
        cylinder(r=hoopRadius, h = bottomHeight);
      translate([0, hoopSpacing, 0])
        cylinder(r=hoopRadius, h = bottomHeight);
    }
    
    translate([-hoopRadius + squareOffsetX, -hoopRadius + squareOffsetY, bottom])
      cube([squareLength, squareWidth, bottomHeight]);

    magnetCutout(bottomHeight - magnetHeight);
    translate([-hoopRadius + totalLength + walls + hingeHole / 2, -hoopRadius - walls - 1, bottomHeight])
    rotate([-90, 0, 0])
      cylinder(r=hingeHole / 2, h = outerLength + 2);

    difference() {
      translate([-hoopRadius + totalLength + walls + hingeHole / 2, -hoopRadius + (outerLength - hingeLengthTop) / 2 - walls, bottomHeight])
        rotate([-90, 0, 0])
          cylinder(r=hingeHole / 2 + hingeWall + 0.1, h = hingeLengthTop);
    
      translate([-hoopRadius + totalLength + walls + hingeHole / 2, -hoopRadius + (outerLength - hingeLengthBottom) / 2 - walls, bottomHeight])
        rotate([-90, 0, 0])
          cylinder(r=hingeHole / 2 + hingeWall + 0.1, h = hingeLengthBottom);
    }
  }
}