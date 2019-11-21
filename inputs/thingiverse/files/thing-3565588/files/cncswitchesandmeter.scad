$fn=50;

//rotate([0,90,0]) makeboxshell();
//makeboxbase();
//makeboxleftend();
//makeboxrightend();
//makeboxleftbumper();
//makeboxrightbumper();
makeinsertxs();

module makeinsertxs()
{
  projection()
  {
    difference()
    {
      union()
      {
        translate([5,0,0]) roundedbox(50+2-2,80+1-2,40,20+1.5-1);
        translate([-10,0]) roundedbox(40+2-2,80+1-2,40,10+1.5-1);
      }
      rotate([0,0,-45]) translate([90+1.25-1,0,0]) cube([150,150,100],center=true);
    }
  }
}

module makeboxleftbumper()
{
  rotate([180,0,0]) makeboxbumper(-1);
}

module makeboxrightbumper()
{
  makeboxbumper(1);
}

module makeboxbumper(dir)
{
  render()
  {
    difference()
    {
      difference()
      {
        union()
        {
          translate([5,0,0]) roundedbox(50+9,80+9,12,20+4.5);
          translate([-10,0]) roundedbox(40+9,80+9,12,10+4.5);
        }
        rotate([0,0,-45]) translate([90+4.5,0,0]) cube([150,150,100],center=true);
      }
      translate([0,0,0])
      {
        difference()
        {
          union()
          {
            translate([5,0,0]) roundedbox(50-14,80-14,20,20-7);
            translate([-10,0,0]) roundedbox(40-14,80-14,20,10-7);
          }
          rotate([0,0,-45]) translate([90-7,0,0]) cube([150,150,100],center=true);
        }
      }
      translate([0,0,dir*3])
      {
        difference()
        {
          union()
          {
            translate([5,0,0]) roundedbox(50+2,80+1,12,20+1.5);
            translate([-10,0]) roundedbox(40+2,80+1,12,10+1.5);
          }
          rotate([0,0,-45]) translate([90+1.25,0,0]) cube([150,150,100],center=true);
        }
      }
    }
  }
}

module makeboxleftend()
{
  rotate([180,0,0]) makeboxend(-1);
}

module makeboxrightend()
{
  makeboxend(1);
}

module makeboxend(dir)
{
  render()
  {
    difference()
    {
      difference()
      {
        union()
        {
          translate([5,0,0]) roundedbox(50,80,6,20);
          translate([-10,0]) roundedbox(40,80,6,10);
        }
        rotate([0,0,-45]) translate([90,0,0]) cube([150,150,100],center=true);
      }
      translate([0,0,dir*3])
      {
        difference()
        {
          translate([0,0,0]) cube([100,100,6],center=true);
          difference()
          {
            union()
            {
              translate([5,0,0]) roundedbox(50-6,80-6,20,20-2.5);
              translate([-10,0,0]) roundedbox(40-6,80-6,20,10-2.5);
            }
            rotate([0,0,-45]) translate([90-3,0,0]) cube([150,150,100],center=true);
          }
        }
      }
      translate([0,0,dir*3])
      {
        difference()
        {
          union()
          {
            translate([5,0,0]) roundedbox(50-18,80-18,6,20-2.5-6);
            translate([-10,0,0]) roundedbox(40-18,80-18,6,10-2.5-6);
          }
          rotate([0,0,-45]) translate([90-9,0,0]) cube([150,150,100],center=true);
        }
      }
      translate([-5.5,37.5-2,dir*3]) cube([34+2,4,6],center=true);
      translate([-27.5+2,0,dir*3]) cube([4,60+2,6],center=true);
    }
  }
}

module makeboxbase()
{
  difference()
  {
    translate([0,0,0]) roundedbox(74-1,50-1,2.75,4.5);
    translate([-32.75,0,0]) cylinder(h=10,r1=1.5,r2=1.5,center=true);
    translate([32.75,0,0]) cylinder(h=10,r1=1.5,r2=1.5,center=true);
  }
}

