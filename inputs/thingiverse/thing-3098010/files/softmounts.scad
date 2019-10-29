// Diameter of the center element
centerDiameter = 7;
// DIameter of the hole in the center (this should be smaller than centerDiameter)
centerHoleDiameter = 6;

// Walls around the screw hole/slot
walls = 3;

// Diameter of the screw hole/slot
screwHoleDiameter = 3;

// Max spacing between the screw holes
outerScrewDiameter = 19;
// Min spacing between the screw holes
innerScrewDiameter = 16;

// Height of the pad
height = 1.5;

// Shape of the pad
shape = "cross"; // [cross, cricle]

/* [Hidden] */
$fn = 50;
centerHoleRadius = centerHoleDiameter / 2;
centerRadius = centerDiameter / 2;

screwHoleRadius = screwHoleDiameter / 2;

outerRadius = screwHoleRadius + walls; //outerDiameter / 2;

screwHoleOffset = outerScrewDiameter / 2;

screwHoleLength = (outerScrewDiameter - innerScrewDiameter) / 2;

module shape() {
  group() {
    if(shape == "cross") {
      for(a = [0:90:360])
        hull() {
          cylinder(r = centerRadius, h = height);
          rotate([0, 0, a])
            translate([screwHoleOffset, 0, 0])
              cylinder(r = outerRadius, h = height);
        }
    } else {
      cylinder(r = screwHoleOffset + screwHoleRadius + walls, h = height);
    }
  }  
}

difference() {
  shape();

  for(a = [0:90:360])
    translate([0, 0, -1]) {
      cylinder(r = centerHoleRadius, h = height + 2);
      
      rotate([0, 0, a]) {
        translate([screwHoleOffset, 0, 0]) {
          hull() {
            cylinder(r = screwHoleRadius, h = height + 2);
            translate([-screwHoleLength, 0, 0])
              cylinder(r = screwHoleRadius, h = height + 2);
          }
        }
      }
    }
}