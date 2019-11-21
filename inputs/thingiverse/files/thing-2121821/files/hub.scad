d1 = 51.0;     // inner diameter
d2 = 55.0;     // outer diameter
d3 = 16.18;    // inner diametr of pipe
t  =  2.38;    // thick of pipe
d4 = d3+2*t;   // outer diameter of pipe

$fn=300;
zero=0.001;

h  = 24.0;     // overall heigth
h1 =  5.0;
h2 =  2.0;
h3 =  3.0;
h4 = h-h1-h2-h3;

n  = 6;                  // quantity of holes
angle=(n==0)?720:360/n;  // angle between holes
r  = (d1+d4)/4;          // radius for holes
dd = (n==0)?0:min( 2*3.1415*r/n-t ,(d2-d4)/2-2*t); // diameter of holes


module hub()
{  difference()
   {  union()
      {                            cylinder(d=d1,         h=h1);
         translate([0,0,h1])       cylinder(d1=d1, d2=d2, h=h2);
         translate([0,0,h1+h2])    cylinder(d=d2,         h=h3);    
         translate([0,0,h1+h2+h3]) cylinder(d=d4,         h=h4);
      }
      translate([0,0,-zero]) cylinder(d=d3, h=h+2*zero);
      for(a=[30:angle:390-angle])
         translate([sin(a)*r,cos(a)*r,-zero]) cylinder(d=dd, h=h+2*zero);
   }
}

hub();