////////////////////////////////////////////////////////////////
// PARAMETERS //////////////////////////////////////////////////

holeCount = 4;

glassThickness = 10; // in millimeters

// Other variables that people don't get to choose
// none


module tubeBracket(holeCount, glassThickness) {
  glassThickness = glassThickness + 1; // to account for added spheres
  width = (holeCount * 8) + 2;  // body width
  spacing = glassThickness + 3; // space between each branch of the fork
  thickness = 6;  // body thickness
  sphereD = 6;
  lengthMain = 102;
  
  translate([0, 0, width]) // position ready for printing
  rotate(90, [0, 1, 0])
  difference() {
    union() {
      // 3 rounded corners, 1 square corner
      translate([0, -5, -5]) {
        difference() {
          cube([width, 10 + thickness, 10 + thickness]);
           translate([-1, 11, -1])
            cube([width + 2, 6, 6]);
          translate([-1,0,0])
            rotate(90, [0,1,0])
              cylinder(h=width + 2, r=5, $fn=40);
          translate([-1, 0, 10 + thickness])
            rotate(90, [0,1,0])
              cylinder(h=width + 2, r=5, $fn=40);
          translate([-1, 10 + thickness, 10 + thickness])
            rotate(90, [0,1,0])
              cylinder(h=width + 2, r=5, $fn=40);        
        }
      }
      translate([0, -16,0])
        cube([width, 42 + spacing, thickness]);  // horizontal
      translate([0, 0, -80]) {
        difference() {
          union() {
          cube([width, thickness, lengthMain]);  // main vertical
          // Add spheres to not allow water to climb because of capilarity.
          for(i = [1:1:lengthMain/(2*sphereD)-1]) {
            translate([(width - sphereD)/4, sphereD/2 + 1.3, i*2*sphereD - 10])
              sphere(d = sphereD , $fn=50);
            translate([width - (width - sphereD)/4, sphereD/2 + 1.3 , i*2*sphereD - 10])
              sphere(d = sphereD , $fn=50);
          }        
          }  
          translate([-5,1,-5])
          rotate(40, [1,0,0])
            cube([width + 10, 10, 20]);  // bottom chamfer
        }
      }
      translate([0, spacing , -75])
        rotate(-5, [1, 0, 0])
          difference() {
            cube([width, thickness, 80]);  // skewed vertical
            translate([-5,1,-5])
            rotate(40, [1,0,0])
              cube([width + 10, 10, 20]);  // bottom chamfer
          }
      translate([0, spacing + 2*thickness - 2, -5]) {
        difference() {
          cube([width, 7, 6]);
          translate([-1, 6.7, 0])
            rotate(90, [0, 1, 0])
              cylinder(h=width+2, r=5, $fn=40);  //  inside filet
        }
      }
    };
    holes(holeCount = holeCount, rotation = 0, translateY = -11, translateZ = -1);
    holes(holeCount = holeCount, rotation = 0, translateY = 20 + spacing, translateZ = -1);
    holes(holeCount = holeCount, rotation = 90, translateY = 10, translateZ = 17);
  }
}

module holes(holeCount, rotation, translateY, translateZ) {
  for(hole = [1 : holeCount]) {
    translate([hole*8 - 3, translateY, translateZ])
      rotate(rotation, [1, 0, 0])
        cylinder(h=12, r = 2.5, $fn=20);
  }
}


tubeBracket(holeCount = holeCount, glassThickness = glassThickness);