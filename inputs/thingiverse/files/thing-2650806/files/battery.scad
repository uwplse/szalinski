////////////////////////////////////////////////////////////////////////////////
//
// Dummy Battery
//
////////////////////////////////////////////////////////////////////////////////

// battery type (for the 'Generic' type set the values in the 'Generic Battery' section below)
battery_type    = "AA" ; // [AAA,AA,C,D,Generic,Demo]

/* [Settings for Generic Battery (mm)] */
// diameter of the body
body_diameter   = 14.5 ; // [8:0.1:40]
// height of body plus pin
body_height     = 50.5 ; // [35:0.1:60]
// width of the body wall
body_wall_width =  1.2 ; // [0.7:0.1:5]
// diameter of the pin
pin_diameter    =  5.5 ; // [3:0.1:12]
// height of the pin
pin_height      =  1.0 ; // [0.7:0.1:2.5]
// diameter of the holes for the wire
wire_diameter   =  1.2 ; // [0.7:0.1:2]

////////////////////////////////////////////////////////////////////////////////

/* [Hidden] */

// column index into Batt
cName        = 0 ; // name
cDiameter    = 1 ; // body diameter
cHeight      = 2 ; // body height (incl pin height)
cWidth       = 3 ; // wall width
cPinDiameter = 4 ; // pin diameter
cPinHeight   = 5 ; // pin width
cWire        = 6 ; // wire diameter

/*
  Dimensions:
  
  D   http://data.energizer.com/pdfs/e95.pdf
      http://professional.duracell.com/downloads/datasheets/product/Industrial/Industrial%20D.pdf
  C   http://data.energizer.com/pdfs/e93.pdf
      http://professional.duracell.com/downloads/datasheets/product/Industrial/Industrial%20C.pdf  
  AA  http://data.energizer.com/pdfs/e91.pdf
      http://professional.duracell.com/downloads/datasheets/product/Industrial/Industrial%20AA.pdf
  AAA http://data.energizer.com/pdfs/l92.pdf
      http://professional.duracell.com/downloads/datasheets/product/Industrial/Industrial%20AAA.pdf
*/

// Note: Battery length is the height of the battery body and plus the pin height.
Batt =
[ // name, diam, heig, wid, pinD, pinH, wire
  [ "D"  , 34.2, 61.5, 1.5,  9.5,  1.5, 1.2 ],
  [ "C"  , 26.2, 50.0, 1.5,  7.5,  1.5, 1.2 ],
  [ "AA" , 14.5, 50.5, 1.2,  5.5,  1.0, 1.2 ],
  [ "AAA", 10.5, 44.5, 1.0,  3.8,  0.8, 1.2 ]
] ;

$fa =  5 ;
$fs =  0.4 ;

////////////////////////////////////////////////////////////////////////////////

module battery(batt)
{
  radius = batt[cDiameter] / 2 ;
  height = batt[cHeight] - batt[cPinHeight] ;

  difference()
  {
    union()
    {
      cylinder(h=height, r=radius); // outer
      translate([0,0,height-0.1])
      {
	cylinder(h=batt[cPinHeight]+0.1, d=batt[cPinDiameter]) ; // pin on top
      }
    }
    color("lightgreen")
    translate([0, 0, batt[cWidth]]) { cylinder(h=height-2*batt[cWidth], r=radius-batt[cWidth]) ; }  // inner

    // (+) wire
    color("red")
    {
      offsetTop1 = (batt[cPinDiameter] + 2*batt[cWire]) / 2 ;
      offsetTop2 = batt[cDiameter]/2 - batt[cWidth] - 0.5*batt[cWire] ;
      offsetTop = offsetTop1 < offsetTop2 ? offsetTop1 : offsetTop2 ;
      translate([ offsetTop, 0,height-1.5*batt[cWidth]]) { cylinder(h=2*batt[cWidth]+batt[cPinHeight], d=batt[cWire]) ; }
      translate([-offsetTop, 0,height-1.5*batt[cWidth]]) { cylinder(h=2*batt[cWidth]+batt[cPinHeight], d=batt[cWire]) ; }
    }

    // (-) wire
    color("black")
    {
      offsetBottom = (batt[cDiameter]/2 - batt[cWidth]) * 2 / 3 ;
      translate([ offsetBottom, 0, -batt[cWidth]/2]) { cylinder(h=2*batt[cWidth], d=batt[cWire]) ; } 
      translate([-offsetBottom, 0, -batt[cWidth]/2]) { cylinder(h=2*batt[cWidth], d=batt[cWire]) ; }
      translate([ 0, offsetBottom, -batt[cWidth]/2]) { cylinder(h=2*batt[cWidth], d=batt[cWire]) ; }
      translate([ 0,-offsetBottom, -batt[cWidth]/2]) { cylinder(h=2*batt[cWidth], d=batt[cWire]) ; }
    }

    color("orange")
    hull() // cut-out
    {
      translate([-radius, radius, radius+2*batt[cWidth]])
        rotate([90,0,0])
        cylinder(h=2*radius, r=radius) ;
      translate([-radius, radius, height-radius-2*batt[cWidth]])
        rotate([90,0,0])
        cylinder(h=2*radius, r=radius) ;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

module batteryType(battery_type, body_diameter, body_height, body_wall_width, pin_diameter, pin_height, wire_diameter)
{
  idx = search([battery_type], Batt) ;
  if (idx != [[]])
  {
    battery(Batt[idx[0]]) ;
  }
  else if (battery_type == "Demo")
  {
    iD   = search(["D"  ], Batt) ;   rD   = Batt[iD  [0]][cDiameter] / 2 ;
    iC   = search(["C"  ], Batt) ;   rC   = Batt[iC  [0]][cDiameter] / 2 ;
    iAA  = search(["AA" ], Batt) ;   rAA  = Batt[iAA [0]][cDiameter] / 2 ;
    iAAA = search(["AAA"], Batt) ;   rAAA = Batt[iAAA[0]][cDiameter] / 2 ;

    dD   =   rD                              ; translate([-rD  , dD  , 0]) batteryType("D"  ) ;
    dC   = 2*rD +   rC                  + 10 ; translate([-rC  , dC  , 0]) batteryType("C"  ) ;
    dAA  = 2*rD + 2*rC +   rAA          + 20 ; translate([-rAA , dAA , 0]) batteryType("AA" ) ;
    dAAA = 2*rD + 2*rC + 2*rAA +   rAAA + 30 ; translate([-rAAA, dAAA, 0]) batteryType("AAA") ;
  }
  else
  {
    battery(["Generic", body_diameter, body_height, body_wall_width, pin_diameter, pin_height, wire_diameter]) ;
  }
}

////////////////////////////////////////////////////////////////////////////////

rotate([0,0,180])
rotate([0, 90, 0])
  batteryType(battery_type, body_diameter, body_height, body_wall_width, pin_diameter, pin_height, wire_diameter) ;

////////////////////////////////////////////////////////////////////////////////
// EOF
////////////////////////////////////////////////////////////////////////////////
