// Do you want to have a drain hole? In case of a saucer set to Yes if you have a drainhole in the pot
Drain_hole = "Yes"; //[Yes,No]
// Do you want to have risers (only for saucers, see desciption)
Pot_risers = "Yes"; //[Yes,No]
// Vase mode , Drain Holde = 0 !
Vase_mode = "No"; //[Yes,No]
/*[Bottom Part settings]*/
// Defines the thickness of the bottom part of your Pot
Bottom_Thickness = 1;
// Wall Thickness of the bottom part in mm
Wall_thickness_low = 0.8;
// Diameter of the bottom part in mm
Lower_Diameter = 78;
// Defines the angle of the walls in the X Direction(1 = 90degees)
Scale_X_Direction = 1.2;
// Defines the angle of the walls in the X Direction(1 = 90degrees)
Scale_Y_Direction = 1.2;
// Hight of the Bottom Part / Base
base_height = 72;
// When the pot shouldbe twisted insert here an angle between 20 and 40 or 0
Twist_angle = 30;
// sides of the bottom Part, the more sides, the rounder it is
Sides_of_the_base = 8; //[3:100]
// diameter of the Drainhole in mm
Drain_Hole_Diameter = 7;
/*[Hidden]*/
/*[Rim settings]*/
// hightof your rim in mm
Rim_hight = 10;
// Defines the distance therim shouldpoint out in mm (0=no rim)
Rim_thickness = 0.8;
// angle of the rim in X direction(1 = 90�)
Rim_scale_X_Direction = 1;
// angle of the rim in Y direction(1 = 90�)
Rim_scale_Y_Direction = 1;
// defines the Angle of the twist in the rim in degrees
twist_angle_rim = 5;
/*[Hidden]*/
/*[Pot riser Settings]*/
// Number of risers (default = 5)
Number_of_pot_risers = 5;
// hight of the risers in mm
riser_hight = 2;
/*[Hidden]*/

Wall_thickness = Vase_mode == "No" ? Wall_thickness_low : ((Lower_Diameter/2)+ Rim_thickness);
rim_mode = Vase_mode == "No" ? 0 : Lower_Diameter/2;
//echo((((360 / Sides_of_the_base) / 2)+ fine_tune_rim));
union(){
  difference() {
    difference() {
      union(){
        linear_extrude( height=base_height, twist=Twist_angle, scale=[Scale_X_Direction, Scale_Y_Direction], center=false){
          {
            $fn=Sides_of_the_base;    //set sides to Sides_of_the_base
            circle(r=(Lower_Diameter / 2));
          }
        }
        translate([0, 0, base_height]){
          linear_extrude( height=Rim_hight, twist=twist_angle_rim, scale=[Rim_scale_X_Direction, Rim_scale_Y_Direction], center=false){
            scale([Scale_X_Direction, Scale_Y_Direction, 1]){
              if (Twist_angle == 0) {
                {
                  $fn=Sides_of_the_base;    //set sides to Sides_of_the_base
                  circle(r=(Lower_Diameter / 2 + Rim_thickness));
                }
              } else {
                rotate([0, 0, Twist_angle*-1]){
                  {
                    $fn=Sides_of_the_base;    //set sides to Sides_of_the_base
                    circle(r=(Lower_Diameter / 2 + Rim_thickness));
                  }
                }
              }

            }
          }
        }
      }

      translate([0, 0, Bottom_Thickness]){
        union(){
          linear_extrude( height=base_height, twist=Twist_angle, scale=[Scale_X_Direction, Scale_Y_Direction], center=false){
            {
              $fn=Sides_of_the_base;    //set sides to Sides_of_the_base
              circle(r=(Lower_Diameter / 2 - Wall_thickness));
            }
          }
          translate([0, 0, base_height]){
            linear_extrude( height=Rim_hight, twist=twist_angle_rim, scale=[Rim_scale_X_Direction, Rim_scale_Y_Direction], center=false){
              scale([Scale_X_Direction, Scale_Y_Direction, 1]){
                if (Twist_angle == 0) {
                  {
                    $fn=Sides_of_the_base;    //set sides to Sides_of_the_base
                    circle(r=(Lower_Diameter / 2 - rim_mode));
                  }
                } else {
                  rotate([0, 0, Twist_angle*-1]){
                    {
                      $fn=Sides_of_the_base;    //set sides to Sides_of_the_base
                      circle(r=(Lower_Diameter / 2 - rim_mode));
                    }
                  }
                }

              }
            }
          }
        }
      }
    }

    if (Drain_hole == "Yes" && Pot_risers == "No") {
      cylinder(r1=(Drain_Hole_Diameter / 2), r2=(Drain_Hole_Diameter / 2), h=1000, center=true);
    }

  }
  if (Pot_risers == "Yes") {
    difference() {
      for (i = [0 : abs(1) : Number_of_pot_risers]) {
        rotate([0, 0, ((360 / Number_of_pot_risers) * i)]){
          translate([0, -1.5, Bottom_Thickness]){
            cube([((Lower_Diameter - 10) / 2), 3, riser_hight], center=false);
          }
        }
      }

      if (Drain_hole == "Yes") {
          translate([0,0,(Bottom_Thickness*(1))]){
        cylinder(r1=(Drain_Hole_Diameter / 2), r2=(Drain_Hole_Diameter / 2), h=1000, center=false);
      }}

    }
  }

}
