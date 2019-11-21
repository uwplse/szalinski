/* Parametrized Version of the HackDock Connector
Copyright (C) 2013 by Oliver Stickel
oliver.stickel@student.uni-siegen.de
*/

// Which part would you like to see?
part = "both"; // [box:Only the Box,lid:Only the lid,both:Box and lid]

print_part();

/* [Basic Measurements] */

// INNER height of the box, i.e. height of the usable space
innerheight = 40;

//Width of the box, i.e. length of the sides with the sliding rails for the lid on them.
width = 223;

//Length of the box, i.e. length of the sides into which the lid later slides into.
length = 143;

//Thickness of the walls, the lid, etc. 2.5mm is the default and works well.
wall = 2.5;




/* [Input/Output-Openings] */

//Width of the main I/O-opening (height is always maximized by default).
main_io_width = 35; //[0:width-30-7-3]

//Length: Lower opening on the side with the big, default I/O-opening
io1_l = 120; //[0:width-30-7-3]
//Height: Lower opening on the side with the big, default I/O-opening
io1_h = 13; //[0:height-2*wall]

//Length: Upper opening on the side with the big, default I/O-opening
io2_l = 120; //[0:width-30-7-3]
//Height: Upper opening on the side with the big, default I/O-opening
io2_h = 13; //[0:height-2*wall]

//Length: Lower opening on the next side perpendicular to the first two openings
io3_l = 30;//[0:length/2-cutoutlength/2-wall]
//Height: Lower opening on the next side perpendicular to the first two openings
io3_h = 13;//[0:height-2*wall]

//Length: Upper opening on the next side perpendicular to the first two openings
io4_l = 30;//[0:length-7]
//Height: Upper opening on the next side perpendicular to the first two openings
io4_h = 13;//[0:height-2*wall]



/* [Mounting holes] */

//Distance between four centered holes to mount the box on the VESA-mounts behind a standard monitor. Most VESA-mounts use either 100mm or 75mm distances (measure yours).
vesadistance = 100;

//Diameter of the VESA mounting holes holes, determined through the thickness of the screws you need to use. Set to 0 if you don't want any VESA mounting holes.
screwthickness = 5; 

//Diameter of a single mounting hole, centered on the lid (i.e. for mounting under a desk). Set to 0 if you don't want this hole.
centerscrewthickness = 4;


module print_part() {
	if (part == "box") {
		buildbox();
	} else if (part == "lid") {
		buildlid();
	} else if (part == "both") {
		buildboth();
	} else {
		buildboth();
	}
}


/* [Hidden] */

//Total height (without the mounting slits for the lid)
height = innerheight+wall;

preview_tab = "";


//Measurements for the click in-cutouts in the base in which the counterparts on the lid click into

cutoutlength = 12;
cutoutheight = 4;

slideadjust = 0.2; //Adjustment for Click-in and slide-in stuff


// Basic shape of the box, up until now solid
module basicshape() {

	translate ( [width/2,length/2,height/2] )
roundedBox([width, length, height], 6, true);

}


//Smaller (by the Wall thickness) but otherwise same shape: The inner cavity of the box
module innercavity() {
	
	translate ( [ (width/2), (length/2), (height/2)+wall] )	
roundedBox([width-2*wall, length-2*wall, height], 6, true);

}


//Main opening for incoming cables
module cableopening() {
	
	translate ( [ 7, 0, wall] )
cube ( [main_io_width, wall*2, height-2*wall] );
}


// Customizable I/O opening long side lower
module ioopening1(io1_l, io1_h, wall) {
	
	translate ( [ width-io1_l-7, 0, wall] )
cube ( [io1_l, wall*2, io1_h] );
}

// Customizable I/O opening long side upper
module ioopening2(io2_l, io2_h, wall) {
	
	translate ( [ width-io2_l-7, 0, height-io2_h-3] )
cube ( [io2_l, wall*2, io2_h] );
}

// Customizable I/O opening short side lower
module ioopening3(io3_l, io3_h, wall) {
	
	translate ( [ width-2*wall, 7, wall] )
cube ( [wall*2, io3_l, io3_h] );
}

// Customizable I/O opening short side upper
module ioopening4(io4_l, io4_h, wall) {
	
	translate ( [ width-2*wall, 7, height-io4_h-3] )
cube ( [wall*2, io4_l, io4_h] );
}




//Holes in the base unit in which the fixtures on the lid can click into

module clickinholes(){

	translate ( [ 0,20,height-wall-cutoutheight] )
cube( [wall,cutoutlength,cutoutheight] );

