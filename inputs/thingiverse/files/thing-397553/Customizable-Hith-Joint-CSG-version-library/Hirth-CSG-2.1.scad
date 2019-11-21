// author:  Lukas Süss aka mechadense
// date:    2014-07
// title:   Hirth-Joint (CSG version)
// license: public domain

/*
Customizable Hith Joint (CSG version) (library)

This is an improved version of
http://www.thingiverse.com/thing:387292

This improved model can start the teeth not just at the center but also at a polygon of choosable radius. Meaning one can create thin walled tube couplings that are radially self centering (Such couplings are often found in Mountainbike axles).

The interpenetration depth of the teeth can be limited with the flatlimit parameter.


## Specialised functions
hirthaxle(l,d,dbore,n,beta,delta,flatlimit)
hirthtube(l,d,dbore,n,beta,delta,flatlimit)
"axle"-postfix: all teeth converge to the center
"tube"-postfix: all teeth emerge from the polygon inscribed into the bore diameter

## Convinience functions that make the coupling printeable upside down:
supportlesshirthaxle(l,d,dbore,n,beta,delta,flatlimit)
supportlesshirthtube(l,d,dbore,n,beta,delta,flatlimit)
"supportless"-prefix: optimized for upside down supportless printability

## Full functonatlity:
hirth(l,d,dbore,dpolygon,n,beta,delta,flatlimit,inlimit)
rawhirth(beta,delta,n,dpolygon,flatlimit,inlimit)

Notes regarding the first design:
* The parametric interdependencies behave a little different in this model!
* Using volumetric CSG descriptions turns out to be a lot easier than triangle vertex juggling.

###################

TODO:

refactor:
d0 -> dout0
dbore0 -> din0
same for 00's

Maybe:

Add an asymmetry parameter "ddelta" that rotates the teeth upwards and a "dbeta" to compensate for the emerging difference in tooth bottom- and top-wideness. Since the coupling becomes asymmetric a countermpart needs to be made from negative space.
make grid with random parameters -- echo(rands(0,10,2));

Check if inward facing (or combined inward outward) teeth are possible too.
=> seems nontrivial


Known problems:
  using rawhirth(...) with intersection works fine
  using rawhirth(...) with difference not - why ??
*/


// ##########################


/* [Character] */

// symmetry
  n0 = 9; // [2:60]
// flank angle
  beta0 = 15;
// cone angle (>0)
  delta0_ = 45;
  delta0 = abs(delta0_);
// size of flat center polygon (edge to edge)
  dpolygon0 = 14;

// (ab)using 0 is BAD!
// maximum interlocking/interpenetration depth  (0.. no limit)
  flatlimit0 = 2;
// 0 -> improve upside down printability
  inlimit00 = 1; // [0:1]
  inlimit0 = (inlimit00==0) ? false : true;




/* [Size] */

// height of hirth-joint bottom to center
  l0 = 16;
// outer hirth-coupling diameter
  d00 = 26;
// size of center bore
  dbore00 = 6;

// outer polygon diameter: [0...corner to corner | 1...width across flats]
measureout = 1; // [0:1]
// inner polygon diameter: [0...corner to corner | 1...width across flats]
measurein = 1; // [0:1]

// (ab)using 0 is BAD!
// number of outer edges (0...circle)
  nout0 = 0; // [0,3,4,5,6,7,8,9,10,11,12]
// number of inner edges (0...circle)
  nin0 = 0; // [0,3,4,5,6,7,8,9,10,11,12]

d0 = (measureout==0 || nout0==0 ) ? d00 : d00 / cos(360/(nout0*2));
dbore0 = (measurein ==0 || nin0==0 ) ? dbore00 : dbore00 / cos(360/(nin0 *2));



/* [Resolution] */

  $fa = 4;
  $fs = 0.2;

// Openscad internal stuff needed to be reimplemented:
function resol(r) = min(360/$fa, max(6,2*3.1415*r/$fs)); 



/* [Sidehole] */

// hight of sidehole for wormscrew (or whatever)
  hsidehole = 6;
// diameter of sidehole for wormscrew (or whatever)
  dsidehole = 3;
// number of sideholes
  nsidehole = 3;



/* [Keep big] */

s0 = 50;



/* [Hidden] */

colorred   = [1,0.3,0.2]*1;
colorgreen  = [0.15,0.65,0.1]*1;
colorblue = [0.3,0.4,0.7]*1;

explx = 16*1;
exply = 30*1;
exply2 =25*1;
shift = 3*1;
eps = 0.05*0;

// ##################################
// -------------------------------- examples

customizable();
//demo();


// customizer default parameter part (tube-example)
module customizable()
{
  difference()
  {
    color(colorred) translate([0,0,l0+eps]) // <<<<<<< color hack
      hirth(l0,d0,dbore0,dpolygon0,n0,beta0,delta0,flatlimit0,inlimit0);
    for(i=[0:nsidehole-1])
    {
      rotate(360/nsidehole*i,[0,0,1])
      translate([0,0,hsidehole]) rotate(90,[0,1,0])
        cylinder(r=dsidehole/2,h=d0);
    }
  }
}


