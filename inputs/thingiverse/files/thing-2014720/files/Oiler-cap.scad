// Oiler nozzle cap with rubber band
// by György Balássy 2016 (http://gyorgybalassy.wordpress.com)
// http://www.thingiverse.com/thing:2014720

// The thickness of the wall in mm.
wallThickness = 2;

// The inner diameter of the top, rubber band holder section (dark blue) in mm.
topDiameter = 3.5;

// The height of the top, rubber band holder section (dark blue) in mm.
topHeight = 5;

// The inner diameter of the central section (dark blue) in mm.
middleDiameter = 3.5;

// The height of the central section (dark blue) in mm.
middleHeight = 3;

// The inner diameter of the bottom section (light blue) in mm.
bottomDiameter = 6.5;

// The height of the bottom section (light blue) in mm.
bottomHeight = 20;

/* [Hidden] */

capHeight = wallThickness;

mainColor = [0.117, 0.565, 1];      // DodgerBlue: RGB(30, 144, 255)
highlightColor = [0.384, 0.726, 1]; // Lighter DodgerBlue: RGB(98, 185, 255)

$fa = 0.3;     // Default minimum facet angle.
$fs = 0.3;     // Default minimum facet size.
delta = 0.1;   // Ensures that no faces remains after boolean operations.

// Top section.
color(mainColor) {
  difference() {
    translate([0, 0, middleHeight + capHeight])
      cylinder(d1 = topDiameter + 2 * wallThickness, d2 = topDiameter + 2 * wallThickness, h = topHeight);
    
    translate([-(topDiameter + 2 * wallThickness) / 3 / 2, -(topDiameter + 2 * wallThickness) / 2, middleHeight + wallThickness - delta])
      cube([(topDiameter + 2 * wallThickness) / 3, topDiameter + 2 * wallThickness + 2 * delta, topHeight + 2 * delta]);
  }
}

// Cap.
color(highlightColor) {  
  translate([0, 0, middleHeight])
    cylinder(d1 = middleDiameter + 2 * wallThickness, d2 = topDiameter + 2 * wallThickness, h = capHeight);
}

// Middle section.
color(mainColor) {
  tube(middleDiameter, topDiameter, wallThickness, middleHeight);
}  

// Bottom section.
color(highlightColor) {
  translate([0, 0, -bottomHeight])
    tube(bottomDiameter, middleDiameter, wallThickness, bottomHeight);
} 

module tube(bottomInnerDiameter, topInnerDiameter, wallThickness, height) {
  difference() {   
    cylinder(d1 = bottomInnerDiameter + 2 * wallThickness, d2 = topInnerDiameter + 2 * wallThickness, h = height);  // Outer
    translate([0, 0, -delta])
      cylinder(d1 = bottomInnerDiameter, d2 = topInnerDiameter, h = height + 2 * delta);  // Inner
  }  
}