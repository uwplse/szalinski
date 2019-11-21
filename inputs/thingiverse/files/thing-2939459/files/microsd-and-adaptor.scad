$fn = 100;
PI = 3.141592 * 1;
TOP_IMAGE = "";
TOP_TEXT = "";
BOTTOM_CREDITS = true;
// Change to zero when rendering, any other value will be considered a preview (better performance)
PREVIEW = 0;
LAYOUT = 0;

microSdCardCount = 8;
sdCardCount = 1;

hasSDCard = sdCardCount > 0;

topTextSize = 7;
topTextFont = "Helvetica Neue:style=Bold";

cardsExtraSpace = 0.5;
screwExtraSpace = 0.5;

sdCardHeight = 32.0 + cardsExtraSpace;
sdCardWidth = 24.5 + cardsExtraSpace;
sdCardThickness = 2.1 + cardsExtraSpace;

microSdCardHeight = 15.0 + cardsExtraSpace;
microSdCardWidth = 11.0 + cardsExtraSpace;
microSdCardThickness = 0.72 + cardsExtraSpace;
microSdCardXAxisOffset = 0.5;

spaceBetweenCards = 1.75;
lengthOfCardOutsideBox = 4.38;

bottomOuterCylinderDiameter = 46.0;
bottomInnerCylinderDiameter = 40.0;

caseGripCount = 30;
caseGripSize = 1;

caseWallSize = 4.0;
bottomScrewHeight = 7.34;

bottomInnerCylinderHeight
  = caseWallSize + (hasSDCard ? sdCardHeight : microSdCardHeight) - lengthOfCardOutsideBox;
bottomOuterCylinderHeight =
  bottomInnerCylinderHeight - bottomScrewHeight;

topCylinderHeight =
  lengthOfCardOutsideBox + caseWallSize + bottomScrewHeight + 0.5;

// LAYOUTS
layout1XOffset = -10.9;
layout1YOffset = 0;
layout1ZOffset = 0;

layout2XOffset = 0;
layout2YOffset = 0;
layout2ZOffset = 0;

translate([bottomOuterCylinderDiameter / 2 + 5, 0, 0]) bottom();
translate([-(bottomOuterCylinderDiameter / 2 + 5), 0, 0]) top();

module bottom() {
  difference() {
    union() {
      cylinder(d = bottomInnerCylinderDiameter, h = bottomInnerCylinderHeight);
      color([.557, .553, .478]) cylinder(d = bottomOuterCylinderDiameter, h = bottomOuterCylinderHeight);
      if (PREVIEW == 0) {
        difference() {
          translate([0, 0, bottomOuterCylinderHeight]) screw_thread(bottomOuterCylinderDiameter - caseWallSize, 2, 55, bottomScrewHeight, PI / 2.2);
          translate([0, 0, bottomInnerCylinderHeight - 0.01]) cylinder(d = bottomOuterCylinderDiameter * 1.1, h = bottomScrewHeight);
        }
      }
      for (i = [0 : 1 : caseGripCount - 1]) {
        color([.557, .553, .478]) rotate(a = [0, 0, i * (360 / caseGripCount)]) translate([(bottomOuterCylinderDiameter / 2) - caseGripSize, 0, bottomOuterCylinderHeight / 2]) cylinder(d = caseGripSize * 3, h = bottomOuterCylinderHeight, center = true);
      }
    }
    if (LAYOUT == 1) {
      translate([layout1XOffset, layout1YOffset, layout1ZOffset]) layout1();
    } else if (LAYOUT == 2) {
      translate([layout2XOffset, layout2YOffset, layout2ZOffset]) layout2();
    } else {
      layout0();
    }

    translate([0, 0, -0.1]) difference() {
      cylinder(d = bottomOuterCylinderDiameter * 1.1, h = 2);
      translate([0, 0, -0.1]) hull() {
        cylinder(d = bottomOuterCylinderDiameter - 1, h = 0.1);
        translate([0, 0, 2.1]) cylinder(d = bottomOuterCylinderDiameter + 1, h = 0.1);
      }
    }

    if (BOTTOM_CREDITS) {
      difference() {
        translate([0, 0, -0.1]) linear_extrude(height = 1.6) rotate([180, 0, 90]) text(text = "txgruppi.com", size = 5, valign = "center", halign = "center", font = "Helvetica Neue:style=Bold");
        translate([2.2, 3, 0]) cube([2, 2, 2]);
      }
    }
  }
}

