//0 = female, 1 = male
start = 1;
end = 0;

//The angle of the corner, between 0 and 90
angle = 45;

//Number of steps of the corner
corner_fn = 18;

//Width of the track, just leave it
//It helps to center the connectors
w = 78.8;

$fn = 12;

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

module startpiece()
{
    translate([0,-w/2,0])
    connector(start);
}

module endpiece()
{
  rotate([0,0,angle])
  translate([0,-w/2,0])
  rotate([0,0,180])
    connector(end);
}

module border(offset=0)
{
	borderradius=1.0;
  for(t=[(angle/corner_fn):(angle/corner_fn):angle])
  {
    t0 = t - (angle/corner_fn);
    hull()
    {
      translate([sin(t0) * (offset), -cos(t0) * (offset),0])
      {
        sphere(r=borderradius);
        
        translate([0,0,15.5])
        sphere(r=borderradius);
      }
      
      translate([sin(t) * (offset), -cos(t) * (offset),0])
      {
        sphere(r=borderradius);
        
        translate([0,0,15.5])
        sphere(r=borderradius);
      }
    }
    
    hull()
    {
      translate([sin(t0) * (offset + 5), -cos(t0) * (offset + 5),0])
      {
        sphere(r=borderradius);
        
        translate([0,0,15.5])
        sphere(r=borderradius);
      }

      translate([sin(t) * (offset + 5), -cos(t) * (offset + 5),0])
      {
        sphere(r=borderradius);
        
        translate([0,0,15.5])
        sphere(r=borderradius);
      }
    }

    hull()
    {
      translate([sin(t0) * (offset), -cos(t0) * (offset),0])
      {
        translate([0,0,15.5])
        sphere(r=borderradius);
      }
      
      translate([sin(t) * (offset), -cos(t) * (offset),0])
      {
        translate([0,0,15.5])
        sphere(r=borderradius);
      }

      translate([sin(t0) * (offset + 5), -cos(t0) * (offset + 5),0])
      {
        translate([0,0,15.5])
        sphere(r=borderradius);
      }

      translate([sin(t) * (offset + 5), -cos(t) * (offset + 5),0])
      {
        translate([0,0,15.5])
        sphere(r=borderradius);
      }
    }
  }
}

module road()
{
	union()
	{
	  hull()
	  {
		translate([0,-1,0])
		cube([1,1,8]);
		
		for(r=[0:angle/corner_fn:angle])
		{
		  translate([sin(r) * (w-5), -cos(r) * (w-5),0])
		  cube([1,1,8]);
		}
	  }
	  border(w - 6);
  
	  border(1);
	}  
  
}


color("Blue")
{
	union()
	{
	  startpiece();
	  endpiece();
	  difference()
	  {
		  road();
		
		translate([-10,-100,-1])
		cube([10,100,30]);

		translate([-5,-w,-5])
		cube([w + 5,w + 5,5]);
	  }
  }
}