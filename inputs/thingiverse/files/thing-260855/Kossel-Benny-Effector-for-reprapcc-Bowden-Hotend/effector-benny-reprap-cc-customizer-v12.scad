
// Kossel Effector
// based on http://www.thingiverse.com/thing:218402/#files
// Update by nischelwitzer@gmail.com


  //////////////////////////
 // Customizer Settings: //
//////////////////////////


// How big is the hotend radius?
hotend_rad   = 5;  // [3:10]

// How height should the hotend holder be?
hholder_height = 20; // [14:30]

  //////////////////////
 // Static Settings: //
//////////////////////

module GoAwayCustomizer() {
// This module is here to stop Customizer from picking up the variables below
}

// ---------------------------------------------------
// NIS Hotend Data

hotend_radius   = hotend_rad + 0.17;  // 0.17mm buffer 

height = 9;
hholder_border = 7.0;

m5_hole    = 5.0;
m3_hole    = 3.0+0.3;
m3_loch_b  = 5.75;
m3_flachmutter = 2.0+0.4; // dicke
buffer     = 0.3;

// ---------------------------------------------------
 


// ---------------------------

// include <configuration.scad>;

// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// OpenBeam or Misumi. Currently only 15x15 mm, but there is a plan
// to make models more parametric and allow 20x20 mm in the future.
extrusion = 15;

// Placement for the NEMA17 stepper motors.
motor_offset = 44;
motor_length = 47;


// ----------------------------

separation      = 40;  // Distance between ball joint mounting faces.
offset          = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.

mount_radius    = 12.5;  // Hotend mounting screws, standard would be 25mm


push_fit_height = 7.5;  // Length of brass threaded into printed plastic.

cone_r1 = 2.5;
cone_r2 = 14;




module effector() {

  difference() {
    union() {

      color("blue") cylinder(r=offset-3, h=height, center=true, $fn=60);

      // NIS Benny Holder
      color("lightblue") cylinder(r=hotend_radius+hholder_border, h=hholder_height, center=false, $fn=60);

      for (a = [60:120:359]) rotate([0, 0, a]) {

	rotate([0, 0, 30]) translate([offset-2, 0, 0])
	  color("green") cube([10, 13, height], center=true);

	for (s = [-1, 1]) scale([s, 1, 1]) {
	  translate([0, offset, 0]) difference() {
	    intersection() {
	      color("red") cube([separation, 40, height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
	    }
	    rotate([0, 90, 0])
	      cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
	    rotate([90, 0, 90])
	      cylinder(r=m3_nut_radius, h=separation-24, center=true, $fn=6);
	  }

        }
      }
    }

    // cutter 
    translate([0, 0, -height*2])
      cylinder(r=hotend_radius, h=height*10, $fn=36);

  // m3 cuts
  translate([0,0,hholder_height-11]) rotate([0,0,-30]) schrauben_cut();
  translate([0,0,hholder_height-11]) rotate([0,0,-30+120]) schrauben_cut();
  translate([0,0,hholder_height-11]) rotate([0,0,-30-120]) schrauben_cut();

  }
 


}

// ############################################################
// ############################################################

translate([0, 0, height/2]) effector();

// ############################################################
// ############################################################

module schrauben_cut()
{
  translate([2.5+hotend_radius,-m3_loch_b/2,2]) 
    cube([m3_flachmutter,m3_loch_b,20]);

  translate([0,0,6]) rotate([0,90,0]) 
    cylinder(20, r=(3+buffer)/2,$fn=100);      
}

// ############################################################

