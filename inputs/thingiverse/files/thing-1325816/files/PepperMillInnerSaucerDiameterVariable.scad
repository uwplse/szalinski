//
// Pepper Mill Inner Saucer - Diameter Variable by Robert Halter
//
// Licensed: Creative Commons - Attribution - Non-Commercial - Share Alike (by-nc-sa)
// see: http://en.wikipedia.org/wiki/Creative_Commons
//
// File: PepperMillInnerSaucerDiameterVariable.scad
//
// author: Robert Halter - CH - 08.02.2016
//
// with:   OpenSCAD Version 2015.03
//
// History
// 08.02.2016
// - Initial Version
//

use <write/Write.scad>

/* [Parameters] */
//
// exact mill outer Diameter [mm]
millOuterDiameter = 55;
//
// exact mill inner Diameter [mm]
millInnerDiameter = 45;
//
/* [Hidden] */

// $fa is the minimum angle for a fragment.
// Even a huge circle does not have more fragments than 360 divided by this number.
// The default value is 12 (i.e. 30 fragments for a full circle).
// The minimum allowed value is 0.01.
// Any attempt to set a lower value will cause a warning.
// $fa = 3; // 12

// $fn is usually 0. When this variable has a value greater than zero,
// the other two variables are ignored
// and full circle is rendered using this number of fragments.
// The default value is 0.
$fn = 60;

//
// Thickness of Wall [mm]
wallThickness = 2;
//
// Thickness of Bottom [mm]
bottomThickness = 2;
//
// inner Wall Height [mm]
innerWallHeight = 15;
//
// horziontal and vertical Edges Cut [mm] 
edgesCut = 0.4;

// calculated Values
// [mm]
saucerOuterDiameter = millOuterDiameter + 12;

// [mm]
wallOuterDiameter = millInnerDiameter - 1;

// [mm]
wallInnerDiameter = wallOuterDiameter - wallThickness;

// [mm]
labelInnerDiameter = millOuterDiameter + 1;

// [mm]
labelOuterDiameter = saucerOuterDiameter - 2;

// [mm]
labelThickness = (labelOuterDiameter - labelInnerDiameter) / 2;

// [mm]
labelHeight = innerWallHeight;

labelFont = "orbitron.dxf"; 

// Start of construction

difference() {
  union() {
    Bottom();
    Wall();
    InnerConnectorWallToBottom();
    Pepper();
  };
  trimTheWallTopOuterEdges();
  trimTheWallTopInnerEdges();
  trimTheSoucerTopOuterEdges();
  trimTheSoucerBottomOuterEdges();
}

// Bottom
module Bottom() {
  cylinder(h = bottomThickness,
           d = saucerOuterDiameter,
           center = false);
}

// Wall
module Wall() {
  translate([0, 0, bottomThickness]) {
    difference() {
      cylinder(h = innerWallHeight,
               d = wallOuterDiameter,
               center = false);
      translate([0, 0, -0.01]) {
        cylinder(h = innerWallHeight + 0.02,
                 d = millInnerDiameter - 0.5 - wallThickness,
                 center = false);
      }
    }
  }
}

module InnerConnectorWallToBottom() {
  translate([0, 0, bottomThickness - 0.01]) {
    // add Connector at inner Wall to Bottom
    difference() {
      cylinder(h = edgesCut,
               d = wallInnerDiameter + 0.1,
               center = false);
      translate([0, 0, -0.01]) {
        cylinder(h = edgesCut + 0.02,
                 d1 = wallInnerDiameter - (2 * edgesCut), // Bottom of cone
                 d2 = wallInnerDiameter + 0.1,            // Top of cone
                 center = false);
      }
    }
  }
}

