$fn=50*1;
include <write/Write.scad>
use <write.scad>

// INPUTS in mm ///////

BOX_LENGTH = 43;
BOX_WIDTH = 22;
BOX_HEIGHT = 22; // must be >= 4

wall = 0.4*1;
X_ANGLE = 35; // [1:90]
Xwidth = .8*1;
Xheight = 6*1;
Xlength = 1.6*1;

// enter a letter as first character if not rendering
HORIZONTAL_TEXT = "PO104545";
VERTICAL_TEXT = " ";
// value is 1/
TEXT_SIZE = 3; //[1:10] 

///////////////////////
X = BOX_LENGTH < BOX_WIDTH ? BOX_LENGTH : BOX_WIDTH;

difference () 
{

// hollow cube

cube([BOX_LENGTH,BOX_WIDTH,BOX_HEIGHT], center=true);
cube([BOX_LENGTH-(2*wall), BOX_WIDTH-(2*wall), BOX_HEIGHT-(2*wall)], center=true);


// X

translate([0,0,BOX_HEIGHT/2])
rotate([0,0,X_ANGLE])
cube([X*Xlength, Xwidth, Xheight], center=true);


translate([0,0,BOX_HEIGHT/2])
rotate([0,0,-X_ANGLE])
cube([X*Xlength, Xwidth, Xheight], center=true);

}
// Text - horizontal

translate([0,-BOX_WIDTH/2,0])
rotate([90,0,0])
write(HORIZONTAL_TEXT,t=1,h=(BOX_HEIGHT/TEXT_SIZE),center=true);


// Text - vertical

translate([0,-BOX_WIDTH/2,0])
rotate([90,90,0])
write(VERTICAL_TEXT,t=1,h=(BOX_HEIGHT/TEXT_SIZE),center=true);


// Sinterbox Maker
// J. Scaturro
// October, 2013
// For Customizer

