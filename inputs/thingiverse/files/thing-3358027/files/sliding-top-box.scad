/* [Outside Dimensions] */
// width
boxX = 40; 
// depth
boxY = 60; 
// height
boxZ = 15;
// radius of curved corners
cornerRad = 3; 
// thickness of box walls
wallThick = 2.4; 

/* [Compartments] */
// number of columns
xCompartments = 1;

// thickness of divider walls
dividerThick = 1; 

/* [Lid] */
// amount of play in the lid in mm.  1.1 works well for Prusa MK3
lidPlay = 1.4;

/* 
  This section is "hidden" from the customizer and is used for calculating
  variables based on those that the user inputs above
*/

/* [Hidden] */
// define the amount that needs to be subtracted to account for wall thicknesses
wallSub = 2 * wallThick;

// to avoid "z fighting" where surfaces line up exactly, add a bit of fudge
fudge = .001; 

/*
  OpenSCAD Parametric Box Lesson

  Original Creator: Aaron Ciuffo (aaron.ciuffo/txoof) - reachable at gmail or thingiverse

  December 16 2015

  Released under the Creative Commons Share Alike License
  http://creativecommons.org/licenses/by-sa/3.0/

  Thanks to:
  agalavis: http://www.thingiverse.com/agalavis (Nail slot issue!)
  0707070: http://www.thingiverse.com/0707070 (issues with lid size)

  Modified by:  Patrick James
  January 1, 2019
  Modifications:  
      (1) Flipped the lid right-side up, to simplify subsequent customization
          with labels, decorations, etc.
      (2) Resized the lid so it does not protrude from the end of the box when closed
      (3) Removed Y divider code which original author notes as disabled
      (4) Renamed lidSnugness to lidPlay.  Increasing this value increases the degree
          of play or looseness of the lid.  This makes more sense than "snugness", which
          would imply that an increased value would increase how snug or tight the lid
          fits.

  Project remains under the Creative Commons Share Alike License
  http://creativecommons.org/licenses/by-sa/3.0/

  Style Notes:
    * Indentation is used to show nested calls:

      union() {
        // one indention to show that all calls are part of the union call
        cube([x, y, z], center = true)
        sphere(r = radius, center = true)
      }

    * cammelCaps are used to name variables to make them readable:
      - this allows more descriptive and readable variable names
      
      lidLength = 5 versus lidlength or lidl
      boxCutOut = 4 versus boxcutout boxc
    
    * Long commands are split over multiple lines using indenation
      - this makes code more readable in all editors and makes relationships
        more clear

      translate([0, lY/2-wall/2, -wall+catch/2]) 
        cube([lX*.8, catch*1.5, catch*1.3], center=true);

*/



/* 
  Add a ready made library for making rounded boxes
  Learn more about the MCAD libraries here: http://reprap.org/wiki/MCAD
*/
include <MCAD/boxes.scad>

/*
  Create the lid trapezoidal lid
  This sub creates both a lid and is used for cutting out the lid shape in the basic box
*/

play = 0.5;
module lid(cutter = false) {
  /*
    Lid profile

       boxX - 2* wall thickness + 2*(wall thickness/tan(trap angle))
    p0 ---------------- p1
       \) trap angle  /
        \            /
    P3   ------------   p2
         boxX - 2* wall thickness
  */
    

  // define how snug the fit should be on the lid
  // when this sub is used to "cut" enlarge the dimensions to make the opening larger
  play = cutter==false ? 1 : lidPlay;

  // define the lid width (X)
  lidX = (boxX - wallSub) + play;

  // define the length of the lid (Y) 
  lidY = boxY - wallThick;

  // define the thickness of the lid
  lidZ = wallThick + play;
  echo("lidZ=", lidZ, " and cutter=", cutter);
  // define slot dimensions
  slotX = lidX*.9;
  slotY = lidY*.05;


