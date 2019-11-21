// Author: Anthony Weber, agweber.net, thingiverse user agweber
// http://www.thingiverse.com/thing:1931310

// Possible future expansions
// TODO "valid" angles, where the hinge sticks to certain angles or angle intervals (every 45° as an example)
// TODO min/max angles of the hinge's folding capability
// TODO set angle of hinge
// TODO Fix leaf connecting with hinge >= 50% height

/* [General parameters] */
// Number of hinge joints
hingeCount = 5; // [3:10]
// How tall is the hinge (aka length when it's laying flat)
height = 48;
// Leaf width, each
width = 12;
// Thickness of the hinge leafs
thickness = 4;
// Diameter of the actual hinging portion
hingeDiameter = 10;

/* [Screw holes] */
// Number of screw holes
holeCount = 3;
// Diameter of the screw shaft
holeDiameter = 4;
// Type of holes for the screws. Straight will just be straight holes, countersunk will use the below parameters for a countersunk head
holeType = "countersunk"; // [countersunk, straight]
// Diameter of the head of the countersunk screw
holeCountersinkHeadDia = 6;
// Distance it tapers from the head of the screw to the body
holeCountersinkDepth = 2;

/* [Screw hole spacing/placement] */
// If balanced, the below fields will be automatically generated on model generation, offsets will use the below offsets for fine control
holeSpacingType = "balanced"; // [offsets, balanced]
// Space between holes
holeSpacing = 12;
// Distance along the hinge the holes starting
holeOffsetX = 3;
// Distance from the far edge of the leafs the screwholes placed
holeOffsetY = 3;

/* [Tweak/tolerance parameters] */
// Space between the hinge pieces
hingeGap = 0.5; // [0.1:0.1:2.5]
// Cut the hinge open for display purposes; 1 means not cut open
cutOpen = 1; // [0.4:0.05:1]

/* [Advanced parameters] */
// 0 means hinge interfaces will come to points, increase it to blunt the ends
interfaceMinRadius = 1;
// Roundness setting angle; lower = finer large radius
$fa = 0.5;
// Roundless setting size; lower = finer small radius
$fs = 0.75;
// What angle is the interface portions of the hinge printing at. Higher is typically easier to print
hingeInterfaceAngle = 45; // [45:5:75]
// Display preferences
transparency = 0.9;

/* [Hidden] */
// Calculated parameters
hingeRadius = hingeDiameter/2;
hingePartLength = (height+hingeGap)/hingeCount;
// if this > hingePartLength/2, the interfaces will join as a solid object
hingeInterfaceLength = (sin(hingeInterfaceAngle*2)) * hingeRadius; // TODO handle < 45 degrees
c = [[0.1,0.65,0.6,transparency], [0.6,0.65,0.1,transparency]]; // display preferences

// Don't bother with these
buffer = 0.01; // used to every so slighty adjust things to prevent 0-thickness walls

module screwHole(hole, holeSpacing, holeOffsetX, holeOffsetY, headDia, side) {
  // Move hole depending on which one it is
  translate([headDia*(hole+0.5)+holeOffsetX+holeSpacing*hole,
             (max(0,side)*width)-side*(headDia/2 + holeOffsetY), 0]) // Move hole from far edge
  // Flip the created object and move it up
  translate([0,0,thickness+buffer]) rotate([180,0,0])
  union() {
    cylinder(r=holeDiameter/2, h=thickness+buffer*2);
    if (holeType == "countersunk") {
      cylinder(r1=holeCountersinkHeadDia/2, r2=holeDiameter/2, h=holeCountersinkDepth);
    }
  }
}

