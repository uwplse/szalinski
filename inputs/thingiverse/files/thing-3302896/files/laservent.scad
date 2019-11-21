$fn=50;

faninlet();
//fanoutlet();
//aircollector();
//aircollectorholder();

module faninlet()
{
  difference()
  {
    union()
    {
      translate([0,0,0]) cylinder(h=20+2.5,r1=(62+5)/2,r2=(62+5)/2,center=true);
      translate([0,0,10+1.25+9.5]) cylinder(h=20,r1=20/2,r2=20/2,center=true);
      translate([0,0,-10-1.25+1.5]) cylinder(h=3,r1=(62+5+10)/2,r2=(62+5+10)/2,center=true);
      translate([0,0,10]) cylinder(h=10,r1=(20+20)/2,r2=20/2,center=true);
      translate([0,0,28]) cylinder(h=1.5,r1=(20+1.5)/2,r2=20/2,center=true);
      translate([0,0,28-1.45]) cylinder(h=1.5,r1=20/2,r2=(20+1.5)/2,center=true);
    }
    translate([0,0,-2.5]) cylinder(h=20+2.5,r1=62/2,r2=62/2,center=true);
    translate([0,0,0]) cylinder(h=100,r1=(20-5)/2,r2=(20-5)/2,center=true);
  }
}

module aircollectorholder()
{
  union()
  {
    difference()
    {
      cube([59+6-1,15,9+3+2.5+1],center=true);
      translate([0,0,-0.5]) cube([59,50,9+1],center=true);
      translate([0,0,5]) cube([59-6,50,9+1],center=true);
    }
    translate([-30.75,12.5,-3.25]) cube([2.5,20,9],center=true);
    translate([-31+1,12.5+8,-7.75+6]) rotate([0,0,45]) cube([3,2.5,2],center=true);
    translate([30.75,12.5,-3.25]) cube([2.5,20,9],center=true);
    translate([31-1,12.5+8,-7.75+6]) rotate([0,0,-45]) cube([3,2.5,2],center=true);
    translate([0,12.5,-8+1.5-0.125]) cube([20,20,2.25],center=true);
  }
}

module aircollector()
{
  difference()
  {
    union()
    {
      scale([23,50,50]) rotate([0,0,45]) cylinder($fn=4,h=1,r1=1.5/2,r2=1/2,center=true);
      translate([-5.5,0,25]) rotate([0,-20,0]) cylinder(h=27,r1=19/2,r2=19/2,center=true);
    }
    translate([0,0,-3]) scale([17,44,50]) rotate([0,0,45]) cylinder($fn=4,h=1,r1=1.5/2,r2=1/2,center=true);
    translate([-5.5,0,25+2]) rotate([0,-20,0]) cylinder(h=27+4,r1=(19-5)/2,r2=(19-5)/2,center=true);
  }
}

module fanoutlet()
{
  difference()
  {
    union()
    {
      cube([59+6,34+6,10+3],center=true);
      translate([0,0,6.5+13]) cylinder(h=26,r1=32/2,r2=32/2,center=true);
      translate([0,0,6.5+7]) cylinder(h=15,r1=40/2,r2=10,center=true);
      translate([0,0,28]) cylinder(h=1,r1=32/2,r2=35/2,center=true);
      translate([0,0,29]) cylinder(h=1.1,r1=35/2,r2=32/2,center=true);
    }
    translate([0,0,-3]) cube([59,34,10+3],center=true);
    cylinder(h=100,r1=(32-5)/2,r2=(32-5)/2,center=true);
  }
}