  // define the angle in the trapezoid; this needs to be less than 45 for most printers
  trapAngle = 70;
  lidAdd = wallThick/tan(trapAngle);
  // define points for the trapezoidal lid
  p0 = [0, 0];
  p1 = [lidX, 0];
  p2 = [lidX + lidAdd, lidZ];
  p3 = [0 + -lidAdd , lidZ];
  
  //center the lid

  translate([-lidX/2, -lidZ/2, 0])
    // rotate the lid -90 degrees 
    rotate([-90])
    difference() {
      // draw a polygon using the points above and then extrude
      // linear extrude only works in the Z axis so everything has to be rotated after
      linear_extrude(height = lidY, center = true) 
        polygon([p0, p1, p2, p3], paths = [[0, 1, 2, 3]]); 


      // add a fingernail slot for making opening the lid easier
      // the variable names are a bit wonky because the lid is drawn rotated -90 degrees
      if ( cutter == false) {
        translate([lidX/2, 0, lidY/2-slotY*2])
          roundedBox([slotX, lidZ, slotY], radius = slotY/2, $fn=36);
      }
    }
}

/*
  create the dividers for the columns in the box
*/
module xDividers(innerBoxDim) {
  
  // copy from here

  echo ("This is the xDividers module");
  echo ("innerBoxDim=", innerBoxDim);
  // the number of dividers is always one less than the number of compartments
  cols = xCompartments - 1;

  // calculate the spacing of the dividers based on the dimensions of the inner box

  // element 0 of the innerBoxDim variable contains the X dimension  
  increment = innerBoxDim[0]/xCompartments;

  // if the number of compartments is bigger than 1, do this:
  if ( xCompartments > 1) {
    // this loops several times to make each divider from 1 to the number of columns
    for ( i = [1 : cols]) {
      // move each divider into place
        translate([-innerBoxDim[0]/2+i*increment, 0, 0])
          // draw a cube - remember to remove a bit for the snuggness factor on the lid
          cube([dividerThick, innerBoxDim[1], innerBoxDim[2]-2*play], center =true);
      
    } // this bracket is the end of the "for" loop
  } // this bracket is the end of the IF statement
  

  // copy to here

} // this should be the LAST curly bracket for xDividers


/*
  create the basic box
*/
module basicBox(outerBox, innerBox) {
  // Set the curve refinement
  $fn = 36;


  // Create the box then subtract the inner volume and make a cut for the sliding lid
  difference() {
    // call the MCAD rounded box command imported from MCAD/boxes.scad
    // size = dimensions; radius = corner curve radius; sidesonly = round only some sides

    // First draw the outer box
    roundedBox(size = outerBox, radius = cornerRad, sidesonly = 1);
    // Then cut out the inner box
    roundedBox(size = innerBox, radius = cornerRad, sidesonly = 1);
    // Then cut out the lid
    translate([0, 0, (boxZ/2)+fudge])
      lid(cutter = true); 
  }
}

/*
  This module will call all of the other modules and assemble the final box
*/
module dividedBox() {
  echo ("This is the dividedBox module");
  // Define the volume that will be the outer box
  outerBox = [boxX, boxY, boxZ];

  // Define the volume that will be subtracted from the box
  // a "fudge factor" is added to avoid Z fighting when faces align perfectly
  innerBox = [boxX-wallSub, boxY-wallSub, boxZ-wallSub+fudge*2];

  // call the basic box module to add the box
  basicBox(outerBox, innerBox);

  // explain what's going on
  echo ("innerBox=", innerBox);

  // draw the dividers in the X dimension
  xDividers(innerBox);

  // move the lid to the left of the box and also move it down  so it sits at the
  // same level as the bottom of the box
  //translate([-boxX, 0, -boxZ/2 + wallThick + lidPlay])
  translate([-boxX, 0,(-1*((boxZ/2 + fudge))+ + wallThick + 1)])    
    resize(newsize=[0, boxY - wallThick - lidPlay, 0])
    lid();
}

// call the dividedBox module
dividedBox();

