$fn=25;

difference()
{
  union()
  {
    translate([0,0,0]) cube([54,24,3.8],center=true);
    translate([0,8.5,1.9+1.3]) cylinder(h=2.7,r1=3.3/2,r2=3.3/2,center=true);
    translate([21,4.5,1.9+1.3]) cylinder(h=2.7,r1=3.3/2,r2=3.3/2,center=true);
    translate([-21,4.5,1.9+1.3]) cylinder(h=2.7,r1=3.3/2,r2=3.3/2,center=true);
  }
  translate([21,-3.5,0]) cylinder(h=10,r1=5/2,r2=5/2,center=true);
  translate([-21,-4.5,0]) cylinder(h=10,r1=5/2,r2=5/2,center=true);
  translate([0,8.5,-1.9]) cylinder(h=2.6*2,r1=5/2,r2=5/2,center=true);
  translate([21,4.5,-1.9]) cylinder(h=2.6*2,r1=5/2,r2=5/2,center=true);
  translate([-21,4.5,-1.9]) cylinder(h=2.6*2,r1=5/2,r2=5/2,center=true);
}
