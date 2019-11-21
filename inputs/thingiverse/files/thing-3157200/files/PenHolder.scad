width = 57.0;
height = 80.0;
depth = 14.5;

magnetDepth = 3.8;
magnetRadius = 2.3;
magnetsPerSide = 4;
magnetSpacing = height / magnetsPerSide;
magnetHeight = 0.4;

windowStart = 33.0;
windowEnd = 47.0;
windowHeight = windowEnd - windowStart;

wallThickness = 1.0;

//MagnetHolder();
PenHolder();

module MagnetHolder() {
   difference() {
      cylinder(magnetDepth + magnetHeight + wallThickness, magnetRadius + wallThickness, magnetRadius + wallThickness, $fn=50);
      translate([0, 0, magnetHeight]) {
         cylinder(magnetDepth, magnetRadius, magnetRadius, $fn=50);
      }
   }
}

module PenHolder() {
   difference() {
      union() {
         cube([width + (2 * wallThickness), height + wallThickness, depth + (2 * wallThickness)]);
         cube([width + (2 * wallThickness), height + wallThickness, wallThickness]);
         
         for (i = [0:magnetsPerSide - 1]) {
            translate([0, (i + 0.5) * magnetSpacing, 0]) {
               hull() {
                  translate([-magnetRadius, 0, 0]) {
                     cylinder(magnetDepth + magnetHeight + wallThickness, magnetRadius + wallThickness, magnetRadius + wallThickness, $fn=50);
                  }
                  translate([width + magnetRadius + (2 * wallThickness), 0, 0]) {
                     cylinder(magnetDepth + magnetHeight + wallThickness, magnetRadius + wallThickness, magnetRadius + wallThickness, $fn=50);
                  }
               }
            }
         }
      }
      
      translate([wallThickness, wallThickness, wallThickness]) {
         cube([width, height, depth]);
      }
      
      // Window
      translate([wallThickness, wallThickness + windowStart, wallThickness + depth]) {
         cube([width, windowHeight, depth]);
      }
      
      for (i = [0:magnetsPerSide - 1]) {
         translate([0, (i + 0.5) * magnetSpacing, 0]) {
            translate([-magnetRadius, 0, magnetHeight]) {
               cylinder(magnetDepth, magnetRadius, magnetRadius, $fn=50);
            }
            translate([width + magnetRadius + (2 * wallThickness), 0, magnetHeight]) {
               cylinder(magnetDepth, magnetRadius, magnetRadius, $fn=50);
            }
         }
      }
   }
}
