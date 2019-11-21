//
// Parametric Metric Measuring Spoon, V1.1
//
// For the protocol:
//   07/2013
//   (C)CC-BY-SA, FMMT666(ASkr)
//   www.askrprojects.net
//

//
// CHANGES V1.1:
//  - Hid the "CP" (aka $fn) variable from the Thingiverse Customizer.
//


MINITESTGRIP =     0;      // print test grip? 0/1 (off/on)
                           // Useful for testing the size of the bowl
                           // with much faster prints...


volume =           5.0;    // volume of the spoon in ml
thickness =        1.4;    // thickness of wall in mm

gripDia =          7.0;    // diameter of the grip
gripLen =         80.0;    // length of the grip
gripAngle =       30.0;    // angle of the bowl-grip joint

sink =             0.4;    // cut off the bottom a bit (easier to print)


//=========================================================================
//=== NO CHANGES BELOW HERE ===============================================
//=========================================================================
/*[hidden]*/
CP   = 75; // arc resolution ($fn)
rad  = pow( (6000.0*volume/(4.0*3.14159)), (1.0/3.0) );
rado = rad + thickness;
cuts = 2 * (rad + thickness + 1);



Spoon();



//=========================================================================
module Spoon()
{

  difference()
  {
    // join bowl and grip
    translate([ 0, 0, -sink ])
    union()
    {
      translate([ 0, 0, rado ])
      rotate([ 0, gripAngle, 0 ])
      translate([ 0, 0, -rado ])
      Bowl();

      if( MINITESTGRIP )
      {
        difference()
        {
          Grip();
          translate([ rado, -gripDia/2-1])
          cube([ gripLen + gripDia + 2, gripDia + 2, gripDia +2 ]);
        }
      }
      else
        Grip();

    }// END union

    // bottom cutoff
    translate([ -rado - 1 - gripDia/2, (-rado - 1)/2, -sink - 1 ])
    cube([rado + gripLen + gripDia + 2, rado + 2, sink + 1 ]);

  }// END difference
}


//=========================================================================
module BowlCut()
{
  translate([0,0,rado])
  hull()
  {
    translate([ gripLen, 0, 0])
    sphere(r = rado, $fn = CP );
    sphere(r = rado, $fn = CP );
  }
}


//=========================================================================
module Bowl()
{
  translate([0,0,rado])
  difference()
  {
    sphere(r = rado, $fn = CP );
    sphere(r = rad, $fn = CP );
    translate([-cuts/2,-cuts/2,0])
    cube([cuts,cuts,cuts]);
  }
}


//=========================================================================
module Grip()
{

  difference()
  {
    union()
    {
      // round end of the grip
      translate([ gripLen, 0, gripDia/2])
      sphere( r = gripDia/2, $fn = CP, center = true );

      // the round grip
      rotate([0,90,0])
      translate([-gripDia/2,0,0])
      cylinder( r = gripDia/2, h = gripLen, $fn = CP );
    }

    translate([0,0,rado])
    sphere(r = rad, $fn = CP );

  }//END difference
}


