
dBearing = 22.1;  // 608
hBearing =  7.0;
dBall    = 12.9;   // balls 1/2" = 12.7mm
v        = 0.2;
thick    =  1.3;                   
nBalls   =  5;    // quantity of balls

// spiral
start_angle = 1.78;
loops    = 1.9;  
x        = 12;
y        =-20;
k        = 7;

// placement for balls
rBalls   = 31.5;    // radius
aBalls   = 42.5;    // angle

angle    = 360/nBalls;  
$fn      = 100;
zero     =  0.001;





spinner();


module spinner()
{  difference()
   {  union()
      {  intersection()
         {  cylinder(d=dBearing+2*thick, h=hBearing, center=true);
            sphere(d=dBearing+2*thick);
         }

      for(a=[0:angle:360-angle])   
         rotate([0,0,a]) translate([x*sin(y),x*cos(y),0])  
            translate([0,0,-hBearing/2]) linear_extrude(height=hBearing)
                spiral(0, thick, k-thick, loops);
      
      for(a=[aBalls:angle:360-angle+aBalls])   
         translate([rBalls*sin(a), rBalls*cos(a), 0]) 
            intersection()
            {  cylinder(d=dBall+2*thick, h=hBearing, center=true);
               sphere(d=dBall+2*thick);
            }
      }
  
      cylinder(d=dBearing,h=hBearing+2*zero,center=true); 
  
      for(a=[aBalls:angle:360-angle+aBalls])   
         translate([rBalls*sin(a), rBalls*cos(a), 0])
            {sphere(d=dBall);
             cylinder(d=dBall-v,h=hBearing+2*zero,center=true);   
            }
   } 
}


module spiral(begin, thick, gap, loops)
{
  step        = thick + gap;
  end_angle   = loops;

  function fspiral( a, g) = let(r = (begin + g + step*a))  [r * sin(a*360), r * cos(a*360)];

  inner = [for(a = [start_angle : 1/360: loops+1])  fspiral(a-1,gap) ];

  outer = [for(a = [loops+1: -1/360 : start_angle]) fspiral(a,0) ];

  polygon(concat(inner, outer));
  
}