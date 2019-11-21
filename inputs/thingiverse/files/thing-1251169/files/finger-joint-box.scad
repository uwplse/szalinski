/*
  Box with fingerjoints - Based on earlier version of Finger Joint Box
  http://www.thingiverse.com/thing:448592
  Aaron Ciuffo
  24 December 2015 
*/


//include <../libraries/nuts_and_bolts.scad>
/* [Box Dimensions] */
// Box X dimension
customX = 100;
// Box Y dimension
customY = 60;
// Box Z dimension
customZ = 40;

// Finger & Cut width (sides, bottom) - must be < 1/3 shortest side
customFinger = 10;
// Finger & Cut wdith on lid only - must be < 1/3 shortest X or Y 
customLidFinger = 20;

/* [Layout Option] */
// layout 2D or 3D style - THINGIVERSE CANNOT OUTPUT 2D STLS!
customLayout2D = 0; // [0:3D layout for visualization, 1:2D layout for DXF output]

/* [Hidden] */
customSize = [customX, customY, customZ];
o = .001; // overage for cutting 


// cuts that fall completely inside the edge
module insideCuts(length, finger, cutD, uDiv) {
  numFinger = floor(uDiv/2);
  numCuts = ceil(uDiv/2);

  myCutD = cutD+o; // add an overage to make the cut complete
  // draw rectangles to make slots
  for (i=[0:numCuts-1]) {
    translate([i*finger*2, 0, 0])
      square([finger, myCutD]);
  }
}

module outsideCuts(length, finger, cutD, uDiv) {
  numFinger = ceil(uDiv/2);
  numCuts = floor(uDiv/2);

  myCutD = cutD+o; // add an overage in to make cuts slightly larger


  // calculate the length of the extra long cut at either end
  endCut = (length-uDiv*finger)/2;
  // amount of padding to add to the itterative placement of cuts
  // this is the extra long cut at either end
  padding = endCut+finger;

  square([endCut, myCutD]);

  for (i = [0:numCuts]) {
    if (i < numCuts) {
      translate([i*(finger*2)+padding, 0, 0])
        square([finger, myCutD]);
    } else {
      translate([i*finger*2+padding, 0, 0])
        square([endCut, myCutD]);
    }
  }
}


// Face A (X and Z dimensions)
// front and back face
module faceA(size, finger, lidFinger, material, usableDiv, usableDivLid) {
  uDivX = usableDiv[0];
  uDivZ = usableDiv[2];
  uDivLX = usableDivLid[0];
  uDivLZ = usableDivLid[2];

  boxX = size[0];
  boxY = size[1];
  boxZ = size[2];

  difference() {
    square([boxX, boxZ], center = true);

    // X+/- edge (X axis in openSCAD)
    translate([-uDivLX*lidFinger/2, boxZ/2-material, 0])
      insideCuts(length = boxX, finger = lidFinger, cutD = material, uDiv = uDivLX);

    translate([-uDivX*finger/2, -boxZ/2-o, 0]) // -o to move outside
      insideCuts(length = boxX, finger = finger, cutD = material, uDiv = uDivX);

    // Z+/- edge (Y axis in OpenSCAD)
    translate([boxX/2-material, uDivZ*finger/2, 0]) rotate([0, 0, -90])
      insideCuts(length = boxZ, finger = finger, cutD = material, uDiv = uDivZ);
    translate([-boxX/2-o, uDivZ*finger/2, 0]) rotate([0, 0, -90]) // -o to move outside
      insideCuts(length = boxZ, finger = finger, cutD = material, uDiv = uDivZ);
  } // end difference
}

// Face B (X and Y dimensions)
// lid and base
module faceB(size, finger, lidFinger, material, usableDiv, usableDivLid, lid = false) {
  
  // if this is the lid, use different settings than if it is the base
  uDivX = lid == true ? usableDivLid[0] : usableDiv[0];
  uDivY = lid == true ? usableDivLid[1] : usableDiv[1];
  myFinger = lid == true ? lidFinger : finger;

  //uDivX = finger != lidFinger ? usableDivLid[0] : usableDiv[0];
  //uDivY = finger != lidFinger ? usableDivLid[1] : usableDiv[1];
  //myFinger = finger != lidFinger ? lidFinger : finger;
  
