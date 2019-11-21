$fn=30;
width=20.0;
height=2.0;
hole=2.0;


module flower_2()
{
    difference()
    {
        union()
        {
          for(i=[0:72:360])
          {
              rotate([0,0,i])
              {
                  translate([0,((width)/4),height/2])
                  {
                        //hull()
                        {
                            rotate_extrude(convexity = 100)
                            {
                                translate([((width/4)-(height/4)), 0, 0]) circle(d = height);
                            }
                        }
                  }
              }
          }
          for(i=[36:72:360])
          {
              rotate([0,0,i])
              {
                  hull()
                  {
                        translate([0,(width*0.38),height/2])
                        {
                            sphere(d=height);
                        }
                        translate([0,0,height/2]) 
                        {
                            rotate_extrude(convexity = 100)
                            {
                                translate([(width*0.25),0,0]) circle(d = height);
                            }
                        }
                  }
              }
          }
        }
        union()
        {
            translate([0,0,(height/2)])
            {
                for(i=[36:72:360])
                {
                    rotate([0,0,i])
                    {
                        translate([0,((width/4)-(hole)),-(height)]) cylinder(d=hole,h=width);
                        hull()
                        {
                              translate([0,(width*0.3),height/2])
                              {
                                  sphere(d=height*0.6);
                              }
                              translate([0,0,height/2]) 
                              {
                                  rotate_extrude(convexity = 100)
                                  {
                                      translate([(width*0.1),0,0]) circle(d = height);
                                  }
                              }
                        }
                    }
                }
            }
       }
   }
}




translate([0,0,0]) flower_2();