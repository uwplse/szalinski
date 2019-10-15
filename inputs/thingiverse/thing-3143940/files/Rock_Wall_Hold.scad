// Sarah Wade

include <Bolt.scad>

// Defines the radius of the entire hold [mm].
radius = 100;

// Defines the resolution
$fn = 100;
module WallHold(r)
{
  difference()
  {
    sphere(r, true);
    difference()
    {
      sphere(0.9*r, true);
      translate([0,0,-0.8*0.9*r])cube(0.9*2*r, true);
    }
    
    translate([0,0,-r])cube(2*r, true);
    translate([-0.3*r,0.2*r,0.7*r])rotate([-20,-15,0])Heart(r);
  }
}

module Heart(r)
{
  s = 0.3;
  h = 0.5*r;
  union()
  {
    translate([-s*r,0,0])cylinder(h, s*r, s*r,  true);
    translate([s*r, 0, 0])cylinder(h, s*r, s*r, true);
    difference()
    {
      translate([0,0.86*s*r,0])rotate([0,0,45])cube([2.15*s*r, 2.15*s*r,h], true);
      translate([0,-0.65*s*r,0])cube([s*r, s*r,h], true);
    }
  }
}

difference()
{
  WallHold(radius);
  translate([0,0,0.2*radius])Bolt();
}