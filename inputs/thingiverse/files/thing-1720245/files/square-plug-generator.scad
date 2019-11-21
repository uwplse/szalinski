// OpenSCAD file to create custom sized plugs/caps for square and rectangular tubes.
// Setup for use with Thingiverse.com customizer.
//
// preview[view:south west, tilt:bottom diagonal]
//
// Created Aug 14, 2016 by Allan M. Estes
//
// to do:
//   [x]keep consistant angle on cap taper
//   (allow control of taper angle?)
//   [x]display on build surface w/on-off option
//   [x]control view
//   [x]more sanity checks?
//   [x]possibly angle retaining tabs out a degree or two
//   (allow control of tab angle?)
//   [x]base tab size on tube size (like 2/3*sqrt((x+y)/2) )

$fn=36+0;

// Following are parameter which are configurable through the customizer

// input_units exists to allow mm or inch values to be entered through customizer
// it is currently disabled and set to mm input;
// Units for customizer input (output is allways mm)
input_units = 1+0; // [1:mm, 25.4:inch]  

// Outside measurement of tube end (X direction)
tube_x =  25.4;
// Outside measurement of tube end (Y direction) 0 = same as X (square tube)
tube_y = 0;
// How thick is tube wall
tube_wall = 1.58;
// Amount of rounding to apply to corners (0=no rounding, 50=default rounding, 100=maximum rounding)
corner_rounding = 50; // [0:100]

// Length of external portion of cap/plug 
cap_length = 5;
// Portion of plug with straigt sides (pergentage)
straight_pct = 50; // [0:100]
// Add grooves to retaining tabs?
groove_tabs = 1; // [0:no, 1:yes]
// Percent cap will be recessed underneath (none to maximum)
recess_pct = 100; // [0:100]

// user control of viewable build plate in Customizer:
// Turn on viewable build plate?
display_build_plate = 0; // [0:no, 1:yes]
use <utils/build_plate.scad>
// For display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
// When Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
// When Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


// santize/convert parameters: 
tubeY = abs((tube_y==0) ? tube_x : tube_y) * input_units;
tubeX = abs(tube_x) * input_units;
tubeWall = abs(tube_wall) * input_units;
capLen = abs(cap_length) * input_units;

echo(tubeY);

fillet = tubeWall * (corner_rounding/25); // 0:4, default=2 
taperpct = 1 - (straight_pct/100);

shorter = min(tubeX,tubeY);
tabThck = 3/5*sqrt((tubeX+tubeY)/2);
tabLen = (tubeX+tubeX)/2/3;

// flag problems for bad data, used later to generate error "messages"
bad_cap = capLen<2 || capLen>shorter;	// too short or long (long is a bit arbitrary)
bad_wall = tubeWall<1;				// too thin
bad_ratio = shorter<2*tubeWall+3*tabThck;	// too thick for tube
bad_over = tubeX>800 || tubeY>800;	// really determined by build plate
									// it won't break the program but why bother 
bad_input = tubeX==undef || tubeY==undef || tubeWall==undef || capLen==undef;

// Module definitions start here

// copy and move an object 
module duplicat(M) {
  child(0);
  translate(M) child(0);
}

// generate 2d shape used to build cap
module cap_outline() {
  if (2*fillet>shorter) {
      circle(fillet);
   } else if (fillet>0) {
    minkowski() {
      square([tubeX-(2*fillet),tubeY-(2*fillet)], true);
      circle(fillet);
    }
  } else
      square([tubeX,tubeY], true);
}

// hollows/recesses cap by difference with a scalled down clone
module hollow() {
  hpctx = (tubeX-2*(tubeWall+tabThck))/tubeX;
  hpcty = (tubeY-2*(tubeWall+tabThck))/tubeY;
  // possibly calc a min cap thickness bassed on tube size??
  hpct = max(hpctx, hpcty) * (recess_pct/100);
  // reduce hollow if cap will be too thin:
  hpctz = ((1-hpct)*capLen>1.5) ? hpct : max((capLen-1.25)/capLen,0);

