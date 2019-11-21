////////////////////////////////////////////////////////////////////////////////
// Rod Holder

// height
h = 30.0 ; // [5:0.5:40]

// hole diameter
d =  8.4 ; // [4:0.1:20]

// wall width
w =  3.0 ; // [2:0.1:8]

// extra base width
b =  3.0 ; // [0:0.1:10]

// screw diameter
sd = 4 ; // [3:0.5:8]

// open
open = 1 ; // [1:top,2:bottom,3:closed]

// cut extra base at round edge
cut = 0 ; // [0:round,1:cut]

module rodHolder(h, d, w, b, sd, open=0, cut=0)
{
  $fa = 10;
  $fs = 0.4;
  x = d/2 + 2*w + b ;
  
  difference()
  {
    union()
    {
      translate([0, x, w/2]) cube([2*x, 2*x, w], center=true) ;
      
      rotate_extrude($fn = 90)
      difference()
      {
        polygon( points=[ [0, 0], [x, 0], [x, w], [d/2 + 2*w, w], [d/2 + w, 2*w], [d/2 + w, h+w], [d/2, h+w], [d/2, w], [0, w] ]) ;
        translate([d/2+2*w, 2*w]) circle(r = w, $fn = 60) ;
      }
    }
    if (open == 1)
      translate([0, (b+d)/2,h/2+2*w]) cube([d, b+d, h+2*w], center=true) ;
    if (open == 2)
      translate([0,-(b+d)/2,h/2+2*w]) cube([d, b+d, h+2*w], center=true) ;
      

    hull()
    {
      translate([ x/2, d/2+2*w+sd/2, 0]) cylinder(d=sd, h=4*w, center=true) ;
      translate([ x/2, 2*x-w-sd    , 0]) cylinder(d=sd, h=4*w, center=true) ;
    }
    hull()
    {
      translate([-x/2, d/2+2*w+sd/2, 0]) cylinder(d=sd, h=4*w, center=true) ;
      translate([-x/2, 2*x-w-sd    , 0]) cylinder(d=sd, h=4*w, center=true) ;
    }
    if (cut)
    {
      translate([0, -(d/2+2*w)-x/2, w/2])  cube([2*x, x, 2*w], center=true);
    }
  }
}

rodHolder(h, d, w, b, sd, open, cut) ;

////////////////////////////////////////////////////////////////////////////////
// EOF
////////////////////////////////////////////////////////////////////////////////
