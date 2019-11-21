/* [Display options] */
//Current values for Dials
// Display the lid in place (use this to check if the parameters are ok) 
assambled = false;
// Display only the box or the box and lid
displayLid = true;
sectioned = false;

/* [Dial Dimensions] */
// Diameter of the dial
dialDiameter = 47;
// Thickness of the dial
dialThickness = 10.5;
// Number of dials
nbDials = 10;

/* [Compartments] */
// divider height as a fraction of internal compartment height
dividerHeightFraction = 0.4; 
dividerHeight = dialDiameter*dividerHeightFraction;
//Second row size fraction
secondRowFraction = 0;
// thickness of divider walls
dividerThick = 0.8;

/* [Box Dimensions] */
// radius of curved corners
cornerRad = 1.5; 
// thickness of box walls
wallThick = 1.5; 
//Finger recess on the sides 
sideOpeningRadius = 10;  

/* [Lid] */
// amount of play in the lid in mm - the lid can't be the exact same size as the opening
lidTolerance = 0.2;
//Lid orientation
lidSlidesOverLenght = true;
//Closing lip
lidLip = true;

/* 
  This section is "hidden" from the customizer and is used for calculating
  variables based on those that the user inputs above
*/

/* [Hidden] */
yDivderThick = secondRowFraction>0?dividerThick:0;

outerLenght=(dialThickness)*nbDials+dividerThick*(nbDials-1)+2*wallThick; 
outerWidth=dialDiameter+2*wallThick+yDivderThick+dialDiameter*secondRowFraction;
//We change the X and Y depending on the lid orientation
// width
boxX = lidSlidesOverLenght?outerWidth:outerLenght; 
// depth
boxY = lidSlidesOverLenght?outerLenght:outerWidth; 
// height
boxZ = dialDiameter+2*wallThick;
// number of columns
xCompartments = lidSlidesOverLenght?2:nbDials;
// number of rows 
yCompartments = lidSlidesOverLenght?nbDials:2; 
// define the amount that needs to be subtracted to account for wall thicknesses
wallSub = 2 * wallThick;
// to avoid "z fighting" where surfaces line up exactly, add a bit of fudge
fudge = .001; 

/*
  OpenSCAD Parametric Box Lesson

  Created by Aaron Ciuffo (aaron.ciuffo/txoof) - reach me at gmail or thingiverse

  December 16 2015

  Released under the Creative Commons Share Alike License
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
  echo ("This is the lid module");


  // define how snug the fit should be on the lid
  // when this sub is used to "cut" enlarge the dimensions to make the opening larger
  snugness = cutter? lidTolerance:0;
  tolerance2 = cutter? 0:lidTolerance;

  // define the lid width (X)
  lidX = boxX - wallSub + snugness - wallThick/2;

  // define the length of the lid (Y) 
  lidY = boxY - wallThick - tolerance2;

  // define the thickness of the lid
  lidZ = wallThick+lidTolerance;

  // define slot dimensions
  slotX = lidX*.8;
  slotY = lidZ*0.5;


  // define the angle in the trapezoid; this needs to be less than 45 for most printers
  trapAngle = 60;
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
    union() {
      // draw a polygon using the points above and then extrude
      // linear extrude only works in the Z axis so everything has to be rotated after
        difference(){
          linear_extrude(height = lidY, center = true) 
            polygon([p0, p1, p2, p3], paths = [[0, 1, 2, 3]]); 
          // add a fingernail slot for making opening the lid easier
          // the variable names are a bit wonky because the lid is drawn rotated -90 degrees
          if ( cutter == false) {
            translate([lidX/2, 0, (lidY-2*wallThick)/2])
              roundedBox([slotX, lidZ, slotY], radius = slotY/2, $fn=36);
          }
        }
      lipRotation = [0,90,0];
      lipTranslation = [lidX/2, lidZ, -(lidY-wallThick)/2]; 
      translate(lipTranslation)
        rotate(lipRotation)
        cylinder(h=slotX,r=wallThick/4,center=true, $fn=36);
    }
}

/*
  create the dividers for the columns in the box
*/
module xDividers(innerBoxDim) {
  // the number of dividers is always one less than the number of compartments
  cols = lidSlidesOverLenght?2:xCompartments;

  // calculate the spacing of the dividers based on the dimensions of the inner box
  // element 0 of the innerBoxDim variable contains the X dimension  
  increment = innerBoxDim[0]/xCompartments;

