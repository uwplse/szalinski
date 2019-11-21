
// 2013 Lukas Süss aka mechadense - CC-BY
// Blocks with Tackle - customizable

/*

These are general blocks for the construction of:
http://en.wikipedia.org/wiki/Block_and_tackle
Among other options you can choose the number of sheaves the blocks hold.

DO NOT USE THIS TO SECURE LIFE OR OBJECTS OF HIGH VALUE
THIS IS A FREE MODEL 
THE ENTIRE RISK OF USING THIS OBJECT IS WITH YOU
I AM NOT REPONSIBLE FOR ANY DAMAGE ARISING OUT OF THE USE OF THIS OBJECT

when using these you'll probably need to bind some knots:
mid-rope-loop:
  http://en.wikipedia.org/wiki/Butterfly_loop
non tightening loop:
  http://en.wikipedia.org/wiki/Bowline
self tightening loop:
  http://en.wikipedia.org/wiki/Double_overhand_noose
end knot:
  http://en.wikipedia.org/wiki/Figure-eight_knot
keep rope tidy:
  http://de.wikibooks.org/wiki/Klettern/_Seiltransport   (de Seilpuppe -> en ???)
non tightening but adjustable loop:
  http://en.wikipedia.org/wiki/Blake%27s_hitch
bindable under high tension:
  http://en.wikipedia.org/wiki/Round_turn_and_two_half-hitches

Note:
Tripple or higher-tupled blocks where not tested.

# Example

The single and double example blocks with otherwise default settings 
are for rope with diameter of 4mm and M6 Bolts. With these you can make:
2 x advantage: Gun tackle 
3 x advantage: Luff tackle
4 x advantage: Double tackle 

I've succesfully tested a Luff tackle with a load reduction from 15 to 5 kg

To reproduce my setup you'll need one dual and one single sheave block
First assemble the blocks.
Then put the single-sheave-blocks eyelet over one end A of the rope.
With the ropes end A bind a self tightening loop (...) around the load.
Near the loop bind the sigle-sheave-blocks eyelet into a butterfly loop.
Thread the ropes far end B through one of the sheaves of the double-sheave-block.
Keep the block some distance away.
Go back and thread B through the single-sheave-blocks sheave.
Finally thread B through the second sheave of the double block.
Try to keep everything untangled.
Bind a stopper eight knot in the end of the rope to prevent it from slipping out.
Use two bowline or self tightening knots to mount the eyelet to your support structure.
Finished -> start pulling. When the load is in place bind a blakes hitch around one of the tensioned ropes to secure it. 

# Hint

Print with the layers perpendicular to the holes
Print with full support and file the burgerplates thoroughly flat afterwards. 
PLA prints need to be lubed to work properly.

The rope used in my case was: 
http://www.amazon.de/Seil-Leine-Schnur-16-fach-x20AC/dp/B0085IZ054/ref=sr_1_6?ie=UTF8&qid=1378759292&sr=8-6&keywords=pp+seil

*/




// resolution: maximal angle per vertex 
$fa = 5;
// resolution: minimal length per facet
$fs = 0.25;

// ########### "vitamin" parameters
// axle diammeter + clearing
daxle = 6.3;
raxle = daxle/2;
// rope diameter
drope = 4;
rrope = drope/2;
//############

// wheel thickness
twheel = drope*sqrt(2);

// burgerplate thickness
t = 7;

// number of rollers
nn = 2; // [1,2,3,4,5,6,7,8]
n = nn+1;

// roller diameter at center of rope: choose > daxle+drope/2 
dloop = 18;  
rloop = dloop/2;
// choose dloop greater than daxle+drope/2 !!


// additional space for rope to go through 
add = 2*1;
rout = rloop+rrope+add; // free space
// burgerplate diameter - keep >= rout*2
w = rout*2;

// clearing - added on both sides
clr = 0.25;
// 0.1 was too little - dont forget to file flat


// burgerplate bevellings
bevel = 0.75;
// eyelet bevellings
bevel2 = 2;

// do not change - too keep load balanced?
//l0 =  w/2-daxle/2; // why -daxle/2
l0 = w/2*0.75;

// eyelet beefiness 
tcenter = t; // equal burgerplate thickness

// eyelet diameter
deyelet = rrope*5;
rring = deyelet/2; 

htotal = (t+twheel+2*clr)*n-twheel-2*clr;

//dentout
f = 0.1;

part = "block"; // [block,wheel]
//part = "wheel"; // [block,wheel]




//####################
if (part=="block") hoist();
if (part=="wheel") wheel();

