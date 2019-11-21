
// 2013 Lukas Süss
// Schmidt Style Coupling (parametric)
// license: CC-BY

/*
### Thingiverse description:

This is a mechanism to transmit rotation power between two axles that can move relative to one another but stay parallel at all times. It can take higher loads than a doublecardan joint.

it was inspired by this:
  http://www.thingiverse.com/thing:14060

and it is intended as a drive for my moineau pump model
  http://www.thingiverse.com/thing:28237


### Thingiverse Instructions:

You'll need the following parts for a full set:
 2 outertricrosses
 1 innertricross
 6 connectors
 6 Short pins
 3 long pins
 2 main pins
 = 20 Parts total (of 6 types)

At the moment it's not included in a whole working machine.
So you have to make your application and this one fit together yourself. 

(main pin standard length is choosen for a 2mm thick washer)
*/


//use <pins.scad>;
include <pins/pins.scad> // trouble??

//######### customizer parameters

// maximum axle displacement (choose as low as possible for you application but dont let the pins merge)
_1_max_displacement = 22;
smax = _1_max_displacement;

// choose the part to generate
_2_part = "fullassembly"; // [fullassembly,printplate,connector,innertricross,outertricross,longpin,shortpin,mainpin]
part = _2_part;

//part = "fullassembly";
//part = "printplate"; // F6 slow !!
//part = "outertricross";
//part = "innertricross";
//part = "connector";
//part = "shortpin";
//part = "longpin";
//part = "mainpin";

//diameter of input and output pin
rmainpin = 6;

// length of main pin
lmainpin = 26;
//lmainpin = 2*tconn+2; // suggestion
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< choose size to fit hexwidth ??

//diameter of center plates
dcenter = 20;
rcenter = dcenter/2;

// diameter and width of connector pieces
dconn = 12.5;
rconn = dconn/2;

// connector pin diameter (keep >= 8)
dpin = 8;
rpin = dpin/2;  // decouple?? <<<<<<<<<<

// thickness of all pieces (keep > 10)
tconn = 12;

// edge breaking
b = 1;

// resolution: segments per angle
$fa = 4;

// resolution: minimal segment length
$fs = 0.75;

// ##########


// calculate lbar from lconn
gap = 1*1; // hide from customizer
lconn = smax/2;
lbar = (lconn+2*rconn+gap)/2/sin(60);

// fullassembly orientation parameters
alpha =   30*1; //shiftangle 1 //30° is the critical angle to check
beta  = 30+150; //shiftangle 2   [0,180]



//##########################################################

if(part == "fullassembly") fullassembly();
if(part == "connector") conn();
if(part == "innertricross") innertricross();
if(part == "outertricross") outertricross();
if(part == "longpin") longpin();
if(part == "shortpin") shortpin();
if(part == "mainpin") mainpin();
if(part == "printplate") plate();



module plate()
{
  for(i=[0:5])
  {
   translate([rconn*2*1.2*i,0,0])
   {
     translate([0,-rconn*1.2,0])
     rotate(-90,[0,0,1]) conn(); // x6
     translate([0,tconn,0]) shortpin(); // x6
   }
  }
  for(i=[0:2])
  {
    translate([-rconn*2-(i*rpin*2*1.5),0,0])
      longpin(); // x3
  }
  translate([-rconn*2-rpin*3*3-lbar,0,0])
  rotate(180,[0,0,1])
    innertricross(); // x1

  translate([-rconn*2-lmainpin/2,+(tconn*1.5+rmainpin*1.5),0]) rotate(90,[0,0,1])
    mainpin(); // x2
  translate([-rconn*2-lmainpin/2,-(tconn*1.5+rmainpin*1.5),0]) rotate(90,[0,0,1])
    mainpin(); // x2

  translate([-rconn*2-rpin*3*3-lbar*1.5,+(lbar*2),0])
    outertricross();  // x2
  translate([-rconn*2-rpin*3*3-lbar*1.5,-(lbar*2),0])
    outertricross();  // x2
}

module fullassembly()
{
  outertricross();
  translate([lconn*cos(alpha),lconn*sin(alpha),tconn*2])
  {
    innertricross();
    translate([lconn*cos(beta),lconn*sin(beta),tconn*2]) 
     swap() outertricross();
  }
  color("orange")
  translate([0,0,tconn*1]) distribute() conn(alpha);
  color("orange")
    translate([lconn*cos(alpha),lconn*sin(alpha),0])
  translate([0,0,tconn*3]) distribute() conn(beta);
}

// #####################################################

module longpin()  { pinpeg(h=tconn*3, r=rpin, lh=3, lt=1, t=0.2); }
module shortpin() { pinpeg(h=tconn*2, r=rpin, lh=3, lt=1, t=0.2); }
module mainpin()  { pinpeg(h=lmainpin, r=rmainpin, lh=3, lt=1, t=0.2); }

module conn(tetha=0)
{
  rotate(tetha,[0,0,1])
  difference()
  {
    hull()
    {
      bcyl(rconn,tconn,b);
      translate([lconn,0,0]) bcyl(rconn,tconn,b);
    }
    union()
    {
      pinhole(h=tconn, r=rpin, lh=3, lt=1, t=0.3, tight=true, fixed=false);
      translate([lconn,0,0]) swap()
        pinhole(h=tconn, r=rpin, lh=3, lt=1, t=0.3, tight=true, fixed=false);
    }
  }
}

module outertricross(phi=0)
{
  difference()
  {
    tricross(phi=0);
      pinhole(h=tconn, r=rmainpin, lh=3, lt=1, t=0.3, tight=true, fixed=true);
    // cuts for short pins
    distribute() // swap unusable since stacked child() unsupported :(
    translate([0,0,tconn]) scale([1,1,-1])  
      pinhole(h=tconn, r=rpin, lh=3, lt=1, t=0.3, tight=true, fixed=false);
  }
}
module innertricross(phi=0)
{
  difference()
  {
    tricross(phi=0);
    translate([0,0,-tconn*0.1]) cylinder(r=10/2,h=tconn*1.2);
    // cylinder cuts for long pins <<<<<<<<<<<<<<<<<<<
    distribute() translate([0,0,-tconn*0.1]) cylinder(r=rpin+0.1,h=tconn*1.2);
  }
}

// basic shape
module tricross(phi=0)
{
  rotate(phi,[0,0,1])
  {

    difference() // redmove?
    {
      union()
      {
        //cylinder(r=rcenter,h=tconn);
        bcyl(rcenter,tconn,b);
        for(i=[0:2])
        { 
          rotate(120*i,[0,0,1])
          hull()
          {
            bcyl(rconn,tconn,b);//cylinder(r=rconn,h=tconn);
            translate([lbar,0,0]) bcyl(rconn,tconn,b);
          }
        }
      }
    }

  }
}



// ########################### util functions
module swap()
{
  translate([0,0,tconn]) scale([1,1,-1]) child();
}


module distribute()
{
  function phi(i) = 120*i; 
  for(i=[0:2])
  {
    translate([lbar*cos(phi(i)),lbar*sin(phi(i)),0]) child();
  }
}

module bcyl(rr,hh,b)
{
  hull()
  {
    translate([0,0,b]) cylinder(r=rr,h=hh-2*b);
    cylinder(r=rr-b,h=hh);
  }
}
// #########################################

/*
maybe TODO:
? make mainpin with electrodrillbit hexshape on one site
? optional: make pinholes symmetric ?

Application specific notes:
axle displacement length needed for a quite big moineau pump is around
10mm in whole 5mm to one side and 2.5mm/stage 
this cant be archived due to pin diameter :S
still it works it just looks a little ugly
*/