  boxX = size[0];
  boxY = size[1];
  boxZ = size[2];
  
  difference() {
    square([boxX, boxY], center = true);

    // X+/- edge
    translate([-boxX/2, boxY/2-material, 0])
      outsideCuts(length = boxX, finger = myFinger, cutD = material, uDiv = uDivX);
    translate([-boxX/2, -boxY/2-o, 0]) // -o to move the cuts completely outside the face
      outsideCuts(length = boxX, finger = myFinger, cutD = material, uDiv = uDivX);

    // Y+/- edge 
    translate([boxX/2-material, uDivY*myFinger/2, 0]) rotate([0, 0, -90])
      insideCuts(length = boxY, finger = myFinger, cutD = material, uDiv = uDivY);      
    translate([-boxX/2-o, uDivY*myFinger/2, 0]) rotate([0, 0, -90]) // -o to move
      insideCuts(length = boxY, finger = myFinger, cutD = material, uDiv = uDivY);      
  }
  
}

// Face C (Z and Y dimensions)
// left and right sides
module faceC(size, finger, lidFinger, material, usableDiv, usableDivLid) {
  uDivX = usableDiv[0];
  uDivY = usableDiv[1];
  uDivZ = usableDiv[2];
  uDivLX = usableDivLid[0];
  uDivLY = usableDivLid[1];
  uDivLZ = usableDivLid[2];

  boxX = size[0];
  boxY = size[1];
  boxZ = size[2];

  difference() {
    square([boxY, boxZ], center = true);

    //Y+/- edge (X axis in OpenSCAD)
    // lid edge
    translate([-boxY/2, boxZ/2-material, 0])
      outsideCuts(length = boxY, finger = lidFinger, cutD = material, uDiv = uDivLY);
    // bottom edge
    translate([-boxY/2, -boxZ/2-o, 0]) // -o to move outside
      outsideCuts(length = boxY, finger = finger, cutD = material, uDiv = uDivY);

    //Z+/- edge (Y axis in OpenSCAD)
    translate([boxY/2-material, boxZ/2, 0]) rotate([0, 0, -90])
      outsideCuts(length = boxZ, finger = finger, cutD = material, uDiv = uDivZ);
    translate([-boxY/2-o, boxZ/2, 0]) rotate([0, 0, -90]) // -o to move outside
      outsideCuts(length = boxZ, finger = finger, cutD = material, uDiv = uDivZ);
  }

}


module layout2D(size, finger, lidFinger, material, usableDiv, usableDivLid) {
  boxX = size[0];
  boxY = size[1];
  boxZ = size[2];

  //separation of pieces
  separation = 1.5;
  // calculate the most efficient layout
  yDisplace = boxY > boxZ ? boxY : boxZ + separation;

  translate([])
    color("Red")
      faceA(size = size, finger = finger, material = material, lidFinger = lidFinger, 
            usableDiv = usableDiv, usableDivLid = usableDivLid);
  translate([boxX+separation+boxY+separation, 0, 0])
    color("darkred")
      faceA(size = size, finger = finger, material = material, lidFinger = lidFinger, 
            usableDiv = usableDiv, usableDivLid = usableDivLid);

  translate([boxX/2+boxY/2+separation, 0, 0])
    color("blue")
      faceC(size = size, finger = finger, material = material, lidFinger = lidFinger,
            usableDiv = usableDiv, usableDivLid = usableDivLid);
  translate([boxX/2+boxY/2+separation, -yDisplace, 0])
    color("darkblue")
      faceC(size = size, finger = finger, material = material, lidFinger = lidFinger,
            usableDiv = usableDiv, usableDivLid = usableDivLid);


  translate([0, -boxZ/2-yDisplace/2-separation, 0])
    color("lime")
      faceB(size = size, finger = finger, material = material, lidFinger = lidFinger, 
            usableDiv = usableDiv, usableDivLid = usableDivLid, lid = true);

  translate([boxX+separation+boxY+separation, -boxZ/2-yDisplace/2-separation, 0])
    color("green")
      faceB(size = size, finger = finger, material = material, lidFinger = lidFinger, 
            usableDiv = usableDiv, usableDivLid = usableDivLid, lid = false);
}

