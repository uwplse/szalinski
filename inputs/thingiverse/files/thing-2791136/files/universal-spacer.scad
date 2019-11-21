// Library: spacer.scad
// Version: 1.1
// Author: Robbin Fernström <rofer@protonmail.com>
// Copyright: 2018
// Licence: CC BY-SA 4.0


/* [Options] */
spacer_shape = 2; // [0:No legs,1:1 Leg,2:2 Legs L Shape,3:2Legs I Shape,4:3 Legs,5:4 Legs,6:8 Legs]

// same for all holes, compensate for inaccuracy (mm)
hole_diameter = 3.25; //[0:0.25:10]

// octagonal cylinder diameter i.e. side to side (mm)
spacer_diameter = 8; //[0:0.5:20]

// including base, i.e. total height  (mm)
spacer_height = 25; //[0:100]

// top angle (deg)
support_angle = 20; //[0:45]

// including base (mm)
support_height = 25; //[0:100]


/* [Hidden] */
spacer_diameter_outer = spacer_diameter * 1/cos(180/8);
support_width = tan(support_angle) * (support_height) + spacer_diameter_outer/2;
support_thickness = spacer_diameter_outer * sin(180/16) * 2;
base_thickness = support_thickness;
base_length = support_width + hole_diameter;

module spacer_leg() {
  // base leg
  difference() {
    union() {
      hull() {
        rotate([0,0,180/8])
        cylinder(r=spacer_diameter_outer/2, h=base_thickness, $fn=8);

        translate([base_length,0,0]) {
          rotate([0,0,180/8])
          cylinder(r=spacer_diameter_outer/2, h=base_thickness, $fn=8);
        }
      }
    }

    translate([base_length,0,-1]) {
      cylinder(r=hole_diameter/2, h=base_thickness+2, $fs=0.2);
    }
  }

  // support leg
  hull() {
    translate([0,-support_thickness/2,0])
    cube([spacer_diameter/2, support_thickness, support_height]);

    translate([0,-support_thickness/2,0])
    cube([support_width, support_thickness, base_thickness]);
  }
}

module spacer(shape) {
  difference() {
    union() {
      // add legs
      if(shape==1) { // 1 leg
        spacer_leg();
      } else if(shape==2) { // 2 legs L Shape
        spacer_leg();
        rotate([0,0,90])
        spacer_leg();
      } else if(shape==3) { // 2 legs I Shape
        spacer_leg();
        rotate([0,0,180])
        spacer_leg();
      } else if(shape==4) { // 3 legs T Shape
        for (i=[0:2]) {
          rotate([0,0,90*i-1])
          spacer_leg();
        }
      } else if(shape==5) { // 4 legs
        for (i=[0:3]) {
          rotate([0,0,90*i-1])
          spacer_leg();
        }
      } else if(shape==6) { // 8 legs
        for (i=[0:7]) {
          rotate([0,0, 360/8*i-1])
          spacer_leg();
        }
      }

      // add main cylinder
      rotate([0,0,180/8])
      cylinder(r=spacer_diameter_outer/2, h=spacer_height, $fn=8);
    }

    // create the cylinder hole.
    translate([0,0,-1])
    cylinder(r=hole_diameter/2, h=spacer_height+2, $fs=0.2);
  }
}

spacer(spacer_shape);