module makeboxshell()
{
  difference()
  {
    union()
    {
      makebox();
      translate([0,37.5,-5.5]) cube([84,3,34],center=true);
      translate([0,0,-27.5]) cube([84,60,5],center=true);
    }
    translate([-45,0,0]) cube([6,100,100],center=true); // Meter cutout
    translate([45,0,0]) cube([6,100,100],center=true); // Meter cutout
    translate([0,0,-12]) rotate([45,0,0]) translate([0,0,20]) makepanelcutouts();
    translate([0,40,0]) makebackcutouts();
    translate([0,36,0]) makebacknutholes();
    translate([0,0,-30]) roundedbox(74,50,5,5);
    translate([0,0,-27]) roundedbox(58,44,10,5);
    translate([-32.75,0,-27]) cylinder(h=10,r1=1.5,r2=1.5,center=true);
    translate([32.75,0,-27]) cylinder(h=10,r1=1.5,r2=1.5,center=true);
  }
}

module makebox()
{
  render()
  {
    rotate([0,-90,0])
    {
      difference()
      {
        difference()
        {
          union()
          {
            translate([5,0,0]) roundedbox(50,80,90,20);
            translate([-10,0]) roundedbox(40,80,90,10);
          }
          rotate([0,0,-45]) translate([90,0,0]) cube([150,150,100],center=true);
        }
        difference()
        {
          union()
          {
            translate([5,0,0]) roundedbox(50-5,80-5,90-5,20-2.5);
            translate([-10,0,0]) roundedbox(40-5,80-5,90-5,10-2.5);
          }
          rotate([0,0,-45]) translate([90-3,0,0]) cube([150,150,100],center=true);
        }
      }
    }
  }
}

module makebacknutholes()
{
  render()
  {
    translate([-5,0,2]) rotate([90,0,0]) cylinder(h=5,r1=6.25,r2=6.25,$fn=6,center=true);
    translate([-5,0,-13]) rotate([90,0,0]) cylinder(h=5,r1=6.25,r2=6.25,$fn=6,center=true);
    translate([25,0,2]) rotate([90,0,0]) cylinder(h=5,r1=6.25,r2=6.25,$fn=6,center=true);
    translate([25,0,-13]) rotate([90,0,0]) cylinder(h=5,r1=6.25,r2=6.25,$fn=6,center=true);
    translate([-25,0,2]) rotate([90,0,0]) cylinder(h=5,r1=6.25,r2=6.25,$fn=6,center=true);
    translate([-25,0,-13]) rotate([90,0,0]) cylinder(h=5,r1=6.25,r2=6.25,$fn=6,center=true);
  }
}

module makebackcutouts()
{
  render()
  {
    translate([-5,0,2]) rotate([90,0,0]) cylinder(h=20,r1=4.5,r2=4.5,center=true);
    translate([-5,0,-13]) rotate([90,0,0]) cylinder(h=20,r1=4.5,r2=4.5,center=true);
    translate([25,0,2]) rotate([90,0,0]) cylinder(h=20,r1=4.5,r2=4.5,center=true);
    translate([25,0,-13]) rotate([90,0,0]) cylinder(h=20,r1=4.5,r2=4.5,center=true);
    translate([-25,0,2]) rotate([90,0,0]) cylinder(h=20,r1=4.5,r2=4.5,center=true);
    translate([-25,0,-13]) rotate([90,0,0]) cylinder(h=20,r1=4.5,r2=4.5,center=true);
  }
}

module makepanelcutouts()
{
  render()
  {
    translate([-10.75,12.75,0])
    {
      translate([0,2,0]) cube([46,27,10],center=true); // Meter cutout
      translate([38,-3.5+2,0]) cube([13,20,10],center=true); // Power switch cutout
      translate([-18,-32,0]) cube([10,14,10],center=true); // Fan switch cutout
      translate([39.5,-32,0]) cube([10,14,10],center=true); // LASER switch cutout
      translate([-18+19.17,-32,0]) cube([10,14,10],center=true); // Spindle switch cutout
      translate([-18+38.33,-32,0]) cube([10,14,10],center=true); // Lights switch cutout
    }
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


