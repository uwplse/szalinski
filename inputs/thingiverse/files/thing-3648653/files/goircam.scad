$fn=20;

translate([0,0,10.5/2]) makeheaderadapter();
translate([0,-25,1.25]) makebackplate();
translate([0,27.5,15.5/2]) maketopbox();

module maketopbox()
{
  union()
  {
    difference()
    {
      translate([0,0,0]) roundedbox(68+4,24.2+4,15.5,4);
      translate([0,0,2.5]) roundedbox(68-2,24.2-2,15.5,5);
      translate([0,0,15.5/2]) roundedbox(68+0.5,24.2+1,10,4);
      translate([34-22,0,0]) cylinder(h=20,r1=11/2,r2=11/2,center=true);
    }
    translate([24,0,-7.75+(5/2)+1.25-0.1]) cube([6,10,5],center=true);
    translate([-14,0,-7.75+(7/2)+1.25]) cube([25,12,7],center=true);
  }
}

module makebackplate()
{
  union()
  {
    difference()
    {
      union()
      {
        translate([0,0,0.5]) roundedbox(68,24.2,2.5+1,4);
        translate([-15.25,0,1.25]) roundedbox(42.5,24.2,5,4);
      }
      translate([-14,0,0]) cube([36,20.2,2.6],center=true);
      translate([-14,0,0]) cube([33,17,10],center=true);
      translate([5.5,0,7.25]) cube([10,5,10],center=true);
    }
    translate([8.5,6.875,2.25]) cylinder(h=5,r1=5/2,r2=5/2,center=true);
    translate([8.5,6.875,3.7]) cylinder(h=5,r1=2.2/2,r2=2.2/2,center=true);
    translate([8.5,-6.875,2.25]) cylinder(h=5,r1=5/2,r2=5/2,center=true);
    translate([8.5,-6.875,3.7]) cylinder(h=5,r1=2.2/2,r2=2.2/2,center=true);
    translate([21.5,0,2.25]) cube([4,10,5],center=true);
  }
}

module makeheaderadapter()
{
  difference()
  {
    translate([0,0,0]) cube([34.5,18.75,10.5],center=true);
    translate([0,0,1.25]) cube([45,14.2,8],center=true);
    translate([0,3.4,0]) cube([26,3,20],center=true);
  }
}

module roundedbox(l,d,h,r)
{
  difference()
  {
    difference()
    {
      difference()
      {
        difference()
        {
          cube([l,d,h],center=true);
          translate([-(l/2)+r,-(d/2)+r,0]){corner(r,h,0);};
        }
        translate([(l/2)-r,-(d/2)+r,0]){corner(r,h,90);};
      }
      translate([(l/2)-r,(d/2)-r,0]){corner(r,h,180);};
    }
    translate([-(l/2)+r,(d/2)-r,0]){corner(r,h,270);};
  }
}

module corner(r,h,ang)
{
  rotate([0,0,ang])
  {
    difference()
    {
      difference()
      {
        difference()
        {
          cylinder(h*2,r*2,r*2,center=true);
          cylinder(h*2,r,r,center=true);
        }
        translate([r*5,0,0]){cube([r*10,r*10,h*2],center=true);}
      }
      translate([0,r*5,0]){cube([r*10,r*10,h*2],center=true);}
    }
  }
}

