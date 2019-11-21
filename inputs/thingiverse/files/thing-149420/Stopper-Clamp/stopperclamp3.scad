
// author:   Lukas Süss aka mechadense
// released: 2013
// title:    Stopper Clamp
// license:  CC-BY

/*
This clamp can be used to pull on slippery poles.  
Use a double overhand noose to tie a self tightening loop.  
http://en.wikipedia.org/wiki/Double_overhand_noose  
Due to the integration of a of rubber inlet and the loops self tightening, high axial load compoments can be held (~15kg tested). Untying is easy: You can take the loop out of the goove over the tip of the rod and pull the loop to zero to let the knot vanish.  

It can be used inconjunction with  
Block and Tackle - customizable: http://www.thingiverse.com/thing:148571  
To lift up really long (12m) poles. I've succesfully tested this with a telescopic rod originally indended for cleaning equipment:  
http://www.wischmop-shop.de/teilige-profi-teleskopstange-12meter-gleitstein-p-335.html  

A butterfly loop can be used for sideward stabilizing ropes.  
Alternatively one could add eylets to this thing.  
*/

// resolution: maximal angle per vertex (overridable by $fs)
$fa = 5;
// resolution: minimal size per vertex
$fs = 0.2;

// pole diameter (subtract 1mm for preload)
dpolestage3 = 24;
rpolestage3 = dpolestage3/2;

// main part thickness
t0 = 3;  // Flexing vs maximal pulling force 2.5...very soft
// thickness of the rubber sheet you're goint to use
trubber = 3; // 4 was wrong

// main parts height
hsqueezer = 30;

// rope diameter (+ ~1mm)
dropehole = 5;
rropehole = dropehole/2;
// thickness of the giude
tropehole = 4;
rropeloop = rpolestage3+trubber+t0+rropehole;
// number of flexcuts (watch out to don't cut the bevelings away)
n = 12;

// opening angle
angle = 120; // 135 was too much.
overangle = (180-angle)/2;




difference()
{
  union()
  {
    unflexing();
    // round off
    translate([0,0,hsqueezer/2+dropehole/2]) 
      torus(tropehole/2,rropeloop+dropehole/2+tropehole/2);
  }
  // inserting cut - tweak angle !!
  scale([tan(overangle),1,1])
    translate([0,0,-50]) rotate(-45,[0,0,1])
      cube([100,100,100]);
  // flexing cuts:
  for(i=[-3:3])//for(i=[0:n-1])
  {
    hull()
    {
      rotate(360/n*i,[0,0,1])
        translate([-(rpolestage3+trubber+t0),0,0])
          cylinder(r=1,h=hsqueezer*1.2);
      rotate(360/n*i,[0,0,1])
        translate([-(rpolestage3+trubber+t0)-10,0,0])
          cylinder(r=2,h=hsqueezer*1.2);
    }
    //cylinder(r=1,h=hsqueezer*1.2); 
      rotate(360/n*i+360/2/n*0,[0,0,1])
        translate([-(rpolestage3+trubber/2),0,-1])
          cylinder(r=trubber/2,h=hsqueezer*1.2);
  }
  // breaking edges
  rotate(-overangle-0.05,[0,0,1]) translate([0,rropeloop,0])
    translate([0,0,hsqueezer/2-rropehole]) rotate(-90,[0,1,0])
      hull()
      {
        cylinder(r1=rropehole+1.5,r2=rropehole,h=1.5);
        translate([2*dropehole,0,0])
        cylinder(r1=rropehole+1.5,r2=rropehole,h=1.5);
      }
  rotate(+overangle+0.05,[0,0,1]) translate([0,-rropeloop,0])
    translate([0,0,hsqueezer/2-rropehole]) rotate(-90,[0,1,0])
      hull()
      {
        cylinder(r1=rropehole+1.5,r2=rropehole,h=1.5);
        translate([2*dropehole,0,0])
        cylinder(r1=rropehole+1.5,r2=rropehole,h=1.5);
      }
}

module unflexing()
{
  difference()
  {
    hull()
    {
      // main body
      bcylinder(rpolestage3+trubber+t0,hsqueezer,2);
      // rope channel body
      translate([0,0,hsqueezer/2])
        elongorus(rropehole+tropehole,rropeloop,dropehole);
    }
    //cut for the pole
    translate([0,0,-hsqueezer*0.1])
      cylinder(r=rpolestage3+1.5,h=hsqueezer*1.2);
  
    // cut for the rubber inlet
    translate([0,0,+t0])
      bcylinder(rpolestage3+trubber,hsqueezer-2*t0,2);
  
    // rope channel
    translate([0,0,hsqueezer/2+50/2])
      elongorus(rropehole,rropeloop,dropehole+50);
  
    // open up ropeholder
    difference()
    {
      translate([0,0,hsqueezer/2+dropehole/2]) cylinder(r=100,h=100);
      translate([0,0,hsqueezer/2-1]) cylinder(r=rropeloop,h=100);
    }

  }
}






module bcylinder(rr,hh,b=1)
{
  cylinder(r1=rr-b,r2=rr,h=b);
  translate([0,0,b]) cylinder(r=rr,h=hh-2*b);
  translate([0,0,hh-b]) cylinder(r1=rr,r2=rr-b,h=b);
}

module torus(r1,r2)
{
  rotate_extrude(convexity=4)
  translate([r2,0,0])
    circle(r=r1);
}
module elongorus(r1,r2,l)
{
  rotate_extrude(convexity=4)
  translate([r2,0,0])
    hull()
    {
      translate([0,l/2,0]) circle(r=r1);
      translate([0,-l/2,0]) circle(r=r1);
    }
}



