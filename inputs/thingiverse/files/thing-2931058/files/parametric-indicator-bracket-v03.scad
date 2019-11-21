/*
  Copyright 2018 by cnww, 
  This code is provided under a Creative Commons Attribution-ShareAlike 4.0 license (CC BY-SA)
  See https://creativecommons.org/licenses/by-sa/4.0/
 */


/* Customizable parameters are below, all descriptions assume a Prusa i3 or similar printer with the following axis:
   
   X axis: Moves extruder right or left across the print surface, using a carriage that slides along two horizontal metal rods, one positioned directly above the other
   
   Y axis: Moves extruder towards the front or rear of the print surface
  
   Z axis: Moves up and down relative to the print surface
 */

//Diameter of your printer's X-Axis rods in mm
//most Prusa i3 clones use 8mm
rod_diameter = 8;

//Center-to-center distance between rods most Prusa i3 clones use 45mm
//use calipers to measure the distance between the rods and then add the rod diameter
rod_c2c = 44;

//Extra tolerance for the rods, increases the inner diameter of the clips. You probably don't need to change this.
rod_tolerance = 0.1; 

//Thickness of the bracket, measured along the x-axis (i.e. parallel to the indicator mounting screw)
//Note that around the indicator mounting slot the thickness will be either 2/3 this value or this value - 6,
//whichever is larger. 8-20 are generally good values
bracket_thickness = 16; 

//Minimum thickness of the bracket measured along the y-axis (i.e. parallel to the y-axis)
//You probably don't need to change this
bracket_depth = rod_c2c * 0.28;

//This is the height of the U-shaped mounting bracket on the back of the dial indicator, in mm
//16mm is fairly common
mount_height = 16;
mount_tolerance = 0.1; //Extra tolerance for the indicator slot, you probably don't need to change this

//Distance from the back of the main dial-indicator body to the center of the mounting hole
//This can safely be oversized by several mm to allow for adjustments
mount_depth = 10;

//Shift the indicator mounting slot up or down, zero is centered between the X-axis rods
mount_voffset = 0;

//Shift the indicator mount (and the main body) along the Y axis, positive is towards the side with the visible dial
//The default setting offsets based on the other dimensions to avoid interfering with a 5mm timing belt set between the X-axis rods
mount_hoffset = 2.5 + bracket_depth/2; 

//Diameter of the hole for the dial-indicator mounting screw.
//Set this at least 1mm larger than the major diameter of the screw, but not so large that the screw head
//or nut you're using can pass through the hole.
mount_screw_diameter = 6.5;

//Clip thickness, you probably don't need to change this
clip_d = 6.5;

/* Clip arc, this affects the amount of force needed to clip or un-clip the bracket, 180= zero force, larger numbers = more
   195 seems to work well for PLA, set to 180 if you're printing in a more brittle material like glass or aluminium
   Set to a slightly higher value for more a elastic material like ABS
   The range of valid values is 180 to 360. Values above about 230 will typically result in a bracket that needs to be slid onto the end of a rod instead of clipped on in the middle (i.e. won't work)
 */
clip_arc1 = 195;
clip_arc2 = 195;

//***** You shouldn't need to change anything below this line *****
$fn = 120; //Number of faces to use for cylinders

//Radius of the circular cut-out for the indicator mounting slot
mountr = (mount_height + mount_tolerance) / 2;

//Inner radius of the rod clips
rodr = (rod_diameter + rod_tolerance) / 2;

clipr = clip_d / 2;
cr = rodr+2*clipr;

//Generate an open rod clip suitable for attaching the bracket to the x-axis rods
module rodclip(arc, ext) {
  //n.b. ext should generally be zero whenever arc is not 180 +/- 10 degrees
  
  wa = 360-arc; //Cut-out wedge angle for the arc
  
