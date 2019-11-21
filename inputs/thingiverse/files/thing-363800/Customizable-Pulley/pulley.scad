/////////////////////////////////////////////////////////////////////////
//  
//  'Customizable Pulley' by Chris Molloy (http://chrismolloy.com/)
//  
//  Released under Creative Commons - Attribution - Share Alike licence
//  
/////////////////////////////////////////////////////////////////////////

rope_diameter = 8;
wheel_diameter = 60;

/* [Hidden] */
$fn = 60;

module wheel(ropeDiameter = 10, wheelDiameter = 100) {
  wheelRadius = wheelDiameter / 2;
  ropeRadius = ropeDiameter / 2;

  difference() {
    cylinder(r = wheelRadius, h = ropeDiameter + 2); // wheel
    rotate_extrude(convexity = 10) {
        translate([wheelRadius + 1, ropeRadius + 1, 0]) {
          circle(r = ropeRadius);
        }
      } // rope groove
    cylinder(r = 4.5, h = ropeDiameter * 3, center = true); // axel
  }
}

module halfShell(ropeDiameter = 10, wheelDiameter = 100) {
  wheelRadius = wheelDiameter / 2;
  ropeRadius = ropeDiameter / 2;
  thinEnd = (ropeRadius * 3) + 4;
  thickEnd = (5 * thinEnd) / 3;
  span = wheelRadius + ropeDiameter;
  blockDepth = max(20, thinEnd);

  difference() {
    union() {
      cylinder(r = thinEnd, h = 4); // foot block
      linear_extrude(convexity = 10, height = 4) {
          polygon(points = [
            [-thinEnd, 0],
            [-thickEnd, span],
            [-thickEnd, span + blockDepth],
            [thickEnd, span + blockDepth],
            [thickEnd, span],
            [thinEnd, 0]
          ]);
        } // arm
      translate([-thickEnd, span, 0]) {
          cube([thickEnd * 2, blockDepth, ropeRadius + 6]);
        } // head block
      cylinder(r = 4, h = ropeRadius + 6); // axel
      translate([0, 0, 4]) {
          cylinder(r1 = 5, r2 = 4, h = 1);
        } // axel collar
      translate([-thinEnd, span + 10, (ropeRadius / 2) + 7]) {
          cylinder(r1 = 5, r2 = 4, h = ropeRadius + 2);
        } // male pin
      translate([0, span + blockDepth, 0]) {
          cylinder(r = thinEnd, h = ropeRadius + 6);
        } // handle block
      translate([0, thinEnd - 2, 4]) {
          sphere(radius=1, center=true);
        } // guide bump 1
      translate([0, -(thinEnd - 2), 4]) {
          sphere(radius=1, center=true);
        } // guide bump 2
      translate([thinEnd - 2, 0, 4]) {
          sphere(radius=1, center=true);
        } // guide bump 3
      translate([-(thinEnd - 2), 0, 4]) {
          sphere(radius=1, center=true);
        } // guide bump 4
    }
    translate([0, 0, -1]) {
        cylinder(r = 2, h = ropeRadius + 8);
      } // axel hole
    translate([-thinEnd, span + 10, -1]) {
        cylinder(r = 2, h = ropeDiameter + blockDepth);
      } // male pin hole
    translate([thinEnd, span + 10, -1]) {
        cylinder(r = 2, h = ropeRadius + 8);
      } // female pin hole
    translate([thinEnd, span + 10, (ropeRadius + 6) / 2]) {
        cylinder(r1 = 4, r2 = 5, h = ropeRadius + 2);
      } // female pin
    translate([0, span + blockDepth, -1]) {
        cylinder(r = thinEnd / 2, h = ropeRadius + 8);
      } // handle block
  }
}

translate([0, (rope_diameter * 1.5) + 8, 0]) {
  halfShell(rope_diameter, wheel_diameter);
}
rotate([0, 0, 180]) {
  translate([0, (rope_diameter * 1.5) + 8, 0]) {
    halfShell(rope_diameter, wheel_diameter);
  }
}
translate([-((wheel_diameter / 2) + (rope_diameter * 1.5) + 8), 0, 0]) {
  wheel(rope_diameter, wheel_diameter);
}