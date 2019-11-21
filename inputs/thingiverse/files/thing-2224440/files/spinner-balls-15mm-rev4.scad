dBearing = 16.05;  // 688 bearing
hBearing =  4.0;
dBall    = 15.0;   // balls 15mm

thick    =  2;                   
nBalls   =  3;    // quantity of balls

// spiral
loops    = 1.4;  
x        = -9.5;
y        = 90;
k        = 12;

// placement fo balls
rBalls   = 28;    // radius
aBalls   =60;    // angle

angle    = 360/nBalls;  
$fn      = 150;
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
  
      cylinder(d=dBearing, h=hBearing+2*zero,center=true); 
  
      for(a=[aBalls:angle:360-angle+aBalls])   
         translate([rBalls*sin(a), rBalls*cos(a), 0]) sphere(d=dBall);
   } 
}


module spiral(begin, thick, gap, loops)
{
  step        = thick + gap;
  start_angle = 0.25;
  end_angle   = loops;

  function fspiral( a, g) = let(r = (begin + g + step*a))  [r * sin(a*360), r * cos(a*360)];

  inner = [for(a = [1.25 : 1/360: loops+1])  fspiral(a-1,gap) ];

  outer = [for(a = [loops+1: -1/360 : 1.25]) fspiral(a,0) ];

  polygon(concat(inner, outer));
  
}