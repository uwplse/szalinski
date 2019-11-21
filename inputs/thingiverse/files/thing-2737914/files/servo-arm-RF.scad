/**
    Parametric servo arm generator for OpenScad

    Forked from 2012 Charles Rincheval.  All rights reserved.

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

*/

// Which Spline would you like to see?
// spline_type = 1; // [1:"Hitec C1-24T",2:"Hitec D1-15T",3:"Futaba 1F-15",4:"Futaba 2F-21T (9g?)",5:"Futaba 3F-25T]";
// Spline Size
spline_type = 1; // [1:Hitec C1-24T, 2:Hitec D1-15T, 3:Futaba 1F-15, 4:Futaba 2F-21T (9g?), 5:Futaba 3F-25T, 6:Actobotics Horn(Hitec), 7:Actobotics Horn(Futaba), 8:Tetrix Horn(Hitec), 9:Tetrix Horn(Futaba) ]

arm_length = 20;

arm_count = 1; // [1,2,3,4,5,6,7,8]

arm_screw_diameter = 2.0;

base_thickness = 2.0;

/**
    Clear between arm head and servo head
    With PLA material, use clear : 0.3, for ABS, use 0.2
*/
SERVO_HEAD_CLEARANCE = 0.2;


$fn = 40/1;


/**
    Head / Tooth parameters
    http://https://www.servocity.com/servo-spline-info

    First array (head related) :
    0. Head external diameter  (INTERNAL OF TEETH)
    1. Head height
    2. Head thickness
    3. Head screw diameter
    4. Head Base Thickness

    Second array (tooth related) :
    0. Tooth count
    1. Tooth height
    2. Tooth length
    3. Tooth width
*/
/**
   Tooth (ON SERVO)

     |<-w->|
     |_____|___
     /     \  ^h
   _/       \_v
    |<--l-->|

   - tooth height (h)
   - tooth length (l)
   - tooth width (w)

    For a new servo: Seems to work best to first set the tooth height to zero,
     and get the outer diameter snug, then work on the teeth.

   Printed very well on Printrbot Simple Pro  0.3mm nozzle, 0.1 layer PLA

   If you need just the spline, set the arm length, and head base thickness to zero

*/
//------------------------------------------------

HITEC_D1_SPLINE = [
                    [7.6, 5.5, 1.8, 3.4, base_thickness],
                    [15, 0.7, 1.3, 0.2]
                  ];
module servo_hitec_d1(length, count) {
  servo_arm(HITEC_D1_SPLINE, [length, count]);
}
//------------------------------------------------

HITEC_C1_SPLINE = [
                    [5.6, 3.5, 1.6, 2.8, base_thickness],
                    [24, 0.4, 0.7, 0.051]
                  ];
module servo_hitec_c1(length, count) {
  servo_arm(HITEC_C1_SPLINE, [length, count]);
}
//------------------------------------------------

FUTABA_1F_SPLINE = [
                     [4.0, 3.75, 1.1, 2.3, base_thickness],
                     [15, 0.25, 0.6, 0.09]
                   ];
module servo_futaba_1f(length, count) {
    servo_arm(FUTABA_1F_SPLINE, [length, count]);
}
//------------------------------------------------

FUTABA_2F_SPLINE = [
                     [4.90, 3, 1.8, 2.3, base_thickness],
                     [21, 0.57, 0.7, 0.1]
                   ];
module servo_futaba_2f(length, count) {
  servo_arm(FUTABA_2F_SPLINE, [length, count]);
}
//------------------------------------------------

FUTABA_3F_SPLINE = [
                     [5.92, 3, 1.1, 2.5, base_thickness],
                     [25, 0.3, 0.7, 0.1]
                   ];
module servo_futaba_3f(length, count) {
  servo_arm(FUTABA_3F_SPLINE, [length, count]);
}
//------------------------------------------------

/**
    If you want to support a new servo, juste add a new spline definition array
    and a module named like servo_XXX_YYY where XXX is servo brand and YYY is the
    connection type (3f) or the servo type (s3003)
*/

//    Servo head

module servo_head(params, clear = SERVO_HEAD_CLEARANCE) {

  head = params[0];
  tooth = params[1];

  head_diameter = head[0];
  head_height = head[1];
  head_base = head[4];

  tooth_count = tooth[0];
  tooth_height = tooth[1];
  tooth_length = tooth[2];
  tooth_width = tooth[3];

  //     %cylinder(r = (head_diameter / 2), h = head_height + 1);

