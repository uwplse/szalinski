/* This customizable algorithm will fill an area with
   a number of cylinders of a desired height. This is
   handy for subtracting from a solid, thus creating
   vent holes. The spacing in x and y direction is not
   necessarily equal as the algorithm will fill with
   cylinders right to the very edges. A space of one cylinder
   diameter is maintained around the edges of the area.
   For instance if you make a lid say 40 x 60, then if diameter is 4,
   an area of 32 x 52 is exactly filled. 40 - 2*4, 60 - 2*4.
*/

//---------------------------------------------------------------------
// User inputs

   lengthx=40;    //x direction of area
   lengthy=60;    //y direction of area
   cyldiam=4;     //diameter of the cylinders
   height=6;      //height of the cylinders
   spacingx=6.0;  //desired spacing x direction
   spacingy=6.0;  //desired spacing y direction

// End of user input
//---------------------------------------------------------------------


//program start, change anything below this at your own peril!

r=cyldiam / 2;         //radius equals half diameter
a=lengthx - 3*cyldiam; //calculate the space around perimeter
b=lengthy - 3*cyldiam; //calculate the space around perimeter
// used 3 diameters because of the cylinder at the center
sx=spacingx;
sy=spacingy;

module array() {

  qa = floor(a/2/sx);  //number of x direction rows + and -
  echo("qa=",qa);
  qb = floor(b/2/sy);  //number of y direction rows + and -
  echo("qb=",qb);
  //now adjust spacing so space is exactly filled
  sx = (a/2/qa);
  echo("sx=", sx);
  sy = (b/2/qb);
  echo("sy=", sy);
  //build the array
    for (x=[-qa:qa])
      for (y=[-qb:qb])
        translate([x*sx,y*sy,r/2])
          cylinder(h=height, r=r, ,center=true);
} // end of module array()


array();
