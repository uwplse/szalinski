//-- limit switch holder / servo arm extender for Auto Bed Leveling
//-- by AndrewBCN - Barcelona, Spain - November 2014
//-- GPLV3
//-- (armv3 below)

//-- remix of Thingiverse #167430 (armv1 below)
//-- by zennmaster

//-- remix of Thingiverse #209384 (armv2 below)
//-- by Stephen Castello

//--remix of Thingiverse #573181 (Added switch_holes and diameter variable to allow for different-size switches)
//-- by Atrixium

// Some measurements and features

// armv1 has a (fixed) length of 37mm,
// width is 10mm, thickness is 4mm,
// uses 2 x M2.5 screws and nuts to hold a small limit switch.
// Uses standard 9G microservo.

// armv2 is for a much larger limit switch and also
// apparently for a larger servo, although everything seems
// to be configurable. Default thickness is 5mm.
// Uses M3 screws and nuts to hold the limit switch.

// armv3 has a parametric length (default is 37mm), uses
// a T-profile with 4mm base thickness to avoid flexing,
// holds the small limit switch with either 2 x small M2.5
// screws and nuts or a nylon tie.
// Uses standard 9G microservo.
// The slot for the servo arm is properly shaped.


// arm body length, add approximately 8mm for total length
// i.e. with an arm length of 37mm, the distance between
// the servo center and the tip of the limit switch is 45mm

// Configure according to your extruder dimensions
arm_length=37; // [30:70]
// Limit switch hole spacing between centers
switch_holes=9; //[1:15]
// Limit switch hole diameter
diameter=2.5; //[0:4]

module armv3() {
    difference() {
      // body
      union() {
      cylinder(r=6, h=4,center=true,$fn=32);
      translate([-arm_length/2,0,0]) cube([arm_length,8,4],center=true);
      // reinforcement
      translate([-arm_length/2,0,3]) cube([arm_length-16,2,4],center=true);
      // limit switch base
      translate([-arm_length,0,0]) cube([6,5+switch_holes,4],center=true);
      }
      
    // hole for servo spindle
    cylinder(r=3.8,h=10,center=true,$fn=32); 

    // slot for servo arm
    hull() {
      translate([0,0,5.5]) cylinder(r=3.2,h=10,center=true,$fn=32);
      translate([-14.7,0,5.5]) cylinder(r=2,h=10,center=true,$fn=32);
    }
    
    // holes for nylon tie or M2.5 screws holding limit switch
    translate([-arm_length,switch_holes/-2,0]) cylinder(r=diameter/2,h=10,center=true,$fn=32);
    translate([-arm_length,switch_holes/2,0]) cylinder(r=diameter/2,h=10,center=true,$fn=32);
    
    // some limit switches will fit better with this
    translate([-arm_length,switch_holes/-2,4]) cylinder(r=diameter/2+1,h=5,center=true,$fn=32);
    translate([-arm_length,switch_holes/2,4]) cylinder(r=diameter/2+1,h=5,center=true,$fn=32);    
    translate([-arm_length+2.5,switch_holes/-2,4]) cube([4,diameter+2,5],center=true);
    translate([-arm_length+2.5,switch_holes/2,4]) cube([4,diameter+2,5],center=true);    
    }
}


module armv1() {
  difference(){
    union(){
      difference(){
	roundedBox([10,37,4],4,true); //main body
	translate([0,0,3])
	  roundedBox([4.8,28,5],2.4,true);  //slot for servo arm
	translate([0,-12.5,-5])
	cylinder(r=3.75,h=10, $fn=30); //  Hole for servo spindle
      }

      translate([0,16.5,0])
      roundedBox([20,5,4],1.75,true); // Microswtich mount body
    }
    translate([0,16.5,-1])
    roundedBox([16,2.8,10],1.4,true);  // slot for mounting screws
  }
}

