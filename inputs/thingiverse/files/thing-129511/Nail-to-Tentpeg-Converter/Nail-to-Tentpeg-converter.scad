// 2013 Lukas Süss aka mechadense
// Nail-to-Tentpeg Converter - Public Domain


// mainplate thickness
h0=4;
//length the nail is enclosed
hhull = 8;


// nail diameter
dnail = 5;
// wall thickness around nail
tnailhull = 3;
// ...
dnailtot = dnail+2*tnailhull;

// side hole diameter
dhole = 6;
// wall thickness around hole
tholehull = 3;
// ....
dholetot =dhole+2*tholehull;
// how far outward to place the hole
holeshift = 10;


// peg diameter
dpeg = 6;
// how far outward to place the peg
pegshift = 12;
// peg hight (choose higher or lower than hhull)
hpeg = 8;
// pegs sideward extension
sidepeg =5;

//clearing
clr = 0.1;
$fa = 5;
$fs = 0.15;

// how much to break the edges
bevel = 0.75;



difference()
{
  union()
  {
    bcylinder(dnailtot/2, hhull);
    difference() // connectionplate to hole
    {
      hull()
      {
        bcylinder(dnailtot/2, h0); // center
        translate([holeshift,0,0])
          bcylinder(dholetot/2, h0);    
      }
      // holecut  --<<<<<<<<<<<<< break edges
      translate([holeshift,0,-h0*0.1])
        cylinder(r=dhole/2, h=h0*1.2);    
    }
    hull() // connectionplate to peg
    {
      bcylinder(dnailtot/2, h0); // center ????
      translate([-pegshift,0,0])
        bcylinder(dpeg/2, h0);    
    }
    //peg
    translate([-pegshift,0,0])
      bcylinder(dpeg/2, hpeg);
    // sidepegs
    translate([-pegshift,0,0])
      hull() // connectionplate to peg
      {
        translate([0,+sidepeg,0]) bcylinder(dpeg/2, h0);
        translate([0,-sidepeg,0]) bcylinder(dpeg/2, h0);    
      }
  }
  // cut for nail
  translate([0,0,-hhull*0.1])
    cylinder(r=dnail/2+clr, h=hhull*1.2);
}
//bcylinder(10,20,2);
//translate([0,15,0])bcylinder(11/2,8);

module bcylinder(rr,hh,b=bevel)
{
  cylinder(r1=rr-b,r2=rr,h=b);
  translate([0,0,b]) cylinder(r=rr,h=hh-2*b);
  translate([0,0,hh-b]) cylinder(r1=rr,r2=rr-b,h=b);
}

