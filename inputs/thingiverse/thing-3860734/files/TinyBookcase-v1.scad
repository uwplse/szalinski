/* Tiny Bookcase
   by Lyl3

Creates a tiny bookcase for the tiny secret books that are scaled to 50%

This code is published at:
https://www.thingiverse.com/thing:3860734
licensed under the Creative Commons - Attribution - Share Alike license (CC BY-SA 3.0)
*/

/* [Basic parameters] */

// The number of shelves in the bookcase
numShelves = 3; // [1:1:10]

// The width of the bookcase (mm)
caseWidth = 50; // [15:1:200]

/* [Advanced parameters] */

// The height of each shelf (mm)
shelfHeight = 24; 

// The depth of each shelf (mm)
shelfDepth = 21;

// The height of the base (below the bottom shelf) of the bookcase (mm)
baseHeight = 3; // [0:1:10]

// The width of the walls (mm)
wallWidth = 1.6; // [0.8:0.1:10]

fudge = 0.005 + 0.0;

caseHeight = numShelves*(shelfHeight+wallWidth) + baseHeight + wallWidth;
caseDepth = shelfDepth + wallWidth;

translate([caseHeight/2,-caseWidth/2,caseDepth]) rotate([-90,0,90])
difference() {
  cube([caseWidth,caseDepth,caseHeight]);
  translate([wallWidth,-fudge,-fudge]) cube([caseWidth-2*wallWidth,caseDepth-wallWidth+fudge,baseHeight+fudge]);
  for (i = [1:numShelves]) {   
    translate([wallWidth,-fudge,(i-1)*(shelfHeight+wallWidth)+baseHeight+wallWidth]) cube([caseWidth-2*wallWidth, caseDepth-wallWidth+fudge, shelfHeight]);
  }
}