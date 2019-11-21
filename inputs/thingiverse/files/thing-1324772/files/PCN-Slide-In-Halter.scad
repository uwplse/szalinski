//-- This is a holder for the Arduino
//-- Uno + CNC Shield V3 + A4988 + 60mm fan stack,
//-- where the boards slide in USB interface first.
//-- Based on my earlier similar design for the P3Steel.
//-- by AndrewBCN - Barcelona, Spain - May 2015
//-- 
//-- License is GPL V3

//-- Inspired by two Thingiverse objects: #8706 and #443013
//-- Remixed from #825279
//-- Original version specifically designed to use
//-- self-tapping wood screws to screw the holder to a
//-- wooden base.
//-- Modification By Olaf Bennert, Toolbox-Bodensee e.V. 
//-- to fit easily to every PCB-Board

//-- PCB-Board dimensions



length = 50;
width = 50;
pcb_thickness = 1.75;



/* [Hidden] */
wall_th = 2; // wall thickness
side_wall_height = 7;
bottom_wall_height = 11;
pcb_length = length+2; // add 2mm for small cylinders to prevent slide out of pcb
pcb_width = width;
//usb_w = 13.5;  // USB cutout width -- Orgignal Code removed
//power_w = 10;  // Arduino power connector cutout width -- Orgignal Code removed

base_l = pcb_length + wall_th+3;
base_w = pcb_width + wall_th + wall_th + 0.9; // 1mm margin to allow the arduino to slide in
base_h = wall_th + 1; // make it slightly thicker than walls

bottom_rail_height = -1.8; // I confess I eyeballed this value

//-- frame attachments dimensions
holder_corner_radius = 6.5;
holder_corner_height = 7;

nut_well_diameter = 8.8;
nut_well_depth = 5;
screw_diam = 3.4; // M3 nuts and bolts are used throughout

//-- Olaf : Changed Calculation for 
x1 = base_w+19/2; // horizontal distance between bottom holes
x2 = base_w+19/2; // horizontal distance between top holes
x_offset = 0; // approximate horizontal offset between top and bottom holes centerlines

y1 = (base_l-nut_well_diameter-10); // vertical distance between holes


module base() {
//-- Build base, bottom wall, side wall, rails
//-- all are cubes
//-- note base is hollowed out using another cube

  rotate([0,0,90])
  translate([20,4,base_h/2]) {
    difference() {
      cube([base_l, base_w, base_h], center=true);
      cube([base_l-2*side_wall_height, base_w-2*side_wall_height, 3*base_h], center=true);
      translate([-29,-15.5,0])
	cylinder(r=0, h=3*base_h,$fn=30,center=true); // small prong cutout - r=3 replaced by r=0
    }
    translate([wall_th/2-base_l/2,0,bottom_wall_height/2])
      difference() {
	cube([wall_th, base_w, bottom_wall_height], center=true); // bottom wall
	translate([0,11.7,0])
	  //cube([2*wall_th, usb_w+0.5, bottom_wall_height+2], center=true); // USB cutout
	translate([0,-16.3,0])
	  cube([2*wall_th, power_w+0, bottom_wall_height+2], center=true); // Arduino power connector cutout
      }
    translate([0,-wall_th/2+base_w/2,bottom_wall_height/2]) {
      cube([base_l, wall_th, bottom_wall_height], center=true); // side wall left
      translate([0,-wall_th/2,bottom_rail_height])
	cube([base_l, 1.8, 1], center=true); // bottom rail
      translate([0,-wall_th/2,bottom_rail_height+pcb_thickness]) // 2.8 = pcb thickness + rail thickness + some margin
	cube([base_l, 1.8, 1], center=true); // top rail
      }
    translate([0,wall_th/2-base_w/2,bottom_wall_height/2]) {
      cube([base_l, wall_th, bottom_wall_height], center=true); // side wall right
      translate([0,wall_th/2,bottom_rail_height])
	cube([base_l, 1.8, 1], center=true); // bottom rail
      translate([0,wall_th/2,bottom_rail_height+pcb_thickness]) // 2.8 = pcb thickness + rail thickness + some margin
	cube([base_l, 1.8, 1], center=true); // top rail
      }
    // small bumps to prevent the arduino sliding out of the holder *** Not implemented yet ***
    translate([pcb_length/2,pcb_width/2,3]) cylinder(r=0.6,h=5,$fn=10);
    translate([pcb_length/2,-pcb_width/2,3]) cylinder(r=0.6,h=5,$fn=10);
  }
}

module stands() {
  difference() {
    cylinder(r=holder_corner_radius,h=holder_corner_height,$fn=30,center=true); // cylinder
    cylinder(r=screw_diam/2,h=2*holder_corner_height,$fn=30,center=true); // M3 screw hole
    translate([0,0,holder_corner_height-nut_well_depth])
      cylinder(r=nut_well_diameter/2,h=nut_well_depth+1,$fn=16,center=true); // M3 nut well
  }
}

module attachments() {
//-- OK, now we define the small stands that are going to be attaching
//-- our holder to the steel frame. These have to be positioned
//-- so they match the already laser-drilled holes in the frame.

//-- The centers of the four corner cylinders
//-- These are measured on the P3Steel frame on the left side
//-- P1, P4 : bottom holes
//-- P3, P4 : left holes

  P1=[x1/2,-y1/2,0];
  P2=[x2/2+x_offset,y1/2,0];
  P3=[-x2/2+x_offset,+y1/2,0];
  P4=[-x1/2,-y1/2,0];

  translate([-6,20,holder_corner_height/2]) {
      translate(P1)
	stands();
      translate(P2)
	stands();
      translate(P3)
	stands();
      translate(P4)
	stands();
  }
}



module arms() {
  // stand 1 right top
  #hull() {
  translate([20,-8,base_h/2]) ;
  translate([40.7,-3,base_h/2]) ;
  translate([40.7,4,base_h/2]) ;
  translate([20,7,base_h/2]) ;  
  }

  // stand 2 right bottom
  #hull() {
  translate([22,-22,base_h/2]) ;
  translate([37.5,-42.5,base_h/2]) ;
  translate([33.5,-48,base_h/2]) ;
  translate([15,-30,base_h/2]) ;  
  }

  // stand 3 left top
  #hull() {
  translate([-32,10,base_h/2]) ;
  translate([-37,4,base_h/2]) ;
  translate([-37,-3,base_h/2]) ;
  translate([-32,-7,base_h/2]) ;  
  }

  // stand 4 left bottom
  #hull() {
  translate([-34,-31,base_h/2]) ;
  translate([-22,-30,base_h/2]) ;
  translate([-38,-43,base_h/2]) ;
  translate([-34,-46,base_h/2]) ;  
  }
}

//-- Print the part
translate ([-2,0,0]) base();
attachments();
//arms(); // not used in this version

// these are used to check that the cutouts are correct
//translate([-43.5,-16,12]) color("blue") cube([9,1,2]);
//translate([18.5,-16,12]) color("blue") cube([3,1,2]);
//translate([-11,-16,12]) color("blue") cube([19,1,2]);