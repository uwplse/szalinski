/*
    [CZ]
    Detske knofliky
    
    [ENG]
*/
$fn=30;
width=20.0;
height=2.0;
hole=2.0;
drill=3;


module flower_1()
{
    difference()
    {
        union()
        {
            hull()
            {
                rotate_extrude(convexity = 100)
                {
                    translate([(width/2), 0, 0]) circle(d = height/2);
                }
            }
          for(i=[0:60:300])
          {
              rotate([0,0,i])
              {
                  translate([0,((width)/4),height/4])
                  {
                        hull()
                        {
                            rotate_extrude(convexity = 100)
                            {
                                translate([((width/4)-(height/4)), 0, 0]) circle(d = height*0.666);
                            }
                        }
                  }
              }
          }
        }
        union()
        {
            translate([0,0,(height/6)]) cylinder(d1=(width/2), d2=((width+height)/2),h=(height/1));
            for(i=[0:(360/drill):360])
            {
                rotate([0,0,i])
                {
                    translate([0,((width/4)-(hole)),-(height/4)]) cylinder(d=hole,h=width);
                }
            }
        }
    }
}




translate([0,0,0]) flower_1();