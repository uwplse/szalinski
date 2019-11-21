
// date: 2014 
// author: Lukas Süss aka mechadense
// title: excenter ball
// license: public domain

/*
This is a toy ball with a decentral center of gravity that makes it behave in an uncommon way.

When the center part is printed halfway put in something heavy on one side (e.g. a nut or some piece of scrap iron). WARNING: Check if the overstanding piece will not crash into yor fanduct before you put it in. When finished glue the caps on (~33% infill) to make a complete sphere. You might want to lock the enclosed mass so that is does not rattle and thus does not quickly stops movement (e.g. with a folded piece of paper).

There's also a fill option but then you need to print the center part near 100% infill and will get at best 1/5th the effect of an iron fill.

density iron:  	7.874 g/ccm
density plastic: ~1.2 g/ccm

Give it your cat to play or find some other unique application.

*/


/* [parameters] */

part = "all"; // [all,cap,center]

// inner ball diameter (outer diameter is inner + 4*t)
d = 25;
// wall thickness
t = 1.25;
// diaphragm thickness
t2 = 1.75;

filled = "no"; // [yes,no]

/* [resolution] */

$fa =4; $fs=0.2;


r = d/2;
ri = r+1*t;
ro = r+2*t;
di = 2*ri;
do = 2*ro;



if(part == "all")
{
  translate([-(do+3),0,0]) cap();
  translate([+(do+3),0,0]) cap();
  center();
}
if(part == "cap") { cap(); }
if(part == "center") { center(); }





module cap()
{
  difference()
  {
    sphere(r=r+2*t);
    translate([0,0,-ro*1.2/2])
    cube([do*1.2,do*1.2,ro*1.2],center=true);
  
    intersection()
    {
      sphere(r=r+t);
      translate([0,0,ri/sqrt(2)/2-1])
      cube([do*1.2,do*1.2,ri/sqrt(2)+2],center=true);
 
    } 
  }
}

module center()
{
  translate([0,0,ri/sqrt(2)])
  intersection()
  {
    difference()
    {
      sphere(r=r+t);
      difference()
      {
        sphere(r=r);
        cube([do*1.2,t2,di+2],center=true);
        if(filled == "yes")
        {
          translate([0,do/2,0])
          cube([do*1.2,do,di+2],center=true);
        }
      }
    }
  cube([do*1.2,do*1.2,di/sqrt(2)],center=true);
  } 
}