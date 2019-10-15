
// 2013 Lukas Süss aka mechadense
// Measuring Cup Pairs

/*
Eiter use the common decimal fractions (in cubic mm):
A good sequence is:
(10,50);(20,100);(50,200);(100,500);
-(200,1k)-;-(500,2k)-;-(1k,5k)-;
(2k,10k);(5k,20k);(10k,50k);(20k;100k),(50k,200k)

Or use powers of three.
With those you need the least number of measuring cups
but calculating exact volumes gets cumbersome.
Good for ratios though.
A suggested base size sequence in cubic mm: 
(10,30);(90,270); -(810,2430)- ;(7290,21870); (65610,196830)
*/

// known bugs:
// v1 is assumed > v0
// widening vertical connector hangs openscad for small volumes
// [1] r0 and r1 are specific global variables (l01 is derived)
// todo - thread those as parameters



// ### constants

pi=3.141592653*1;
s2 = sqrt(2);
function radius(v) = pow(3*(v)/(4*pi),1/3);


// ### parameters:

// first volume in cubic mm
v0 = 810;
// second volume in cubic mm (bigger than v0)
v1 = 2430;

// minimum stem length =40;
length = 60;

// minimum wall thickness
t = 1.25;
// add maximum too?
// wall-thickness to cup-diameter ratio
wallscale = 0.075; 

// make an easy to clean triangular connection bar
tribar = true;

// make a fitting spatula
spatula = false;

// resolution - maximal angel per facet
$fa=4;
// resolution - minimal length per facet
$fs=0.2;


// ### calculated values

r0 = radius(v0*2);
r1 = radius(v1*2);

echo("choosen wallthickness is:",max(t,wallscale*r1));

l01 = max(length,r1/2);  


 
//demo(); -- will not work yet due to bug [1]
module demo()
{
  cuppair(r0,r1,max(t,wallscale*r1));
  translate([0,50,0])
  cuppair(r2,r3,max(t,wallscale*r3));
}


//##########################################################
//##########################################################

//translate([40,30,0])cube([10,10,10]); // size estimation cube

if(spatula == false)
{
  cuppair(r0,r1,max(t,wallscale*r1));
}

//translate([0,+l01/2,0])
if(spatula){ spatula(1);}


module cuppair(r0,r1,t)
{
  lcc = r0+t+l01+t+r1;
  shift = (r1-r0)/2;
  difference()
  {
    union()
    {
      spherepair(r0,r1,t,t);
      supportpillars(r0,r1,t);
  
      if(tribar == false)
      {
        // vertical connector
        translate([-shift,0,(r1+t)/2])
        hull()
        {
          cube([lcc,t,r1+t],center=true);
          //cube([lcc,t*3,r1-t],center=true);
        }
      
        // horizontal connector ----- length not 100% correct (1cmm case)
        translate([-shift,0,t])
        hull()
        {
          cube([lcc,r0*s2,2*t],center=true);
          translate([0,0,+t/2])
          cube([lcc,(r0+t)*s2,t],center=true);
        }
      }
      if(tribar)
      {
        translate([-shift,0,0])
        difference()
        {
          tribar(lcc,(r0+t)*s2,t,0);
          tribar(lcc,(r0+t)*s2,t,t*1.5);
        }
      }
    }
    spherepair(r0,r1,0,t);
    translate([0,0,r1+t+r1+t/2])
    cube([8*l01,6*r1,2*r1+t],center=true);

    if(tribar==false)
    {
      // material savings
      hull()
      {
        translate([l01/2-(r0/2),0,r1+t]) rotate(90,[1,0,0])
        cylinder(r=r0/2,h=5*t,center=true);
        translate([-(l01/2-(r0/2)),0,r1+t]) rotate(90,[1,0,0])
        cylinder(r=r0/2,h=5*t,center=true);
      }
    }
  }
}

// s..additional shift outward
// t..wall thickness
module spherepair(ra,rb,s,t)
{
  translate([ra+t+l01/2,0,rb+t]) sphere(r=ra+s);
  translate([-(rb+t+l01/2),0,rb+t]) sphere(r=rb+s);
}
module supportpillars(ra,rb,t)
{
  translate([ra+t+l01/2,0,0])
  hull()
  {
    cylinder(r=(ra)/s2,h=t+r1);
    translate([0,0,t])
    cylinder(r=(ra+t)/s2,h=r1);
  }
  translate([-(rb+t+l01/2),0,0])
  hull()
  {
    cylinder(r=(rb)/s2,h=t+r1);
    translate([0,0,t])
    cylinder(r=(rb+t)/s2,h=r1);
  }
}


// l .. rod length
// w .. maximum width
// b .. bevelling hight
// s .. shiftin
module tribar(l,w,b,s)
{
  c = b/cos(30);
  rr = (w-c)/2/cos(30)-s;
  
  translate([0,0,(rr+s)*sin(30)])
  hull()
  {
    rotate(90,[0,1,0]) rotate(180*1,[0,0,1]) cylinder(r=rr,h=l,$fn=3,center=true);

    translate([0,+b*sin(30),b*cos(30)])
      rotate(90,[0,1,0]) rotate(180*1,[0,0,1]) cylinder(r=rr,h=l,$fn=3,center=true);

    translate([0,-b*sin(30),b*cos(30)])
      rotate(90,[0,1,0]) rotate(180*1,[0,0,1]) cylinder(r=rr,h=l,$fn=3,center=true);
  }
}



module spatula(clr)
{
  intersection()
  {
    hull()
    {
      translate([-l01/2,0,0]) sphere(r0-clr);
      translate([+l01/2,0,0]) sphere(r1-clr);
    }
    translate([0,0,t/2])
    cube([4*r1+l01,4*r1,t],center=true);
  }
}