//!OpenSCAD

// Use 0.4 shell thickness or supports may not print
// change lengthDots and widthDots to the dimensions you need
// intended Nozzle Diameter adjusts the wall thickness for 3d printing
// thinPlate = "yes" for plate "no" for regular block height
lengthDots = 2;
widthDots = 1;
intendedNozzleDiameter = 0.4;
thinPlate = "no";
// Constants
singleWidth = 7.8;
standardHeight = (thinPlate== "yes" ? 3.18 : 9.6);
perBlockWidthAdjustment = 0.19;
wallThickness = 1.1;
dotHeight = 1.8;
dotRadius = 2.5;
wallSupportThickness = 0.6;
undersideSingleWidthSupportPostRadius = 1.6;//under 1xN blocks
union(){
  union(){
    // Brick Shape
    difference() {
        //outer brick shape
      translate([(-singleWidth), (-singleWidth), 0]){
        cube([(singleWidth * widthDots + (widthDots - 1) * perBlockWidthAdjustment), (singleWidth * lengthDots + (lengthDots - 1) * perBlockWidthAdjustment), standardHeight], center=false);
      }
        //inside subtracted to create walls
      translate([(-(singleWidth - wallThickness)), (-(singleWidth - wallThickness)), 0]){
        cube([((singleWidth * widthDots + (widthDots - 1) * perBlockWidthAdjustment) - wallThickness * 2), ((singleWidth * lengthDots + (lengthDots - 1) * perBlockWidthAdjustment) - wallThickness * 2), (standardHeight - wallThickness)], center=false);
      }
    }
    // create the small protuberances inside the block that tighten then blocks grip on other blocks
    difference() {
      for (k = [-(singleWidth * 0.5) : abs(singleWidth + perBlockWidthAdjustment) : singleWidth * (widthDots - 1) + (widthDots - 1) * perBlockWidthAdjustment]) {
        for (i = [-(singleWidth * 0.5) : abs(singleWidth + perBlockWidthAdjustment) : singleWidth * (lengthDots - 1) + (lengthDots - 1) * perBlockWidthAdjustment]) {
          translate([k, i, 0]){
            union(){
              translate([0, 0, (standardHeight / 2)]){
                cube([(lengthDots <= widthDots ? singleWidth : 1), (lengthDots > widthDots ? singleWidth : 1), standardHeight], center=true);
              }
              translate([0, 0, (standardHeight / 2)]){
                cube([(lengthDots > widthDots ? singleWidth : 1), (lengthDots <= widthDots ? singleWidth : 1), standardHeight], center=true);
              }
            }
          }
        }

      }

      for (k = [0 : abs(singleWidth + perBlockWidthAdjustment) : singleWidth  + (widthDots - 1) * perBlockWidthAdjustment]) {
        for (i = [0 : abs(singleWidth + perBlockWidthAdjustment) : singleWidth  + (lengthDots - 1) * perBlockWidthAdjustment]) {
          translate([(-(singleWidth - wallThickness) + wallSupportThickness / 2), (-(singleWidth - wallThickness) + wallSupportThickness / 2), 0]){
            cube([(((singleWidth * widthDots + (widthDots - 1) * perBlockWidthAdjustment) - wallThickness * 2) - wallSupportThickness), (((singleWidth * lengthDots + (lengthDots - 1) * perBlockWidthAdjustment) - wallThickness * 2) - wallSupportThickness), (standardHeight - wallThickness)], center=false);
          }
        }

      }

    }
  }
  // Dots on tops
  for (m = [-((singleWidth + perBlockWidthAdjustment) / 2) : abs(-singleWidth - perBlockWidthAdjustment) : singleWidth * (widthDots - 1) + (widthDots - 1) * perBlockWidthAdjustment]) {
    for (j = [-((singleWidth + perBlockWidthAdjustment) / 2) : abs(singleWidth + perBlockWidthAdjustment) : singleWidth * (lengthDots - 1) + (lengthDots - 1) * perBlockWidthAdjustment]) {
      translate([m, j, (standardHeight - wallThickness / 2)]){
        difference() {
          cylinder(r1=dotRadius, r2=dotRadius, h=(dotHeight + wallThickness / 2), center=false, $fn=100);

          cylinder(r1=(dotRadius - intendedNozzleDiameter * 3), r2=(dotRadius - intendedNozzleDiameter * 3), h=dotHeight, center=false, $fn=100);
        }
      }
    }

  }