module Pepper() {
  difference() {
    union() {
      // Pepper in the West
      writecylinder(text = "Pepper",
                    font = labelFont,
                    center = true,
                    where = [0, 0, bottomThickness + (labelHeight / 2) - 0.01],
                    radius = (labelOuterDiameter / 2) - (labelThickness / 2),
                    h = labelHeight,
                    t = labelThickness,
                    west=90
      );
      // Stabilize Pepper in the West with a '-'
      // between 'P' and 'e'
      // and
      // between 'e' and 'r'
      writecylinder(text = "-       -",
                    font = labelFont,
                    center = true,
                    where = [0, 0, bottomThickness + (labelHeight / 2) - 0.01],
                    radius = (labelOuterDiameter / 2) - (labelThickness / 2),
                    h = labelHeight * 0.5,
                    t = labelThickness * 0.5,
                    west=90
      );
      // Pepper in the East
      writecylinder(text = "Pepper",
                    font = labelFont,
                    center = true,
                    where = [0, 0, bottomThickness + (labelHeight / 2) - 0.01],
                    radius = (labelOuterDiameter / 2) - (labelThickness / 2),
                    h = labelHeight,
                    t = labelThickness,
                    east=90
      );
      // Stabilize Pepper in the East with a '-'
      // between 'P' and 'e'
      // and
      // between 'e' and 'r'
      writecylinder(text = "-       -",
                    font = labelFont,
                    center = true,
                    where = [0, 0, bottomThickness + (labelHeight / 2) - 0.01],
                    radius = (labelOuterDiameter / 2) - (labelThickness / 2),
                    h = labelHeight * 0.5,
                    t = labelThickness * 0.5,
                    east=90
      );
    };
    // on the Bottom Side cut the lower Parts of the little P's
    translate([0, 0, 0 - 5]) {
      cylinder(h = 5 + 0.01,
               d = saucerOuterDiameter + 0.5,
               center = false);
    }
  }
}

module trimTheWallTopOuterEdges() {
  translate([0, 0, bottomThickness + innerWallHeight - edgesCut + 0.01]) {
    // cut outer Wall on Top
    difference() {
      cylinder(h = edgesCut,
               d = wallOuterDiameter + 0.01,
               center = false);
      translate([0, 0, -0.01]) {
        cylinder(h = edgesCut + 0.02,
               d1 = wallOuterDiameter,                  // Bottom of cone
               d2 = wallOuterDiameter - (2 * edgesCut), // Top of cone
                 center = false);
      }
    }
  }
}

module trimTheWallTopInnerEdges() {
  translate([0, 0, bottomThickness + innerWallHeight - edgesCut + 0.01]) {
    // cut inner Wall on Top
    difference() {
      cylinder(h = edgesCut,
               d1 = wallInnerDiameter,                  // Bottom of cone
               d2 = wallInnerDiameter + (2 * edgesCut), // Top of cone
               center = false);
      translate([0, 0, -0.01]) {
        cylinder(h = edgesCut + 0.02,
                 d = wallInnerDiameter - 0.01,
                 center = false);
      }
    }
  }
}

module trimTheSoucerTopOuterEdges() {
  translate([0, 0, bottomThickness - edgesCut + 0.01]) {
    // cut Bottom on Top
    difference() {
      cylinder(h = edgesCut,
               d = saucerOuterDiameter + 0.01,
               center = false);
      translate([0, 0, -0.01]) {
        cylinder(h = edgesCut + 0.02,
               d1 = saucerOuterDiameter,                  // Bottom of cone
               d2 = saucerOuterDiameter - (2 * edgesCut), // Top of cone
                 center = false);
      }
    }
  }
}

module trimTheSoucerBottomOuterEdges() {
  translate([0, 0, 0 - 0.01]) {
    // cut Bottom on Top
    difference() {
      cylinder(h = edgesCut,
               d = saucerOuterDiameter + 0.01,
               center = false);
      translate([0, 0, -0.01]) {
        cylinder(h = edgesCut + 0.02,
               d1 = saucerOuterDiameter - (2 * edgesCut), // Bottom of cone
               d2 = saucerOuterDiameter,                  // Top of cone
                 center = false);
      }
    }
  }
}
