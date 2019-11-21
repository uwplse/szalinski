// This printed part is one possible way to anchor Shapeoko belts.
// See http://www.shapeoko.com/wiki/index.php/Belt_Anchors for other ideas.
// Motivated by http://www.thingiverse.com/thing:33881 not being strong enough
// when I initially printed it.

// Upright: printed, but not stress tested, looks sturdy
// Top: completely untested

gThick = 8;
gRibHeight = 6;
gTopRoundoverRadius = 4;
gSideRoundoverRadius = 4;
gMainWidth = 16;
gTopWidth = 30;
gRibWidth = 3.4;
gHoleSpacing = 20;
gBeltWide = 14; // 1/4" belt + slop
gBeltPitch = 2.032; // MXL in mm
gBeltThick = 1.5;
e = 0.02;

// screw_clearance_diameter, socket_head_clearance_diameter, nut outside diameter
// TODO untested numbers, these should move to a common include.
M3 = [3.5, 6.4, 6.4];
M5 = [5.5, 9.4, 9.4];
M8 = [8, 13, 13];

module InsetHole(x) {
  d = x[0];
  socket_head = x[1];
  union() {
    translate([0,0,-50]) cylinder(r=d/2, h=100);
    cylinder(r=socket_head/2, h=10);
  }
}

module NutHole(x) {
  d = x[0];
  nut_size = x[2];
  union() {
    translate([0,0,1]) cylinder(r=d/2, h=50);
    cylinder(r=nut_size/2, $fn=6, h=6);
  }
}

module Rib(t=4) {
  translate([-t/2,0,-0.1])
    rotate([90,0,90])
      linear_extrude(height=t)
        polygon(points=[[0,0],[40,0],[0,gRibHeight]],paths=[[0,1,2]]);
}

module Roundover(r) {
  translate([0.1,0.1,-50])
    difference() {
      cube([r,r,100]);
      translate([0,0,-1]) cylinder(r=r,h=102,$fn=20);
    }
}

module Upright() {
  difference() {
    union() {
      // body, for now (until beziers work)
      translate([0,-25,(gThick+gRibHeight)/2]) cube([gTopWidth,10,gThick+gRibHeight], center=true);
      translate([0,0,gThick/2]) cube([gMainWidth,60,gThick], center=true);
      // ribs
      translate([(gMainWidth-gRibWidth)/2,-20,gThick]) Rib(t=gRibWidth);
      translate([-(gMainWidth-gRibWidth)/2,-20,gThick]) Rib(t=gRibWidth);
    }
    // Chamfer top edges
    // TODO make these translation numbers constants as well, and fix Roundover's
    // origin.
    translate([gTopWidth/2-gTopRoundoverRadius,0,gThick+gRibHeight-gTopRoundoverRadius])
      rotate([90,0,0])
        Roundover(r=gTopRoundoverRadius);
    translate([-(gTopWidth/2-gTopRoundoverRadius),0,gThick+gRibHeight-gTopRoundoverRadius])
      rotate([90,0,180])
        Roundover(r=gTopRoundoverRadius);
    // Chamfer edges near bottom mounting hole
    translate([gMainWidth/2-gSideRoundoverRadius,26,0])
      Roundover(r=gSideRoundoverRadius);
    translate([-(gMainWidth/2-gSideRoundoverRadius),26,0])
      rotate([0,0,90])
        Roundover(r=gSideRoundoverRadius);
    // M5 mounting holes
    translate([0,0,gThick-2]) InsetHole(M5);
    translate([0,20,gThick-2]) InsetHole(M5);
    // M3 nut traps (20mm spacing, for compat with old part)
    translate([-gHoleSpacing/2,-16,(gThick+gRibHeight)/2]) rotate([90,-90,0]) NutHole(M3);
    translate([gHoleSpacing/2,-16,(gThick+gRibHeight)/2]) rotate([90,-90,0]) NutHole(M3);
  }
}

module Belt() {
  translate([0,0,gBeltThick/2]) cube([gBeltWide,30,gBeltThick], center=true);
  for(i = [0:30/gBeltPitch]) {
    translate([0,i * gBeltPitch,-gBeltThick/2+e]) cube([gBeltWide,gBeltPitch / 2,gBeltThick], center=true);
  }
}

module Top() {
  rotate([-90,0,0]) difference() {
    translate([0,-5,(gThick+gRibHeight)/2]) cube([gTopWidth,10,gThick+gRibHeight], center=true);
    // holes
    translate([-gHoleSpacing/2,20,(gThick+gRibHeight)/2]) rotate([90,-90,0]) NutHole(M3);
    translate([gHoleSpacing/2,20,(gThick+gRibHeight)/2]) rotate([90,-90,0]) NutHole(M3);
    // chamfer
    translate([gTopWidth/2-gTopRoundoverRadius,0,gThick+gRibHeight-gTopRoundoverRadius])
      rotate([90,0,0])
        Roundover(r=gTopRoundoverRadius);
    translate([-(gTopWidth/2-gTopRoundoverRadius),0,gThick+gRibHeight-gTopRoundoverRadius])
      rotate([90,0,180])
        Roundover(r=gTopRoundoverRadius);
    // TODO remove 12 as magic number
    translate([0,-12+(1.6*gBeltThick),0]) rotate([90,0,0]) Belt();
  }
}

union() {
  Upright();
  translate([0,-50,0]) Top();
}
