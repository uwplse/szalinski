//!OpenSCAD

// The tickness ofyour Tablet in mm
Tablet_thickness = 10;
// The stand has adefinedplace wich one do you want:
Version = "both";//[both,right,left]
// The width of the stand
width = 20;

/* [Advanced] */
// The height of the stand (mm)
Height = 20;
// Pay attention to the angle! It must decrease with increasing lengh(mm)
lengh = 100;
// Angle of the flattend end in degrees(mm)
angle = 10;
/* [Hidden] */

if (Version == "both") {
  union(){
    translate([0, (width + 8), 0]){
      difference() {
        linear_extrude( height=Height, twist=0, scale=[1, 1], center=false){
          union(){
            translate([0, (width / 2), 0]){
              circle(r=(width / 2));
            }
            translate([0, 0, 0]){
              square([lengh, width], center=false);
            }
            translate([lengh, (width / 2), 0]){
              circle(r=(width / 2));
            }
          }
        }

        translate([5, 4, 7]){
          rotate([0, angle, 0]){
            cube([Tablet_thickness, (width - 4), 50], center=false);
          }
        }
        translate([30, 0, Height]){
          rotate([0, angle, 0]){
            cube([100, 100, 100], center=false);
          }
        }
      }
    }
    difference() {
      linear_extrude( height=Height, twist=0, scale=[1, 1], center=false){
        union(){
          translate([0, (width / 2), 0]){
            circle(r=(width / 2));
          }
          translate([0, 0, 0]){
            square([lengh, width], center=false);
          }
          translate([lengh, (width / 2), 0]){
            circle(r=(width / 2));
          }
        }
      }

      translate([5, 0, 7]){
        rotate([0, angle, 0]){
          cube([Tablet_thickness, (width - 4), 50], center=false);
        }
      }
      translate([30, 0, Height]){
        rotate([0, angle, 0]){
          cube([100, 100, 100], center=false);
        }
      }
    }
  }
} else if (Version == "right") {
  translate([0, (width + 8), 0]){
    difference() {
      linear_extrude( height=Height, twist=0, scale=[1, 1], center=false){
        union(){
          translate([0, (width / 2), 0]){
            circle(r=(width / 2));
          }
          translate([0, 0, 0]){
            square([lengh, width], center=false);
          }
          translate([lengh, (width / 2), 0]){
            circle(r=(width / 2));
          }
        }
      }

      translate([5, 4, 7]){
        rotate([0, angle, 0]){
          cube([Tablet_thickness, (width - 4), 50], center=false);
        }
      }
      translate([30, 0, Height]){
        rotate([0, angle, 0]){
          cube([100, 100, 100], center=false);
        }
      }
    }
  }
} else {
  difference() {
    linear_extrude( height=Height, twist=0, scale=[1, 1], center=false){
      union(){
        translate([0, (width / 2), 0]){
          circle(r=(width / 2));
        }
        translate([0, 0, 0]){
          square([lengh, width], center=false);
        }
        translate([lengh, (width / 2), 0]){
          circle(r=(width / 2));
        }
      }
    }

    translate([5, 0, 7]){
      rotate([0, angle, 0]){
        cube([Tablet_thickness, (width - 4), 50], center=false);
      }
    }
    translate([30, 0, Height]){
      rotate([0, angle, 0]){
        cube([100, 100, 100], center=false);
      }
    }
  }
}

