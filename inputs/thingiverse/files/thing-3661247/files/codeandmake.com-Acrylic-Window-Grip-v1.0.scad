/*
 * Acrylic Window Grip by Code and Make (https://codeandmake.com/) is licensed under a Creative
 * Commons Attribution 4.0 International License (http://creativecommons.org/licenses/by/4.0/).
 *
 * https://www.thingiverse.com/thing:3661247
 * v1.0 (07 June 2019)
 */

/* [General] */

// length of strip (in mm)
length = 200; // 0.1

// overall thickness of the material (in mm)
materialThickness = 3; // 0.1

// thickness of your acrylic (in mm) - oversize slightly
acrylicThickness = 3.5; // 0.1

// single or double grip - use single for door seals
gripType = "double"; // [double:Double, single:Single]

// depth of the grip groove (in mm)
gripDepth = 5; // 0.1


/* [Taper] */

// taper angle of left end (> -90 and < 90)
leftEndTaperAngle = 0; // [-89:0.1:89.9]

// taper angle of right end (> -90 and < 90)
rightEndTaperAngle = 0; // [-89.9:0.1:89.9]


/* [Screws] */

// the total number of screw holes
numberOfScrewHoles = 3;

// diameter of the screw holes (in mm)
screwHoleDiameter = 4; // 0.1

// diameter of the screw head (in mm)
screwHeadDiameter = 8; // 0.1

// countersink screw holes
countersinkScrews = 1; // [0:No, 1:Yes]

// countersink angle (82 and 90 are common)
countersinkAngle = 90; // [0.0:0.1:180.0]

// depth to counterbore screws (in mm)
counterboreDepth = 0; // 0.1

// width of the screw plate (in mm)
screwPlateWidth = 12; // 0.1


/* [Bevel] */

// bevel the grip
bevelGrip = 1; // [0:No, 1:Yes]

// bevel the base
bevelBase = 1; // [0:No, 1:Yes]


