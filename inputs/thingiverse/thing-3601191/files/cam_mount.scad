/* [General] */
// Camera you are using
cam = "f7"; // [tx06, f7, cyclops, tx03]
// Angle of the Cam mount
angle = 30;

/* [Mount Bottom] */
spacing = 26;
screwHoleDiameter = 1.9; // 2.1
padding = 1.2;
mountHeight = 1.2; //

holeHeight = 2;

walls = 1.2; // 1.4

/* [Cam settings] */
camHeight = 13.35; // 13.3
camDepth = 7.5; // 8
camLength = 14.45; // 14.4
camLensDiameter = 10.2; // 10
camLensLength = 7;
camLensOffsetZ = 0.8; // 1
camLensOffsetX = 0.7; // 1.4, 1.2, 1.0, 0.9

antennaWidth = 6;
antennaDepth = 3;

bottomHeightModifier = 0; // 2

/* [Mount cam] */
cutoutLeftHeight = 7;
cutoutLeftZ = 3.25;

cutoutRightHeight = 5;
cutoutRightZ = 0;

camLensCutoutWidth = 4;
camLensCutoutHeight = 10;

cutoutDepth = 0.6;

roundness = 2;

cutoutBigHeight = 10.5;
cutoutBigDepth = 2.5;

sidesLength = 13.3;

/*
hookLength = 2.5;
hookHeight = 2;
*/

/* [Hidden] */
$fn = 50;

// F7 3in1 is default
antennaOffset = 0;

// TX06
if(cam == "tx06") {
  antennaOffset = (camLength - antennaWidth) / 2;
  all(antennaOffset, antennaDepth, antennaWidth, camLength, camHeight, camLensOffsetX, camLensOffsetZ);
}

// Cyclops
else if(cam == "cyclops") {
  camHeight = 12.35;
  antennaDepth = 1;
  camLensOffsetZ = 0.4;
  antennaOffset = -walls - 1;
  antennaWidth = antennaWidth + walls + 1;
  all(antennaOffset, antennaDepth, antennaWidth, camLength, camHeight, camLensOffsetX, camLensOffsetZ);
}

// TX03
else if(cam == "tx03") {
  camHeight = 14.1;
  camLength = 19.6;
  //antennaDepth = 1;
  camLensOffsetZ = 0.6;
  camLensOffsetX= 0.4;
  antennaWidth = 10.5;
  antennaOffset = 6;
  echo((camLength - antennaWidth) / 2);
  all(antennaOffset, antennaDepth, antennaWidth, camLength, camHeight, camLensOffsetX, camLensOffsetZ);
}

else {
  all(antennaOffset, antennaDepth, antennaWidth, camLength, camHeight, camLensOffsetX, camLensOffsetZ);
}

module all(antennaOffset, antennaDepth, antennaWidth, camLength, camHeight, camLensOffsetX, camLensOffsetZ) {
  diagonal = sqrt(spacing * spacing + spacing * spacing);
  screwHoleRadius = screwHoleDiameter / 2;
  camLensRadius = camLensDiameter / 2;

  c = camDepth + walls;
  beta = 90 - angle;
  a = c * cos(beta);
  b = sqrt(c * c - a * a);

  translate([-camLength / 2 - walls - camLensOffsetX, -b + padding + screwHoleRadius, mountHeight + a])
    rotate([-angle, 0, 0])
      translate([0,0,-bottomHeightModifier])
        camHolder();
  mount();

  module mount() {
    difference() {
      group() {
        //Sides
        hull() {
          translate([-diagonal / 2, 0, 0])
            cylinder(h = mountHeight, r = screwHoleRadius + padding);
          translate([diagonal / 2, 0, 0])
            cylinder(h = mountHeight, r = screwHoleRadius + padding);

          translate([-1, -sidesLength + screwHoleRadius + padding, 0])
            cube([2, sidesLength, mountHeight]);
        }      
        translate([-diagonal / 2, 0, 0])
          cylinder(h = holeHeight, r = screwHoleRadius + padding);
        translate([diagonal / 2, 0, 0])
          cylinder(h = holeHeight, r = screwHoleRadius + padding);

        // Front
        hull() {
          translate([0, -diagonal / 2, 0])
            cylinder(h = mountHeight, r = screwHoleRadius + padding);
          
          translate([-8, -5 + screwHoleRadius + padding, 0])
            cube([16, 2, mountHeight]);
        }
        translate([0, -diagonal / 2, 0])
          cylinder(h = holeHeight, r = screwHoleRadius + padding);
        
        // Enforcement (front)
        hull() {
          translate([-1, -b + padding + screwHoleRadius, 0])
            cube([2, 0.1, a / 3 * 2 + mountHeight]);
          
          translate([-1, -diagonal / 2 + screwHoleRadius + padding - 1, 0])
            cube([2, 0.1, holeHeight]);
        }
        
        //Enforcement left side
        hull() {
          translate([camLength / 2 + walls - camLensOffsetX - 0.1, screwHoleRadius + padding - b + 0.5, 0])
            cube([0.1, 2, a / 3 * 2 + mountHeight]);
          
          translate([diagonal / 2 - screwHoleRadius - padding + 1 - 0.1, -1, 0])
            cube([0.1, 2, holeHeight]);
        }
        
        //Enforcement right side
        hull() {
          translate([-camLength / 2 - walls - camLensOffsetX, screwHoleRadius + padding - b + 0.5, 0])
            cube([0.1, 2, a / 3 * 2 + mountHeight]);
          
          translate([-diagonal / 2 + screwHoleRadius + padding - 1, -1, 0])
            cube([0.1, 2, holeHeight]);
        }
        
        translate([-camLength / 2 - walls - camLensOffsetX, -b + padding + screwHoleRadius, 0]) {
          wedge();
        }
      }
    
      translate([-diagonal / 2, 0, -1])
        cylinder(h = mountHeight + 2, r = screwHoleRadius);
      translate([diagonal / 2, 0, -1])
        cylinder(h = mountHeight + 2, r = screwHoleRadius);    
      translate([0, -diagonal / 2, -1])
        cylinder(h = mountHeight + 2, r = screwHoleRadius);
    }
  }