	translate ( [ 0,length-cutoutlength-20,height-wall-cutoutheight] )
cube( [wall,cutoutlength,cutoutheight] );

	translate ( [ width-wall,length/2-cutoutlength/2,height-wall-cutoutheight] )
cube( [wall,cutoutlength,cutoutheight] );


	translate ( [ width/2-cutoutlength/2, length-wall, height-wall-cutoutheight] )
cube( [cutoutlength,wall,cutoutheight] );
}



//////////////////
////// UPPER PART (the lid):

//Body of the lid
module lidbase() {

	translate ( [width/2-width-5,length/2,wall/2] )
roundedBox([width, length, wall], 6, true);
}

//The noses which click into the holes in the base to fix the lid on the base. Code is extremely messy, it's 4AM and I'm just tired. Sorry.

module clickinnoses(){

//Lower right
	translate ( [ -wall-wall-5, 20+slideadjust/2, wall] )
cube( [wall,cutoutlength-slideadjust,wall+cutoutheight] );
	
	translate ( [ -wall-5, 20+cutoutlength-slideadjust/2, wall+wall+cutoutheight/2] )
	rotate (a=[90,0,0]) {
cylinder( h = cutoutlength-slideadjust, r = cutoutheight/2-slideadjust/2 );
	}

//Upper right
	translate ( [ -wall-wall-5, length-cutoutlength-20+slideadjust/2, wall] )
cube( [wall,cutoutlength-slideadjust,wall+cutoutheight] );
	
	translate ( [ -wall-5, length-cutoutlength-20+cutoutlength-slideadjust/2, wall+wall+cutoutheight/2] )
	rotate (a=[90,0,0]) {
cylinder( h = cutoutlength-slideadjust, r = cutoutheight/2-slideadjust/2 );
	}


//Other side, middle hole
	translate ( [ -width-5+wall, length/2-cutoutlength/2-slideadjust/2, wall] )
cube( [wall,cutoutlength-slideadjust,wall+cutoutheight] );
	
	translate ( [ -width-5+wall, length/2+(cutoutlength-slideadjust)/2-slideadjust, wall+wall+cutoutheight/2] )
	rotate (a=[90,0,0]) {
cylinder( h = cutoutlength-slideadjust, r = cutoutheight/2-slideadjust/2 );
	}


//Back side, middle hole

	translate ( [ -width/2-(cutoutlength-slideadjust)/2 -5, length-wall-wall, wall] )
cube( [cutoutlength-slideadjust,wall, wall+cutoutheight] );

	translate ( [ -width/2-(cutoutlength-slideadjust)/2 -5, length-wall, wall+wall+cutoutheight/2] )
	rotate (a=[90,0,90]) {
cylinder( h = cutoutlength-slideadjust, r = cutoutheight/2-slideadjust/2 );
	}
	
}


//Mounting holes

module vesamount(vesadistance, screwthickness) {

	translate ( [width/2-width-5 - (vesadistance/2) ,length/2 + (vesadistance/2) , 0] )
cylinder ( h = wall, r=screwthickness/2);

	translate ( [width/2-width-5 - (vesadistance/2) ,length/2 - (vesadistance/2) , 0] )
cylinder ( h = wall, r=screwthickness/2);

	translate ( [width/2-width-5 + (vesadistance/2) ,length/2 - (vesadistance/2) , 0] )
cylinder ( h = wall, r=screwthickness/2);

	translate ( [width/2-width-5 + (vesadistance/2) ,length/2 + (vesadistance/2) , 0] )
cylinder ( h = wall, r=screwthickness/2);


//Center hole
	translate ( [width/2-width-5 ,length/2, 0] )
cylinder ( h = wall, r=centerscrewthickness/2);
}



//////////////////
//BUILD THIS THING!

//More detail
$fs=0.5;
$fa=0.5;


module buildbox(){
// Subtraction of the inner cavity from the basic shape as well as all other openings
difference() {
basicshape();
innercavity();
cableopening();
ioopening1(io1_l, io1_h, wall);
ioopening2(io2_l, io2_h, wall);
ioopening3(io3_l, io3_h, wall);
ioopening4(io4_l, io4_h, wall);
clickinholes();
}


}


module buildlid(){
// Asembly of the lid including VESA holes
difference() {
lidbase();
vesamount(vesadistance, screwthickness);
}
clickinnoses();
}


module buildboth(){
buildbox();
buildlid();
}










////////////////////////////////////////////////
// Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: BSD
module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis]) 
          translate([x,y,0]) 
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}