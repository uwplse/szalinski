//use <./sc.scad>
t=2;
w1=40;
w2=15;
h1=15;
h2=16;
d1=20;
d2=80;
D(){hull(){
    Cu(w1+2*t,d2,h1+2*t);Tz(h2-h1/2)Cu(w2+t,d2,h1+2*t);}
    Ty(t)hull(){Cu(w1,d2,h1);Tz(h2-h1/2)Cu(w2,d2,h1);}
    Ty(d1)Cu(w1+3*t,d2-h1,h2+h1/2);
    T(0,t,-h1/2-t)hull(){Cu(w1-3*t,d2,0.001);Tz(t)Cu(w1,d2,0.001);}
    }
    
    // ShortCuts.scad 
// Autor: Rudolf Huttary, Berlin 2015
//
$fn = 100; 


//show_examples(); 

module show_examples()
	place_in_rect(30, 30)
	{
		Cy(h = 10); 
		CyH(h = 10); 
		CyH(h = 10, w = 30); 
		CyS(h = 10); 
		CyS(h = 10, w1 = 25, w2 = 75); 
		Cu(10); 
		Ri(h = 10); 
		RiH(h = 10); 
		RiS(h = 10, w1 = 10); 
		RiS(h = 10, w1 = 30, w2 = 300); 
		Sp(); 
		SpH(10, 30, 30); 
	}



module help()
{
echo("==============="); 
echo("help(): shows this help"); 
echo("show_examples(): shows some examples"); 
echo("place_in_rect(): places children objects in grid"); 
echo("Transformations:"); 
echo(" transform :  T(x=0, y=0, z=0), Tx(x=0) , Ty(y=0), Tz(z=0)"); 
echo(" rotate :  R(x=0, y=0, z=0), Rx(x=0) , Ry(y=0), Rz(z=0)"); 
echo(" scale :  S(x=1, y=1, z=1), Sx(x=1) , Sy(y=1), Sz(z=1)"); 
echo("Logical"); 
echo(" difference :  D()"); 
echo(" union :  U()"); 
echo(" intersection : *missing*"); 
echo("Primitives"); 
echo(" circle :  Ci(r=10)"); 
echo(" circle_half :  CiH(r=10, w=0)")
echo(" circle_segment :  CiS(r=10, w1=0, w2=90)")
echo(" square :  Sq(x=10, y=0, center=true))"); 
echo(" cylinder :  Cy(r=10, h=1, center=true)"); 
echo(" cylinder_half :  CyH(r=10, w=0)")
echo(" cylinder_segment: CyS(r=10, h=1, w1=0, w2=90,center=true)"); 
echo(" cylinder_segment: Pie(r=10, h=1, w1=0, w2=90,center=true)"); 
echo(" cube :  Cu(x=10, y=0, z=10, center=true)"); 
echo(" ring :  Ri(R=10, r=5, h=1, center=true)"); 
echo(" ring_half :  RiH(R=10, r=5, h=1, w=0 center=true)"); 
echo(" ring_segment :  RiS(R=10, r=5, h=1, w1=0, w2=90, center=true)"); 
echo(" sphere:  Sp(r=10))"); 
echo(" sphere_half:  SpH(r=10, w1 = 0, w2 = 0))"); 
echo("==============="); 
}


// Euclidean Transformations

module T(x=0, y=0, z=0){translate([x, y, z])children(); }
module Tx(x) { translate([x, 0, 0])children(); }
module Ty(y) { translate([0, y, 0])children(); }
module Tz(z) { translate([0, 0, z])children(); }


module R(x=0, y=0, z=0){rotate([x, y, z]) children();}
module Rx(x=90){rotate([x, 0, 0]) children();}
module Ry(y=90){rotate([0, y, 0]) children();}
module Rz(z=90){rotate([0, 0, z]) children();}

module S(x=1, y=1, z=1){scale([x, y, z]) children();}
module Sx(x=1){scale([x, 1, 1]) children();}
module Sy(y=1){scale([1, y, 1]) children();}
module Sz(z=1){scale([1, 1, z]) children();}


module D() difference(){children(0); children([1:$children-1]);}
module U() children([0:$children-1]);
// module I() intersection()children([0:$children-1]); // does not work for some reason


// primitives - 2D

