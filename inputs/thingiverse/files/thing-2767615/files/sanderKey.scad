baseWidth = 19.5;
baseDepth = 18.0;
baseHeight = 3.5;

keyTolerance = 0.1;
keyMeanHeight = 22.25;
keyMaxHeight = 24.5;
keyDepth = 5.0 - 2 * keyTolerance;
keyWidth = 13.7 - 2 * keyTolerance;
keyAngle = 18.0;

cutoutHeight = 15.5;
cutoutWidth = (keyWidth - (2 * 2.0)) + 2 * keyTolerance;

ClarkeKey();

module ClarkeKey() {
   AngleMountedKey();
   radius = 1.5;
   translate([-baseWidth / 2 + radius, -baseDepth / 2 + radius, -baseHeight + radius]) {
      minkowski() {
         cube([baseWidth - radius * 2, baseDepth - radius * 2, baseHeight - radius * 2]);
         sphere(radius, $fn=20);
      }
   }
}

module AngleMountedKey() {
   intersection() {
      AngledKey();
      PositiveSpace();
   }
   rotate([0, 180, 0]) {
      difference() {
         AngledKey();
         PositiveSpace();
      }
   }
}

module AngledKey() {
   rotate([0, keyAngle, 0]) {
      TaperedKey();
   }
}

module TaperedKey() {
   intersection() {
      Key();
      
      hull() {
         translate([-(keyWidth + 10) / 2, -(keyDepth + 10) / 2, 0]) {
            cube([keyWidth + 10, keyDepth + 10, 0.00001]);
         }
         translate([-((keyWidth / 2) - 1), -((keyDepth / 2) - 1), keyMeanHeight + 1]) {
            cube([keyWidth - 2, keyDepth - 2, 0.00001]);
         }
      }
   }
}

module Key() {
   difference() {
      translate([-keyWidth / 2, -keyDepth / 2, 0]) {
         cube([keyWidth, keyDepth, keyMeanHeight]);
      }
      
      translate([-cutoutWidth / 2, -keyDepth / 2, keyMeanHeight - cutoutHeight]) {
         cube([cutoutWidth, keyDepth, cutoutHeight]);
      }
   }
}

module PositiveSpace() {
   big = 100;
   translate([-big / 2, -big / 2, 0]) {
      cube([big, big, big]);
   }
}