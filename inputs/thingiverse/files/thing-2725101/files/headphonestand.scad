////////////////////////////////////////////////////////////////////////////////
// Head Phone Stand
////////////////////////////////////////////////////////////////////////////////
//
// (c) Andreas Mueller
// License: Creative Commans - Attribution
// http://creativecommons.org/licenses/by/4.0/
//
////////////////////////////////////////////////////////////////////////////////

// Height (mm)
height = 205 ; // [150:250]
// Length (mm)
length =  50 ; // [ 40: 80]
// Angle (°)
angle  =  70 ; // [ 60: 90]
// Print in two parts
split = 0 ;    // [0:all, 1:split]

// calculating round edges takes very long time
roundEdge = 0+0 ; // [0:no, 1:yes]

/* [Hidden] */

////////////////////////////////////////////////////////////////////////////////

module headPhoneStand(height=185, lengthTop=50, angle=70, split=0, roundEdge=0)
{
  $fn = 90 ;
  length0 = height / tan(angle) ;
  lengthBottom = (lengthTop+length0) * 1.2 ;

  extrudeScale = (lengthBottom-length0) / lengthBottom ;
  widthBottom = 120 ;

  a = lengthBottom * 0.8 ;
  b = widthBottom / 2 * 0.8 ;
  t = tan(20) ;
  x = (a*b) / sqrt(b*b + a*a * t*t) ;
  y = (b/a) * sqrt(a*a - x*x) ;

  l = x - lengthTop/extrudeScale ;

  ////////////////////////////////////////
  
  module platform()
  {
    difference()
    {
      linear_extrude(height=height, scale=extrudeScale)
        difference()
      {
        scale([2*lengthBottom, widthBottom]) circle(d=1, $fa=12, $fs=2) ;
      
        translate([0,  widthBottom+y]) square([lengthBottom*2, widthBottom*2], center=true) ;
        translate([0, -widthBottom-y]) square([lengthBottom*2, widthBottom*2], center=true) ;
        translate([ lengthBottom-l,0]) square([lengthBottom*2, widthBottom*2], center=true) ;
      }

      translate ([0, 0, height/2 - 20]) cube([4*lengthBottom, 4*widthBottom, height], center=true) ;
      translate ([0, 0, 1.5*height   - 10]) cube([4*lengthBottom, 4*widthBottom, height], center=true) ;

      difference()
      {
        lx = (lengthTop-20)/extrudeScale ;
        linear_extrude(height=height, scale=extrudeScale)
        translate([-x+lx/2+10/extrudeScale,0])
        square([lx, widthBottom], center=true) ;

        translate([0,0,height/2-12])
        cube([4*lengthBottom, 4*widthBottom, height], center=true) ;
      }
    }
  }

  ////////////////////////////////////////
  
  module base()
  {
    module baseShape(length, width)
    {
      difference()
      {
        scale([2*length, width]) circle(d=1, $fa=12, $fs=2) ;
        scale([2*length*0.8, width*0.8]) circle(d=1, $fa=12, $fs=2) ;
        translate([length-l,0]) square([length*2, width*2], center=true) ;
      }
    }

    difference()
    {
      linear_extrude(height=height, scale=extrudeScale)
        baseShape(lengthBottom, widthBottom) ;

      translate([0,0,height*0.75-20])
        cube([5*lengthBottom, 5*lengthBottom, height/2], center=true) ;
      rotate([0,5,0])
        translate([0,0,height*0.25+10])
        cube([5*lengthBottom, 5*lengthBottom, height/2], center=true) ;
    
      rotate([0,0,80])
        translate([0,-lengthBottom,20])
        cube([5*lengthBottom, 5*lengthBottom,height]) ;
      rotate([0,0,190])
        translate([-lengthBottom,0,20])
        cube([5*lengthBottom, 5*lengthBottom,height]) ;
    }

    linear_extrude(height=height, scale=extrudeScale)
      difference()
    {
      baseShape(lengthBottom, widthBottom) ;
      rotate(  70) translate([0,-2.5*lengthBottom]) square(5*lengthBottom) ;
      rotate(-100) translate([0,-2.5*lengthBottom]) square(5*lengthBottom) ;
    }

    linear_extrude(height=height, scale=extrudeScale)
      difference()
    {
      baseShape(lengthBottom, widthBottom) ;
      rotate(-70) translate([0,-2.5*lengthBottom]) square(5*lengthBottom) ;
      rotate(100) translate([0,-2.5*lengthBottom]) square(5*lengthBottom) ;
    }
  }

  ////////////////////////////////////////
  
  module roundEdge()
  {
    if (roundEdge > 0)
    {
      difference()
      {
        minkowski()
        {
          sphere(d=4, $fn = 20) ;
          union()
          {
            children() ;
          }
        }

        translate([0,0,-500]) cube([1000,1000,1000], center=true) ;
      }
    }
    else
    {
      children() ;      
    }
  }

  ////////////////////////////////////////
  
  module split()
  {
    splitHeight = (roundEdge>0) ? height - 22 : height - 20 ;
    echo(splitHeight=splitHeight) ;

    if (split > 0)
    {
      difference()
      {
        union() children() ;
        translate([0, 0, 1.5*splitHeight]) cube([4*lengthBottom, 4*widthBottom, splitHeight], center=true) ;
      }

      translate([length/2, 0, -splitHeight])
      difference()
      {
        union() children() ;
        translate([0, 0, 0.5*splitHeight]) cube([4*lengthBottom, 4*widthBottom, splitHeight], center=true) ;
      }

    }
    else
    {
      children() ;
    }
  }

  ////////////////////////////////////////
  
  split()
  {
    roundEdge()
    {
      platform() ;
      base() ;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

headPhoneStand(height, length, angle, split, roundEdge) ;

////////////////////////////////////////////////////////////////////////////////
// EOF
////////////////////////////////////////////////////////////////////////////////