  difference() {
    cylinder(bracket_thickness,cr,cr); //Clip base object
    
    translate([0,0,-1]) cylinder(bracket_thickness+2,rodr,rodr); //Center cut-out for the rod

    //Wedge-shaped cut-out for the open side
    ct = 10*(rodr+2*clipr);
    if( wa < 180 ) {
      intersection() {
        rotate([0,0,180-wa/2]) translate([-ct/2,0,-1]) cube([ct,ct,bracket_thickness+2]);
        rotate([0,0,180+wa/2]) translate([-ct/2,-ct,-1]) cube([ct,ct,bracket_thickness+2]);
      }
    }
    else {
      union() {
        rotate([0,0,180-wa/2]) translate([-ct/2,0,-1]) cube([ct,ct,bracket_thickness+2]);
        rotate([0,0,180+wa/2]) translate([-ct/2,-ct,-1]) cube([ct,ct,bracket_thickness+2]);
      }
    }
  }
  
  //Rounded tips
  rotate([0,0,180-wa/2]) translate([rodr+clipr,0,0]) cylinder(bracket_thickness,clipr,clipr);
  rotate([0,0,180+wa/2]) translate([rodr+clipr,0,0]) cylinder(bracket_thickness,clipr,clipr);
  
  //Extensions, a pair of convex hulls over four more cylinders
  if( ext > 0 ) {
    hull() {
      translate([-ext,rodr+clipr,0]) cylinder(bracket_thickness,clipr,clipr);
      translate([0,rodr+clipr,0]) cylinder(bracket_thickness,clipr,clipr);
    }
    hull() {
      translate([-ext,-rodr-clipr,0]) cylinder(bracket_thickness,clipr,clipr);
      translate([0,-rodr-clipr,0]) cylinder(bracket_thickness,clipr,clipr);
    }
  }
}

//Generate a negative of the mounting slot for the dial indicator
module indicatormount() {
  sloth = min( 6, bracket_thickness / 3 );
  slotext = mountr*2;
  
  translate([0,0,-1]) cylinder(bracket_thickness+10,mount_screw_diameter/2, mount_screw_diameter/2);
  
  translate([0,0,bracket_thickness-sloth]) {
    cylinder(sloth+1,mountr,mountr);
    translate([0,-mountr,0]) cube([slotext,mountr*2,sloth+1]);
  }
}

//Main module
module bracket() {
  slotshift = (rod_c2c/2)+mount_voffset;
  centerdim = mountr*2.5;
  armd = clip_d * 0.66;
  
  difference() {
    union() {
      //Upper rod clip
      rodclip(clip_arc2, bracket_depth * 0.5);
      
      //Lower rod clip
      translate([0,rod_c2c,0]) rotate([0,0,-90]) rodclip(clip_arc1,0);
      
      //Central body
      translate([mount_hoffset - bracket_depth/2,slotshift-centerdim/2,0]) 
        cube([bracket_depth,centerdim,bracket_thickness]);
        
      //Upper arm
      hull() {
        translate([mount_hoffset-bracket_depth/2, -centerdim/2+slotshift, 0]) cube([bracket_depth,armd,bracket_thickness]);
        translate([-bracket_depth/2, rod_diameter/2+2*rod_tolerance, 0]) cube([bracket_depth,armd,bracket_thickness]);
        translate([0,rodr+clipr,0]) cylinder(bracket_thickness,clipr,clipr);
      }
      
      //Lower arm
      hull() {
        translate([mount_hoffset-bracket_depth/2, centerdim/2+slotshift-armd, 0]) cube([bracket_depth,armd,bracket_thickness]);
        translate([-bracket_depth/2, rod_c2c-rod_diameter/2-2*rod_tolerance-armd, 0]) cube([bracket_depth,armd,bracket_thickness]);
        
        translate([0,rod_c2c-rodr-clipr,0]) cylinder(bracket_thickness,clipr,clipr);
      }

    }
    
    //Mounting slot cut-out
    translate([mount_hoffset,slotshift,0]) indicatormount();
  }
}

bracket();
