$fn=25;

//maketop();
//makelcdbezel();
//makedialbase();
//makedialtop();
makebottom();

module makebottom()
{
  render() difference()
  {
    render() union()
    {
      render() difference()
      {
        translate([0,-0.5,0]) roundedbox(55+4+6,96+3+6,14,10);
        translate([0,-0.5,3]) roundedbox(55+4,96+3,14,7);
      }
      translate([32-10-4,52.5-0.5-5-21,-5.5+1.9]) cube([26,16,2],center=true);
      translate([-24-1.5,(96/2)-0.5-1.9,0]) rotate([0,0,45]) cylinder(h=14,r1=12.8/2,r2=12.8/2,$fn=6,center=true);
      translate([24+1.5,(96/2)-0.5-1.9,0]) rotate([0,0,-45]) cylinder(h=14,r1=12.8/2,r2=12.8/2,$fn=6,center=true);
      translate([-24-1.5,-(96/2)-0.5+1.9,0]) rotate([0,0,15]) cylinder(h=14,r1=12.8/2,r2=12.8/2,$fn=6,center=true);
      translate([24+1.5,-(96/2)-0.5+1.9,0]) rotate([0,0,-15]) cylinder(h=14,r1=12.8/2,r2=12.8/2,$fn=6,center=true);
    }
    translate([-24-1.5,(96/2)-0.5-1.9,0]) cylinder(h=20,r1=3.5/2,r2=3.5/2,$fn=15,center=true);
    translate([24+1.5,(96/2)-0.5-1.9,0]) cylinder(h=20,r1=3.5/2,r2=3.5/2,$fn=15,center=true);
    translate([-24-1.5,-(96/2)-0.5+1.9,0]) cylinder(h=20,r1=3.5/2,r2=3.5/2,$fn=15,center=true);
    translate([24+1.5,-(96/2)-0.5+1.9,0]) cylinder(h=20,r1=3.5/2,r2=3.5/2,$fn=15,center=true);
    render() difference()
    {
      translate([0,-0.5,0]) roundedbox(100+55+4+6,100+96+3+6,18,10);
      translate([0,-0.5,0]) roundedbox(55+4+6,96+3+6,100,10);
    }
    translate([32-10-4,52.5-0.5-5-21,0]) cube([20,10,20],center=true);
  }
}

module makedialtop()
{
  union()
  {
    difference()
    {
      translate([0,0,0]) cylinder(h=7,r1=37/2,r2=35/2,$fn=50,center=true);
      translate([0,0,-3.5]) cylinder(h=6,r1=26.5/2,r2=26.5/2,$fn=50,center=true);
      translate([0,0,3.5]) cylinder(h=4,r1=31/2,r2=31/2,$fn=50,center=true);
      for(c=[0:20])
        rotate([0,0,c*(360/20)])
          translate([-19.75,0,0])
            rotate([0,15,0])
              cylinder(h=30,r1=4/2,r2=4/2,$fn=25,center=true);
    }
    translate([0,0,3.5-1.1]) cylinder(h=2.1,r1=5/2,r2=5/2,$fn=25,center=true);
  }
}

module makedialbase()
{
  rotate([180,0,0])
  {
    difference()
    {
      union()
      {
        translate([0,0,1]) cylinder(h=12,r1=18/2,r2=18/2,$fn=50,center=true);
        translate([0,0,1+6-1]) cylinder(h=2,r1=26/2,r2=26/2,$fn=50,center=true);
      }
      difference()
      {
        translate([0,0,0]) cylinder(h=20,r1=6.5/2,r2=6.5/2,center=true);
        translate([0,-(6.5/2)-0.5,10-1]) cube([10,4,20],center=true);
      }
    }
  }
}

module makelcdbezel()
{
  rotate([0,180,0])
  {
    difference()
    {
      translate([0,0,0]) roundedbox(27+6,15+6,1.5,2);
      translate([0,0,0]) cube([27,15,50],center=true);
      translate([0,0,-1]) cube([27+1.5,15+1.5,1.5],center=true);
    }
  }
}

