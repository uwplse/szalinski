// Author: Martin Cloutier
// Date  : 2017-02-08
// Email : mxclouti@gmail.com

$fn=16;  // Adjust

HoleSize = 2.0;  // Adjust
HoleRadius = (2*HoleSize)/sqrt(3)/2;

module handle()
{
    union()
    {
      cylinder(r=4,h=25,center=true);   
      translate([0,0,12.5]) sphere(r=4);
      translate([0,0,-14.0]) cylinder(h=3,r1=2.5,r2=4,center=true);
    }
}

difference()
{
  handle();
  translate([0,0,-5]) cylinder(r=HoleRadius,h=25,center=true);    
  for (a = [0 : 30 : 359])
  {
    rotate([0, 0, -a])
    translate([0, 4.75, 1.25])
    cylinder(r=1.0,h=15,center=true);
  }   
  
  rotate([90,0,0])
  translate([0,11,0])
  cylinder(r=1.5,h=20,center=true);
  
  rotate([90,0,0])
  translate([0,-9,5])
  cylinder(r=1.5,h=10,center=true);
}


