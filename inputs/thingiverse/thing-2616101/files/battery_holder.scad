/* [General] */
// Amount of battery rows
rows = 2; // [1:10]
// Amount of battery columns
columns = 2; // [1:10]

// Diameter of the battery
batteryDiameter = 15;
// Length of the battery
batteryLength = 50;

// With of the cutout to help removing the battery
batteryHolderPullWidth = 15;

// Bottom Height
batteryHolderBottom = 1;
// Wall thickness
batteryHolderWalls = 1;

/* [Connector] */
// Thickness of the battery tabs
batteryConnectorThickness = 1.75;
// Diameter of the holes for power cables
batteryHolderHoleDiameter = 3;

/* [Hidden] */
$fn = 50;

spacing = 0.2;
batteryRadius = batteryDiameter / 2;
batteryHolderHeight = batteryHolderBottom + batteryRadius;
batteryHolderHeightOuter = batteryHolderBottom + batteryDiameter;
batteryHolderLength = (batteryLength * columns) + (batteryHolderWalls + batteryConnectorThickness) * 2;
batteryHolderLengthInner = (batteryLength) * columns;

batteryXOffset = batteryHolderWalls + batteryConnectorThickness;
batteryPullOffset = batteryLength / 2 - batteryHolderPullWidth / 2;
batteryHolderWidth = (batteryDiameter + batteryHolderWalls) * rows + batteryHolderWalls;

batteryHolderHoleRadius = batteryHolderHoleDiameter / 2;

batteryHolder();

module batteryHolder() {
  difference() {
    group() {
      difference() {
        cube([batteryHolderLength, batteryHolderWidth, batteryHolderHeightOuter]);
        translate([batteryHolderWalls + batteryConnectorThickness, -1, batteryHolderHeight]) {
          cube([batteryHolderLengthInner, batteryDiameter * rows + batteryHolderWalls * (rows + 1) + 2, batteryHolderHeight + 1]);
      }
      }
      
      for(i=[1:1:rows]) {
        rotate([0, 90, 0])
          translate([-batteryRadius - batteryHolderBottom, batteryRadius + batteryHolderWalls + (batteryDiameter + batteryHolderWalls) * (i - 1), 0])
            cylinder(h=batteryLength * columns + (batteryHolderWalls + batteryConnectorThickness) * 2, r =batteryRadius + batteryHolderWalls);
      }
    }
    
    translate([-1,-1,batteryHolderHeightOuter])
      cube([batteryHolderLength + 2, batteryHolderWidth + 2, batteryHolderHeightOuter]);

    for(i=[1:1:rows]) {
      rotate([0, 90, 0]) {
        translate([-batteryRadius - batteryHolderBottom, (batteryRadius + batteryHolderWalls) + (batteryDiameter + batteryHolderWalls) * (i - 1), batteryHolderWalls + batteryConnectorThickness])
          cylinder(h=batteryLength * columns, r =batteryRadius);
      }
    }
    
    translate([batteryHolderWalls + batteryConnectorThickness, -1, batteryHolderHeight * 1.5]) {
      cube([batteryHolderLengthInner, (batteryDiameter + batteryHolderWalls) * rows + batteryHolderWalls + 2, batteryHolderHeight + 1]);
    }
    
    rotate([0, 90, 0]) {
      translate([-batteryRadius - batteryHolderBottom, batteryRadius + batteryHolderWalls, -1]) {
        cylinder(h=batteryHolderWalls + 2, r=batteryHolderHoleRadius);
      }
      translate([-batteryRadius - batteryHolderBottom, batteryRadius + batteryHolderWalls * 2 + (batteryDiameter + batteryHolderWalls) * (rows - 1), -1]) {
        cylinder(h=batteryHolderWalls + 2, r=batteryHolderHoleRadius);
      }
    }
    
    translate([batteryHolderWalls, batteryHolderWalls, batteryHolderBottom])
      cube([batteryConnectorThickness + spacing, (batteryDiameter + batteryHolderWalls) * rows - batteryHolderWalls, batteryHolderBottom + batteryDiameter + 1]);
    
    translate([batteryHolderWalls + batteryConnectorThickness + batteryLength * columns - spacing, batteryHolderWalls, batteryHolderBottom])
      cube([batteryConnectorThickness + spacing,  (batteryDiameter + batteryHolderWalls) * rows - batteryHolderWalls, batteryHolderBottom + batteryDiameter + 1]);
    
    for(i=[1:1:columns]) {
      translate([batteryXOffset + batteryPullOffset + (batteryLength * (i - 1)), -1, batteryHolderHeight / 3])
        cube([batteryHolderPullWidth, batteryHolderWidth + 2, batteryHolderHeight * 2]);
      
      translate([batteryXOffset + batteryLength / 8 + (batteryLength * (i - 1)), -1, batteryHolderHeight])
        cube([batteryLength / 8 * 6, batteryHolderWidth + 2, batteryHolderHeight * 2]);
    }

    translate([batteryXOffset, -1, batteryHolderHeight])
        cube([batteryLength / 8 * 6, batteryHolderWidth + 2, batteryHolderHeight * 2]);
  }
}