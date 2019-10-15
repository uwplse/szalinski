backHoleDiameter = 7.2;
frontHoleDiameter = 5;
switchHoleDiameter = 2;
bowdenHoleDiameter = 12.5;
srewHoleDiameter = 3.4;

bowdenHoleOffsetX = 13.5;

slotWidth = 4;
slotLength = 7.5;

slotOffsetX = 27;
slotOffsetY = 6;

backHoleOffsetX = 9.5;
backHoleOffsetY = 9.5;

frontHoleOffsetX = 51.25;
frontHoleOffsetY = 9.5;

switchHoleOffsetX = 38;
switchHoleOffsetY = 3.5;
switchHoleSpacing = 6.7;

screwHoleOffsetX = 4.6;
screwHoleOffsetY = 10;
screwHoleSpacing = 12;

roundness = 5;
roundnessFront = 3;

width = 69.7;
length = 62.2;

frontWidth = 37.6;
frontLength = 89.7 - length;

height = 4.4;

/* [Hidden] */
$fn = 90;

backHoleRadius = backHoleDiameter / 2;
frontHoleRadius = frontHoleDiameter / 2;
switchHoleRadius = switchHoleDiameter / 2;
bowdenHoleRadius = bowdenHoleDiameter / 2;
screwHoleRadius = srewHoleDiameter / 2;

difference() {
  base();
  
  translate([0, 0, -1]) {
    // Bowden Hole
    translate([length + frontLength - bowdenHoleOffsetX, 0, 0])
      cylinder(r = bowdenHoleRadius, h = height + 2);
    cutouts();
    mirror([0, 1, 0])
      cutouts();
  }
}

module cutouts() {  
  group() {
    // Back Hole
    translate([backHoleOffsetX, -width / 2 + backHoleOffsetY, 0])
      cylinder(r = backHoleRadius, h = height + 2);

    // Front Hole
    translate([frontHoleOffsetX, -width / 2 + frontHoleOffsetY, 0])
      cylinder(r = frontHoleRadius, h = height + 2);
    
    // slot
    translate([slotOffsetX, -width / 2 + slotOffsetY, 0])
      cube([slotLength, slotWidth, height + 2]);
    
    // Switch Holes
    translate([switchHoleOffsetX, -width / 2 + switchHoleOffsetY, 0]) {
      cylinder(r = switchHoleRadius, h = height + 2);
      translate([switchHoleSpacing, 0, 0])
      cylinder(r = switchHoleRadius, h = height + 2);
    }

    // Screw Holes
    translate([length + frontLength - screwHoleOffsetX, -frontWidth / 2 + screwHoleOffsetY, 0]) {
      cylinder(r = screwHoleRadius, h = height + 2);
      translate([-screwHoleSpacing, 0, 0])
        cylinder(r = screwHoleRadius, h = height + 2);
    }
  }
}

module base() {
  group() {
    mainPlate();
    frontPlate();
  }
}

module mainPlate() {
  hull() {
    translate([roundness, width / 2 - roundness, 0])
      cylinder(r = roundness, h = height);
    translate([roundness, -width / 2 + roundness, 0])
      cylinder(r = roundness, h = height);
      
    translate([-roundness + length, width / 2 - roundness, 0])
      cylinder(r = roundness, h = height);
    translate([-roundness + length, -width / 2 + roundness, 0])
      cylinder(r = roundness, h = height);
  }
}

module frontPlate() {
  hull() {
    translate([-1 + length, -frontWidth / 2, 0])
      cube([1, frontWidth, height]);
  
    translate([-roundnessFront + length + frontLength, frontWidth / 2 - roundnessFront, 0])
      cylinder(r = roundnessFront, h = height);
    translate([-roundnessFront + length + frontLength, -frontWidth / 2 + roundnessFront, 0])
      cylinder(r = roundnessFront, h = height);
  }

  difference() {
    translate([length, -frontWidth / 2 - roundness, 0])
      cube([roundness, frontWidth + roundness * 2, height]);
    translate([length + roundness, -frontWidth / 2 - roundness, -1])
      cylinder(r=roundness, h = height + 2);
    translate([length + roundness, frontWidth / 2 + roundness, -1])
      cylinder(r=roundness, h = height + 2);
  }
}