  cylinder(r = head_diameter / 2 - tooth_height + 0.03 + clear, h = head_height);

// add teeth
    for (i = [0 : tooth_count]) {
      rotate([0, 0, i * (360 / tooth_count)]) {
        translate([0, head_diameter / 2 - tooth_height + clear, 0]) {
          servo_head_tooth(tooth_length, tooth_width, tooth_height, head_height);
        }
      }
    }
  }


module servo_head_tooth(length, width, height, head_height){

  curvatureAdd = 0.05;
  linear_extrude(height = head_height) {
    polygon([[-length / 2 - curvatureAdd, -curvatureAdd], [-width / 2, height], [width / 2, height], [length / 2 + curvatureAdd, -curvatureAdd]]);  
   }
}
/**
    Servo hold
    - Head / Tooth parameters
    - Arms params (length and count)
*/
module servo_arm(params, arms) {

  head = params[0];
  tooth = params[1];

  head_diameter = head[0];
  head_height = head[1];
  head_thickness = head[2];
  head_screw_diameter = head[3];
  head_base = head[4];

  tooth_length = tooth[2];
  tooth_width = tooth[3];

  arm_length = arms[0];
  arm_count = arms[1];

  /**
      Servo arm
      - length is from center to last hole
  */
  module arm(tooth_length, tooth_width, head_height, hole_count ) {

//    arm_screw_diameter = 2;

    difference() {
      union() {
        hull() {
          cylinder(r = tooth_width / 2, h = head_base);
          translate([0, tooth_length, 0]) {
          cylinder(r = arm_screw_diameter / 2 + 1.5, h = head_base);
//          #cylinder(r = tooth_width / 3, h = head_base);
              
          } 
        }

      }

      // Hole
//      for (i = [0 : hole_count - 1]) {
        //translate([0, length - (length / hole_count * i), -1]) {
        translate([0, tooth_length , -1]) {
          cylinder(r = arm_screw_diameter / 2, h = 10);
        }
//      }

      translate([0, 0, -0.001])cylinder(r = head_screw_diameter / 2, h = 10);
    }



  }

  arm_thickness = head_thickness;

  // Arm
  difference() {   // spline hub
    union(){
      for (j = [0 : arm_count - 1]) {
        rotate([0, 0, j * (360 / arm_count)]) {
          arm(arm_length, head_diameter + arm_thickness * 2, head_height, 1);
            hull() {                  // cross support
              translate([0 , head_diameter/2, 0])
              cylinder(r = head_base / 2, h = head_base + head_height);
              translate([0 , max(arm_length - 4,0), 0])
              cylinder(r = head_base / 2, h = head_base);
            } 
         }
       }
        
       cylinder(r = head_diameter / 2 + head_thickness, h = head_height + head_base );
     }
    
     translate([0, 0, -0.001]) 
     cylinder(r = head_screw_diameter / 2, h = 10);  // hole
     translate([0, 0, head_base + 0.0001])
     servo_head(params); // teeth

  }

     if (spline_type >= 6 ){       // servo horns for actobotics,tetrix
         difference(){
              rad=13.5;
              if (spline_type >= 8) {
                  cylinder(r=11.5,h=head_base);}
              else {
                  cylinder(r=13.5,h=head_base);}
                      
                 for (j = [0 : arm_count - 1]) {
                     rotate([0, 0, j * (360 / arm_count)])
                     translate([0, arm_length , -1]) 
                     cylinder(r = 2.05 , h = 10);
//                     cylinder(r = arm_screw_diameter / 2 , h = 10);
                         }
         
         }
         }

 
}


print_part();

module print_part() {
	if (spline_type == 1)  {
		servo_hitec_c1 (arm_length, arm_count);
	} else if (spline_type  == 2) {
		servo_hitec_d1 (arm_length, arm_count);
	} else if (spline_type  == 3)  {
		servo_futaba_1f(arm_length, arm_count);
	} else if (spline_type  == 4) {
		servo_futaba_2f(arm_length, arm_count);
	} else if (spline_type  == 5) {
		servo_futaba_3f(arm_length, arm_count);
	} else if (spline_type  == 6) {
		servo_hitec_c1 (0.770*25.4/2, 8);
	} else if (spline_type  == 7) {
		servo_futaba_3f(0.770*25.4/2, 8);
	} else if (spline_type  == 8) {
		servo_hitec_c1 (16/2, 8);
	} else if (spline_type  == 9) {
		servo_futaba_3f(16/2, 8);
	}
}
/*
translate([00,0,0]) servo_futaba_1f(10, 1);
translate([10,0,0]) servo_futaba_2f(10, 1);
translate([0,-30,0]) servo_futaba_3f(20, 4);
translate([20,0,0]) servo_hitec_c1 (30, 1);
translate([32,0,0]) servo_hitec_d1 (40, 2);
*/