  difference() {
    child();
    scale(v=[hpctx,hpcty,hpct]) child();
  }
}

// create cap portion of plug/cap
module build_cap() {
    hollow()
    union() {
      if (taperpct>0) {
        translate([0,0,capLen*(1-taperpct)])
		// scale is based on length to maintain a 45 deg angle - could be adjustable 
        linear_extrude(height=capLen*taperpct, center=false, convexity=10, scale=1-(capLen*taperpct/(shorter/2)))
        child(0);
      }
      if (taperpct!=1) { 
        linear_extrude(height=capLen*(1-taperpct), center=false, convexity=10)
        child(0);
      }
    }
}

// modules to deal with retaining tabs
// tabs are created by building a 2D profile, extruding to length (and beveling the
// ends for clearance), and moving into position

// 2D shape for tab
module tab_profile() {
  sp = (tabLen - .75*tabThck - tubeWall)/3; // spacing for grooves, a hack

  multmatrix([ [1,0,0,0], [sin(-2.5),1,0,0], [0,0,1,0], [0,0,0,1] ])
  difference() {
    polygon([[0,0],[tabLen-.75*tabThck,0],[tabLen,.75*tabThck],[tabLen,tabThck],[0,tabThck]]);
    if (groove_tabs) {
      for (i=[0:2]) {
        translate([tabLen-.75*tabThck-.6*sp-i*(sp*1.05),-sp/3.0])
        circle(sp*.6);
      }
    }
    translate([tubeWall/3,-tubeWall/3,0])
    circle(tubeWall/2);
  }
}

// extrude tabe to length and bevel
module build_tab(size) {
  difference() {
  linear_extrude(height=size,center=false) child(0);
  duplicat([0,0,size])
  translate([(tabLen*1.1)/2,tabThck,0])
  rotate([45,0,0])
  cube([tabLen*1.1,tabThck,tabThck], true);
  }
}

// generates and places the four retaining tabs
module place_tabs() {
  tabWidX = tubeX-2*(tubeWall+tabThck);
  tabWidY = tubeY-2*(tubeWall+tabThck);

  translate([tubeX/2-tubeWall,tabWidY/-2,0])
  rotate([-90,90,0])
  build_tab(tabWidY) child(0);

  translate([tubeX/-2+tubeWall,tabWidY/2,0])
  rotate([90,90,0])
  build_tab(tabWidY) child(0);

  translate([tabWidX/2,tubeY/2-tubeWall,0])
  rotate([180,90,0])
  build_tab(tabWidX) child(0);

  translate([tabWidX/-2,tubeY/-2+tubeWall,0])
  rotate([0,90,0])
  build_tab(tabWidX) child(0);
}

// Main "code" starts here, first portion deals with customizer errors

s = 10 + 0; r=s*1.414+s; // points to create octagon
if (bad_input || bad_cap || bad_wall || bad_ratio || bad_over) {
  rotate([90,0,0]) {
    color("red")
    translate([0,0,-.01])
    polygon([[r,s],[s,r],[-s,r],[-r,s],[-r,-s],[-s,-r],[s,-r],[r,-s]]);
    text("Bad Parameters",halign="center",valign="bottom");
    if (bad_input) {
        text("Missing or non-numeric data",halign="center",valign="top");
       //echo("Missing or non-numeric data");
    } else if (bad_ratio) {
        text("Wall too thick for Tube dimensions",halign="center",valign="top");
       //echo("Wall too thick for Tube dimensions");
    } else if (bad_wall) {
        text("Wall too thin",halign="center",valign="top");
        //echo("Wall too thin");
    } else if (bad_cap) {
        text("Bad Cap Length",halign="center",valign="top");
        //echo("Bad Cap Length");
    } else if (bad_over) {
        text("Overly large Tube dimensions",halign="center",valign="top");
        //echo("Overly large Tube dimensions");
    }
  }
} else { 

// The cap/plug is built here... 

  if (display_build_plate) 
	build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
  translate([0,0,capLen]) rotate([0,180,0]) // position object for build plate
  union() {
    place_tabs() tab_profile();
    build_cap() cap_outline();
  }
}