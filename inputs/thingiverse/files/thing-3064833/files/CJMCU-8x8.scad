////////////////////////////////////////////////////////////////////////////////
// Module Holder
////////////////////////////////////////////////////////////////////////////////

// length of module
length = 65   ;
// height of standoff
height =  6   ;
// space between modules
space  =  1   ;
// distance between pins
pinDx  =  8.5 ;
// distance between pin rows
pinDy  = 62.5 ;
// pin diameter
pinD   =  1.5 ;
// pin height
pinH   =  2.5 ;
// screw hole diameter
screwD =  4   ;
// height of base bars
baseH  =  2   ;
// width of base bars
baseW  = 10   ;

/* [Hidden] */

baseL = 2*length + space ;
baseL2 = baseL/2 ;
offset = (length + space) / 2 ;

$fa = 5   ;
$fs = 0.2 ;

module plate()
{
  module pins()
  {
    translate([0, -pinDx, 0]) cylinder(d = pinD, h = height + pinH) ;
    translate([0,      0, 0]) cylinder(d = pinD, h = height + pinH) ;
    translate([0, +pinDx, 0]) cylinder(d = pinD, h = height + pinH) ;
  }

  difference()
  {
    union()
    {
      translate([0, 0, height/2])   cube([length, 2* (pinDx + pinD), height], center=true) ;
      translate([0, 0, height/2])   cube([2* (pinDx + pinD), length, height], center=true) ;
    }

    cube([length - 6*pinD, length-6*pinD, 4*height], center=true) ;
  }

  translate([-pinDy/2, 0, 0]) pins() ;
  translate([+pinDy/2, 0, 0]) pins() ;
}

module base()
{
  difference()
  {
    union()
    {
      translate([-offset, 0, baseH/2]) cube([baseW, baseL, baseH], center=true) ;
      translate([+offset, 0, baseH/2]) cube([baseW, baseL, baseH], center=true) ;
      translate([0, -offset, baseH/2]) cube([baseL + baseW, baseW, baseH], center=true) ;
      translate([0, +offset, baseH/2]) cube([baseL + baseW, baseW, baseH], center=true) ;

      translate([-baseL2-baseW/2, -offset, baseH/2]) cylinder(d = baseW, h = baseH, center=true) ;
      translate([+baseL2+baseW/2, -offset, baseH/2]) cylinder(d = baseW, h = baseH, center=true) ;
      translate([-baseL2-baseW/2, +offset, baseH/2]) cylinder(d = baseW, h = baseH, center=true) ;
      translate([+baseL2+baseW/2, +offset, baseH/2]) cylinder(d = baseW, h = baseH, center=true) ;
    }
    translate([-baseL2-baseW/2, -offset, baseH/2]) cylinder(d = screwD, h = baseH*2, center=true) ;
    translate([+baseL2+baseW/2, -offset, baseH/2]) cylinder(d = screwD, h = baseH*2, center=true) ;
    translate([-baseL2-baseW/2, +offset, baseH/2]) cylinder(d = screwD, h = baseH*2, center=true) ;
    translate([+baseL2+baseW/2, +offset, baseH/2]) cylinder(d = screwD, h = baseH*2, center=true) ;
  }
}

translate([-offset, -offset, 0]) plate() ;
translate([+offset, -offset, 0]) plate() ;
translate([-offset, +offset, 0]) plate() ;
translate([+offset, +offset, 0]) plate() ;

base() ;

////////////////////////////////////////////////////////////////////////////////
// EOF
////////////////////////////////////////////////////////////////////////////////
