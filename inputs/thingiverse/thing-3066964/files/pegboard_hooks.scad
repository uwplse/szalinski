// Diameter of the pegboard holes
holeDiameter = 3.75;
// Spacing between the holes
holeSpacing = 25;
// Thickness of the board itself (oversize this a bit for a better fit)
thickness = 5;

// Length of the hook
hookLength = 12;
// Heigth of the hook
hookHeight = 5;

/* [HIDDEN] */
holeRadius = holeDiameter / 2;
step = 15;
$fn = 10;

hook();

module hook() {
  hull() {
      sphere(r = holeRadius);
      translate([0, hookLength + thickness + holeDiameter, 0])
          sphere(r = holeRadius);
  }

  translate([0, hookLength + thickness + holeDiameter, 0]) {
      hull() {
          sphere(r = holeRadius);
          translate([hookHeight, 0, 0])
              sphere(r = holeRadius);
      }
  }

  translate([holeSpacing, thickness * 1 / 3, 0]) {
      hull() {
      sphere(r = holeRadius);
      translate([0, thickness * 2 / 3, 0])
          sphere(r = holeRadius);
      }
  }

  translate([holeSpacing + thickness, thickness * 1 / 3, 0]) {
      for(a = [step:step:(90)]) {  
          hull() {
              rotate([0, 0, 180 - a])
                  translate([0, thickness, 0])
                      sphere(r = holeRadius);
              rotate([0, 0, 180 - a + step])
                  translate([0, thickness, 0])
                      sphere(r = holeRadius);
          }
      }
  }

  translate([0, thickness, 0]) {
      hull() {
          sphere(r = holeRadius);
          translate([holeSpacing, 0, 0])
              sphere(r = holeRadius);
      }
  }
}