module demo()
{
  translate([shift,0,10])
  {
    translate([-explx,-exply2,0])
      axledemo();
    translate([-explx,+exply2,0])
      axledemo(2,true);

    translate([+explx,-exply,0])
      tubedemo();
    translate([+explx,+exply,0])
      tubedemo(3,true); // for supportless upside down printing
  }
}



module axledemo(flatlimit = 0, inlimit = false) // backwardcapability-demo
{
  color(colorgreen)
  if(!inlimit)
  {   hirthaxle(10,20,3,6,15,12.5,flatlimit);  } else
  {   supportlesshirthaxle(10,20,6,5,15,25,flatlimit);  }
}


module tubedemo(flatlimit = 0, inlimit = false)
{
  color(colorblue)
  if (!inlimit)
  {  hirthtube(10,32,20,8, 5,45, flatlimit);  } else
  {  supportlesshirthtube(10,32,20,12, 5,45, flatlimit);  }
}



// -----------------------------------  convenience functions



// axle couplings
module hirthaxle(l,d,dbore,n,beta,delta,flatlimit)
{
  dpolygon = 0; inlimit = true;
  hirth(l,d,dbore,  0  ,n,beta,delta,flatlimit,  inlimit); 
}
// axle couplings && well upside down printable
module supportlesshirthaxle(l,d,dbore,n,beta,delta,flatlimit)
{
  dpolygon = 0; inlimit = false;
  hirth(l,d,dbore,  0  ,n,beta,delta,flatlimit,  inlimit);
}



// for self centering tube couplings
module hirthtube(l,d,dbore,n,beta,delta,flatlimit)
{
  dpolygon = dbore; inlimit = true;
  hirth(l,d,dbore,  dpolygon , n,beta,delta,flatlimit,  inlimit);
}

// for self centering tube saped couplings  &&  well upside down printable
module supportlesshirthtube(l,d,dbore,n,beta,delta,flatlimit)
{
  dpolygon = dbore; inlimit = false;
  hirth(l,d,dbore,  dpolygon  ,n,beta,delta,flatlimit,  inlimit);
}


// ------------------------------------- fundamental functions

// basic hirth joint cut to a cylindrical ring 
module hirth(l,d,dbore,dpolygon,n,beta,delta,flatlimit,inlimit)
{

  cornersout = (nout0==0) ? resol(d/2) : nout0;
  cornersin  = (nin0==0) ? resol(dbore/2) : nin0;

  difference()
  {
    intersection()
    {
      rawhirth(dpolygon,n,beta,delta,flatlimit,inlimit);
      rotate(360/(cornersout*2),[0,0,1])
        cylinder(r=d/2,h=2*l,center=true,$fn=cornersout);
    }

    // unintuitive ugly hack
    // to avoid further parameter <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    //checking (dbore == dpolygon) woud lead to unintuitive behaviour 
    if(inlimit != false || true) 
    {
      rotate(360/(cornersin*2),[0,0,1])
        cylinder(r=dbore/2,h=2.2*l,center=true,$fn=cornersin);
    }
    else // disabled
    { 
      rotate(360/n/4,[0,0,1])
        // polygon avoids blade arcs
        cylinder(r=dbore/2,h=2*(l0+eps),center=true,$fn=2*n);
    }

  }
}

// "infinite" sized raw hirth coupling ( if hs() where a true halfspace )
module rawhirth(dpolygon,
                n,
                beta,
                delta,
                flatlimit  = 0,
                inlimit = false,
                s = s0)
{
  // size of flat center polygon (side to side)
  shift = dpolygon*cos(360/n/4);

  // angle per period
  a = 360/n;

  // outward upward flanks
  intersection()
  {
    for(i=[0:n-1])
    {
      rotate(360*i/n,[0,0,1])
      intersection()
      {
        translate([shift/2,0,0]) 
        rotate(-delta,[0,1,0]) hs(s);
        rotate(-a/4,[0,0,1])
        rotate(+(90-beta),[1,0,0]) hs(s);
        rotate(+a/4,[0,0,1])
        rotate(-(90-beta),[1,0,0]) hs(s);
      }
    }
    if (flatlimit!=0) { translate([0,0,flatlimit]) hs(s); }
  }

  // inward downward flanks and solid lower body
  union()
  {
    intersection()
    {
      intersection_for(i = [0 : n])
      {
        rotate(360*(i+1/2)/n,[0,0,1])
        translate([shift/2,0,0]) 
        rotate(+delta,[0,1,0]) hs(s);
      }
      hs(s);
    }
    if(flatlimit!=0 && inlimit == true)
    { 
      // cut the teeth bottoms off (flat)
      translate([0,0,-flatlimit0]) hs(s);
    }
     
  }

}


// halfspace (big-cube-approximation)
module hs(s)
{
  translate([0,0,-s/2])
    cube([s,s,s],center=true);
}
