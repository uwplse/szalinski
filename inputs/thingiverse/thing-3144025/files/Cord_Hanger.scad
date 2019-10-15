include <Bolt.scad>

// Number of screws to use (hooks - 1)
N = 3;

/* [Hidden] */
h = 100;    // mm
w = 0.8*h;  // mm
t = h/2;    // mm
module Bracket()
{
  
  difference()
  {
    union()
    {
      translate([-w/4,-3*t/8,0])cube([w/2,t/4,h],true);
      translate([w/4,0,-h/4])cube([w/2,t,h/2],true);
    }
    translate([w/4,0,-h/4])rotate([90,0,0])Bolt();
  }
}

union()
{
  for(x = [0:N-1])
  { 
      translate([x*w,0,0])Bracket();
  }
  translate([(N)*w,0,0])translate([-w/4,-3*t/8,0])cube([w/2,t/4,h],true);
}
