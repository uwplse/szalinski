/* Pololu stepper driver board
  Neeraj Verma
  July 23 2018
  GPL V3
  
  use </path/to/libraries/step_stick.scad>
  //full
  step_stick(sinkHeight=5);
  //simple
  step_stick();
*/

/*
  Breakaway Header Pins: pitch 2.54, adjustable
  Aaron Ciuffo
  December 23 2015
  GPL V3
  derived from Molex KK 100 break-away header:
  http://www.molex.com/pdm_docs/sd/022032041_sd.pdf
  Usage (default values shown): 
  ```
  use </path/to/libraries/header_pins.scad>
  //full
  headerPins(columns = 3, rows = 2, centerV = false, center = true, pitch = 2.52);
  //simple
  headerPins(3, 2);
  ```
  columns = integer number of columns (X axis)
  rows = integer number of rows (Y axis)
  centerV = vertically center around base - fale places bottom at origin
  center = center the array at the origin
  pitch = distance between center of each pin
  Note: 
  * the breakaway connector is a bit of a fudge and does not appear at the same
    Z height for centered/versus non centered; this should be largely irrelevant 
  updates can be found at GitHub:
  https://github.com/txoof/OpenSCAD_electronics
*/

sinkHeight=5;


module singlePin(center = false, locate = false, v = false, pinHeight=14.22, pinAboveNylon = 7.49) {
  pinDimensions = [.67, .67, pinHeight];
  nylonDimensions = [2.36, 2.36, 3.3];

  trans = center == false ? [0, 0, nylonDimensions[2]/2] : [0, 0, 0];

  translate(trans)
  union() {
    translate([0, 0, (-pinDimensions[2]/2+nylonDimensions[2]/2)+pinAboveNylon])
      color("gold")
      cube(pinDimensions, center = true);    
    color("darkgray")
      cube(nylonDimensions, center =true);
    if (locate) {
      color("red")
        cylinder(r = 0.1, h = pinDimensions[2]*5, center = true);
    }
  }

  if (v) {
    echo("single pin dimension:", pinDimensions);
    echo("pin above nylon:", pinAboveNylon);
  }

}

module headerPins(columns = 3, rows = 2, centerV = false, center = true, 
                  pitch = 2.54, locate = false, v = false, pinHeight=14.22, pinAboveNylon=7.49) {
  transV = centerV == false ? pitch/2 : 0; // vertical center

  trans = center == false ? [0, 0, 0] : [-(columns-1)*pitch/2, -(rows-1)*pitch/2, 0];
  if (v) {
    echo("header pin array");
    echo("usage: columns, rows, centerV, center, pitch, locate, v(erbose)");
  }

  translate(trans) 
  union() {
    for (i = [0:columns-1]) {
      for (j = [0:rows-1]) {
        translate([pitch*i, pitch*j, 0])
          singlePin(locate = locate, v = v, pinHeight=pinHeight, pinAboveNylon=pinAboveNylon);
      }
    }
    translate([0, 0, -pitch/2+transV])
      color("black")
      cube([pitch*(columns-1), pitch*(rows-1), 2]);
  }
}

module board(sinkHeight=5) {
// pcb
translate([15.25,0,0]) rotate(90) color("red") cube([15.3,20.5,1.66]);   
// chip
translate([1,3.54,1.66]) cube([7,7,1]);    
// heat sink    
color("silver") difference() {
    translate([0,2.54,2.66]) cube([9,9,sinkHeight]);
    union() {
        translate([-.1,3.54,3.4]) cube([10,1,sinkHeight+1]);
        translate([-.1,5.54,3.4]) cube([10,1,sinkHeight+1]);
        translate([-.1,7.54,3.4]) cube([10,1,sinkHeight+1]);
        translate([-.1,9.54,3.4]) cube([10,1,sinkHeight+1]);
    }    
}    
// pot
translate([13,6.54,1.5]) color("silver") cylinder(h=0.5,d=3.37, $fn=20);   
} 

module step_stick(sinkHeight=5) {
    headerPins(8, 1, pinAboveNylon=3, pinHeight=11);
    translate ([0,13,0]) headerPins(8, 1, pinAboveNylon=3, pinHeight=11);
    translate([-5,-1.2, 3.4]) board(sinkHeight=sinkHeight);
}

  step_stick(sinkHeight=sinkHeight);
