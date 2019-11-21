/* [Box Dimensions]*/
//X Dimension
xDim = 100;
//Y Dimension
yDim = 120;
//Z Dimension
zDim = 135;
//material thickness
material = 5;
//finger width
finger = 8;
//add debugging text
addText = 1; //[1:Add Text, 0:Do Not Add Text]

/*[Layout Type]*/
layout = "3D"; //[2D:2D for SVG output, 3D:3D for Visualization]

/*[Hidden]*/
//wierd bug in thingiverse customizer won't deal with boolean values so there's this hack
helpText = addText==1 ? true : false;


/*
#Finger Joint Library
Created by Aaron Ciuffo aaron . ciuffo at gmail.

This library calculate the appropriate number of finger joints for joining laser cut parts 
given an edge length, material thickness and finger joint length. This is a **LIBRARY** 
to be used in other OpenSCAD projects when a finger join (also known as a box joint or 
comb joint) is needed between two faces.

To create a joint between faceA and faceB, faceA must have an insideCut() and faceB must
have an outsideCut() to properly align. 

*Note:* Finger length must be less than 1/3 the length of the edge to work properly.
If you see the warnings below in the OpenSCAD console, check your finger length 
values. Setting text=true will also provide useful visual debugging.
***DEPRECATED: Using ranges of the form [begin:end] with begin value greater than the end value is deprecated. 

A demonstration is also provided through module 2Dlayout() and 3Dlayout(). 

The thingiverse customizer will *not* yield proper STLS in 2D mode. The 3D models are not
proper either. 

This is derived from my previous Finger Joint Boxes.


###tl;dr usage:
use </path/to/fingerjoint.scad>
//cuts that fall entirely inside an edge
insideCuts(length = 204, finger = 10, material = 4.4);
//cuts that fall outside an edge
outsideCuts(length = 204, finger = 10, material = 4.4);
//2D layout demo
2Dlayout();
//3D layout demo
3Dlayout();

###Demo modules:
*Two Dimensional Layout*
- SVG EXPORT:  Render (F6), *File* > *Export* > *Export as SVG*
2DLayout();

*Three Dimensional Layout*
- For visualization only; this will not yield a proper STL for printing
3DLayout();



##module: insideCuts
create a set of cuts that falls entirely inside the edge
  ###parameters:
    *length* (real)         length of edge
    *finger* (real)         length of each individual finger
    *material* (real)       thickness of material - sets cut depth
    *text* (boolean)           add help text to indicate cut type (for debugging)
    *center* (boolean)         center the set of fingers with respect to origin
      
##module: outsideCuts
Create a set of finger-joint cuts that result in two larger cuts taken at the outside 
edge 
  ###parameters:
    *length* (real)         length of edge
    *finger* (real)         length of each individual finger
    *material* (real)       thickness of material - sets cut depth
    *text* (boolean)           add help text to indicate cut type (for debugging)
    *center* (boolean)         center the set of fingers with respect to origin

##module 2Dlayout:
Create a 2D layout of demonstration box
  ###Parameters:
    *xDim* (real)             X dimension pf bpx
    *yDim* (real)             Y dimension of box
    *zDim* (real)             Z dimension of box
    *finger* (real)           length of each individual finger
    *material* (real)         thickness of material - sets cut depth
    *text* (boolean)          true: turns on help text to help identify cut type (debugging)

##module 3Dlayout:
Create a 3D layout of demonstration box
  ###Parameters:
    *xDim* (real)             X dimension pf bpx
    *yDim* (real)             Y dimension of box
    *zDim* (real)             Z dimension of box
    *finger* (real)           length of each individual finger
    *material* (real)         thickness of material - sets cut depth
    *text* (boolean)          true: turns on help text to help identify cut type (debugging)
*/


if (layout=="2D") {
  2Dlayout(xDim = xDim, yDim = yDim, zDim = zDim, finger = finger, material = material,
          text = helpText);
} 

if (layout=="3D") {
  3Dlayout(xDim = xDim, yDim = yDim, zDim = zDim, finger = finger, material = material,
          text = helpText);
}

module insideCuts(length = 100, finger = 8, material = 5, text = true, center = false) {
  // overage to ensure that all cuts are completed 
  o = 0.0001;


  //maximum possible divisions for this length
  maxDiv = floor(length/finger);
  //number of usable divisions that fall completely within the edge
  //for this implementation the number of divisions must be odd
  uDiv = maxDiv%2==0 ? maxDiv-3 : maxDiv-2; 
  
