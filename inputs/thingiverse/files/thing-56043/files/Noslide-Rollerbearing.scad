/*
2013 Lukas Süss aka mechadense
Nonsliding Roller Bearing
license: CC-By


Thingiverse Description:

This is a roller bearing that can be printed in one piece.

The special thing about it:
It has less sliding friction than a roller bearing WITH cage.
This is archived through the central rolls.
Those let the inner and outer rolls roll on rolls.
This bearing can can take radial and axial force. 

It should run under (axial) load so that rolling is ensured !!
A preload would work to but than a zero clearnce print with post assembly is required.
(split the ring or better the center piece in two for that)

A very little unavoidable friction occurs at the slanted top & bottom retainers but this should'nt hurt.
(gears also have a tiny friction component)

It was inspired by this thing:
http://www.thingiverse.com/thing:55515
Which was inspired by emmets popular gear bearing.
http://www.thingiverse.com/thing:53451


Thingiverse Instructions:

There are a lot of parameter combinations that do not work.
Change one at a time.
Low roller nubers lead to the necessity of high bearing diameters.
High roller numers make the rollers small and lead to the necessity of high center piece diameters
( 8 to 12 rollers are good I think) 


//#################################
//all main radii starting from center: rra; rr1; rr2; rr3; rrb; rout
*/

// for a dual color print
part = "whole"; // [whole,mainrolls,rest]

//#################
function p2(x) = pow(x,2); // shorthand
function p3(x) = pow(x,3); // shorthand
function p4(x) = pow(x,4); // shorthand
pi = 3.141592653*1;
phi = 1.61803*1;


// clearing
clr = 0.15;
// resolution: minimal segment length 
$fs = 0.15; 
// resolution: maximal segment angle
$fa = 3; 
eps = 0.05*1;
//##################

// number of rollers (when decreasing increase fgap)
nroller = 8; 

alpha = 360/nroller; a = alpha; 
sa = sin(a); ca = cos(a);
ca2 = cos(a/2); sa2 = sin(a/2);


// outermost diameter of bearing (choose big enough for the rollers)
dout = 64; 
rout = dout/2;
// diameter of the inner piece
dda = 20; 
rra = dda/2;
// height of bearing
h0 = 12; 
// hexagon width
w = 6.7; 

// determines gap between innermost roller shell good: 1.414
f = 1.414; 

fact = (1/2*f) * 2*pi/(2*nroller);
// r1 = 2*(rra + r1)*pi / (2*nroller)*f; ==>
r1 = rra*fact/(1-fact);
rr1 = rra+r1; // starting point for calculation

// !!! gap increasement factor (choose so that inner & outer rollers have similar size)
fgap = 1.8; 
gap1 = 2*(rra+r1)*sin(alpha/2)-2*r1;
gap2 = gap1*fgap; 
gap3 = gap2*fgap;

//echo("r1",r1);
//echo("rr1",rr1);
//echo("gap1 between r1 rollers is:",gap1);

//----------------------------------------------------------------------------------------

// approach: choose the next radius such that the gap between r2 rolls is choosable.
// the placing radius of second roller row calculates to: (make sketch)
// rr2 = [(rra+r1)*cos(alpha/2)] + sqrt[(r1+r2)^2-((rra+r1)*sin(alpha/2))^2] // ****
// We demand that the gap between the r2 rollers should be the same as the one between the r1 ones:
// r2 + gap/2 = rr2*sin(alpha/2);
// solve for r2 in a Comp.Alg.Syst. =>

r2 = 1/2*1/(p2(sa2)-1)*(-sqrt(p2(gap2*sa2)-4*gap2*r1*p2(sa2)-2*gap2*rr1*sa*p2(sa2)+4*p2(r1*sa2)+4*r1*rr1*sa*p2(sa2))-2*r1*p2(sa2)-2*rr1*sa2*ca2+gap2);
rr2 = (rr1*cos(alpha/2)) + sqrt(p2(r1+r2)-p2(rr1*sin(alpha/2))); // ****

r3 = 1/2*1/(p2(sa2)-1)*(-sqrt(p2(gap3*sa2)-4*gap3*r2*p2(sa2)-2*gap3*rr2*sa*p2(sa2)+4*p2(r2*sa2)+4*r2*rr2*sa*p2(sa2))-2*r2*p2(sa2)-2*rr2*sa2*ca2+gap3);
rr3 = (rr2*cos(alpha/2)) + sqrt(p2(r2+r3)-p2(rr2*sin(alpha/2))); // ****

rrb = rr3+r3; // outer rolling diameter

// cut a quater away
debug = false; 



//########################################################

if(debug==true)
{
  difference()
  {
    whole();
    translate([0,0,-50])
    cube([100,100,100]);
    #translate([0,50,50]) cune([10,10,10]);
  }
} 
else 
{ 
  whole(); 
}



module whole()
{
  if(part == "whole" || part == "mainrolls")
  {
    color("grey")
    for(i=[0:nroller-1]) // inner rollers
    {
      rotate(alpha*i,[0,0,1])
      translate([rr1,0,0]) //cylinder(r=r1,h=h0);
        cyl(r1,h0,true,clr/2);
    }
    color("grey")
    for(i=[0:nroller-1]) // outer rollers
    {
      rotate(alpha*i,[0,0,1])
      translate([rr3,0,0]) //cylinder(r=r3,h=h0);
        cyl(r3,h0,true,clr/2);
    }
  }

  if(part == "whole" || part == "rest")
  {
    for(i=[0:nroller-1]) // middle rollers
    {
      rotate(alpha*i+alpha/2,[0,0,1])
      translate([rr2,0,0]) //cylinder(r=r2,h=h0);
        cyl(r2,h0,false,clr/2);
    }
  
    // inner piece
    difference()
    {
      //cylinder(r=rra,h=h0);
      cyl(rra,h0-eps,false,clr/2);
      translate([0,0,-h0*0.1])
      cylinder(r=w/2/cos(30),h=h0*1.2,$fn=6);
    }
  
    // outer ring
    difference()
    {
      cylinder(r=rout,h=h0-eps);
      translate([0,0,-eps])
      // cylinder(r=rrb,h=h0+2*eps);
        cyl(rrb,h0+2*eps,true,clr/2);
    }
  }

} // end whole


//cyl(20,20);

module ring(rr,hh,outward=true,clr=0,dr=1,dh=1,s=1) {} // TO DEFINE!!

module cyl(rr,hh,outward=true,clr=0,dr=1,dh=1,s=1)
{
  if(outward==true)
  {
    cylinder(r=rr-dr-clr,h=hh);
    hull()
    {
      translate([0,0,s+dh]) cylinder(r=rr-clr,h=hh-2*s-2*dh);
      translate([0,0,s]) cylinder(r=rr-dr-clr,h=hh-2*s);
    }
  }
  else
  {
    cylinder(r=rr-clr,h=hh);
    hull()
    {
      cylinder(r=rr+dr-clr,h=s);
      cylinder(r=rr-clr,h=s+dh);        
    }
    translate([0,0,hh]) scale([1,1,-1])
    hull()
    {
      cylinder(r=rr+dr-clr,h=s);
      cylinder(r=rr-clr,h=s+dh);        
    }
  }
}
