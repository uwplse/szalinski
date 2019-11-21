// iPadMiniLandscapeAndCase.scad - bracket to hold an iPadMini in its case in landscape orientation
//   with holes to take a nut, and a be screwed into a tripod.
// by David Phillip Oster  https://www.thingiverse.com/thing:3913046  Version 1.1


/* [Global] */

/* [iPad] */

// long dimension of iPad + case in mm
iPadLength = 205;  // [100:1000]

// thickness of iPad + case in mm
iPadThickness = 14; // [4:50]

// How high the box should come up, gripping the iPad in mm
iPadZ = 64;   // [20:100]

// radius in mm of the left and right curve of the iPad in its case in mm
iPadRadius = 14;  // [0:40]


// wall thickness of case in mm.
wallThickness = 4;  // [1:10]

// "finger" thickness: amount front of case reaches over the ipad in mm.
fingerThickness = 6;  // [1:10]


// How does the mount attach to the tripod?
attachment = "Screw"; // [Wedge:Wedge,Screw:Screw]

/* [Screw] */

/* [Wedge] */

// "z" dimension of top square tripod connector plate in mm
capHeight = 3.95;   // [2:10]

// "x" dimension of top square plate in mm
capWidth = 51.84; // [20:100]

// "y" dimension of top square tipod connector plate in mm
capLength = 51.84; // [20:100]

// the sum of the height of the cap and the wedge in mm.
totalHeight = 13.3;  // [10:100]

// "x" narrowest dimension of bottom wedge plate in mm
wedgeTopWidth = 35;  // [20:100]

// "x" widest dimension of bottom wedge plate in mm
wedgeWidth = 43.1;  // [20:100]

// "y" widest dimension of bottom wedge plate in mm
wedgeLength = 43.8;  // [20:100]

/* [Hidden] */

// extra space around the iPad, so it will actially fit in mm.
iPadClearance = 0.5; // [0:2]

baseHeight = 8;


module tripodWedge() {
  // slide it so it's centered atop 0 at the correct height
  translate([-capWidth/2, -capLength/2, totalHeight - capHeight]){
    cube([capWidth, capLength, capHeight]);
  }

  // slide it so it's centered atop 0.
  translate([0, wedgeLength/2, 0]) {
    // flip it to the correct orientation
    rotate([90, 0, 0]) {
      // make 2D wedge 3D
      linear_extrude(height=wedgeLength) {
        // the wedge in 2D
        polygon([[0,0], [wedgeWidth/2, 0], [wedgeTopWidth/2, totalHeight - capHeight],
                 [-(wedgeTopWidth/2), (totalHeight -  capHeight)], [-wedgeWidth/2, 0]] );
      }
    }
  }
}

// No clearance needed since this comes from measuing the exiting attachment.

// Like cube([x, y, z], except round the corners in the x and y directions by radius r.
module roundedCube(x1, y1, z1, r1) {
  hull() {
    translate([r1, r1, 0]) {
        cylinder(r=r1, h=z1);
    }
    translate([x1-r1, r1, 0]) {
        cylinder(r=r1, h=z1);
    }

    translate([r1, y1-r1, 0]) {
        cylinder(r=r1, h=z1);
    }
    translate([x1-r1, y1-r1, 0]) {
        cylinder(r=r1, h=z1);
    }
  }
}

// the negative space the iPad will take.
module iPadModel() {
  effectiveLength = iPadLength+2*iPadClearance;
  effectiveThickness = iPadThickness+2*iPadClearance;
  translate([-effectiveLength/2, effectiveThickness/2, 0]) {
    rotate([90, 0, 0]) {
      roundedCube(effectiveLength, iPadZ*2, effectiveThickness, iPadRadius);
    }
  }
}

// Slices through the box, to create the "window" to see the iPad screen.
module iPadWindow() {
  translate([(fingerThickness+wallThickness)-(iPadLength/2), (iPadThickness  + 4*(fingerThickness+wallThickness)), 0]) {
    rotate([90, 0, 0]) {
      roundedCube(iPadLength-(2*(fingerThickness+wallThickness)), iPadZ*2-2*fingerThickness, 15*iPadThickness, iPadRadius);
    }
  }
}

// The actual iPad holder, before the cutout for the iPad.
module topHolder() {
  holderLength = 2*(wallThickness+iPadClearance) + iPadLength;
  holderThickness = 2*(wallThickness+iPadClearance) + iPadThickness;
  holderZ = iPadZ+baseHeight;
  translate([-holderLength/2, -holderThickness/2, 0]) {
    cube([holderLength, holderThickness, holderZ]);
  }
}

// Decorative really, a half-round undercut along most of the bottom of the base.
module undercut() {
  translate([-iPadLength, 0, 0]) {
    rotate([0, 90, 0]){
      cylinder(d=8, h=iPadLength*2);
    }
  }
}

// The full holder: the box, minus the iPad and its window plus either the wedge, or the screw support.
module holder() {
  holderThickness = 2*(wallThickness+iPadClearance) + iPadThickness;
  difference() {
  union() {
    difference() {
      topHolder();
      translate([0, 0, baseHeight]) {
        iPadModel();
      }
      translate([0, 0, baseHeight+2*wallThickness]) {
        iPadWindow();
      }
      undercut();
    }
    if (attachment == "Screw") {
      screwThickness = 13 + 2 * wallThickness;
      screwBaseThickness = holderThickness < screwThickness ? screwThickness : holderThickness;
      rotate([0, 0, 45/2]) {
        cylinder(d=screwBaseThickness, h=baseHeight, $fn=8);
      }
    } else if (attachment == "Wedge") {
      translate([0, 0, -(totalHeight - capHeight)]) {
        tripodWedge();
      }
    }
  }
  if (attachment == "Screw") {
      translate([0, 0, baseHeight-5]) {
        cylinder(d=13, h=15, $fn=6);
      }
      cylinder(r=3.5, h=baseHeight-5, $fn=20);
    }
  }
}

holder();

