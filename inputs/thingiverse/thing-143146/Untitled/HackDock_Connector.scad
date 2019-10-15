/* Parametrized Version of the HackDock Connector
Copyright (C) 2013 by Oliver Stickel
oliver.stickel@student.uni-siegen.de
*/

/* [Measurements] */

//Width of the connector. Measure distance between the notebook and the maximum potrusion of the plugs with cables bent about 90 degrees. Add 4mm (to offset the connector's walls thickness).
width = 50;

//Length of the connector. Measure between the two outer connectors but here add 8mm.
length = 90;

//Height of the connectors base. Measure from the tabletop to the upper rim of your thickest plug and add 1-2mm to leave space for the Sugru.
height = 15;


//Width of the cable opening in the back wall. 
cableopening = 20;

//Width of the ziptie openings in the back wall. Only needed for MacBook Air (and similar, see the blog for more Info. Set to 0 if you don't need them.
ziptieopening = 3;

//


/* [Hidden] */

//

//Wall thickness
wall = 2;

// This is the measurement for sliding elements
slide = wall+0.15; 



// Basic shape of the connector, up until now solid
module basicshape() {

	translate ( [width/2,length/2,height/2] )
roundedBox([width, length, height], 5, true);

	translate ( [5,0,0] )
cube ( [width-5, length, height] );
}



//Smaller (by the Wall thickness) but otherwise same shape: The inner cavity of the connector
module innercavity() {
	
	translate ( [ (width/2)+wall, (length/2), (height/2)+wall] )	
roundedBox([width, length-2*wall, height], 5, true);

	translate ( [5,wall,wall] )
cube ([width, length-2*wall, height]);
}


//Opening for cables
module cableopening() {
	
	translate ( [ (width-cableopening)/2, length-wall, wall] )
cube ( [cableopening, wall+1, height-wall] );
}

//Openings for ziptie

module ziptieopenings() {

	translate ( [ width/2+cableopening/2+2, length-wall, wall] )
cube ( [ziptieopening, wall, 2.5] );

	translate ( [ width/2+cableopening/2+2, length-wall, wall+5.5] )
cube ( [ziptieopening, wall, 2.5] );

}

//Potrusions on the lower part that slide against the upper and lower ones on the upper part (to hold it in place)

module lowergripper() {
	
	translate ( [width-1.8, wall, wall] )
cube ( [1.8, 1, height-wall] );

	translate ( [width-1.8, length-wall-1, wall] )
cube ( [1.8, 1, height-wall] );


}



//////////////////
////// UPPER PART (the lid):

//Body of the lid
module lid() {

	translate ( [width/2-width-5,length/2,wall/2] )
roundedBox([width, length, wall], 5, true);

	translate ( [-width-5,0,0] )
cube ( [width-5, length, wall] );
}

//Potrusions on the lid that will later guide/hold it in the body
	
//Lower
	translate ( [-width-3,slide,0] )
cube ( [width-10, 1, height-wall-2] );

//Upper left
	translate ( [-width-3,length-1-slide,0] )
cube ( [3, 1, height-wall-2] );
	
//Upper right: -5 is the distance the lid is away from the y-axis, 8 is the width of the potrusion, 6 is the curvature plus 1 unit for safety
	translate ( [-5-5-6,length-1-slide,0] )
cube ( [5, 1, height-wall-2] );

//Right
	translate ( [-5-1-slide, 10 ,0] )
cube ( [1, length-20, height-wall-2] );



//////////////////
//BUILD THIS THING!

//More detail
$fs=0.5;
$fa=0.5;


// Subtraction of the inner cavity from the basic shape
difference() {
basicshape();
innercavity();
cableopening();
ziptieopenings();
}

lid();

lowergripper();























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