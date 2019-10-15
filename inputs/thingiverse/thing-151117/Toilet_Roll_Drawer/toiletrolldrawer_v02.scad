// Licence: Creative Commons, Attribution-NonCommercial
// Created: 12-09-2013 by bmcage http://www.thingiverse.com/bmcage

// A drawer to put in a toilet roll


//the different parts
part = "all";   // [base, side, all]

// roll settings

//toilet roll inner diameter in mm
inner_dia = 42;  //[20:80]
//toilet roll length in mm
length = 95;   //[30:200]
//layer thickness (so as to have shell of one layer thick!)
layer_th = 0.2; 
//thickness of the front and back
side_th = 6;

use <utils/build_plate.scad>;

//for display only, doesn't contribute to final object
build_plate_selector = 1; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 

// we begin the building of the elements

if (part == "base"){
  drawer();
}
if (part == "side"){
  translate([-circumference/4,length/2+inner_dia/2 +5,0]) front();
}
if (part == "all"){
  drawer();
  translate([-circumference/4,length/2+inner_dia/2 +5,0]) front();
  translate([inner_dia,0,0]) translate([-circumference/4,length/2+inner_dia/2 +5,0]) front();
}

circumference = 4/3*PI * inner_dia / 2;
circumin = circumference - 6;
circumin_angle = circumin / inner_dia;

module drawer() {
  base();
  ribs();
  endribs();
}


//size reinforcement
reinf = 5;
module base(){
  translate([-circumference/2, -length/2,0]) {
    cube([circumference, length, layer_th]);
    //now reinforcement around it
    difference(){
      cube([circumference, length, 2*layer_th]);
      translate([reinf,reinf,-.5*layer_th]) cube([circumference-2*reinf, length-2*reinf, 3*layer_th]);
      }
    }
}

module rib(shift){
  //translate([-1+shift, -length/2+side_th,0]) cube([2, length-2*side_th, 1]);
  translate([-1+shift, -length/2,0]) cube([2, length, 1]);
}

nr_ribs = round((circumference-10)/4)+1;
module ribs(){
  for (i=[1:nr_ribs]) {
    rib(-circumference/2+5 +1 +(i-1)*4);
  }
}

module endrib(shift){
  translate([-shift, -length/2,0]) difference() {
	rotate([-90,0,0]) cylinder(r=1.5, h=length, $fn=50);
	translate([-2.5,-1,-10]) cube([5,length+2, 10]);
  }
}

module endribs(){
  endrib(-circumference/2+1.5);
  endrib(circumference/2-1.5);
}

module front(){
  difference(){
  union(){
  //outside ridge
  difference(){
    cylinder(r=inner_dia/2, h=side_th, $fn=50);
    translate([0,0,-0.5])cylinder(r=inner_dia/2-1.1, h=side_th+1, $fn=50);
    translate([inner_dia/2 - 3, -inner_dia/2, -1]) cube([inner_dia, inner_dia, side_th*4]);
 translate([-4* inner_dia+inner_dia/2*cos(circumin_angle*180/PI), -2*inner_dia, -inner_dia/2])cube([4*inner_dia, 4*inner_dia, inner_dia]);
//  rotate([0,0,90-circumin_angle*180/PI]) translate([-inner_dia, -inner_dia, -inner_dia/2])cube([inner_dia, inner_dia, inner_dia]);
//  mirror([0,-1,0]) rotate([0,0,90-circumin_angle*180/PI]) translate([-inner_dia, -inner_dia, -inner_dia/2])cube([inner_dia, inner_dia, inner_dia]);
  }

  //bottom visible part
  difference() {cylinder(r=inner_dia/2, h=1, $fn=50);
    translate([inner_dia/2 - 3, -inner_dia/2, -1]) cube([inner_dia, inner_dia, side_th*4]);
    translate([-4* inner_dia+inner_dia/2*cos(circumin_angle*180/PI), -2*inner_dia, -inner_dia/2])cube([4*inner_dia, 4*inner_dia, inner_dia]);
  }
  //inner piece
  difference() {cylinder(r=inner_dia/2-1-2, h=side_th, $fn=50);
    translate([-4* inner_dia+inner_dia/2*cos(circumin_angle*180/PI), -2*inner_dia, -inner_dia/2])cube([4*inner_dia, 4*inner_dia, inner_dia]);
  }
  }
  // a hollow part at bottom to allow easy removal from the build plate
  translate([-1.5*inner_dia, -1.5,-0.01]) cube([3*inner_dia, 3, 1]);
  }
}
