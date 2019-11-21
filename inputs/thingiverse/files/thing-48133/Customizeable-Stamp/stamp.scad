//  Stamp Customizer
//  D. Scott Nettleton
//  Feb 7, 2013

use <write/Write.scad>
units = 1;  //  [1:Millimeters,10:Centimeters,25.4:Inches]
headType = 1; //  [0:Rectangle,1:Ellipse]
handleDiameter = 50;
handleLength = 80;
headWidth = 120;
headHeight = 35;
myFont = "write/Letters.dxf"; //  ["write/BlackRose.dxf":Black Rose,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]
text = "MakerBot";
textRotation = 0; //  [-90:90]
//textWidth=headHeight*(units*0.55*len(text));
textWidth = headWidth*0.9;
textHeight=textWidth/(units*0.55*len(text))*units;

translate([0,0,(headHeight>handleDiameter)?headHeight*units/2:handleDiameter*units/2])
rotate(a=90, v=[1,0,0])
union() {
  createHandle();
  createBridge();
  createHead();
  createPrint();
}

module createPrint() {
  myHeight = (textHeight<headHeight) ? textHeight : headHeight;
  translate([0,myHeight*0.0625,12.7+2.49999])
    mirror([1,0,0])
      write(text, t=5, h=myHeight*units*0.75, rotate=textRotation,font=myFont, center=true);
}

module createHandle() {
  translate([0,0,-handleLength*units])
  rotate_extrude($fn=100)
  scale([handleDiameter*units/2, handleLength*units*0.8, 0])
    handlePoly();
}

module handlePoly() {
  polygon(points=[[0,0],[0,1],[1,1],[1,0.858],[0.915,0.818],[0.858,0.761],[0.828,0.682],[0.814,0.57],[0.824,0.463],[0.861,0.387],[0.906,0.332],[0.953,0.299],[1,0.277],[1,0.226],[0.923,0.141],[0.707,0.07],[0.317,0.017]]);
}

module createBridge() {
  translate([0,0,-handleLength*units*0.2])
  cylinder(h=handleLength*units*0.2, r1=handleDiameter*units/2, r2=((headWidth<headHeight)?headWidth*units/2:headHeight*units/2), $fn=101);
}

module createHead() {
  if (headType == 0) {  //  Rectangle
    translate([0,0,6.35])
    cube(size=[headWidth*units,headHeight*units,12.7], center=true);
  }
  else if (headType == 1) { //  Ellipse
    //  Scale
    scale([headWidth*units,headHeight*units,1])
    cylinder(h=12.7, r1=0.5, r2=0.5, $fn=101);
  }
}
