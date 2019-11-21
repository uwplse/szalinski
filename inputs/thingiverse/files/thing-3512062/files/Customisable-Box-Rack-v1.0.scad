// A fully parameterised basic shelving rack
//   Author: Nick Wells
// Revision: 1.0 23/03/2019 Initial release
// http://customizer.makerbot.com/docs

// Set the box dimensions here. all units in mm
/* [box Dimensions] */
  // box Width
boxW    = 20; //[10:1:200]
  // box Height
boxH    = 20;  //[10:1:200]
  // box Depth
boxD    = 20;  //[5:1:200]
  // Number of rows
rows    = 5;   //[1:1:20]
  // Number of columns
columns = 5;   //[1:1:20]

// Nozzle diameter
nozzleD = 0.3; //[0.3:0.05:1]
// Wall thickness mulitplier (x nozzle thickness
wallM   = 3;   //[1:1:20]
// Corner Radius
cornerR = 0; //[0:0.5:10]
// Curve rendering quality
$fn     = 25;

//include <MCAD\boxes.scad>

// I had to include the library code for this to work in Thingiverse customiser
// ---Snip library---

// Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// roundedBox([width, height, depth], float radius, bool sidesonly);

// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);

// size is a vector [w, h, d]
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

// ---Snip library---

// Standard flash cards
/*
  boxW = 128;
  boxH = 20;   // 100 cards
  boxD = 40;
  rows = 6;
  columns = 1;
*/



rack();
module rack()
{
  difference()
  {
    outershell();
    compartments();
  }
}
module outershell()
{
  // outer box
  wallT = nozzleD*wallM;
  rackH = (boxH+wallT)*rows+wallT;
  rackW = (boxW+wallT)*columns+wallT;

  roundedBox([rackW, rackH, boxD], cornerR, false);
}
module compartments()
{
  // hollowed out boxes
  wallT = nozzleD*wallM;
  Ystart = -((boxH+wallT)/2)*(rows-1);
  Xstart = -((boxW+wallT)/2)*(columns-1);
  internalR = cornerR/2;
 
  for (y =[0:rows-1])
  { 
    for (x =[0:columns-1])
    {
      translate([Xstart+((boxW+wallT)*x),Ystart+((boxH+wallT)*y),wallT])roundedBox([boxW, boxH,boxD], internalR, false);
    }
  }
}