  module wedge() {
    difference() {
      group() {
        translate([-a/4, -a/4, mountHeight]) {
          cube([camLength + walls * 2 + a / 2, b + a/4, a/4]);
        }

        translate([0, 0, mountHeight])
          cube([camLength + walls * 2, b, a]);
      }
      
      translate([camLength + walls * 2 + a / 2 + 1, b, mountHeight])
          rotate([angle, 0, 180])
            cube([camLength + walls * 2 + a + 2, camDepth + walls + 1, a]);
      
      translate([-1 - a / 2, -a / 4, mountHeight + a / 4])
        rotate([0,90,0])
          cylinder(h = camLength + walls * 2 + a + 2, r = a / 4);
      
      translate([-a / 4, -a / 4 - 1, mountHeight + a / 4])
        rotate([0, 90, 90])
          cylinder(h = camLength + walls * 2 + 2, r = a / 4);

      translate([-a / 4 + camLength + walls * 2 + a / 2, -a / 4 - 1, mountHeight + a / 4])
        rotate([0, 90, 90])
          cylinder(h = camLength + walls * 2 + 2, r = a / 4);
    }
  }

  module camHolder() {
    // Hook top
    /*
    translate([camLength / 2 + walls - hookLength / 2, camDepth + walls, camHeight - hookHeight])
      cube([hookLength, walls, walls + hookHeight]);
    */
    difference() {
      group() {
        hull() {
          translate([0,0, bottomHeightModifier])
            cube([camLength + walls * 2, camDepth + walls, walls]);
          translate([roundness, 0, camHeight + walls - roundness])
            rotate([-90, 0, 0])
              cylinder(r = roundness, h = camDepth + walls);
          translate([camLength + walls * 2 - roundness, 0, camHeight + walls - roundness])
            rotate([-90, 0, 0])
              cylinder(r = roundness, h = camDepth + walls);
        }

        rotate([90, 0, 0])
          translate([camLength / 2 + walls + camLensOffsetX, camHeight / 2 + camLensOffsetZ, -walls])
            cylinder(h = camLensLength, r = camLensRadius + walls);
      }
      
      // Lens Cutout
      rotate([90, 0, 0])
        translate([camLength / 2 + camLensOffsetX + walls, camHeight / 2 + camLensOffsetZ, -walls - 1])
          cylinder(h = camLength + 2, r = camLensRadius);
      
      // Lens split
      for(i=[0:120:360])
        translate([camLength / 2 + walls + camLensOffsetX, -camLensLength, camHeight / 2 + camLensOffsetZ])
          rotate([0, i, 0])
            translate([-camLensCutoutWidth / 2, 0, 0])
              cube([camLensCutoutWidth, camLensLength, camLensCutoutHeight]);

      // Main body cutout
      translate([walls, walls, 0])
        cube([camLength, camDepth + 1, camHeight]);
      
      // Antenna cutout
      translate([walls + antennaOffset, walls + camDepth - antennaDepth, 0])
        cube([antennaWidth, camDepth + 1, camHeight + walls + 1]);

      // Cutout right
      translate([-1, walls + camDepth - cutoutDepth, cutoutRightZ])
        cube([walls + 2, cutoutDepth + 1, cutoutRightHeight]);

      // Cutout left
      translate([camLength + walls - 1, walls + camDepth - cutoutDepth, cutoutLeftZ])
        cube([walls + 2, cutoutDepth + 1, cutoutLeftHeight]);

      // Cutout Big
      translate([-1, walls + cutoutBigDepth, 0])
        cube([camLength + walls * 2 + 2, camDepth - cutoutBigDepth + 1, cutoutBigHeight]);
    }
  }
}