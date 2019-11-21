

$fn=36;
Steps=7;
Type=2;


module Solder(Steps,Type)
  translate([0,0,0])
  {
    if(Type==0)
    color("Silver")
    hull()
      {
        translate([0,0,0.8])
          rotate([0,0,0])
            scale([1,1,0.3])
              sphere(d=2);
        translate([2.54*(Steps-1),0,0.8])
          rotate([0,0,0])
            scale([1,1,0.3])
              sphere(d=2);
      }

  if(Type==1)
  for(a=[0:1:Steps-1])
    {
    color("Silver")
      translate([2.54*a,0,0])
        rotate([0,0,0])
          sphere(d=2);
    }

  if(Type==2)
  {
  for(a=[0:1:Steps-1])
    {
    color("Silver")
      translate([2.54*a,0,0.8])
        rotate([0,0,0])
          scale([1,1,0.3])
          sphere(d=2);
    }
  
  color("Silver")
    hull()
      {
        translate([0,0,0.8])
          rotate([0,0,0])
            scale([1,1,0.4])
              sphere(d=0.5);
        translate([2.54*(Steps-1),0,0.8])
          rotate([0,0,0])
            scale([1,1,0.4])
              sphere(d=0.5);
      }
  }

    }

                    
Solder(Steps,Type);