module layout3D(size, finger, lidFinger, material, usableDiv, usableDivLid, alpha) {
  boxX = size[0];
  boxY = size[1];
  boxZ = size[2];

  // amount to shift to account for thickness of material
  D = material/2;

  // this is the base
  color("green", alpha = alpha)
    translate([])
    linear_extrude(height = material, center = true)
    faceB(size = size, finger = finger, material = material, lidFinger = lidFinger, 
          usableDiv = usableDiv, usableDivLid = usableDivLid, lid = false);

  // this is the "lid"
  color("lime", alpha = alpha)
    translate([0, 0, boxZ-material])
    linear_extrude(height = material, center = true)
    faceB(size = size, finger = finger, material = material, lidFinger = lidFinger, 
          usableDiv = usableDiv, usableDivLid = usableDivLid, lid = true);


  color("red", alpha = alpha)
    translate([0, boxY/2-D, boxZ/2-D])
    rotate([90, 0, 0])
    linear_extrude(height = material, center = true)
    faceA(size = size, finger = finger, material = material, lidFinger = lidFinger, 
         usableDiv = usableDiv, usableDivLid = usableDivLid);
    

  color("darkred", alpha = alpha)
    translate([0, -boxY/2+D, boxZ/2-D])
    rotate([90, 0, 0])
    linear_extrude(height = material, center = true)
    faceA(size = size, finger = finger, material = material, lidFinger = lidFinger, 
         usableDiv = usableDiv, usableDivLid = usableDivLid);
  
  color("blue", alpha = alpha)
    translate([boxX/2-D, 0, boxZ/2-D])
    rotate([90, 0, 90])
    linear_extrude(height = material, center = true)
    faceC(size = size, finger = finger, material = material, lidFinger = lidFinger,
          usableDiv = usableDiv, usableDivLid = usableDivLid);

  color("darkblue", alpha = alpha)
    translate([-boxX/2+D, 0, boxZ/2-D])
    rotate([90, 0, 90])
    linear_extrude(height = material, center = true)
    faceC(size = size, finger = finger, material = material, lidFinger = lidFinger,
          usableDiv = usableDiv, usableDivLid = usableDivLid);

}


module fingerBox(size = [50, 80, 60], finger = 5, 
                lidFinger = 10, material = 3, 2D = true, alpha = .5) {
  boxX = size[0];
  boxY = size[1];
  boxZ = size[2];

  // calculate the maximum number of fingers and cuts possible
  maxDivX = floor(boxX/finger);
  maxDivY = floor(boxY/finger);
  maxDivZ = floor(boxZ/finger);

  // calculate the maximum number of fingers and cuts for the lid
  maxDivLX = floor(boxX/lidFinger);
  maxDivLY = floor(boxY/lidFinger);

  // the usable divisions value must be odd for this layout
  uDivX = (maxDivX%2)==0 ? maxDivX-3 : maxDivX-2;
  uDivY = (maxDivY%2)==0 ? maxDivY-3 : maxDivY-2;
  uDivZ = (maxDivZ%2)==0 ? maxDivZ-3 : maxDivZ-2;
  usableDiv = [uDivX, uDivY, uDivZ];

  uDivLX= (maxDivLX%2)==0 ? maxDivLX-3 : maxDivLX-2;
  uDivLY= (maxDivLY%2)==0 ? maxDivLY-3 : maxDivLY-2;
  usableDivLid = [uDivLX, uDivLY];

  if (2D) {
    layout2D(size = size, finger = finger, lidFinger = lidFinger, material = material,
            usableDiv = usableDiv, usableDivLid = usableDivLid);
  } else {
    layout3D(size = size, finger = finger, lidFinger = lidFinger, material = material,
            usableDiv = usableDiv, usableDivLid = usableDivLid, alpha = alpha);
  }

  
}

//fingerBox(size = [100, 70, 60], finger = 10, lidFinger = 21, 2D = true);

fingerBox(size = customSize, finger = customFinger, lidFinger = customLidFinger, 
          2D = customLayout2D);
