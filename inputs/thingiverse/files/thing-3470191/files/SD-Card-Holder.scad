// Parametric SD Card Holder Remix by Bikecyclist
//
// New features:
// - Rounded corners
// - Customizer-enabled
//
// Published at:
//    http://www.thingiverse.com/thing:3470191
//
// Derivative of Parameterized SD card holder, PAmes
//
// Published at:
//    http://www.thingiverse.com/thing:15323
//
// Derivative of http://www.thingiverse.com/thing:9218 by jpcw
//
// Can adjust the number of slots, the slot size, and the corner radius

// The slot, of course, should be a little larger than the card.
// Adjust for desired fit.  I use these numbers on my TOM/Mk7,
// which give a slightly loose fit (the cards will fall out easily
// if turned over).  If you want to adjust the slot size, try
// experimenting by setting 'slots' to 1.
// All units are mm.

/* [Slots] */

// Number of slots - as many or as few as you want
slots = 8;  

// With of slots (SD Card = 26 mm)
slotWidth = 26;

// Thickness of slots, front to back (SD Card = 3 mm)
slotThickness = 3;

// Barrier between slots
slotSeparation = 4;

// Depth of slots - half of the card height seems about right.
slotDepth = 15;

/* [Holder] */

// Angle of the holder's top surface (in degrees)
topRiseAngle = 15;

// Corner radius of the holder's body
corner_radius = 5;

/* [Hidden] */

// Number of facets
$fn = 32;


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

module BlockRounded() {
    hull ()
        for (i = [0, 1], j = [0, 1])
            translate ([corner_radius + i * (holderDepth - 2 * corner_radius), corner_radius + j * (holderWidth - 2 * corner_radius), -0.01])
                cylinder (r = corner_radius, h = holderBackHeight + 0.02);
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
          intersection ()
          {
            basicBlock();
            
            translate ([0, holderBackHeight, 0])
            rotate([90,0,0])
            BlockRounded();
          }
          slots();
        }
}

SDCardHolder();
