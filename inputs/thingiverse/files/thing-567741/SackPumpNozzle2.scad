/////////////////////////////////////////////////////////////////////////
//  
//  'Sack Pump Nozzle' by Chris Molloy (http://chrismolloy.com/)
//  
//  Released under Creative Commons - Attribution - Share Alike licence
//  
/////////////////////////////////////////////////////////////////////////

// Outer diameter of tube (excluding lip)
throat_od = 29;

// Length of tube (including lip)
throat_length = 9;

// Outer diameter of plug (the bit that fits into bottle)
plug_od = 32;

// Length of plug
plug_length = 9;

// Number of perimeter supports (or zero = no support)
support_count = 30;

/* Hidden */
// Tweak if you want...
lip_width = 1.5;
shoulder_width = 1.5;
wall_thickness = 1.5;
$fn = 50;

// Leave these alone...
throat_or = throat_od / 2;
plug_or = plug_od / 2;
shoulder_or = max(plug_or + shoulder_width, throat_or + lip_width + shoulder_width);

difference() {
  union() {
    // plug
    cylinder(h = plug_length, r = plug_or);

    // shoulder
    translate([0, 0, plug_length]) {
      cylinder(h = shoulder_width, r = shoulder_or);
    }

    // nozzle
    translate([0, 0, plug_length + shoulder_width]) {
      cylinder(h = throat_length, r1 = throat_or + lip_width, r2 = throat_or);

      // lip
      translate([0, 0, throat_length - lip_width]) {
        rotate_extrude(convexity = 10) {
          translate([throat_or, 0, 0]) {
            circle(r = lip_width);
          }
        }
      }
    }

    // shoulder supports
    if (support_count > 0) {
      for (aa = [0: 360 / support_count: 359.9]) {
        rotate([0, 0, aa]) {
          translate([shoulder_or - 0.5, 0, 0]) {
            union() {
              cylinder(h = plug_length - 0.5, r = 0.5);
              translate([0, 0, plug_length - 0.5]) {
                sphere(r = 0.5);
              }
            }
          }
        }
      }
    }
  }

  // hole
  translate([0, 0, -5]) {
    cylinder(h = plug_length + shoulder_width + throat_length + 10, r = min(plug_or, throat_or) - wall_thickness);
  }
}