module top() {
  difference() {
    union() {
      cylinder(d = bottomOuterCylinderDiameter, h = topCylinderHeight);
      for (i = [0 : 1 : caseGripCount - 1]) {
        rotate(a = [0, 0, i * (360 / caseGripCount)]) translate([(bottomOuterCylinderDiameter / 2) - caseGripSize, 0, topCylinderHeight / 2]) cylinder(d = caseGripSize * 3, h = topCylinderHeight, center = true);
      }
    }
    if (PREVIEW != 0) {
      translate([0, 0, caseWallSize]) cylinder(d = bottomOuterCylinderDiameter - caseWallSize, h = topCylinderHeight);
    } else {
      intersection() {
        translate([0, 0, caseWallSize]) cylinder(d = bottomOuterCylinderDiameter, h = topCylinderHeight);
        translate([0, 0, caseWallSize]) screw_thread(bottomOuterCylinderDiameter - caseWallSize + screwExtraSpace, 2, 55, topCylinderHeight, PI / 2.2);
      }
    }
    translate([0, 0, -0.1]) difference() {
      cylinder(d = bottomOuterCylinderDiameter * 1.1, h = 2);
      translate([0, 0, -0.1]) hull() {
        cylinder(d = bottomOuterCylinderDiameter - 1, h = 0.1);
        translate([0, 0, 2.1]) cylinder(d = bottomOuterCylinderDiameter + 1, h = 0.1);
      }
    }
    if (TOP_IMAGE != "") {
      translate([0, 0, -1]) difference() {
        rotate([180, 0, 0]) resize([bottomOuterCylinderDiameter, bottomOuterCylinderDiameter, 2.5]) surface(file = TOP_IMAGE, invert = true, center = true);
        translate([0, 0, 3]) cube([bottomOuterCylinderDiameter * 1.1, bottomOuterCylinderDiameter * 1.1, 0.6], center = true);
      }
    } else if (TOP_TEXT != "") {
      translate([0, 0, -0.1]) linear_extrude(height = 1.6) rotate([180, 0, 0]) text(text = TOP_TEXT, size = topTextSize, valign = "center", halign = "center", font = topTextFont);
    }
  }
}

module layout0() {
  // MicroSD
  union() {
    translate([-(((microSdCardThickness + spaceBetweenCards) * microSdCardCount - spaceBetweenCards) / 2) + microSdCardXAxisOffset, bottomInnerCylinderDiameter / (hasSDCard ? 4.5 : 5.5), 0]) for (i = [0 : 1 : microSdCardCount - 1]) {
      translate([(microSdCardThickness + spaceBetweenCards) * i, 0, bottomInnerCylinderHeight - microSdCardHeight / 2 + lengthOfCardOutsideBox]) cube([microSdCardThickness, microSdCardWidth, microSdCardHeight], center = true);
    }
    translate([-(((microSdCardThickness + spaceBetweenCards) * microSdCardCount - spaceBetweenCards) / 2) + microSdCardXAxisOffset, -(bottomInnerCylinderDiameter / (hasSDCard ? 4.5 : 5.5)), 0]) for (i = [0 : 1 : microSdCardCount - 1]) {
      translate([(microSdCardThickness + spaceBetweenCards) * i, 0, bottomInnerCylinderHeight - microSdCardHeight / 2 + lengthOfCardOutsideBox]) cube([microSdCardThickness, microSdCardWidth, microSdCardHeight], center = true);
    }
  }
  translate([0, bottomInnerCylinderDiameter / (hasSDCard ? 4.5 : 5.5), bottomInnerCylinderHeight]) rotate([0, 90, 0]) cylinder(d = microSdCardWidth * 0.8, h = (microSdCardThickness + spaceBetweenCards) * microSdCardCount * 1.1, center = true);
  translate([0, -(bottomInnerCylinderDiameter / (hasSDCard ? 4.5 : 5.5)), bottomInnerCylinderHeight]) rotate([0, 90, 0]) cylinder(d = microSdCardWidth * 0.8, h = (microSdCardThickness + spaceBetweenCards) * microSdCardCount * 1.1, center = true);

  // SD
  if (hasSDCard) {
    translate([0, 0, bottomInnerCylinderHeight - sdCardHeight / 2 + lengthOfCardOutsideBox]) cube([sdCardWidth, sdCardThickness, sdCardHeight], center = true);
  }
}

module layout1() {
  for (i = [0 : 1 : sdCardCount - 1]) {
    translate([(sdCardThickness + spaceBetweenCards) * i, 0, bottomInnerCylinderHeight - sdCardHeight / 2 + lengthOfCardOutsideBox]) cube([sdCardThickness, sdCardWidth, sdCardHeight], center = true);
  }
  translate([-(sdCardThickness / 2) - (spaceBetweenCards / 2), 0, bottomInnerCylinderHeight]) rotate([0, 90, 0]) cylinder(d = sdCardWidth * 0.8, h = (sdCardThickness + spaceBetweenCards) * sdCardCount);

