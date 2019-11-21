//0 = female, 1 = male
road1 = 1;
road2 = 0;
road3 = 1;
road4 = 0;

//Number of steps of the corner
corner_fn = 6;

//Width of the track, just leave it
//It helps to center the connectors
w = 78.8;

$fn = 18;

module connector(m)
{
    if(m==0)
    {
      import("vtechsmartwheels_female.stl", convexity=3);
    }
    
    if(m==1)
    {
      import("vtechsmartwheels_male.stl", convexity=3);
    }
}

module road1piece()
{
    translate([-w/2,0,0])
    connector(road1);
}

module road2piece()
{
  translate([0,w/2,0])
  rotate([0,0,-90])
    connector(road2);
}

module road3piece()
{
  translate([w/2,0,0])
  rotate([0,0,180])
    connector(road3);
}

module road4piece()
{
  mirror([0,1,0])
  translate([0,w/2,0])
  rotate([0,0,-90])
    connector(road4);
}

module border()
{
  difference()
  {
    hull()
    {
      sphere(r=1);
      
      translate([0,0,15.5])
      sphere(r=1);

      for(r=[0:(90/corner_fn):90])
      {
        translate([-cos(r) * 6, sin(r) * 6,0])
        {
          sphere(r=1);
          
          translate([0,0,15.5])
          sphere(r=1);
        }
      }
    }

    translate([-10,-10,-4])
    cube([20,20,4]);

    translate([0,-20,-4])
    cube([20,20,24]);
  }
}

module road()
{
  difference()
  {
    translate([0,0,8/2])
    cube([w,w,8],center=true);

    translate([0,0,8-6.5])
    difference()
    {
      co = 56.3/2;
      cylinder(r=co,h=6.6,$fn=80);
      cylinder(r=co-2,h=6.6,$fn=80);
    }

    translate([0,0,8-6.5])
    difference()
    {
      ci = 76.2/2;
      cylinder(r=ci,h=6.6,$fn=80);
      cylinder(r=ci-2,h=6.6,$fn=80);
    }
  }
  
  translate([(w/2),(-w/2),0])
  border();

  mirror([1,0,0])
  translate([(w/2),(-w/2),0])
  border();

  mirror([0,1,0])
  translate([(w/2),(-w/2),0])
  border();

  mirror([0,1,0])
  mirror([1,0,0])
  translate([(w/2),(-w/2),0])
  border();
}


color("Orange")
{
  road1piece();
  road2piece();
  road3piece();
  road4piece();

  road();
}