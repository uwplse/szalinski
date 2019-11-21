
// title: parametric ballpocket
// license: public domain


/* [parameters] */

// inner base radius diameter
d = 16.5;
r = d/2;

// wall thickness
t = 1.6;

//additional hight in units of base radius
f = 1;
dh = r*f;

// opening angle
alpha = 20;
dr = dh * sin(alpha);

cut = "no"; // [no,yes]

/* [resolution] */

// maximal angle per segment (3 good & slow)
$fa = 12;
// minimal segment length (0.15 good slow)
$fs = 0.6;

eps = 0.05*1;


intersection()
{
difference()
{
  // outer cylinder
  //translate([0,0,0])
  //cylinder(r1=r+t,r2=r+t+dr,h=r+t+dh,center=false);

  hull()
  {
    translate([0,0,r+t-(r+t)*(1-1/sqrt(2))])
    sphere(r+t);
    translate([0,0,r+t+dh])
    sphere(r+dr+t);  
  }

  hull()
  {
    translate([0,0,r+t])
    sphere(r);
    translate([0,0,r+t+dh])
    sphere(r+dr);  
  }
  //translate([0,0,r+t])
  //cylinder(r1=r,r2=r+dr,h=r+t+dh+eps,center=false);

  if(cut == "yes")
  {  translate([0,0,-1]) cube([100,100,100]); }
}
  translate([0,0,(r+t+dh)/2])
  cube([100,100,r+t+dh],center=true);

}