module maketop()
{
  difference()
  {
    union()
    {
      difference()
      {
        translate([0,-0.5,0]) roundedbox(55+4+6,96+3+6,18,10);
        translate([0,-0.5,3]) roundedbox(55+4,96+3,18,7);
      }
      translate([0,-(96/2)+48-26.5,-9+5+1.5]) cylinder(h=10+3,r1=26/2,r2=26/2,$fn=25,center=true);
      translate([-14,-40,-9+5+1.5]) cube([5,5,10+3],center=true);
      translate([14,-40,-9+5+1.5]) cube([5,5,10+3],center=true);
      translate([-22,-18,-9+5+1.5]) cube([5,5,10+3],center=true);
      translate([22,-18,-9+5+1.5]) cube([5,5,10+3],center=true);
      translate([0,42,-9+1.5+1.5]) cube([20,5,3+3],center=true);
      translate([-24-1.5,(96/2)-0.5-1.9,0]) rotate([0,0,45]) cylinder(h=18,r1=12.8/2,r2=12.8/2,$fn=6,center=true);
      translate([24+1.5,(96/2)-0.5-1.9,0]) rotate([0,0,-45]) cylinder(h=18,r1=12.8/2,r2=12.8/2,$fn=6,center=true);
      translate([-24-1.5,-(96/2)-0.5+1.9,0]) rotate([0,0,15]) cylinder(h=18,r1=12.8/2,r2=12.8/2,$fn=6,center=true);
      translate([24+1.5,-(96/2)-0.5+1.9,0]) rotate([0,0,-15]) cylinder(h=18,r1=12.8/2,r2=12.8/2,$fn=6,center=true);
    }
    translate([0,0,0]) rotate([0,180,0]) controls();
    translate([-24-1.5,(96/2)-0.5-1.9,18-3.5]) rotate([0,0,45]) cylinder(h=18,r1=7/2,r2=7/2,$fn=6,center=true);
    translate([24+1.5,(96/2)-0.5-1.9,18-3.5]) rotate([0,0,-45]) cylinder(h=18,r1=7/2,r2=7/2,$fn=6,center=true);
    translate([-24-1.5,-(96/2)-0.5+1.9,18-3.5]) rotate([0,0,15]) cylinder(h=18,r1=7/2,r2=7/2,$fn=6,center=true);
    translate([24+1.5,-(96/2)-0.5+1.9,18-3.5]) rotate([0,0,-15]) cylinder(h=18,r1=7/2,r2=7/2,$fn=6,center=true);
    translate([-24-1.5,(96/2)-0.5-1.9,5]) cylinder(h=18,r1=3.5/2,r2=3.5/2,$fn=15,center=true);
    translate([24+1.5,(96/2)-0.5-1.9,5]) cylinder(h=18,r1=3.5/2,r2=3.5/2,$fn=15,center=true);
    translate([-24-1.5,-(96/2)-0.5+1.9,5]) cylinder(h=18,r1=3.5/2,r2=3.5/2,$fn=15,center=true);
    translate([24+1.5,-(96/2)-0.5+1.9,5]) cylinder(h=18,r1=3.5/2,r2=3.5/2,$fn=15,center=true);
    difference()
    {
      translate([0,-0.5,0]) roundedbox(100+55+4+6,100+96+3+6,18,10);
      translate([0,-0.5,0]) roundedbox(55+4+6,96+3+6,100,10);
    }
  }
}

module controls()
{
  translate([-(55/2)+5+(27/2)+4.5-1,-(96/2)+65.5+(15/2)-0.5,0]) cube([27+1,15+1,50],center=true);
  translate([(55/2)-9.5,-(96/2)+79,0]) cylinder(h=50,r1=8/2,r2=8/2,center=true);
  translate([(55/2)-9.5,-(96/2)+64,0]) cylinder(h=50,r1=8/2,r2=8/2,center=true);
  translate([-15.5,-(96/2)+48,0]) cylinder(h=50,r1=8/2,r2=8/2,center=true);
  translate([0,-(96/2)+48,0]) cylinder(h=50,r1=8/2,r2=8/2,center=true);
  translate([15.5,-(96/2)+48,0]) cylinder(h=50,r1=8/2,r2=8/2,center=true);
  translate([0,-(96/2)+48-26.5,0]) cylinder(h=50,r1=20/2,r2=20/2,$fn=25,center=true);
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


