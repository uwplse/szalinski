//!OpenSCAD

// Thickness of the blade overall
Overall_Thickness = 6.2;
// Outer Diameter with blades (default 37mm)
Outer_Diameter_Blades = 37;
// Thickness of the blades (default 1mm)
Thickness_Blades = 0.8;
// Amount of blades (default 9)
Amount_Blades = 8;
// The angle with which the blades are bowed (default 50°)
Bowing_Blades = 45;
// The angle of the blades (default 50°)
Angle_Blades = 45;
// Inner Diameter of the Body (default 22.6mm)
Inner_Diameter_Body = 22.8;
// Thickness of the body parts (default 1.2mm)
Thickness_Body = 1;
// The diameter of the axle hole (default 1.8mm)
Axle_Diameter = 2;

// Circle Resolution
$fn = 64;

// Some helping parameter
Length_Blades = (Outer_Diameter_Blades - Inner_Diameter_Body) / 2;
Remaining_Angle = (90 - Bowing_Blades) / 2;
Radius_Blades = Overall_Thickness / (cos(Remaining_Angle) - sin(Remaining_Angle));
translate([0, 0, (Overall_Thickness / 2)]){
  union(){
    difference() {
      union(){
        difference() {
          cylinder(r1=(Inner_Diameter_Body / 2 + Thickness_Body), r2=(Inner_Diameter_Body / 2 + Thickness_Body), h=Overall_Thickness, center=true);

          translate([0, 0, (Thickness_Body / 2)]){
            cylinder(r1=(Inner_Diameter_Body / 2), r2=(Inner_Diameter_Body / 2), h=(Overall_Thickness - Thickness_Body), center=true);
          }
        }
        translate([0, 0, (-1 * (Overall_Thickness / 2 - (Thickness_Body + 0.5)))]){
          cylinder(r1=(Axle_Diameter / 2 + 1), r2=(Axle_Diameter / 2 + 1), h=1, center=true);
        }
      }

      translate([0, 0, (-1 * (Overall_Thickness / 2 - 2.7))]){
        cylinder(r1=(Axle_Diameter / 2), r2=(Axle_Diameter / 2), h=5, center=true);
      }
    }
    intersection() {
      for (i = [0 : abs(360 / Amount_Blades) : 360]) {
        rotate([0, 0, i]){
          translate([((Inner_Diameter_Body + Length_Blades) / 2), 0, 0]){
            rotate([0, 90, 0]){
              Mean_X = Radius_Blades * (cos(Angle_Blades) * cos((Bowing_Blades / 2)));
              Mean_Y = Radius_Blades * (sin(Angle_Blades) * cos((Bowing_Blades / 2)));
              translate([(-1 * Mean_X), (-1 * Mean_Y), 0]){
                for (j = [Angle_Blades - Bowing_Blades / 2 : abs(Bowing_Blades / 20) : Angle_Blades + Bowing_Blades / 2]) {
                  translate([(Radius_Blades * cos(j)), (Radius_Blades * sin(j)), 0]){
                    rotate([(-1 * (atan((sin(j) * Radius_Blades - Mean_Y) / ((Length_Blades + Inner_Diameter_Body) / 2 + Thickness_Body)))), 0, 0]){
                      rotate([0, 0, j]){
                        cube([Thickness_Blades, Thickness_Blades, Length_Blades], center=true);
                      }
                    }
                  }
                }

              }
            }
          }
        }
      }

      cylinder(r1=(Outer_Diameter_Blades / 2), r2=(Outer_Diameter_Blades / 2), h=Overall_Thickness, center=true);

    }
  }
}