// ////////////////////////////////////////////////////////////
//
// D7 Vat cover
//
// Copyright 2017 Kevin F. Quinn
//
// This work is licensed under the Creative Commons
// Attribution-ShareAlike 4.0 International License. To view a
// copy of the license, visit
// https://creativecommons.org/licenses/by-sa/4.0/
//
// History
// 2017-11-08 1.0 Initial publication
// 2018-02-11 1.1 Customizer tweaks; works with OpenSCAD built-in customizer

/*
 Vat dimensions:
  Outer - 178 x 118.5
  Inner - 147.5 x 90.0
  Thickness - 15mm, 14.5mm
  Depth - 30mm
  Screws are 6mm, holes are 7mm, in the middle (56mm from outside edge)
 
 Shape is:
 
    ________
   | 156    |
   |        | 62.5
  _|        |_
 |11        11|
 |            | 56
 |____________|
     178

 In profile; has an overhang all around the front, and at the back.
 No overhang on the cutout areas of course.
*/


/* [What to print] */
// Choose the part to print, base or cover. Base rim is for a rapid print to check dimensions
part = "cover"; // [cover:Cover,base:Base,rim:Base rim]

/* [Dimensions] */
// Size of the vat in the X axis - D7 standard vat is 178mm
x_size=178; // [170:0.1:200]
// Size of the vat in the Y axis - D7 standard vat is 56mm
y_size=56; // [50:0.1:60]
// Depth of the main base panel (excluding raised parts) - note this is the main consumer of plastic!
base_height=2; // [0.4:0.2:3.2]
// Depth of the lip around the edge of the cover
lip_height=4; // [0:1:6]
// Width of border overhanging the vat. 0.8 to be narrow enough to avoid fouling on the D7 cover seal (well, if you're careful)
border=0.8; // [0.4:0.2:3.2]

// Clearance - piece is oversized by this amount around the edges of the vat
clearance=0.2; // [0:0.1:0.8]

/* [Hidden] */
module break() {}

$fn=30;

front_x=x_size+clearance*2;
front_y=y_size+clearance;
cutout_x=11;
back_x=front_x-2*cutout_x;
back_y=62.5+clearance;
vat_th=15;
height=base_height;
lip=lip_height;
beam=2;
corner=2.5;
gs=0.1;


module cover_front() {
  square([front_x,front_y-border]);
}
module cover_back(pdelta=0) {
    // Top section is [border] shorter on each side; the edge lip code
    // in cover() adds the base part of the border back on. Bit ugly, but
    // this ensures the lip on the far edge has its curves at the ends.
    // Note; rear lip is 'beam' wide rather than 'border'; there's space
    // for it (unlike at the front corners of the vat which would be too
    // close to the printer cover
  translate([cutout_x+beam,front_y-border,0])
    square([back_x-beam*2,back_y+border]);
}

module cover_shape() {
  union() {
    cover_front();
    cover_back();
  }
}

module base_shape(pdelta=0) {
  square([front_x-pdelta*2,front_y+back_y-pdelta*2]);
}

module curved_shape(cdelta=0) {
  offset(r=corner) offset(delta=-corner) offset(r=-corner) offset(delta=corner+cdelta)
  children();
}


module curved_border(cborder=border) {
  difference() {
    curved_shape(cdelta=cborder) children();
    curved_shape() children();
  }
}

module box_shape(bdelta=0) {
  translate([bdelta,bdelta,0])
  difference() {
    square([front_x-bdelta*2,front_y+back_y-bdelta*2]);
    translate([border,border,0]) square([front_x-border*2-bdelta*2,front_y+back_y-border*2-bdelta*2]);
  }
}

module curved_box(cdelta=0) {
  difference() {
    curved_shape(cdelta=cdelta) children();
    curved_shape(cdelta=cdelta-border) children();
  }
}

module cover() {
  // Main panel 
  linear_extrude(height=height) curved_shape() cover_shape();
  // Outside edge and lip
  difference() {
    union() {
      linear_extrude(height=height+lip) curved_border(cborder=border) cover_front();
      linear_extrude(height=height+lip) curved_border(cborder=beam) cover_back();
    }
    translate([0,front_y-border-beam-gs,height]) cube([front_x,back_y+border+beam+gs,lip+gs]);
  }
  // internal strengthening grid
  for (off=[vat_th+beam:(front_y+back_y-vat_th*2-beam*3)/6:front_y+back_y-vat_th-beam])
    translate([vat_th+beam,off,height]) cube([front_x-(vat_th+beam)*2,beam,beam]);
  for (off=[vat_th+beam:(front_x-vat_th*2-beam*3)/6:front_x-vat_th-beam])
    translate([off,vat_th+beam,height]) cube([beam,front_y+back_y-(vat_th+beam)*2,beam]);
}

module base() {
  // Main panel 
  linear_extrude(height=height) curved_shape() base_shape();
  // Outside edge and lip
  linear_extrude(height=height+lip) curved_border(cborder=border) base_shape();
}

module punch() {
  translate([vat_th,vat_th,-gs]) cube([front_x-vat_th*2,(front_y+back_y)-vat_th*2,height*2+2*gs]);
}

if (part=="cover") {
  cover();
} else if (part=="base") {
  base();
} else if (part=="rim") {
  difference() {
    base();
    punch();
  }
}
