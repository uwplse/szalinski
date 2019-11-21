columnBaseRoundingRadius = 10.0;
ballRadius = 6.5;
ballOffset = 0.5;
bottomBearingRadius = 27.0;
columnHeight = 50.0;
columnBallHeight = columnHeight - 7.0;
columnRadius = 7.0;
baseHolderClearance = 2.0 * ballOffset;
bearingWallThickness = 2.0;

baseDepth = (ballRadius + bearingWallThickness) - ballOffset;
baseRadius = bottomBearingRadius + ballRadius + 2.0;

holderRadius = 30.0;
screwPointRadius = 5.0;
screwShaftRadius = 1.7;
screwHeadRadius = 3.0;
screwHeadDepth = 3.0;

spoolInnerRadius = 53.0 / 2.0;
platformRoundingRadius = columnBaseRoundingRadius - baseHolderClearance;
platformRadius = columnRadius + ballRadius + bearingWallThickness;
spoolCentreHeight = 30.0;

//Base();
Holder();
//CrossSection();
//BaseTest();
//HolderTest();
//BearingTest();

module BaseTest() {
   intersection() {
      Base();
      translate([-100, -100, 0]) cube([200, 200, 2]);
   }
}

module HolderTest() {
   difference() {
      cylinder(4.0, spoolInnerRadius, spoolInnerRadius);
      cylinder(2.0, spoolInnerRadius - 4.0, spoolInnerRadius - 4.0);
      translate([0, 0, 2.0]) {
         cylinder(2.0, spoolInnerRadius - 2.0, spoolInnerRadius - 2.0);
      }
   }
}

module BearingTest() {
   depth = ballRadius + 2.0;
   outerRadius = bottomBearingRadius + ballRadius + 2.0;
   innerRadius = bottomBearingRadius - (ballRadius + 2.0);
   difference() {
      cylinder(depth, outerRadius, outerRadius);
      translate([0, 0, baseDepth + ballOffset]) BearingBalls(bottomBearingRadius);
      cylinder(depth, innerRadius, innerRadius);
   }
}

module CrossSection() {
   difference() {
      union() {
         Holder();
         Base();
      }
      translate([0, -100, 0]) cube([200, 200, 200]);
   }
}

module Holder() {
   difference() {
      translate([0, 0, baseDepth + baseHolderClearance + platformRoundingRadius]) {
         rotate_extrude($fn=100) {
            difference() {
               hull() {
                  translate([holderRadius, 0, 0]) {
                     circle(platformRoundingRadius, $fn=35);
                  }
                  translate([columnRadius + columnBaseRoundingRadius, 0, 0]) {
                     circle(platformRoundingRadius, $fn=35);
                  }
                  translate([columnRadius + columnBaseRoundingRadius, spoolCentreHeight, 0]) {
                     circle(platformRoundingRadius, $fn=35);
                  }
                  translate([holderRadius, spoolCentreHeight, 0]) {
                     circle(platformRoundingRadius, $fn=35);
                  }
               }
               translate([spoolInnerRadius, 0, 0]) square([100, 100]);
//               translate([columnRadius + baseHolderClearance + 2.0, 2.0, 0]) {
//                  hull() {
//                     width = (spoolInnerRadius - (columnRadius + baseHolderClearance + 4.0));
//                     height = 18.0;
//                     square([width, height]);
//                     translate([width, height + width, 0]) square([0.0001, 0.0001]);
//                  }
//               }
            }
         }
      }
      translate([0, 0, baseDepth + ballOffset]) BearingBalls(bottomBearingRadius);
      translate([0, 0, columnBallHeight + baseDepth]) {
         BearingBalls(columnRadius + ballOffset);
         translate([0, columnRadius + ballOffset, 0]) {
            linear_extrude(columnBallHeight) circle(ballRadius, $fn=35);
         }
      }
   }
}

module Base() {
   difference() {
      union() {
         cylinder(baseDepth, baseRadius, baseRadius, $fn=100);
         translate([0, 0, baseDepth]) {
            Column();
         }
         ScrewPoints();
      }
      translate([0, 0, baseDepth + ballOffset]) BearingBalls(bottomBearingRadius);
      BaseCutout();
   }
}

module BaseCutout() {
   screwGapRadius = bottomBearingRadius - (ballRadius + bearingWallThickness);
   cylinder(screwHeadDepth, screwGapRadius, screwGapRadius);
   translate([0, 0, screwHeadDepth]) {
      cutoutHeight = columnBallHeight - ballRadius;
      cutoutRadius = columnRadius - bearingWallThickness;
      hull() {
         cylinder(cutoutHeight, cutoutRadius, cutoutRadius);
         translate([0, 0, cutoutHeight + cutoutRadius]) cube([0.0001, 0.0001, 0.0001]);
      }
      cylinder(columnBaseRoundingRadius, cutoutRadius + columnBaseRoundingRadius, cutoutRadius);
   }
}

module ScrewPoints() {
   for (i = [0: 3]) {
      rotate([0, 0, 90 * i]) ScrewPoint();
   }
}

module ScrewPoint() {
   translate([baseRadius + screwHeadRadius, 0, 0]) {
      difference() {
         cylinder(baseDepth, screwPointRadius, screwPointRadius, $fn=35);
         cylinder(baseDepth, screwShaftRadius, screwShaftRadius, $fn=35);
         translate([0, 0, baseDepth / 2.0]) cylinder(baseDepth / 2.0, screwHeadRadius, screwHeadRadius, $fn=35);
      }
   }
}

module Column() {
   difference() {
      union() {
         cylinder(columnHeight, columnRadius, columnRadius, $fn=100);
         ColumnBase();
      }
      translate([0, 0, columnBallHeight]) {
         ExtrudedBearingBalls(columnRadius + ballOffset, columnHeight - columnBallHeight);
      }
   }
}

module ColumnBase() {
   difference() {
      bottom = columnRadius + columnBaseRoundingRadius;
      cylinder(columnBaseRoundingRadius, bottom, bottom);
      translate([0, 0, columnBaseRoundingRadius]) {
         rotate_extrude($fn=100) {
            translate([bottom, 0, 0]) circle(columnBaseRoundingRadius, $fn=35);
         }
      }
   }
}

module BearingBalls(bearingRadius) {
   rotate_extrude($fn=100) {
      translate([bearingRadius, 0, 0]) circle(ballRadius, $fn=35);
   }
}

module ExtrudedBearingBalls(bearingRadius, height) {
   rotate_extrude($fn=100) {
      translate([bearingRadius, 0, 0]) {
         hull() {
            circle(ballRadius, $fn=35);
            translate([0, height, 0]) circle(ballRadius, $fn=35);
         }
      }
   }
}
