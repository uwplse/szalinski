translate([0,21,46/2]) basebox();
translate([0,-21,8/2]) boxlid();

module boxlid()
{
  rotate([180,0,0])
  {
    difference()
    {
      cube([50+6+4+2,25+6+4+2,8],center=true);
      translate([0,0,-3]) cube([50+6+2,25+6+2,8],center=true);
      for(c=[0:7])
        translate([-23+((46/7)*c),0,0])
          cube([3,20,20],center=true);
    }
  }
}

module basebox()
{
  difference()
  {
    union()
    {
      cube([50+6,25+6,40+3],center=true);
      translate([0,0,-3]) cube([50+6+4,25+6+4,40+3-3],center=true);
      translate([-15,27.5,-8]) clip();
    }
    translate([0,0,2.5]) cube([50,25,42],center=true);
    for(c=[0:7])
      translate([-23+((46/7)*c),-32.5/2,10])
        cube([3,10,10],center=true);
  }
}

module clip()
{
  union()
  {
    difference()
    {
      cube([26,22.5,30],center=true);
      translate([0,3.75,0]) cube([21,25,30+5],center=true);
    }
    translate([0,-8.5,0]) cube([6,2,30],center=true);
    translate([-10.5,1.25,0]) rotate([0,0,90]) cube([6,2,30],center=true);
    translate([10.5,1.25,0]) rotate([0,0,90]) cube([6,2,30],center=true);
  }
}
