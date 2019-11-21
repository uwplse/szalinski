frameDepth = 8.0;
clipLength = 30.0;
clipHeight = 15.0;
clipWallDepth = 1.0;
filamentHoldeRadius = 3.0;
loopRadius = 5.0;

printTollerance = 0.5;

difference() {
   union() {
      cube([clipLength, frameDepth + printTollerance + (2 * clipWallDepth), clipHeight + clipWallDepth + printTollerance / 2.0]);
      translate([clipLength / 2.0, -(filamentHoldeRadius + (loopRadius / 2.0)), clipHeight]) {
         rotate_extrude($fn=60) {
            translate([filamentHoldeRadius + loopRadius, 0, 0]) {
               circle(loopRadius, $fn=60);
            }
         }
      }
   }
   translate([0, (printTollerance / 2.0) + clipWallDepth, 0]) {
      cube([clipLength, frameDepth, clipHeight]);
   }
}