  // number of "female cuts"
  numCuts = ceil(uDiv/2);
 
  //echo("insideCuts\nmaxDiv", maxDiv, "\nuDiv", uDiv, "\nnumCuts", numCuts);

  xTrans = center==false ? 0 : -uDiv*finger/2;
  yTrans = center==false ? 0 : -material/2;
  
  translate([xTrans, yTrans]) {
    for (i=[0:numCuts-1]) {
      translate([i*finger*2, -o/2, 0]) //move the cuts slightly in y plane for complete cuts
        square([finger, material+o]); //add a small amount to ensure complete cuts
    }
  }
  debugText = finger>=length/3 ? "ERR: finger>1/3 length" : "insideCut";


  if (text) {
    translate([0, yTrans+material*2])
      text(text=debugText, size = length*0.05, halign = "center");
    echo(debugText);
  }

}

module outsideCuts(length = 100, finger = 8, material = 5, text = false, center = false) {
  // overage to ensure that all cuts are completed 
  o = 0.0001;


  //maximum possible divisions for this length
  maxDiv = floor(length/finger);
  //number of usable divisions that fall completely within the edge
  //for this implentation the number of divisions must be odd
  uDiv = maxDiv%2==0 ? maxDiv-3 : maxDiv-2;
  
  // number of "female cuts"
  numCuts = floor(uDiv/2);

  //length of cut at either end
  endCut = (length-uDiv*finger)/2;

  padding = endCut + finger;
  //echo("outsideCuts\nmaxDiv", maxDiv, "\nuDiv", uDiv, "\nnumCuts", numCuts, "\nendCut", endCut);

  xTrans = center==false ? 0 : -(numCuts*2+1)*finger/2-endCut;
  yTrans = center==false ? 0 : -material/2;

  translate([xTrans, yTrans]) {
    // add the "endcut" for a standard width cut plus any residual
    square([endCut, material]);
    //create the standard fingers
    for (i=[0:numCuts]) {
      if(i < numCuts) {
        translate([i*finger*2+padding, -o/2]) //move the cuts slightly in y plane for overage
          square([finger, material+o]); //add a tiny amount to the material thickness 
      } else { // the last cut needs to be an end cut
        translate([i*finger*2+padding, -o/2])
          square([endCut, material+o]);
      }
    }
  }

  debugText = finger>=length/3 ? "ERR: finger>1/3 length" : "outsideCut";


  if (text) {
    translate([length/2+xTrans, yTrans+material*2])
    text(text=debugText, size = length*.05, halign = "center");
    echo(debugText);
  }

}


module faceXY(xDim = 100, yDim = 100, finger = 8, material = 5, 
              center = false, text = true) {
  //create the YZ face

  //calculate the position of the X and Z displacement 
  xTrans = center==true ? 0 : xDim/2;
  yTrans = center==true ? 0 : yDim/2;

  // calculate the text size and rotation based on the dimensions
  textSize = xDim>=yDim ? xDim*.1 : yDim*.1;
  zRot = xDim>=yDim ? 0 : -90;

  // position the entire piece
  translate([xTrans, yTrans, 0]) {
    color("royalblue")
    // difference the fingers and text from the basic square
    difference() {
      square([xDim, yDim], center = true);

      if (text) {
        rotate([0, 0, zRot])
          text(text = "faceXY", size = textSize, halign = "center", valign = "center");
      }

      for(i=[-1,1]) {
        //+/- X edges fingers
        translate([0, i*yDim/2+i*-material/2, 0])
          outsideCuts(length = xDim, finger = finger, material = material, text = text,
          center = true);
        //+/- Y edges fingers
        translate([i*xDim/2+i*-material/2, 0, 0])
          rotate([0, 0, 90])
          insideCuts(length = yDim, finger = finger, material = material, text = text,
          center = true);
      }

    }
  }
}


