$fn=100;

include <boxes.scad>

draft=false;
d=3;
p1 = [13.0,18];
p2 = [113.0,18];
xmax=126;
wSpool=80;
dRing=22.15;

// Options to personalize
menu = 0; // 0 = all, 1 = main_holder, 2 = support, 3 = conical ring
use_support=true;
fancy_hole=true;

if (menu==0)
{
  main_holder();

  translate([120,100,0])
  rotate([90,0,0])
  support();
 
  translate([170,0,0])
  ring();

}
else if (menu==1)
  main_holder();
else if (menu==2)
  support();
else  if (menu==3)
  ring();

// =============================

module ring() //  )___( shaped 
{
 difference()
   {
       
   cylinder(h=7, d=dRing+4,center=true);

   color("blue")
   cylinder(h=7, d=dRing,center=true);

   translate([0,0,0])
   rotate_extrude(convexity = 1)
   translate([17, 0, 0])
   circle(r = 5, $fn = 100);
   }
}

module support()
{
  difference()
  {
    bar(20);      
    translate([0,-10,0])
    cube([120,10,120]);  // flatten bottom
  }
}

module disc(x, y, z)
{
    translate([x ,y + 5,z])    
    cylinder(r=5,h=2);
    translate([x-5,y,z])    
    cube([10,5,2]); 
}

module main_holder()
{
    difference()
    {
    union()
        {    
        cir1(p1[0]);
        cir1(p2[0]);
        moveRoundedBox([xmax,17,d], 1, true);       
        moveRoundedBox([xmax,3,7.25], 1, true);
        translate([10,10,0])
        difference()
        {
           cube([100,19.0,d]);  
           translate([53,98.0,0])
           cylinder(h=d,r=90.0);
        }
        axe(p1[0],p1[1]);
        axe(p2[0],p2[1]);
    }
  
  if (fancy_hole)      
  {
      steps=100;
      xx=40;
      xy0=[xx,14];
      xy1=[xmax/2,4];
      xy2=[xmax-xx,14];
      linear_extrude(height = 5) 
      minkowski()
      {
          BezConic(xy0, xy1, xy2, steps);
           circle(r=0.5,h=1);
      }
  }
    
  if (use_support)
    {
        bar(20);
        bar(xmax-26);   
    }
  }
}

// =============================

module bar(px)
{
  translate([px,-1,0])
  moveRoundedBox([6,7,100], 1, true);
}

module axe(px,py)
{    
  translate([px,py,3.0])
  cylinder(h=0.5,r=5.5);

  translate([px,py,3.25])
  cylinder(h=d+1,r=4.2);
}

module cir1(x)
{
translate([x,p1[1],0])
cylinder(h=d,r=13.0);
}

module hole(x=30)
{    
  translate([x,-1,7.2])
  rotate([0,90,90])
  cylinder(h=30,r=3);
}

module BezConic(p0,p1,p2,steps=5) {

	stepsize1 = (p1-p0)/steps;
	stepsize2 = (p2-p1)/steps;

	for (i=[0:steps-1]) {
		point1 = p0+(stepsize1*i);
		point2 = p1+(stepsize2*i);
		point3 = p0+(stepsize1*(i+1));
		point4 = p1+(stepsize2*(i+1));
      bpoint1 = point1+((point2-point1)*(i/steps));
		bpoint2 = point3+((point4-point3)*((i+1)/steps));
     	polygon(points=[bpoint1,bpoint2,p1]);
	}
}