module armv2() {
  //////////////////////////////////////////////////////////////////////////////////////////////////
  // Created on 12/13/2013 by Stephen Castello
  // Last update: 2/22/2014
  // changed thickness to 5mm (4mm flexed alot)
  //////////////////////////////////////////////////////////////////////////////////////////////////
  // variables
  //////////////////////////////////////////////////////////////////////////////////////////////////
  Z_Rod_dia=10;				// diameter of Z rod
  Screw_dia=3.2;				// clamp screw diameter
  Screw_Thread_dia=2.5;		// screw hole diameter to make a 3mm threaded hole
  Switch_ht=15;				// height of holder
  Switch_thk = 5;				// thickness of holder
  Switch_hole_sep=22;		// distance between holes for switch (19 for mechanical endstop v1.2)
  Switch_hole_offset = 10;		// switch hole offest (mech endstop v1.2 doesn't have one)
  Nut_wrench_size = 5.5;		// wrench size of nut
  Nut_depth = 2.3;			// thickness of nut
  Nylok_depth = 4;			// thickness of nylok nut
  Lever_wd = 12;				// width of lever
  Lever_ht = 33;				// lever length
  Servo_dia = 8.2;			// outside diameter of servo lever
  //////////////////////////////////////////////////////////////////////////////////////////////////
  // make the parts
  //////////////////////////////////////////////////////////////////////////////////////////////////

  rotate([0,-90,0]) {
	  switch_side(0); // switch off to right == 1
	  lever();
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // modules for each part
  //////////////////////////////////////////////////////////////////////////////////////////////////

  module switch_side(Right) { // riser for switch
	  if(Right) {
		  difference() {
			  difference() {
				  difference() {
					  cube([Switch_thk,29,Switch_ht],false);
					  // screw holes for switch
					  rotate(a=[0,90,0]) {		
						  translate([-(Switch_ht-2.5), 4, 0]) {
							  cylinder(h = 11, r = Screw_dia/2, center = false, $fn=50);
						  }
					  }
					  rotate(a=[0,90,0]) {
						  translate(v = [-(Switch_ht-2.5)+Switch_hole_offset, 4+Switch_hole_sep, 0]) {
						  cylinder(h = 11, r = Screw_dia/2, center = false, $fn=50);
						  }
					  }
				  }
			  }
		  }
		  translate([0,12,11]) rotate([45,0,0]) cube([Switch_thk,5,5],false); // gusset
	  } else {
		  difference() {
			  difference() {
				  translate([0,-17,0]) {
					  difference() {
						  cube([Switch_thk,29,Switch_ht],false);
						  // screw holes for switch
						  rotate(a=[0,90,0]) {		
							  translate([-(Switch_ht-2.5)+Switch_hole_offset, 4, 0]) {
								  cylinder(h = 11, r = Screw_dia/2, center = false, $fn=50);
							  }
						  }
						  rotate(a=[0,90,0]) {
							  translate(v = [-(Switch_ht-2.5), 4+Switch_hole_sep, 0]) {
							  cylinder(h = 11, r = Screw_dia/2, center = false, $fn=50);
							  }
						  }
					  }
				  } // translate
			  }
		  }
		  translate([0,0,11]) rotate([45,0,0]) cube([Switch_thk,5,5],false); // gusset
	  }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////

  module lever() {  // servo lever
	  difference() {
		  hull() {
			  translate([0,0,15]) cube([Switch_thk,Lever_wd,Lever_ht-5],false); // lever with a rounded end
			  translate([0,6,Lever_ht + 10.5]) rotate([0,90,0]) cylinder(h=Switch_thk,r=Lever_wd/2,$fn=50);
		  }
		  translate([2.6,3,15]) cube([Switch_thk/2,Lever_wd/2,Lever_ht-5],false); // groove
		  translate([-5,6,Lever_ht + 10]) rotate([0,90,0]) cylinder(h=20,r=Servo_dia/2,$fn=50); // servo arm hole
		  //notch_lever();  // added countersinks instead
	  }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////

  module notch_lever()
  {
	  difference() { // space for servo mounting screw
		  hull() {   // must be adjusted if size is changed *************************************************************
			  translate([-1,15,35]) rotate([90,0,0]) cylinder(h=20,r=2,$fn=50);
			  translate([-1,23,50]) rotate([135,0,0]) cylinder(h=20,r=2,$fn=50);
			  translate([-1,3,36]) rotate([45,0,0]) cylinder(h=20,r=2,$fn=50);
		  }
		  translate([-1,6,47]) {
			  rotate([0,90,0]) minkowski() {
				  cube([Lever_wd-4,Switch_thk-4,Lever_ht], true);
				  cylinder(r=6,h=1,$fn=50);
			  }
		  }
	  }
  }

  //////////////////////end of Z stop servo mount.scad /////////////////////////////////////////////////
}

/*include <boxes.scad>; // required only by armv1
armv1();
translate([30,30,0]) armv2(); */
// print the part
translate([0,-30,0]) armv3();
