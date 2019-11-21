// date:    2014
// author:  Lukas Süss aka mechadense
// title:   customizable gear organizing plate
// license: public domain


/*
This is an extendable structure that should be helpful to quickly try some gearchains.

Its somewhat similar to an optical laboratory table - just less big heavy stiff and level. It also has striking similarity to those flat lego pieces (not intended).

### Usage:

Sandwitch some (e.g. three or more) layers of gears between two layers of these structures. Adjust the distance between the layers to leave sufficient clearing with some distributed spacertubes and screws (either printed or vitamin)

### Notes:

The axles are supposed to be printed flat cut to a thickness of 2*radius/sqrt(2) this makes sure overhangs are <= 45° and this way one can make gears that either couple to the axle or not.

Options to keep the axles from sliding out are
* widen the axle at one point
* slim the axle at one point and use cliprings
* use plates with closed caps


Todo:
# add rotationlock option
  with cutaway 1/sqrt(2) of the radius

*/


// keep retainers on axles (only on one side possible)




/* [Main sizes] */

// module edge length (hexagonal base vector)
s0 = 12;

// plate thickness
tplate = 1.75;
// peg wall thickness
tpegwall = 1.3333;
// how nuch the pegs stand over the connectorgrid (>0 recommened)
toverstand = 1.25;

// hole diameter (without clearing)
daxle = 4;
raxle = daxle/2;



/* [Clearances] */

// additional clearing for holes
clraxle = 0.2;

// peg clearing at the top
clrpegtop = 0.225;
// peg clearing at the bottom
clrpegbottom = 0.05;

r1_ = raxle+clraxle+tpegwall-clrpegbottom;
r2_ = raxle+clraxle+tpegwall-clrpegtop;



/* [Attributes] */

// number of repetitions
rep0 = 4; // [1:8]

cutrotangle = 60;
rotlock = "no";
endlock = "no";

preview = "demo"; // [demo:demo of possible assembly, ptp:parts to print]
part = "ps"; // [ps:plateletstructure, cgs:connectorgridstructure]

/* [Misc] */

democolorseed = 2453245;
demowhiteness = 2.0;
eps = 0.05;



/* [resolution] */

$fa = 5;
$fs = 0.2;

// ########################
// ########################

//translate([40,0,0]) cube([10,10,10],center=true);

//plateletpair();
//stackdemo();

part();

module part()
{
  if(preview=="demo")
  {
    stackdemo();
  }
  else
  {
    if(part=="ps"){ plateletlattice() plateletbasis(); }
    if(part=="cgs"){ plateletlattice() connectorgridbasis(); }
  }
}



// make demo with multiple plateletstructures
module stackdemo()
{
  h = 20;
  w = max(1,demowhiteness);
  seed = democolorseed;
  c0 = [1,1,1]-rands(0,1,3,seed+0)/w;
  c1 = [1,1,1]-rands(0,1,3,seed+1)/w;
  c2 = [1,1,1]-rands(0,1,3,seed+2)/w;
  c3 = [1,1,1]-rands(0,1,3,seed+3)/w;
  c4 = [1,1,1]-rands(0,1,3,seed+4)/w;
  c5 = [1,1,1]-rands(0,1,3,seed+5)/w;
  c6 = [1,1,1]-rands(0,1,3,seed+6)/w;
  c7 = [1,1,1]-rands(0,1,3,seed+7)/w;

  ccenter = [0.2,0.2,0.2];

  color(c0) placesuperbase( 0, 0) plateletlattice() plateletbasis();
  color(c1) placesuperbase( 0,-1) plateletlattice() plateletbasis();
  color(c2) placesuperbase(-1, 0) plateletlattice() plateletbasis();
  color(c3) placesuperbase(-1,-1) plateletlattice() plateletbasis();
  color(ccenter)
  placesuperbase(-1/2,-1/2,tplate) plateletlattice() connectorgridbasis();

  color(c4) placesuperbase( 0, 0,h) plateletlattice() plateletbasis();
  color(c5) placesuperbase( 0,-1,h) plateletlattice() plateletbasis();
  color(c6) placesuperbase(-1, 0,h) plateletlattice() plateletbasis();
  color(c7) placesuperbase(-1,-1,h) plateletlattice() plateletbasis();
  color(ccenter)
  placesuperbase(-1/2,-1/2,h+tplate) plateletlattice() connectorgridbasis();

}


module plateletpair()
{
  // basis + lattice = structure:
  plateletlattice() plateletbasis();

  translate([0,-2,0])
  placesuperbase(-1,-1,0)
  plateletlattice() connectorgridbasis();
}

module placesuperbase(na=0,nb=0,dz=0)
{
  basea = [+rep0*s0*cos(30),+rep0*s0/2,0];
  baseb = [-rep0*s0*cos(30),+rep0*s0/2,0];
  translate(na*basea + nb*baseb +[0,0,dz]) child(); 
}


module plateletlattice(rep=rep0)
{
  for(i=[0:rep-1]){
    for(j=[0:rep-1]){

    translate([i*s0*cos(30),i*s0/2,0])
    translate([-j*s0*cos(30),j*s0/2,0])
    {
      child();
    }
  }}
}

module plateletbasis(closed=endlock)
{
  difference()
  {
    union()
    {
      scale([cos(30)*2,1,1])
      cylinder(r=s0/2,h=tplate,$fn=4);
      // stand aboveconnectorgid so that gears rest on a defined surface
      translate([0,0,tplate-eps])
      cylinder(r1=r1_,r2=r2_,h=tplate+toverstand);
    }

    if(rotlock=="no") { cutter(closed); } else
    if(rotlock=="yes")
    {
      intersection()
      {
        cutter(closed);
        rotate(cutrotangle,[0,0,1])
        translate([0,0,tplate*(4-1)])
        cube([daxle/sqrt(2)+0,daxle*1.2,tplate*8+toverstand],center=true);
      }
    }
  }

  module cutter(closed)
  {
    if(closed=="no")
    {
      translate([0,0,-tplate])
      cylinder(r=raxle+clraxle,h=5*tplate+toverstand);
    }
    if(closed=="yes")
    {
      translate([0,0,+tplate])
      cylinder(r=raxle+clraxle,h=5*tplate+toverstand);
    }
  }
}

module connectorgridbasis()
{
  difference()
  {
      scale([cos(30)*2,1,1])
      cylinder(r=s0/2,h=tplate,$fn=4);

      translate([0,0,-tplate])      
      cylinder(r=raxle+clraxle+tpegwall,h=3*tplate);
  }
}