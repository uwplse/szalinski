e =  0.4;   // tolerance
w =  4.6;   // acrylic thickness 

t =  4.0;   // thick
l = 30.0;   // length 
h =  8.0;   // height
v =  4.0;   // depth


$fn = 100;
zero= 0.001;
o   =  2.0;  // curve


// параллелепипед со скругленными углами
module full_rounded_box(l, r, t, d)
{ scale([l/(l+d), r/(r+d), t/(t+d)]) 
    minkowski() { cube([l,r,t]);  translate([d/2,d/2,d/2]) sphere(d=d);}
}  


module stand()
{
   difference()
    { translate([-t,0,0])  full_rounded_box(l+2*t,w+e+2*t,h,o);
      translate([0,t,h-v+zero]) cube([l+2*zero,w+e,v]);
    }
  translate([l,0,-h]) full_rounded_box(t,w+e+2*t,2*h,o); 
    
}


rotate([180,0,0]) stand();