  // if the number of compartments is bigger than 2, do this:
  if ( xCompartments > 2) {
    // this loops several times to make each divider from 1 to the number of columns
    for ( i = [1 : cols-1]) {
      // move each divider into place
        translate([-innerBoxDim[0]/2+i*increment, 0,  -(innerBoxDim[2]-dividerHeight)/2])
          // draw a cube
          cube([dividerThick, innerBoxDim[1],  dividerHeight], center =true);
      
    } // this bracket is the end of the "for" loop
  } // this bracket is the end of the IF statement
  else {
      if ( secondRowFraction > 0) {
          translate([-innerBoxDim[0]*(0.5)+dialDiameter*secondRowFraction+dividerThick/2,0,  -(innerBoxDim[2]-dividerHeight)/2])
          // draw a cube
          cube([dividerThick,innerBoxDim[1], dividerHeight], center =true);
          }
  }
} // this should be the LAST curly bracket for xDividers


/*
  create the dividers for the rows
*/
module yDividers(innerBoxDim) {
  // the number of dividers is always one less than the number of compartments
  cols = yCompartments;

  // calculate the spacing of the dividers based on the dimensions of the inner box

  // element 0 of the innerBoxDim variable contains the X dimension  
  increment = innerBoxDim[1]/yCompartments;
  
  // if the number of compartments is bigger than 2, do this:
  if ( yCompartments > 2) {
    // this loops several times to make each divider from 1 to the number of columns
    for ( i = [1 : cols-1]) {
      // move each divider into place
        translate([0, -innerBoxDim[1]/2+i*increment, -(innerBoxDim[2]-dividerHeight)/2])
          // draw a cube
          cube([innerBoxDim[0], dividerThick, dividerHeight], center =true);
      
    } // this bracket is the end of the "for" loop
  } // this bracket is the end of the IF statement
  else{
      if ( secondRowFraction > 0) {
          // move the divider into place
          translate([0,-innerBoxDim[1]*(0.5)+dialDiameter*secondRowFraction+dividerThick/2, -(innerBoxDim[2]-dividerHeight)/2])
            // draw a cube
            cube([innerBoxDim[0],dividerThick,dividerHeight], center =true);
      } // this bracket is the end of the IF statement
  }
} // this should be the LAST curly bracket for yDividers. 


/*
  create the basic box
*/
module outerBox(outerBox, innerBox) {
  // Set the curve refinement
  $fn = 36;
  //Define the cut parameters based on the lid orientation
  rotation=lidSlidesOverLenght?[90,0,0]:[0,90,0];
  cilinderHeight = lidSlidesOverLenght?boxY:boxX;
    
  // Create the box then subtract the inner volume and make a cut for the sliding lid
  difference() {
    // call the MCAD rounded box command imported from MCAD/boxes.scad
    // size = dimensions; radius = corner curve radius; sidesonly = round only some sides

    // First draw the outer box
    roundedBox(size = outerBox, radius = cornerRad, sidesonly = 1);
    // Then cut out the inner box
    roundedBox(size = innerBox, radius = cornerRad, sidesonly = 1);
      
    translate([0,0,boxZ/2])
      rotate(rotation)
      cylinder(h=cilinderHeight+2,r=sideOpeningRadius,center=true);
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
  innerBox = [boxX-wallSub, boxY-wallSub, boxZ-wallSub+fudge];
    
    difference(){
      // call the basic box module to add the box
      outerBox(outerBox, innerBox);
      // Then cut out the lid
      translate([0, 0, (boxZ+lidTolerance)/2])
        lid(cutter = true);
    } 

  // draw the dividers in the X dimension
  xDividers(innerBox);
  // draw the dividers in the Y dimension
  yDividers(innerBox); // the # will highlight this in red when it is drawn

  if(displayLid){
      // move the lid to the left of the box and also move it down  so it sits at the
      // same level as the bottom of the box
      translation = assambled?[0, 0,(boxZ)/2]:[-boxX-5, 0, -(boxZ)/2];
      lidRotation = assambled?[0, 0, 0]:[0, 180, 0];
      translate(translation)
        rotate(lidRotation)
        lid();
  }
}

module section() 
{
    if(sectioned){
        difference(){
            dividedBox();
            translate([500,500,500])
              cube([1000,1000,1000],center = true);
        }
    }
    else{
        dividedBox();
    }
}
// call the dividedBox module
//dividedBox();
section();

