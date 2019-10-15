$fn=50;

translate([0,0,0]) makeleadscrewriser();
translate([-22,-30,0]) makesupportrodriser();
translate([-22,30,0]) makesupportrodriser();
translate([22,-30,0]) makesupportrodriser();
translate([22,30,0]) makesupportrodriser();

module makeleadscrewriser()
{
  difference()
  {
    translate([0,0,0]) cube([38,31,6],center=true);
    translate([26.5/2,0,0]) cylinder(h=10,r1=5.8/2,r2=5.8/2,center=true);
    translate([-26.5/2,0,0]) cylinder(h=10,r1=5.8/2,r2=5.8/2,center=true);
  }
}

module makesupportrodriser()
{
  difference()
  {
    translate([0,0,0]) cube([41,25,6],center=true);
    translate([31/2,2,0]) cylinder(h=10,r1=5.8/2,r2=5.8/2,center=true);
    translate([-31/2,2,0]) cylinder(h=10,r1=5.8/2,r2=5.8/2,center=true);
  }
}