  translate([(sdCardThickness + spaceBetweenCards) * sdCardCount + spaceBetweenCards, 0, 0]) {
    translate([0, 7, 0]) {
      for (i = [0 : 1 : microSdCardCount - 1]) {
        translate([(microSdCardThickness + spaceBetweenCards) * i, 0, bottomInnerCylinderHeight - microSdCardHeight / 2 + lengthOfCardOutsideBox]) cube([microSdCardThickness, microSdCardWidth, microSdCardHeight], center = true);
      }
      translate([-(microSdCardThickness / 2) - (spaceBetweenCards / 2), 0, bottomInnerCylinderHeight]) rotate([0, 90, 0]) cylinder(d = microSdCardWidth * 0.8, h = (microSdCardThickness + spaceBetweenCards) * microSdCardCount);
    }
    translate([0, -7, 0]) {
      for (i = [0 : 1 : microSdCardCount - 1]) {
        translate([(microSdCardThickness + spaceBetweenCards) * i, 0, bottomInnerCylinderHeight - microSdCardHeight / 2 + lengthOfCardOutsideBox]) cube([microSdCardThickness, microSdCardWidth, microSdCardHeight], center = true);
      }
      translate([-(microSdCardThickness / 2) - (spaceBetweenCards / 2), 0, bottomInnerCylinderHeight]) rotate([0, 90, 0]) cylinder(d = microSdCardWidth * 0.8, h = (microSdCardThickness + spaceBetweenCards) * microSdCardCount);
    }
  }
}

module layout2() {
  translate([0, 0, bottomInnerCylinderHeight - microSdCardHeight + lengthOfCardOutsideBox]) {
    // MicroSD center
    translate([((microSdCardThickness + spaceBetweenCards) * microSdCardCount - spaceBetweenCards) / -2, microSdCardWidth / -2, 0]) {
      for (i = [0 : 1 : microSdCardCount - 1]) {
        translate([(microSdCardThickness + spaceBetweenCards) * i, 0, 0]) cube([microSdCardThickness, microSdCardWidth, microSdCardHeight]);
      }
    }
    translate([((microSdCardThickness + spaceBetweenCards) * microSdCardCount - spaceBetweenCards) / -2 - spaceBetweenCards, 0, microSdCardHeight - lengthOfCardOutsideBox]) rotate([0, 90, 0]) cylinder(d = microSdCardWidth * 0.8, h = (microSdCardThickness + spaceBetweenCards) * microSdCardCount + spaceBetweenCards);
  }

  translate([0, 0, bottomInnerCylinderHeight - sdCardHeight + lengthOfCardOutsideBox]) {
    translate([sdCardWidth / -2, 11.5, 0]) {
      for (i = [0 : 1 : sdCardCount - 1]) {
        translate([0, (sdCardThickness + spaceBetweenCards) * -i, 0]) cube([sdCardWidth, sdCardThickness, sdCardHeight]);
      }
    }
    translate([sdCardWidth / -2, -14, 0]) {
      for (i = [0 : 1 : sdCardCount - 1]) {
        translate([0, (sdCardThickness + spaceBetweenCards) * i, 0]) cube([sdCardWidth, sdCardThickness, sdCardHeight]);
      }
    }
  }
}

/*
 *    polyScrewThread_r1.scad    by aubenc @ Thingiverse
 *
 * This script contains the library modules that can be used to generate
 * threaded rods, screws and nuts.
 *
 * http://www.thingiverse.com/thing:8796
 *
 * CC Public Domain
 */
module screw_thread(od,st,lf0,lt,rs,cs) {
  or=od/2;
  ir=or-st/2*cos(lf0)/sin(lf0);
  pf=2*PI*or;
  sn=floor(pf/rs);
  lfxy=360/sn;
  ttn=round(lt/st+1);
  zt=st/sn;

  intersection() {
    if (cs >= -1) {
      thread_shape(cs,lt,or,ir,sn,st);
    }
    full_thread(ttn,st,sn,zt,lfxy,or,ir);
  }
}

module thread_shape(cs,lt,or,ir,sn,st) {
  if ( cs == 0 ) {
    cylinder(h=lt, r=or, $fn=sn, center=false);
  } else {
    union() {
      translate([0,0,st/2])
        cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);

      if ( cs == -1 || cs == 2 ) {
        cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
      } else {
        cylinder(h=st/2, r=or, $fn=sn, center=false);
      }

      translate([0,0,lt-st/2])
        if ( cs == 1 || cs == 2 ) {
          cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
        } else {
          cylinder(h=st/2, r=or, $fn=sn, center=false);
        }
    }
  }
}

module full_thread(ttn,st,sn,zt,lfxy,or,ir) {
  if(ir >= 0.2) {
    for(i=[0:ttn-1]) {
      for(j=[0:sn-1]) {
        pt = [
          [0,                  0,                  i*st-st            ],
          [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
          [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
          [0,0,i*st],
          [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
          [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
          [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
          [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
          [0,                  0,                  i*st+st            ]
        ];
        polyhedron(points=pt, faces=[
          [1,0,3], [1,3,6], [6,3,8], [1,6,4], [0,1,2], [1,4,2], [2,4,5],
          [5,4,6], [5,6,7], [7,6,8], [7,8,3], [0,2,3], [3,2,7], [7,2,5]
        ]);
      }
    }
  } else {
    echo("Step Degrees too agresive, the thread will not be made!!");
    echo("Try to increase de value for the degrees and/or...");
    echo(" decrease the pitch value and/or...");
    echo(" increase the outer diameter value.");
  }
}
