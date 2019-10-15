
// 2014 
// Lukas Süss aka mechadense
// public domain
// minimal customizable linkage arm segment (for experimmentation)

/*
These customizable parts should be usable as building blocks
to quickly experiment with various linkage designs.

e.g. the alternative form of paucellier lipkin linkage
like presented in this video
https://www.youtube.com/watch?v=62QmuQdoBRk

* use 3mm filament as axles
* weld or glue axles in place (make rivets)
* stack multiple identical linkages to get more sturdyness
* crop all arms to zero length to get trivial washers

*/

numcopies = 3;
shiftx = 0;
shifty = 16;

$fa = 5;
$fs = 0.4;

//linkage arm thickness
tz = 1.75;
//linkage arm width
tx = 3;
//bearing width
trim = 1.75;

// axle clearance
clr = 0.15;


// length of arm1 (set 0 to remove)
l1 = 8;
phi1 = 0;
// length of arm2 (set 0 to remove)
l2 = 20;
phi2 = 120;
// length of arm3 (set 0 to remove)
l3 = 20;
phi3 = -120;


// axle diameter
daxle0 = 3;
daxle1 = 3;
daxle2 = 3;
daxle3 = 3;
daxle_0 = daxle0+2*clr;
daxle_1 = daxle1+2*clr;
daxle_2 = daxle2+2*clr;
daxle_3 = daxle3+2*clr;

m0 = 1;
m1 = 1;
m2 = 1;
m3 = 1;

for(i=[0:numcopies-1])
{
  translate([shiftx*i,shifty*i,0])
  arm();
}


module arm()
{
difference()
{
  union()
  {
    // center eyelet
    translate([0,0,0])
      cylinder(r=daxle_0/2+trim,h=tz*m0);

    // rod to eyelet2
    extension(l1,daxle_1,m1,phi1);
    extension(l2,daxle_2,m2,phi2);
    extension(l3,daxle_3,m3,phi3);

  }
  translate([0,0,-1])
    cylinder(r=daxle_0/2,h=tz*m0+2);
  extensioncut(l1,daxle_1,m1,phi1);
  extensioncut(l2,daxle_2,m2,phi2);
  extensioncut(l3,daxle_3,m3,phi3);
}
}

module extension(l,daxle_=3+clr,m=1,phi=0)
{
  rotate(phi,[0,0,1])
  {
    translate([0,l/2,tz/2])
      cube([tx,l,tz],center=true);
    translate([0,l,0])
      cylinder(r=daxle_/2+trim,h=tz*m);
  }
}
module extensioncut(l,daxle_,m,phi)
{
  rotate(phi,[0,0,1])
  {
    translate([0,l,-1])
      cylinder(r=daxle_/2,h=tz*m+2);
  }
}



