//!OpenSCAD

// Thickness of the model overall (default 6,2mm)
Overall_Thickness = 6.2;

// Outer Diameter with blades (default 37mm)
Outer_Diameter_Blades = 37;

// Thickness of the blades (default 0,8mm)
Thickness_Walls_Blades = 0.8;

// Amount of blades (default 9)
Amount_Blades = 9;

// The angle of the blades (default 50°)
Angle_Blades = 50;

// The radius with which the blades are bowed perpendicular to the surface of the center part (default 15mm)
Bowing_Radius_Perpendicular_Blades = 15;

// The resolution with which the blades are bowed perpendicular to the surface of the center part (default 17)
Bowing_Resolution_Perpendicular_Blades = 17;

// The radius with which the blades are bowed vertically (default 15mm)
Bowing_Radius_Vertical_Blades = 15;

// The resolution with which the blades are bowed vertically (default 10)
Bowing_Resolution_Vertical_Blades = 10;

// Inner Diameter of the Body (default 22.7mm)
Inner_Diameter_Body = 22.7;

// Thickness of the body parts (default 1mm)
Thickness_Walls_Body = 1;

// The diameter of the axle hole (default 2mm)
Axle_Diameter = 2;

// INTERN VARIABLES
// Circle Resolution
$fn = 64;

// Helper Variables that gives the intended length of the blades
Length_Blades = (Outer_Diameter_Blades - Inner_Diameter_Body) / 2;

// Helper variable that gives the angle difference for the perpendicular bowing
Bowing_Angle_Blades_Perpendicular = 5 + (Overall_Thickness <= (2 * Bowing_Radius_Perpendicular_Blades) * cos(Angle_Blades) ? 2 * (asin(Overall_Thickness / ((2 * Bowing_Radius_Perpendicular_Blades) * cos(Angle_Blades)))) : (Overall_Thickness / (4 * Bowing_Radius_Perpendicular_Blades)) * 360);

// Helper Variable that gives the required Y shift for the blades
Mean_Y = Bowing_Radius_Perpendicular_Blades * (cos(Angle_Blades) * cos((Bowing_Angle_Blades_Perpendicular / 2)));

// Helper Variable that gives the required Z shift for the blades
Mean_Z = Bowing_Radius_Perpendicular_Blades * (sin(Angle_Blades) * cos((Bowing_Angle_Blades_Perpendicular / 2)));

// Helper variable that gives the angle difference for the vertical bowing
Bowing_Angle_Blades_Vertical = Length_Blades <= Bowing_Radius_Vertical_Blades ? asin(Length_Blades / Bowing_Radius_Vertical_Blades) : (Length_Blades / (4 * Bowing_Radius_Vertical_Blades)) * 360;

translate([0, 0, (Overall_Thickness / 2)]){
  difference() {
    union(){
      difference() {
        cylinder(r1=(Inner_Diameter_Body / 2 + Thickness_Walls_Body), r2=(Inner_Diameter_Body / 2 + Thickness_Walls_Body), h=Overall_Thickness, center=true);

        translate([0, 0, (Thickness_Walls_Body / 2)]){
          cylinder(r1=(Inner_Diameter_Body / 2), r2=(Inner_Diameter_Body / 2), h=(Overall_Thickness - Thickness_Walls_Body), center=true);
        }
      }
      translate([0, 0, (-1 * (Overall_Thickness / 2 - (Thickness_Walls_Body + 0.5)))]){
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
        Blade();
      }
    }

    cylinder(r1=(Outer_Diameter_Blades / 2), r2=(Outer_Diameter_Blades / 2), h=Overall_Thickness, center=true);

  }
}

module Blade() {
  for (j = [Angle_Blades - Bowing_Angle_Blades_Perpendicular / 2 : abs(Bowing_Angle_Blades_Perpendicular / Bowing_Resolution_Perpendicular_Blades) : Angle_Blades + Bowing_Angle_Blades_Perpendicular / 2]) {
    rotate([0, 0, (atan((cos(j) * Bowing_Radius_Perpendicular_Blades - Mean_Y) / ((Length_Blades + Inner_Diameter_Body) / 2 + Thickness_Walls_Body)))]){
      translate([((Inner_Diameter_Body + Thickness_Walls_Blades) / 2), 0, (Mean_Z - Bowing_Radius_Perpendicular_Blades * sin(j))]){
        Blade_Stripe(j);
      }
    }
  }

}

module Blade_Stripe(j) {
  for (k = [0 : abs(Bowing_Angle_Blades_Vertical / Bowing_Resolution_Vertical_Blades) : Bowing_Angle_Blades_Vertical]) {
    translate([(Bowing_Radius_Vertical_Blades * sin(k)), (Bowing_Radius_Vertical_Blades * (cos(k) - 1)), 0]){
      rotate([(-1 * j), 0, (-1 * k)]){
        cube([Thickness_Walls_Blades, Thickness_Walls_Blades, Thickness_Walls_Blades], center=true);
      }
    }
  }

}