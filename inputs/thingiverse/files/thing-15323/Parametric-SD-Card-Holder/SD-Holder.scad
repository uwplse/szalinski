// Parameterized SD card holder, PAmes
//
// Published at:
//    http://www.thingiverse.com/thing:15323
//
// Derivative of http://www.thingiverse.com/thing:9218 by jpcw
//
// Can adjust the number of slots, and the slot size

// The slot, of course, should be a little larger than the card.
// Adjust for desired fit.  I use these numbers on my TOM/Mk7,
// which give a slightly loose fit (the cards will fall out easily
// if turned over).  If you want to adjust the slot size, try
// experimenting by setting 'slots' to 1.
// All units are mm.

slots = 6;  // As many or as few as you want
slotWidth = 26;
slotThickness = 3; // front to back
slotSeparation = 4;  // Barrier between slots
slotDepth = 15; // This much of the card fits into the slot, half of the card height seems about right.
topRiseAngle = 15; // degrees


// These should be OK as is.  Adjust if you want wider borders.
bottomHeight = slotSeparation; // bottom of first hole to bottom of holder
sideWidth    = slotSeparation; // left, right borders
frontDepth   = slotSeparation; // front to first hole
backDepth    = slotSeparation; // back to last hole


// Shouldn't have to mess with these.
holderWidth = slotWidth + 2*sideWidth;
holderFrontHeight = slotDepth + bottomHeight - tan(topRiseAngle)*frontDepth;
holderDepth = frontDepth + slotThickness*slots +
            slotSeparation*(slots-1) + backDepth;
holderBackHeight = holderFrontHeight + tan(topRiseAngle)*holderDepth;

module basicBlock() {
  linear_extrude(height=holderWidth, convexity=2)
    polygon(points = [ [0, 0],
                     [holderDepth, 0],
                     [holderDepth, holderBackHeight],
                     [0, holderFrontHeight] ]);
}

// One slot, at first location
module slot() {
  translate([frontDepth, bottomHeight,0])
    translate([0,0,sideWidth])
      cube(size=[slotThickness, holderBackHeight, slotWidth]); // sticks up, used by difference()
}

// Makes all slots
module slots() {
  for (i = [0 : slots-1]) {
    translate([i*(slotSeparation+slotThickness), i*tan(topRiseAngle)*(slotSeparation+slotThickness), 0])
      slot();
  }
}

// Put it all together
module SDCardHolder() {
  // Place into nice orientation
  rotate([0,0,90])
    translate([-holderDepth/2,holderWidth/2,0])
      rotate([90,0,0])
        difference() {
          basicBlock();
          slots();
        }
}

SDCardHolder();