module faceYZ(yDim = 100, zDim = 100, finger = 8, material = 5, 
              center = false, text = true) {
  //create the YZ face

  //calculate the position of the X and Z displacement 

  yTrans = center==true ? 0 : yDim/2;
  zTrans = center==true ? 0 : zDim/2;

  // calculate the text size and rotation based on the dimensions
  textSize = yDim>=zDim ? yDim*.1 : zDim*.1;
  zRot = yDim>=zDim ? 0 : -90;

 // position the entire piece
 translate([yTrans, zTrans]) {
    color("darkorange")
    difference() {
 
      square([yDim, zDim], center = true);


      if (text) {
        rotate([0, 0, zRot])
          text(text = "faceYZ", size = textSize, halign = "center", valign = "center");
      }

      for(i=[-1,1]) {
        //+/- Y edges
        translate([0, i*zDim/2+i*-material/2])
          outsideCuts(length = yDim, finger = finger, material = material, text = text, 
                      center = true);

        //+/- Z edges
        translate([i*yDim/2+i*-material/2, 0])
          rotate([0, 0, 90])
          outsideCuts(length = zDim, finger = finger, material = material, text = text, 
                      center = true);
      }
    }
  }
}

module faceXZ(xDim = 100, zDim = 100, finger = 8, material = 5, 
              center = false, text = true) {
  //create the XZ face

  //calculate the position of the X and Z displacement 
  xTrans = center==true ? 0 : xDim/2;
  zTrans = center==true ? 0 : zDim/2;


  // calculate the text size and rotation based on the dimensions
  textSize = xDim>=zDim ? xDim*.1 : zDim*.1;
  zRot = xDim>=zDim ? 0 : -90;

  // position the entire piece
  translate([xTrans, zTrans]) {
    color("firebrick")
    difference() {
      square([xDim, zDim], center = true);
      
      if (text) {
        rotate([0, 0, zRot])
          text(text = "faceXZ", size = textSize, halign = "center", valign = "center");
      }

      for(i=[-1,1]) {
        //+/- X edges
        translate([0, i*zDim/2+i*-material/2])
          insideCuts(length = xDim, finger = finger, material = material, text = text,
                    center = true);

        translate([i*xDim/2+i*-material/2, 0]) 
          rotate([0, 0, 90])
          insideCuts(length = zDim, finger = finger, material = material, text = text,
                    center = true);
      }


    }
  }
}


module 2Dlayout(xDim = 100, yDim = 100, zDim = 100, finger = 8, 
                material = 5, text = true) {

  //bottom of box (-XY face)
  translate()
    faceXY(xDim = xDim, yDim = yDim, finger = finger, material = material, 
          center = true, text = text);
  
  for (i=[-1,1]) {
    //right and left side of box (+/-YZ face)
    translate([i*(xDim/2+zDim/2+material), 0, 0])
      rotate([0, 0, i*90])
      faceYZ(zDim = zDim, yDim = yDim, finger = finger, material = material, 
          center = true, text = text);
 
    //front and back of box (+/-XZ face)
    translate([0, i*(yDim/2+zDim/2+material)])
      rotate()
      faceXZ(xDim = xDim, zDim = zDim, finger = finger, material = material, 
          center = true, text = text);
  }

  //top of box (+XY face)
  translate([0, yDim+zDim+2*material])
    faceXY(xDim = xDim, yDim = yDim, finger = finger, material = material, 
          center = true, text = text);
}

module 3Dlayout(xDim = 100, yDim = 100, zDim = 100, finger = 8, material = 5, text = true) {
  dim = [xDim, yDim, zDim];
  //bottom of box
  for( i=[-1,1]) {

    //rotatation for faces to make the text readable
    r = i<=0 ? 180 : 0;
    translate([0, 0, i*dim[2]/2+i*-material/2])
      rotate([r, 0, 0])
      color("royalblue")
        linear_extrude(height = material, center = true) {
          faceXY(xDim = xDim, yDim = yDim, finger = finger, material = material, 
          center = true, text = text);
       }
  }

  //front and back of box
  color("firebrick")
    for (i=[-1,1]) {
      //rotatation for faces to make the text readable
      r = i>=0 ? 180 : 0;

      translate([0, i*dim[1]/2+i*-material/2, 0])
        rotate([90, 0, r])
        linear_extrude(height = material, center = true) {
          faceXZ(xDim = xDim, zDim = zDim, finger = finger, material = material, 
          center = true, text = text);
     }
    }

  color("darkorange")
    for(i=[-1,1]) {
      //rotatation for faces to make the text readable
      r = i<=0 ? 180 : 0;

      translate([i*dim[0]/2+i*-material/2, 0, 0])
        rotate([90, 0, 90+r])
        linear_extrude(height=material, center = true) {
          faceYZ(yDim = yDim, zDim = zDim, finger = finger, material = material, 
          center = true, text = text);
        }
    }

}