difference() {
translate([-hingeCount*hingePartLength/2-hingeGap/2,0,0]) union() { // Center result onscreen

// leafs
translate([hingeGap/2,0,0]) for (i = [-1:2:1]) {
  difference() {
  translate([0,-width/2+i*(hingeRadius+width/2),0]) difference() {
    color(c[max(0, i%2)]) cube([height, width, thickness]);
    // Cut out the screw holes
    if (holeCount > 0) {
      echo("Drilling screwholes");
      for (hole = [0:holeCount-1]) {
        if (holeSpacingType == "balanced") {
          if (holeType == "countersunk") {
            holeSpacing = (height-holeCount*holeCountersinkHeadDia)/(holeCount);
            holeOffsetX = holeSpacing/2;
            holeOffsetY = (width-holeCountersinkHeadDia)/2;
            screwHole(hole, holeSpacing, holeOffsetX, holeOffsetY, holeCountersinkHeadDia, i);
          } else {
            holeSpacing = (height-holeCount*holeDiameter)/(holeCount+1);
            holeOffsetX = holeSpacing;
            holeOffsetY = (width-holeDiameter)/2;
            screwHole(hole, holeSpacing, holeOffsetX, holeOffsetY, holeDiameter, i);
          }
        } else if (holeSpacingType == "offsets") {
          if (holeType == "countersunk") {
            screwHole(hole, holeSpacing, holeOffsetX, holeOffsetY, holeCountersinkHeadDia, i);
          } else {
            screwHole(hole, holeSpacing, holeOffsetX, holeOffsetY, holeDiameter, i);
          }
        } else {
          echo("Unknown screwhole type, bit doesn't fit.");
        }
      }
    }
  }
  // Prevent connecting with the other leaf's hinges
  for (j = [0:hingeCount - 1]) {
    if (j%2 != max(0, i%2)) {
      translate([-buffer+hingePartLength*j-hingeGap,0,hingeRadius]) rotate([0,90,0])
        cylinder(r=hingeRadius+hingeGap, h=hingePartLength+hingeGap+buffer*2);
    }
  }
}
}

// hinging portion
for (i = [0:hingeCount - 1]) {
  translate([hingePartLength * i,0,0]) union() {
    difference() {
      union() {
        translate([hingeGap/2,0,hingeRadius]) union() {
          rotate([0,90,0]) color(c[i%2]) cylinder(r=hingeRadius, h=hingePartLength-hingeGap);
          translate([0,-hingeRadius+(i%2)*hingeRadius,-hingeRadius])
            color(c[i%2]) cube([hingePartLength-hingeGap, hingeRadius, hingeRadius]); // Connect to leaf
        }
        if (i % 2 == 1) {
          translate([-hingeInterfaceLength+hingeGap/2,0,hingeRadius]) rotate([0,90,0])
            color(c[i%2]) cylinder(r1=interfaceMinRadius, r2=hingeRadius, h=hingeInterfaceLength);
          if (i != hingeCount-1) translate([hingePartLength-hingeGap/2,0,hingeRadius]) rotate([0,90,0])
            color(c[i%2]) cylinder(r2=interfaceMinRadius, r1=hingeRadius, h=hingeInterfaceLength);
        }
      }
      // Subtract out
      if (i % 2 == 0) { // Inward
        if (i > 0) translate([hingeGap/2-buffer,0,hingeRadius]) rotate([0,90,0])
          color(c[i%2]) cylinder(r2=interfaceMinRadius, r1=hingeRadius, h=hingeInterfaceLength);
        if (i != hingeCount-1) translate([hingePartLength-hingeGap/2-hingeInterfaceLength+buffer,0,hingeRadius]) rotate([0,90,0])
          color(c[i%2]) cylinder(r1=interfaceMinRadius, r2=hingeRadius, h=hingeInterfaceLength);
      }
    }
  }
}

} // End center result onscreen
  // Cut off the top
  if (cutOpen < 1) {
    translate([-height/2-hingeGap-buffer,-width-hingeRadius-buffer,cutOpen*hingeRadius*2])
      cube([height+hingeGap+buffer*2,width*2+hingeRadius*2+buffer*2,hingeRadius*2]);
  }
}