  // Underside supports
  if (widthDots > 1 && lengthDots > 1) {
    difference() {
        // create the basic shape of the cylinder and it's connection points
      for (k = [0 : abs(singleWidth + perBlockWidthAdjustment) : singleWidth * (widthDots - 2) + (widthDots - 1) * perBlockWidthAdjustment]) {
        for (i = [0 : abs(singleWidth + perBlockWidthAdjustment) : singleWidth * (lengthDots - 2) + (lengthDots - 1) * perBlockWidthAdjustment]) {
          translate([k, i, 0]){
            union(){
              cylinder(r1=((round((3.22 - dotRadius) / intendedNozzleDiameter) * intendedNozzleDiameter) + dotRadius), r2=((round((3.22 - dotRadius) / intendedNozzleDiameter) * intendedNozzleDiameter) + dotRadius), h=(standardHeight - wallThickness / 2), center=false, $fn=100);
              translate([0, 0, (standardHeight - ((standardHeight / 2 - wallThickness / 4) - 1.07))]){
                cube([(lengthDots >= widthDots ? singleWidth * 2 : wallSupportThickness), (lengthDots < widthDots ? singleWidth * 2 : wallSupportThickness), ((standardHeight - wallThickness / 2) - 2.14)], center=true);
              }
            }
          }
        }

      }
        // take away the center of each support cylinder
      for (k = [0 : abs(singleWidth + perBlockWidthAdjustment) : singleWidth * (widthDots - 2) + (widthDots - 1) * perBlockWidthAdjustment]) {
        for (i = [0 : abs(singleWidth + perBlockWidthAdjustment) : singleWidth * (lengthDots - 2) + (lengthDots - 1) * perBlockWidthAdjustment]) {
          translate([k, i, 0]){
            cylinder(r1=dotRadius, r2=dotRadius, h=(standardHeight - wallThickness / 2), center=false, $fn=100);
          }
        }

      }

    }
    //if either direction is a single dot the underside changes
  } else if (widthDots > 1 && lengthDots == 1 || widthDots == 1 && lengthDots > 1) {
    for (i = [0 : abs(singleWidth + perBlockWidthAdjustment) : lengthDots > widthDots ? singleWidth * (lengthDots - 2) + (lengthDots - 1) * perBlockWidthAdjustment : singleWidth * (widthDots - 2) + (widthDots - 1) * perBlockWidthAdjustment]) {
      translate([(lengthDots > widthDots ? -4 : i), (lengthDots > widthDots ? i : -4), 0]){
        union(){
            //underside Single Width Support Post
          cylinder(r1=undersideSingleWidthSupportPostRadius, r2=undersideSingleWidthSupportPostRadius, h=(standardHeight - wallThickness / 2), center=false, $fn = 100);
          translate([0, 0, (standardHeight - ((standardHeight / 2 - wallThickness / 4) - 1.07))]){
            cube([(lengthDots > widthDots ? singleWidth - perBlockWidthAdjustment : wallSupportThickness), (widthDots > lengthDots ? singleWidth - perBlockWidthAdjustment : wallSupportThickness), ((standardHeight - wallThickness / 2) - 2.14)], center=true);
          }
        }
      }
    }
    // if the block is 1x1 there is no underside
  } else if (widthDots == 1 && lengthDots == 1) {
    difference() {
      cylinder(r1=1.5, r2=1.5, h=(standardHeight - wallThickness / 2), center=false);

      cylinder(r1=1.5, r2=1.5, h=(standardHeight - wallThickness / 2), center=false);
    }
  }

}