// debug stuff
//cube([10,10,10]);
//translate([0,0,t/2+twheel/2+clr]) wheel();
//#####################



module hoist() 
{ 
  plates();
  translate([0,-f*htotal,0]) hook(); 
}

module plates()
{
  difference()
  {
    union()
    {
      for(i=[0:n-1])
      {
         translate([0,0,(i-n/2+1/2)*(twheel+t+2*clr)]) // clearance added
         {
           bccylinder(w/2,t,bevel);
           // neck
           translate([0,-(rout+bevel2)/2,0])
             bxyzcube(2*l0,rout+bevel2,t,bevel2,bevel2*0,bevel2);
         }
      }
      // sideplate connector centerpiece - backplate
      translate([0,-rout-tcenter/2,0])
      hull()
      {
        bxyzcube(2*l0,tcenter,htotal,bevel2,bevel2,bevel2);
        translate([0,-f*htotal,0])
        bxyzcube(2*l0,tcenter,tcenter*1.618,bevel2,bevel2,bevel2);
        // tcenter*1.618
      }
    }
   // cut for axle
   cylinder(r=raxle,h=100,center=true);
  }
}


module hook()
{
  difference()
  {
    translate([0,0,0])
    {
      // make eyelet body
      translate([0,-(rout+tcenter)-rring,0])
        bccylinder(rring+tcenter,tcenter*1.618,2);
    }

    // cut eyelet ring
    translate([0,-(rout+tcenter)-rring,0])
     cylinder(r=rring,h=tcenter*3,center=true); 

    // break eyelet edges
    translate([0,-(rout+tcenter)-rring,-tcenter*1.618/2+bevel])
      cylinder(r1=rring+bevel2,r2=rring,h=bevel2,center=true); 
    scale([1,1,-1])
    translate([0,-(rout+tcenter)-rring,-tcenter*1.618/2+bevel])
      cylinder(r1=rring+bevel2,r2=rring,h=bevel2,center=true); 
  }
}


module wheel()
{
  difference()
  {
    intersection()
    {
      union()
      {
        // radial size
        cylinder(r=rloop-rrope*(1/sqrt(2)),h=drope*sqrt(2)+10,center=true);
        
        // gside rounded groove ends
        translate([0,0,rrope*sqrt(2)])
          torus(rrope,rloop-rrope*sqrt(2));
        translate([0,0,-rrope*sqrt(2)])
          torus(rrope,rloop-rrope*sqrt(2));
      }
      //axial size
      cylinder(r=rloop*2,h=twheel-2*clr*0,center=true); // clearing removed
    }
  
    // groove cutter
    torus(rrope,rloop);
  
     cylinder(r=raxle,h=20*drope,center=true);
  }
}






// #############################
module torus(r1,r2)
{
  rotate_extrude(convexity=8)
  translate([r2,0,0])
    circle(r=r1);
}
module elongorus(r1,r2,l)
{
  rotate_extrude(convexity=8)
  translate([r2,0,0])
    hull()
    {
      translate([0,l/2,0]) circle(r=r1);
      translate([0,-l/2,0]) circle(r=r1);
    }
}


module bxyzcube(x,y,z,bx,by,bz)
{
  hull()
  {
    cube([x-2*bx, y-2*by, z     ],center=true);
    cube([x,      y-2*by, z-2*bz],center=true);
    cube([x-2*bx, y,      z-2*bz],center=true);
  }
}

module bcube(x,y,z,b=bevel)
{ translate([x/2,y/2,z/2]) bccube(x,y,z,b); }

module bccube(x,y,z,b=bevel)
{
  hull()
  {
    cube([x-2*b,y-2*b,z],center=true);
    cube([x,y-2*b,z-2*b],center=true);
    cube([x-2*b,y,z-2*b],center=true);
  }
}

module bccylinder(rr,hh,b)
{
  eps = 0.05;
  translate([0,0,-hh/2])
  {
    cylinder(r1=rr-b,r2=rr,h=b);
    translate([0,0,b-eps]) cylinder(r=rr,h=hh-2*b+2*eps);
    translate([0,0,hh-b]) cylinder(r1=rr,r2=rr-b,h=b);
  }
}
module bccylinder2(rr,hh,b)
{
  eps = 0.05;
  translate([0,0,-hh/2])
  {
    cylinder(r1=rr+b,r2=rr,h=b);
    translate([0,0,b-eps]) cylinder(r=rr,h=hh-2*b+2*eps);
    translate([0,0,hh-b]) cylinder(r1=rr,r2=rr+b,h=b);
  }
}
