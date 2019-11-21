// Customizable edge marking gauge - 1.0
// by György Balássy 2016 (http://gyorgybalassy.wordpress.com)
// http://www.thingiverse.com/thing:1399421

// The theoretical thickness of the board the gauge should fit in millimeters.
boardThickness = 18;

// You can use this value to add additional, "invisible" millimeters to the board thickness, if your printer does not print accurately, and the result gauge does not fit on your board.
accuracyCorrection = 0.5;

// The desired thickness of the walls of the gauge in millimeters. 
wallThickness = 1.6;

// The desired length of the gauge in millimeters.
length = 40;

/* [Hidden] */

fontFamily = "Arial";
fontSize = 7;
fontSizeSmall = 5;
textDepth = 0.4;
markerSize = 2;
indicatorLineMargin = 0.5;
indicatorLineWidth = 0.5;

$fa = 1;   // Default minimum facet angle.
$fs = 1;   // Default minimum facet size.
delta = 0.1; // Ensures that no faces remains after boolean operations.

fullText = str(boardThickness);
halfText = str(boardThickness / 2);

mainColor = [0.117, 0.565, 1];  // DodgerBlue: RGB(30, 144, 255)
highlightColor = [1, 1, 1];     // White

// Top part.
difference() {
  // Top board.
  color(mainColor)
    cube([boardThickness + accuracyCorrection + 2 * wallThickness, length, wallThickness]);

  // Text on the top.
  color(highlightColor)
    translate ([wallThickness + (boardThickness + accuracyCorrection) / 2, length / 2, wallThickness - textDepth]) 
      linear_extrude(height = textDepth + delta) 
        text(text = fullText, font = fontFamily, size = fontSize, halign = "center", valign = "bottom");
  
  // Indicator line below the text on the top.
  color(highlightColor)
    translate([wallThickness, length / 2 - indicatorLineMargin, wallThickness - textDepth])
      cube([boardThickness + accuracyCorrection, indicatorLineWidth, textDepth + delta]);
  
  // Near marker on the top.
  color(highlightColor)
    translate([wallThickness + (boardThickness + accuracyCorrection) / 2 - markerSize / 2, -delta, -delta / 2])
      linear_extrude(height = wallThickness + 2 * delta)
        polygon(points = [ [0, 0], [markerSize, 0], [markerSize / 2, markerSize] ]);  
  
  // Far marker on the top.
  color(highlightColor)
    translate([wallThickness + (boardThickness + accuracyCorrection) / 2 - markerSize / 2, length - markerSize + delta, -delta / 2])
      linear_extrude(height = wallThickness + 2 * delta)
        polygon(points = [ [0, markerSize + delta], [markerSize / 2, 0], [markerSize, markerSize + delta] ]);    
}

// Left part.
difference() {
  // Left side.
  color(mainColor)
    translate([0, 0, -boardThickness])
      cube([wallThickness, length, boardThickness]);

  // Text on the left side.
  color(highlightColor)
    translate([textDepth, length / 2, -boardThickness / 2])
      rotate([0, -90, 0])
        linear_extrude(height = textDepth + delta)
          text(text = fullText, font = fontFamily, size = fontSize, halign = "center", valign = "bottom");
  
  // Indicator line below the text on the left side.
  color(highlightColor)
    translate([textDepth, length / 2 - indicatorLineMargin, -boardThickness + indicatorLineMargin])
      rotate([0, -90, 0])
        cube([boardThickness - 2 * indicatorLineMargin, indicatorLineWidth, textDepth + delta]);
}

// Right part.
difference() {
  // Right side.
  color(mainColor)
    translate([boardThickness + wallThickness + accuracyCorrection, 0, -boardThickness / 2])
      cube([wallThickness, length, boardThickness / 2]);

  // Text on the right side.
  color(highlightColor)
    translate([boardThickness + accuracyCorrection + 2 * wallThickness - textDepth, length / 2, -boardThickness / 4])
      rotate([0, 90, 0])
        linear_extrude(height = textDepth + delta)
          text(text = halfText, font = fontFamily, size = fontSizeSmall, halign = "center", valign = "bottom");
  
  // Indicator line below the text on the right side.
  color(highlightColor)
    translate([boardThickness + accuracyCorrection + 2 * wallThickness - textDepth, length / 2 - indicatorLineMargin, -indicatorLineMargin])
      rotate([0, 90, 0])
        cube([boardThickness / 2 - 2 * indicatorLineMargin, indicatorLineWidth, textDepth + delta]);
}

 
