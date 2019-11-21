////////////////////////////////////////////////////////////////////////////////
// Clock
////////////////////////////////////////////////////////////////////////////////
//
// (c) Andreas Mueller
// License: Creative Commons - Attribution
// http://creativecommons.org/licenses/by/4.0/
//
////////////////////////////////////////////////////////////////////////////////

// radius of clock
radius_outer   = 120   ; // [50:5:200]
// radius of hole in the middle
radius_inner   =  40   ; // [0:5:150]
// width of bottom, outer and inner wall
width          =   1.6 ; // [0.8:0.1:5]
// width of wall between beams
spacer_width   =   0.8 ; // [0.4:0.1:5]
// height of beam box
height         =  13   ; // [8:1:40]

// number of LEDs/beams (shoud be a multiple of parts)
ws_count       = 60   ; // [3:1:100]
// size of LED
ws_size        =  5.5 ; // [3:0.5:7]

// height of wire channel
wire_height    =  1.6 ; // [0:0.2:3]
// width of wire channel
wire_width     =  3   ; // [0:0.2:5]

// split clock in parts
parts          =  1   ; // [1:one, 2:two, 4:four, 0:center]

/* [Hidden] */

PI = 3.141592654 ;
$fa =  6 ;
$fs =  1 ;

////////////////////////////////////////////////////////////////////////////////

module ws()
{
  rMin = spacer_width / 2 / sin(180/ws_count) ;
  echo("Minimum Radius", rMin) ;
  
  // outer
  rO = radius_outer - width ;
  aswO = 2 * asin(spacer_width / 2 / rO) ; // angle of spacer_width
  awO = (360 - aswO*ws_count) / ws_count ; // angle per beam
  wO = 2 * rO * tan(awO/2) ;

  // inner
  rI = (radius_inner + width) > rMin ? radius_inner + width : rMin + 0.1 ;
  aswI = 2 * asin(spacer_width / 2 / rI) ;
  awI = (360 - aswI*ws_count) / ws_count ;
  wI = 2 * rI * tan(awI/2) ;
  
  da = 360 / ws_count ;

  // corona
  intersection()
  {
    for (a = [da/2:da:360])
    rotate([0, 0, a])
    {
      rotate([90, 0, 0])
      hull()
      {
        translate([0, height/2, rO])
        union()
        {
          translate([0, height, 0]) cube([wO, 2*height, 0.01], center = true) ;
          scale([wO/2, height/2, 1])
          cylinder(r = 1, h = 0.01, center = true, $fn=30) ;
        }
        
        translate([0, height, rI])
          translate([0, height/2, 0]) cube([wI, height, 0.01], center = true) ;
      }
    }

    cylinder(r = rO, h = 4*(height+width)) ;
  }
  
  // hole for LED
  for (a = [da/2:da:360])
  rotate([0, 0, a])
  {
    translate([0, -radius_outer, height/2])
    cube([ws_size, 4*width, ws_size], center=true) ;
  }
}

////////////////////////////////////////////////////////////////////////////////

module wire()
{
  da = 360 / ws_count ;

  for (a = [da:90:360])
  rotate([0, 0, -a])
  translate([0, 0, wire_height/2]) cube([3*(radius_outer), wire_width, wire_height], center=true) ;
}

////////////////////////////////////////////////////////////////////////////////

module center()
{
  module ic(x, y)
  {
    h = 3 ;
    w = 0.8 ;

    difference()
    {
      translate([0, 0, (h+w)/2])
      cube([x+2*w, y+2*w, h+w], center=true) ;

      translate([0, 0, (h+w)/2])
      cube([x, y, 2*(h+w)], center = true) ;
    }

    x2 = x - 10 ;
    difference()
    {
      translate([0, 0, h/2])
      cube([x2, y, h], center = true) ;

      translate([0, 0, 1.5*h-w])
      cube([x2-2*w, y, h], center = true) ;
    }
  }
  
  rO = radius_inner - 0.5 ;
  rI = rO - width ;

  rLdrI = 3.5 ;
  rLdrO = rLdrI + width ;
  
  da = 360 / ws_count ;
  
  difference() // housing
  {
    union()
    {
      difference() // housing
      {
        translate([0, 0, height/2])
        cylinder(r = rO, h = height, center=true) ;

        translate([0, 0, height/2 + width])
        cylinder(r = rI, h = height, center=true) ;
      }

      translate([-10, 14, 0])
      {
        translate([0, 0, height/2]) // LDR hole
        cylinder(r = rLdrO, h=height, center=true) ;
      }
    }

    translate([-10, 14, 0])
    {
      translate([0, 0, height/2]) // LDR hole
      cylinder(r = rLdrI, h=height*2, center=true) ;

      translate([0, 0, height/2 + height-1])  // LDR wire gap
      cube([3*rLdrO, wire_height, height], center=true) ;
    }
    
    for (a = [da/2:90:360]) // wire holes
    rotate([0, 0, -a])
    translate([0, rO, height])
    cube([2*wire_width, rO, 4*wire_height], center=true) ;
  }

  // hook
  translate([0, 28, height/2])
  {
    difference()
    {
      cylinder(r = 4+1.5*width, h = height, center=true) ;
      translate([0, 0, -1.5*width])
      cylinder(r = 4      , h = height, center=true) ;
      translate([0, -2*height, 0])
      cube([4*height, 4*height, 4*height], center=true) ;
    }
  }
  
  // voltage regulator
  translate([-15, -10, width-0.1]) ic(21, 31) ;
  
  // "nodemcu" like ESP board
  translate([12, 0, width-0.1]) ic(27,51) ;

  // text
  translate([0,-35,width/2])
  linear_extrude(height=width)
  text(text = "7V-16V =", size = 3, halign = "center"); 
}

////////////////////////////////////////////////////////////////////////////////
// Main
////////////////////////////////////////////////////////////////////////////////

if (parts != 0)
{
  difference ()
  {
    translate([0, 0, (height+width)/2]) cylinder(r = radius_outer, h = height + width, center = true) ;
    translate([0, 0, (height+width)/2]) cylinder(r = radius_inner, h = 2 * (height + width), center = true) ;

    translate([0, 0, width]) ws() ;
    wire() ;

    if (parts == 4)
    {
      translate([2*radius_outer, 0, (height+width)/2]) cube([4*radius_outer, 4*radius_outer, 2*(height + width)], center = true) ;
      translate([0, 2*radius_outer, (height+width)/2]) cube([4*radius_outer, 4*radius_outer, 2*(height + width)], center = true) ;
    }
    if ((parts == 4) || (parts == 2))
    {
      translate([2*radius_outer, 0, (height+width)/2]) cube([4*radius_outer, 4*radius_outer, 2*(height + width)], center = true) ;
    }
  }
}
else // center
{
  center() ;
}

////////////////////////////////////////////////////////////////////////////////
// EOF
////////////////////////////////////////////////////////////////////////////////
