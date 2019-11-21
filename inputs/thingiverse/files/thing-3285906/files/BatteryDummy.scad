// Customizable Dummy Battery (AAA, AA, C, D, user defined)(Remixed)
// Original author by Eansdar https://www.thingiverse.com/thing:2650806/
// Remixed by mofosyne to print as one piece avoiding overhangs, as well as
//   improving tolerances and adding polarity symbols.
////////////////////////////////////////////////////////////////////////////////
//
// https://en.wikipedia.org/wiki/List_of_battery_sizes
//
// https://en.wikipedia.org/wiki/AA_battery
// An AA cell measures 49.2-50.5 mm (1.94-1.99 in) in length, including the
// button terminal-and 13.5-14.5 mm (0.53-0.57 in) in diameter. The positive
// terminal button should be a minimum 1 mm high and a maximum 5.5 mm in
// diameter, the flat negative terminal should be a minimum diameter of 7 mm
//
// https://en.wikipedia.org/wiki/AAA_battery
// A triple-A battery is a single cell and measures 10.5 mm in diameter and
// 44.5 mm in length, including the positive terminal button, which is a
// minimum 0.8 mm high. The positive terminal has a maximum diameter of 3.8 mm;
// the flat negative terminal has a minimum diameter of 4.3 mm.
//
// A 'C' battery measures 50 millimetres (1.97 in) length and 26.2 millimetres
// (1.03 in) diameter.
//
////////////////////////////////////////////////////////////////////////////////

// battery type (for the 'Generic' type set the values in the 'Generic Battery' section below)
battery_type    = "Demo" ; // [AAA,AA,C,D,Generic,Demo]

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

base_thickness = 1.5;

////////////////////////////////////////////////////////////////////////////////

module plussymbol(s,t)
{
  cube([t,s,s/3], center=true);
  cube([t,s/3,s], center=true);
}
module negsymbol(s,t)
{
  cube([t,s,s/3], center=true);
}

module battery(batt)
{
  batt_radius = batt[cDiameter] / 2 ;
  batt_height = batt[cHeight];
  batt_pin_height = batt[cPinHeight];
  batt_pin_diameter = batt[cPinDiameter];
  batt_wire_diameter = batt[cWire];
  batt_wall_width = batt[cWidth];

  union()
  {
    difference()
    {
      union()
      {
        cylinder(h=batt_height, r=batt_radius); // outer
        translate([0,0,batt_height-0.1])
        {
          cylinder(h=batt_pin_height+0.1, r1=batt_radius, r2=batt_pin_diameter/2 ) ; // pin on top
        }
      }

      /* Polarity */

      translate([batt_radius*2/3+batt_wire_diameter-base_thickness,0,batt_height*5/6])
        plussymbol(batt_radius/2, base_thickness/2);
      translate([batt_radius*2/3+batt_wire_diameter-base_thickness,0,batt_height/6])
        negsymbol(batt_radius/2, base_thickness/2);


      /* Inner Hollow */
      difference()
      {
        translate([0, 0, batt_wall_width]) cylinder(h=batt_height-2*batt_wall_width, r=batt_radius-batt_wall_width) ;  // inner
        translate([batt_radius*2/3+batt_wire_diameter-base_thickness, -batt_radius, 0])
          cube([base_thickness*2,2*(batt_radius),batt_height]);
      }

      /* Base */
      translate([batt_radius*2/3+batt_wire_diameter, -batt_radius, -1])
        cube([(batt_radius)/2,2*(batt_radius),batt_height+2]);

      /* Wires */
      translate([ batt_pin_diameter*2/3, 0,-batt_radius]) { cylinder(h=batt_height  +2*batt_radius, d=batt_wire_diameter) ; } // wire 1
      translate([-batt_pin_diameter*2/3, 0,-batt_radius]) { cylinder(h=batt_height  +2*batt_radius, d=batt_wire_diameter) ; } // wire 2
      translate([0, batt_pin_diameter/2,-batt_radius])  { cylinder(h=batt_height/2+2*batt_radius, d=batt_wire_diameter) ; } // neg terminal wire 3
      translate([0,-batt_pin_diameter/2,-batt_radius])  { cylinder(h=batt_height/2+2*batt_radius, d=batt_wire_diameter) ; } // neg terminal wire 4

      /* Cut-Out */
      hull()
      {
        translate([-batt_radius, batt_radius, batt_radius+batt_wall_width])
          rotate([90,0,0])
          cylinder(h=2*batt_radius, r=batt_radius) ;
        translate([-batt_radius, batt_radius, batt_height-batt_radius-batt_wall_width])
          rotate([90,0,0])
          cylinder(h=2*batt_radius, r=batt_radius) ;
      }
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
  batteryType(battery_type, body_diameter, body_height, body_wall_width, pin_height, wire_diameter) ;

////////////////////////////////////////////////////////////////////////////////
// EOF
////////////////////////////////////////////////////////////////////////////////
