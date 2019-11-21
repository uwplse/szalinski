// This is a model based on the commonly used stompbox enclosure for guitar and
// hobbyist electronic projects.  It is configurable and does not need to be
// drilled out like a normal case, in fact it's not recommended as it will
// affect the infill of the unit.  Specify the holes you want and you need only
// print it and put your electronics in.

// All sizes are in mm (millimeters)

enclosureLength = 112; // length along x axis
enclosureWidth = 60; // width along y axis
enclosureHeight = 6; // enclosureHeight along z axis
enclosureThickness = 2; // this is the thickness of each side
roundness = 2; // this is degree of roundness the corners get
faces = 40; // this is how detailed the curved edges get

screwSize = 3;
screwLength = 10;
screwHeadLength = 10;
screwHeadDiameter = 8;

// countersunk screws (angled) v. cheese head screws (straight sides)
// \    /     |   |
//  \ /       |   |
//  ||         ||
//  ||         ||

screwType = "countersunk"; // see above diagram

cornerThickness = 1.25;


// variables used in the script
edge = roundness*enclosureThickness;
topLength = enclosureLength - 2*edge;
topWidth = enclosureWidth - 2*edge;

module enclosureLid(){

  // draw the shape out, cut the corners, cut screw holes
  difference(){
      cube([enclosureLength, enclosureWidth, enclosureHeight]);

      // this cuts the corner edges around the sides
      cube([edge, edge, enclosureHeight]);
      translate([enclosureLength - edge, 0, 0])
        cube([edge, edge, enclosureHeight]);
      translate([enclosureLength - edge, enclosureWidth - edge, 0])
        cube([edge, edge, enclosureHeight]);
      translate([0, enclosureWidth - edge, 0])
        cube([edge, edge,enclosureHeight]);
      /*screwTapping(); // screws are cut before the corners are filled back in*/

      // this cuts the corner edges around the top
      translate([0, 0, enclosureHeight - edge])
        cube([enclosureLength, edge, edge]);
      translate([0, enclosureWidth - edge, enclosureHeight - edge])
        cube([enclosureLength, edge, edge]);
      translate([0, 0, enclosureHeight - edge])
        cube([edge, enclosureWidth, edge]);
      translate([enclosureLength - edge, 0, enclosureHeight - edge])
        cube([edge, enclosureWidth, edge]);
    }

    // replace the cut side corners with rounded edges
    translate([edge, edge, 0])
      cylinder(r = edge, enclosureHeight - edge, $fn = faces);
    translate([enclosureLength - edge, edge, 0])
      cylinder(r = edge, enclosureHeight - edge, $fn = faces);
    translate([edge, enclosureWidth-edge, 0])
      cylinder(r = edge, enclosureHeight - edge, $fn = faces);
    translate([enclosureLength - edge, enclosureWidth - edge, 0])
      cylinder(r = edge, enclosureHeight - edge, $fn = faces);

    // replace the cut top corners with rounded edges
    translate([edge, edge, enclosureHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([enclosureLength - edge, edge, enclosureHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([edge, enclosureWidth-edge, enclosureHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([enclosureLength - edge, enclosureWidth - edge, enclosureHeight - edge])
      sphere(r = edge, $fn = faces);

    // this lays the long curved edges, starts with origin going CCW
    translate([edge, edge, enclosureHeight - edge])
    rotate([0,90,0])
      cylinder(r = edge, enclosureLength - 2*edge, $fn = faces);
    translate([enclosureLength - edge, edge, enclosureHeight - edge])
    rotate([270,0,0])
      cylinder(r = edge, enclosureWidth - 2*edge, $fn = faces);
    translate([enclosureLength - edge, enclosureWidth - edge, enclosureHeight - edge])
    rotate([0,270,0])
      cylinder(r = edge, enclosureLength - 2*edge, $fn = faces);
    translate([edge, enclosureWidth-edge, enclosureHeight - edge])
    rotate([90,0,0])
      cylinder(r = edge, enclosureWidth - 2*edge, $fn = faces);

}

module excessBottomTrim(){

  // cuts any shapes that developed along the bottom of the lid
  translate([0, 0, -edge])
    cube([enclosureLength, enclosureWidth, edge]);
}

module screwHead(type){
  if(type=="countersunk"){
    union(){
      cylinder(h = screwLength, d = screwSize, $fn = faces);
      translate([0, 0, enclosureHeight - edge])
        cylinder(h = screwHeadLength, d1 = screwSize, d2 = screwHeadDiameter, $fn = faces);
    }
  }
  else if(type=="cheese head"){
    union(){
      cylinder(h = screwLength, d = screwSize, $fn = faces);
      translate([0, 0, enclosureHeight - edge])
        cylinder(h = screwHeadLength, d = screwHeadDiameter, $fn = faces);
    }
  }
}

module screwTapping(type){
  // these two cut exterior screwhead holes in the lid
  if(type == "case"){
    translate([enclosureThickness + 2*cornerThickness, enclosureThickness + 2*cornerThickness, 0])
      screwHead(screwType);
    translate([enclosureLength - enclosureThickness - 2*cornerThickness, enclosureThickness + 2*cornerThickness,  0])
      screwHead(screwType);
    translate([enclosureLength - enclosureThickness - 2*cornerThickness, enclosureWidth - enclosureThickness - 2*cornerThickness, 0])
      screwHead(screwType);
    translate([enclosureThickness + 2*cornerThickness, enclosureWidth - enclosureThickness - 2*cornerThickness, 0])
      screwHead(screwType);
  }

}

// Final Assembly

difference(){
  enclosureLid();
  excessBottomTrim();
  screwTapping("case");
}
