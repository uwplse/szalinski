/* [General parameters] */
// 0 will just create the center holder, which can be useful for testing the fit for your bearing!
numberOfLegs = 3; // [6]
// Thickness of the walls around the bearings
hThick = 2; // [0.5:.25:5]
// Space from the center bearing to the center of each outside bearing
legLength = 30; // [80]
// Sketchy way of carving out the side of the fidget toy
curveScale = 1.5; // [0:0.1:2]

/* [Bearing dimensions] */
// Radius of the outside bearing
outsideBearingRadius = 11; // [5:30]
// Radius of the center bearing
insideBearingRadius = 11; // [5:30]
// For now, just a uniform height is given. If you're using different size bearings, put the larger height of the two.
bearingHeight = 7; // [3:0.5:15]

/* [Adjustments] */
// Amount added to the bearing radii for allowing a better fit
hPlay = 0.1; // [0:0.1:1]
// Will add additional height
vPlay = 0; // [0:0.1:1]
// Affects the beveled edge
roundness = 1.5; // [0:0.1:2.5]
// Moves the 'cutouts' farther out with positive values, closer in with negatives
curveOffset = 0; // [-5:0.1:5]
// Adjusts the size of the 'cutouts', positive increasing, negative decreasing
curveSizeAdjust = 0; // [-5:0.1:5]

/* [Hidden] */
// Anything below will not be visble in the customizer.
$fa = 0.5; // lower = finer large radius
$fs = 0.75; // lower = finer small radius

// Extraneous
buffer = 0.01; // Internal variable that I use for preview to avoid 0-thickness walls

// Derived/utility
oHeight = bearingHeight + vPlay; // Height with adjustments
oRadius = outsideBearingRadius + hPlay; // Bearing radius with adjustments
iHeight = bearingHeight + vPlay;
iRadius = insideBearingRadius + hPlay;
curveRadius = min((legLength - iRadius - oRadius), max(iRadius, oRadius)) * curveScale + curveSizeAdjust;
curveOffsetX = (legLength - oRadius + iRadius)/2; // midpoint between the two bearings
curveOffsetY = ((iRadius + oRadius)/2 + hThick) * curveScale + curveOffset;
legAngle = 360/numberOfLegs;

// Future versions
point = 0;
bInnerR = 4 - hPlay; // inside radius
centerHolder = true;
insideBearingHeight = 7;

// Main object
bearingSpinner();

module bearingSpinner() {
  difference() {
    union() {
      for (i = [0:numberOfLegs-1]) {
        difference() {
          union() {
            hull() { // External
              rotate([0,0,i*(legAngle)]) translate([legLength,0,0])
                rCylinder(r=oRadius+hThick, h=oHeight); // leg
              rCylinder(r=iRadius+hThick, h=iHeight); // inside
            }
            if (point != 0) { // Point generation TODO
              rotate([0,0,i*(legAngle)]) translate([legLength+oRadius,-oRadius/2,1.5])
                cube([10,oRadius,oHeight-1.5*2]);
            }
          }
          for (j = [-1:2:1]) { // Carve out the sides
            rotate([0,0,i*(legAngle)])
              translate([curveOffsetX,curveOffsetY*j,-buffer])
                irCylinder(r=curveRadius, h=oHeight+buffer*2);
          
          }
          if (point != 0) {
            for (j = [-1:2:1]) { // Point generation TODO - Carve out the points
              rotate([0,0,i*(legAngle)])
                translate([legLength+oRadius+hThick/2,(oRadius-hThick+point)*j,-buffer])
                  irCylinder(r=curveRadius+point, h=oHeight+buffer*2);
            }
          }
        }
      }
    }
    for (i = [0:numberOfLegs-1]) {
      // Cut out the outside bearing slots
      rotate([0,0,i*(legAngle)]) translate([legLength,0,0])
        translate([0,0,-buffer]) cylinder(r=oRadius, h=oHeight+buffer*2);
    }
    // Cut out the center bearing
    translate([0,0,-buffer]) cylinder(r=iRadius, h=iHeight+buffer*2);
    
  }
}

// Rounded cylinder module
module rCylinder(r, h) {
  hull() {
    cylinder(r=r-roundness, h=h);
    translate([0,0,roundness]) cylinder(r=r, h=h-roundness*2);
  }
}
// Inverse rounded cylinder (spool shaped sort've)
module irCylinder(r, h) {
  union() {
    cylinder(r=r, h=h);
    translate([0,0,0]) cylinder(r1=r+roundness, r2=0, h=h);
    translate([0,0,0]) cylinder(r1=0, r2=r+roundness, h=h);
  }
}
//irCylinder(r=bRadius+hThick, h=oHeight);
//translate([0,(bRadius+hThick)*2,0])
//  rCylinder(r=bRadius+hThick, h=oHeight);
