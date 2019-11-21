
TerrariumBaseHeight = 17;
JarTotalDiameter    = 128;
JarThroatDiameter   = 100;
GlassHolderDiameter = 80;

color("LightCyan", 1.0) {
  union () {
    // Create the rounded base.
    difference() {
      union() {
        // Create upper rounded edge.
        translate([0,0,TerrariumBaseHeight/2]) {
          rotate_extrude(angle=360, convexity=10, $fn=100) {
            X = (JarTotalDiameter/2)-(TerrariumBaseHeight/2);
            translate([X,0]) circle(TerrariumBaseHeight/2, $fn=100);
          }
        }
        // Fill the centre void.
        cylinder(
          TerrariumBaseHeight,
          (JarTotalDiameter/2)-(TerrariumBaseHeight/2),
          (JarTotalDiameter/2)-(TerrariumBaseHeight/2),
          false,
          $fn=100
        );
        // Fill the rounded edge to the floor.
        cylinder(
          TerrariumBaseHeight/2,
          JarTotalDiameter/2,
          JarTotalDiameter/2,
          false,
          $fn=100
        );
      }
      // Cut out the hole for jar throat
      translate([0,0,2]) {
        cylinder(
          TerrariumBaseHeight,
          JarThroatDiameter/2,
          JarThroatDiameter/2,
          false,
          $fn=100
        );
      }
    }
    // Add glass holder. Can be changed for other sized glass.
    *difference() {
      translate([0,0,2]) {
        cylinder(
          TerrariumBaseHeight-2,
          (GlassHolderDiameter/2)+1,
          (GlassHolderDiameter/2)+1,
          false,
          $fn=100
        );
      }
      translate([0,0,2]) {
        cylinder(
          TerrariumBaseHeight-1,
          GlassHolderDiameter/2,
          GlassHolderDiameter/2,
          false,
          $fn=100
        );
      }
    }
    // Add the flanges to hold the jar in place.
    ThreadCentrePositionZ = 15;
    difference() {
      union() {
        // Thread flange total height is 2mm high. The top
        // half is moved up by 0.5mm to offset centering. 
        translate([0,0,ThreadCentrePositionZ + 0.5]) {
          difference() {
            cylinder(1, 50, 50, true, $fn=100);
            cylinder(1.02, 49.1, 49.1, true, $fn=100);
          }
        }
        // Flange bottom half beveled to fit jar's thread
        // and making it self supporting when printing.
        // It's moved down by 0.5 to offset centering. 
        translate([0,0,ThreadCentrePositionZ - 0.5]) {
          difference() {
            cylinder(1, 50, 50, true, $fn=100);
            cylinder(1.02, 50, 49.1, true, $fn=100);
          }
        }
      }
      translate([0,0,ThreadCentrePositionZ]) {
        // Punch out the 6 flanges from thread ring. 
        FlangeCount = 6;
        for (angle=[0:360/FlangeCount:360]) {
          rotate(a=[0,0,angle]) {
            cube([36,100,2.2], true);
          }
        }
      }
    }
  }
}