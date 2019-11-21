/*
 * Customizable LED ligts - https://www.thingiverse.com/thing:3453860
 * by Taras Kushnirenko
 * created 2019-02-26
 * version v1.1
 *
 * Changelog
 * --------------
  * v1.1 - 2019-03-05:
 *  - [feature] convert to Customizer
 *  - [feature] add left wing of the ligts
 * v1.0 - 2019-02-26:
 *  - initial design
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */

 // Parameter Section //
//-------------------//

// preview[view:south, tilt:top diagonal]

/* [LED lights Settings] */

// The width of the LED strip 
strip_width_in_millimeter = 10.0; //[5:1:20]

// The length of the front LED lamp section
lamp_front_in_millimeter = 105.0; //[25:5:300]

// The length of the right section LED lamp
lamp_right_in_millimeter = 55.0; //[25:5:70]

// The right section angle. 0 - section disabled
lamp_right_angle = 20.0; //[0:5:90]

// The length of the left section LED lamp
lamp_left_in_millimeter = 55.0; //[25:5:70]

// The left section angle. 0 - section disabled
lamp_left_angle = 40.0; //[0:5:90]

// Wall thickness
wall_thickness = 1.2; //[0.4:0.1:5]

// Bottom thickness
bottom_thickness = 1.6; //[0.4:0.1:5]

// The number of front supports
number_of_front_supports = 10; //[2:1:90]

// The number of right supports
number_of_right_supports = 4; //[2:1:20]

// The number of left supports
number_of_left_supports = 4; //[2:1:20]

/* [Hidden] */

l=lamp_front_in_millimeter;
lR=lamp_right_in_millimeter;
lL=lamp_left_in_millimeter;
s=strip_width_in_millimeter;
sS=wall_thickness;
sB=bottom_thickness;

$fn = $preview ? 12 : 72;
//=================================
led();
//echo(tan(45));
//=================================
pP=[[0,0],[0,sB],[s-sS,s],[s,s],[s,0]]; // support profile

module led(){
  main();
  if (lamp_right_angle > 0) {
    right();
  };
  if (lamp_left_angle > 0) {
    left();
  };
};

module sup(n,l){
  for(i=[0:n]){
    translate([i*l/n,0,0])rotate([90,0,90])linear_extrude(height=sS)polygon(pP);
  };
};

module main(){
  difference(){
    union(){
      cube([l,s,sB]);
      translate([0,s-sS,0])cube([l,sS,s]);
    }; //union
    if (lamp_right_angle > 0) {
      rotate([0,0,-lamp_right_angle/2])translate([-l,-0.1,-0.1])cube([l,s+0.2,s+0.2]);
    };
    if (lamp_left_angle > 0) {
      translate([l,0,0])rotate([0,0,lamp_left_angle/2])translate([0,-0.1,-0.1])cube([s,l+0.2,s+0.2]);
    };
  }; //difference
  translate((s-sS)*[tan(lamp_right_angle/2),0,0])sup(number_of_front_supports,l-sS-(s-sS)*(tan(lamp_right_angle/2)+tan(lamp_left_angle/2)));
};

module right(){
  rotate([0,0,-lamp_right_angle])translate([-lR,0,0])union(){
    difference(){
      union() {
        cube([lR,s,sB]);
        translate([0,s-sS,0])cube([lR,sS,s]);
      }; //union
      translate([lR,0,0])rotate([0,0,lamp_right_angle/2])cube([s,s+0.2,s+0.2]);
    }; //difference
    sup(number_of_right_supports,lR-sS-(s-sS)*(tan(lamp_right_angle/2)));
  };
};
module left(){
  translate([l,0,0])rotate([0,0,lamp_left_angle])union() {
    difference(){
      union() {
        cube([lL,s,sB]);
        translate([0,s-sS,0])cube([lL,sS,s]);
      }; //union
      translate([0,0,0])rotate([0,0,90-lamp_left_angle/2])cube([l,s+0.2,s+0.2]);
    }; //difference
    translate((s-sS)*[tan(lamp_left_angle/2),0,0])sup(number_of_left_supports,lR-sS-(s-sS)*(tan(lamp_left_angle/2)));
  };
};
