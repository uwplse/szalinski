/* [General] */
// Width of the tray
width = 65;
// Roundness of the tray
radius = 5; // [0:10]
// Padding between sections
sectionPadding = 4; // [0:10]

/* [Pins] */
// Amount of pin slots
pinSlots = 7; // [3:10]
// Radius of pin slot
pinRadius = 5; // [1:10]
// Padding between pin slots
pinSlotPadding = 0.5; // [0:0.1:10]

/* [Cylinder] */
// Inner radius of the cylinder
cylinderRadiusInner = 7; // [1:50]
// Outer radius of the cylinder
cylinderRadiusOuter = 9; // [1:50]
// Width of the deeper cutout for the cylinder
cylinderPadding = 5; // [1:10]
// Length of the cylinder
cylinderLength = 40; // [0:100]

/* [Hidden] */
$fn = 50;

pinLength = width - radius;

length = radius / 2 + (pinRadius + 0.5) * 2 * (pinSlots - 1) + pinRadius + sectionPadding + cylinderLength;

height = cylinderRadiusOuter / 3 * 2;

tray();

module tray() {
  difference() {
    bottom();

    for(i=[0:(pinSlots - 1)]) {
      xOffset = radius / 2 + (pinRadius + pinSlotPadding) * 2 * i;
      yOffset = radius / 2;
      zOffset = height + pinRadius / 4;

      translate([xOffset, yOffset, zOffset])
        pinSlot();
    }
    
    xOffset = radius / 2 + (pinRadius + 0.5) * 2 * (pinSlots - 1) + pinRadius + sectionPadding;
    zOffset = cylinderRadiusOuter + 0.5;
    translate([xOffset, cylinderRadiusOuter, zOffset])
      cylinderSlot();
    /*
    translate([xOffset, radius + cylinderRadiusInner * 2 +sectionPadding, radius])
      cylinderSlot();
    */
    translate([xOffset, 0, height / 2 + 1])
      cube([cylinderLength, width, height + 1]);
    
    yOffset = cylinderRadiusOuter * 2 + sectionPadding;
    translate([xOffset, yOffset, 0.5])
      cube([cylinderLength, width - yOffset, radius]);
  }
}

module cylinderSlot() {
  rotate([0, 90, 0]) {
    cylinder(r=cylinderRadiusInner, h=cylinderLength);
    cylinder(r=cylinderRadiusOuter, h=cylinderPadding);
  }
}

module pinSlot() {
  hull() {
    sphere(pinRadius);
    translate([0, pinLength, 0])
      sphere(pinRadius);
  }
}

module bottom() {
  cylinderHeight = height - radius;

  difference() {
    hull() {
    //group() {
      cylinder(r=radius, h=cylinderHeight);
      translate([0, 0, cylinderHeight])
        sphere(r=radius);

      translate([0, width, 0]){
        cylinder(r=radius, h=cylinderHeight);
        translate([0, 0, cylinderHeight])
          sphere(r=radius);
      }
        
      translate([length, 0, 0]) {
        cylinder(r=radius, h=cylinderHeight);
        translate([0, 0, cylinderHeight])
          sphere(r=radius);
      }

      translate([length, width, 0]) {
        cylinder(r=radius, h=cylinderHeight);
        translate([0, 0, cylinderHeight])
          sphere(r=radius);
      }
    }
    
    translate([-radius - 1, -radius - 1, -radius -1])
      cube([length + radius * 2 + 2, width + radius * 2 + 2, radius + 1]);
  }
}