/*
  Created by Aaron Ciuffo http://www.thingiverse.com/txoof/about
  Released under the Creative Commons Attrib-Share-Alike license
  16 December 2015

*/

/* [Base] */
xSize = 45; // length
ySize = 15; // height
zSize = 3; //thickness
holeDia = 3.5; // hole diameter

/* [Text] */
textHeight = 2; // [1:10] 
textSize = 7.5; // [1:50]
myFont = "Liberation Sans"; // [Liberation Mono, Liberation Sans, Liberation Sans Narrow and Liberation Serif]
myColor = "yellow"; // [green, yellow, blue, red, silver, black]
myText = "My Name"; // Your name here!

/* [Hidden] */
holeRad = holeDia/2;

// preview[view:south, tilt:top diagonal] 
baseSize = [xSize, ySize, zSize];

include <MCAD/boxes.scad>


module textExtrude() {
  color(myColor)
    linear_extrude(height = textHeight) 
    text(myText, halign = "center", valign = "center", size = textSize, font = myFont);
}

module base() {
  roundedBox(baseSize, radius = 3, sidesonly = 1, $fn = 36);
  //cube(baseSize, center = true);
}

module holes() {
  translate([-xSize/2+holeDia, ySize/2-holeDia, 0])
  //translate([-xSize/2+holeDia, ySize/2, 0])
    cylinder(r = holeRad, h = 2*zSize, $fn = 36, center = true);
  translate([xSize/2-holeDia, ySize/2-holeDia, 0])
  //translate([xSize/2-holeDia, ySize/2, 0])
    cylinder(r = holeRad, h = 2*zSize, $fn = 36, center = true);
}

module makeTag() {
  difference () {
    union() {
      base();
      //translate([0, -ySize/5 , zSize/2]) textExtrude();
      translate([0, -3, 1.5]) textExtrude();
    }
    holes();
  }

}

makeTag();
//base();
//holes();
//textExtrude();
