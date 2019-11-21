$fn=100;

difference()
{
  cube([30,22,10]);
  translate([0,3,3])
    cube([30,22,4]);
}

  translate([0,20-1,-25])
    cube([12,1.2,25]);

  difference()
    {
        color("blue")
    translate([0,17,-2])
    cube([12,5,2]);
    for (y =[22.2,17.0])
    {
      translate([0,y,-2])
      rotate([0,90,0])
      cylinder(r=2,h=12);
    }
  }