module acrylicWindowGrip(
length = length,
materialThickness = materialThickness,
acrylicThickness = acrylicThickness,
gripType = gripType,
gripDepth = gripDepth,

leftEndTaperAngle = leftEndTaperAngle,
rightEndTaperAngle = rightEndTaperAngle,

numberOfScrewHoles = numberOfScrewHoles,
screwHoleDiameter = screwHoleDiameter,
screwHeadDiameter = screwHeadDiameter,
countersinkScrews = countersinkScrews,
countersinkAngle = countersinkAngle,
counterboreDepth = counterboreDepth,
screwPlateWidth = screwPlateWidth,

bevelGrip = bevelGrip,
bevelBase = bevelBase) {

  // clamp values
  lengthClamped = max(length, 0);
  materialThicknessClamped = max(materialThickness, 0);
  acrylicThicknessClamped = max(acrylicThickness, 0);
  gripDepthClamped = max(gripDepth, 0);
  screwHoleDiameterClamped = max(screwHoleDiameter, 0);
  screwHeadDiameterClamped = max(screwHeadDiameter, 0);
  countersinkAngleClamped = max(countersinkAngle, 0);
  counterboreDepthClamped = max(counterboreDepth, 0);
  screwPlateWidthClamped = max(screwPlateWidth, 0);

  numberOfScrewHolesClamped = floor(max(min(numberOfScrewHoles, lengthClamped / (max(screwHoleDiameterClamped, screwHeadDiameterClamped) + 0.5)), 0));

  $fn = 100;
  
  gripWidth = acrylicThicknessClamped + (materialThicknessClamped * 2);
  
  totalWidth = screwPlateWidthClamped + gripWidth;
  totalHeight = materialThicknessClamped + gripDepthClamped;

  module plate(length, minWidth, width, thickness, vertical, flip) {
    bevelWidth = min(width - minWidth, thickness);
    plateWidth = width - bevelWidth;
    
    rotate([(vertical ? 90 : 0), 0, 0]) {
      translate([0, 0, (vertical ? -thickness : 0)]) {
        cube([length, plateWidth, thickness]);
        if (bevelWidth) {
          translate([0, plateWidth, 0]) {
            mirror([0, 0, (flip ? 1 : 0)]) {
              translate ([0, 0, (flip ? -thickness : 0)]) {
                resize([0, bevelWidth, thickness]) {
                  intersection() {
                    cube([length, 1, 1]);
                    rotate([0, 90, 0]) {
                      cylinder(length, 1, 1);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  module taper(angle, width, height) {
    hypotenuse = height / cos(abs(angle));
    opposite = hypotenuse * sin(abs(angle));
    translate([(angle < 0 ? opposite : 0), -1, 0]) {
      rotate([0, angle, 0]) {
        translate([-height, 0, 0]) {
          cube([height, width, hypotenuse]);
        }
      }
    }
  }
  
  module screwHole(holeDepth, holeDiameter, headDiameter, boreDepth, aboveHoleBoreDepth, sinkAngle) {
    boreDiameter = (holeDiameter > 0 ? max(holeDiameter, headDiameter) : 0);
    countersinkAdjacent = (boreDiameter / 2) / tan(sinkAngle / 2);

    translate([0, 0, -0.001]) {
      // screw hole
      cylinder(holeDepth + 0.002, holeDiameter / 2, holeDiameter / 2, false);

      // countersink
      if (sinkAngle > 0) {
        translate([0, 0, holeDepth - countersinkAdjacent - boreDepth]) {
          cylinder(countersinkAdjacent + 0.002, 0, (boreDiameter / 2), false);
        }

        // above hole and bore
        translate([0, 0, holeDepth - boreDepth]) {
          cylinder(boreDepth + aboveHoleBoreDepth + 0.002, boreDiameter / 2, boreDiameter / 2, false);
        }
      } else {
        // full bore
        cylinder(holeDepth + aboveHoleBoreDepth + 0.002, boreDiameter / 2, boreDiameter / 2, false);
      }
    }      
  }
  
  difference() {
    union() {
      // base plate
      if (gripType == "single") {
        basePlateWidth = screwPlateWidthClamped + materialThicknessClamped;
        translate([0, materialThicknessClamped + acrylicThicknessClamped, 0]) {
          plate(lengthClamped, (bevelBase ? materialThicknessClamped : basePlateWidth), basePlateWidth, materialThicknessClamped);
        }
      } else {
        plate(lengthClamped, (bevelBase ? gripWidth : totalWidth), totalWidth, materialThicknessClamped);
      }

      // inside grip
      translate([0, materialThicknessClamped + acrylicThicknessClamped, 0]) {
        plate(lengthClamped, (bevelGrip ? materialThicknessClamped : totalHeight), totalHeight, materialThicknessClamped, true, true);
      }
      
      // outside grip
      if (gripType != "single") {
        plate(lengthClamped, (bevelGrip ? materialThicknessClamped : totalHeight), totalHeight, materialThicknessClamped, true);
      }
    }
    
    // screw holes
    if(numberOfScrewHolesClamped > 0 && screwPlateWidthClamped >= max(screwHoleDiameterClamped, screwHeadDiameterClamped)) {
      holeSpacing = (length / floor(numberOfScrewHolesClamped));

      for (i = [1:numberOfScrewHolesClamped]) {
        translate([(holeSpacing * i) - (holeSpacing / 2), (materialThicknessClamped * 2) + acrylicThicknessClamped + ((screwPlateWidthClamped - (bevelBase ? materialThicknessClamped : 0)) / 2), 0]) {
          screwHole(materialThicknessClamped, screwHoleDiameterClamped, screwHeadDiameterClamped, counterboreDepthClamped, gripDepthClamped + 0.1, (countersinkScrews ? countersinkAngleClamped : 180));
        }
      }
    }
    
    // left end taper
    if (leftEndTaperAngle != 0) {
      taper(leftEndTaperAngle, totalWidth + 2, totalHeight);
    }
    
    // right end taper
    if (rightEndTaperAngle != 0) {
      translate([lengthClamped, 0, 0]) {
        mirror([0, 1, 0,]) {
          rotate([0, 0, 180]) {
            taper(rightEndTaperAngle, totalWidth + 2, totalHeight);
          }
        }
      }
    }
  }
}

acrylicWindowGrip();