module Sq(x =10, y = 0, center = true)
{
   if(y==0)
		square([x, x], center = center); 
	else
		square([x, y], center = center); 
}
module Ci(r = 10)
{
	circle(r = r); 
}

// derived primitives - 2d
module CiH(r = 10, w = 0)
  circle_half(r, w); 

module CiS(r = 10, w1 = 0, w2 = 90)
  circle_segment(r, w1, w2); 


// primitives - 3d
module Cy(r = 10, h = 1, center = true)
{
	cylinder(r = r, h = h, center = center); 
}
module Cu(x = 10, y = 0, z = 10, center = true)
{
  if (y==0)
	cube([x, x, x], center = center); 
  else
	cube([x, y, z], center = center); 
}

// derived primitives - 3d
module CyH(r = 10, h = 1, w = 0, center = true)
  cylinder_half(r, h, w, center); 

module CyS(r = 10, h = 1, w1 = 0, w2 = 90, center = true)
  cylinder_segment(r, h, w1, w2, center); 

module Ri(R = 10, r = 5, h = 1, center = true)
  ring(R, r, h, center); 

module RiS(R = 10, r = 5, h = 1, w1 = 0, w2 = 90, center = true)
   ring_segment(R, r, h, w1, w2, center); 

module RiH(r1 = 10, r2, h = 1, w = 0, center = true)
   ring_half(r1, r2, h, w, center); 
module Pie(r = 10, h = 1, w1 = 0, w2 = 90, center = true)
  cylinder_segment(r, h, w1, w2, center);  
module Sp(r = 10)
  sphere(r); 
module SpH(r = 10, w1 = 0, w2 = 0)
  sphere_half(r, w1, w2); 
module SpS(r = 10, w1 = 0, w2 = 90, w3 = 90)
  sphere_segment(r, w1, w2); 




// clear text definitions
module circle_half(r = 10, w = 0)
{
	difference()
	{
		circle(r); 
     rotate([0, 0, w-90])
     translate([0, -r])
		square([r, 2*r], center = false); 
	}
}

module circle_segment(r = 10, w1 = 0, w2 = 90)
{
  W2 = (w1>w2)?w2+360:w2; 
  if (W2-w1 < 180)
    intersection()
		{
       circle_half(r, w1); 
       circle_half(r, W2-180); 
 		}
	else
    union()
		{
       circle_half(r, w1); 
       circle_half(r, W2-180); 
 		}
}

module cylinder_half(r = 10, h = 1, w = 0, center = true)
{
  linear_extrude(height = h, center = center)
  circle_half(r, w); 
} 

module cylinder_segment(r = 10, h = 1, w1 = 0, w2 = 90, center = true)
{
  linear_extrude(height = h, center = center)
  circle_segment(r, w1, w2); 
} 

module ring(R = 10, r = 5, h = 1, center = true)
{
	difference()
	{
	cylinder(r = R, h = h, center = center); 
   translate([0, 0, -2*h])
	cylinder(r = r, h = 4*h, center = false); 
	}
}

module ring_half(R = 10, r = 5, h = 1, w = 0, center = true)
{
	difference()
	{
		ring(R, r, h, center); 
     rotate([0, 0, w])
     translate([0, -R/2, 0])
		cube([2*R, R, 3*h], center = true); 
	}
}

module ring_segment(R = 10, r = 5, h = 1, w1 = 0, w2 = 90, center = true)
{
  W2 = (w1>w2)?w2+360:w2; 
  if (W2-w1 < 180)
    intersection()
		{
       ring_half(R, r, h, w1, center); 
       ring_half(R, r, h, W2-180, center); 
 		}
	else
    union()
		{
       ring_half(R, r, h, w1, center); 
       ring_half(R, r, h, W2-180, center); 
 		}
}


module sphere_half(r = 10, w1 = 0, w2 = 0)
{  
	difference()
	{
   	sphere(r); 
      rotate([-w1, -w2, 0])
     	translate([0, 0, r])
		cube(2*r, 2*r, r, center = true); 
	}

}


// additional code
module place_in_rect(dx =20, dy=20)
{
  cols = ceil(sqrt($children)); 
  rows = floor(sqrt($children)); 
  for(i = [0:$children-1])
	{ 
	  T(dx*(-cols/2+(i%cols)+.5), dy*(rows/2-floor(i/cols)-.5))
		 children(i); 
	}
}

