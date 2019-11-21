/*
 2014 Lukas Süss aka mechadense
 space filling sphenoid hendecahedrons - crystal rods
 license: CC-BY

 source:
 http://www.steelpillow.com/polyhedra/five_sf/five.htm
 (coordinates at the bottom)
*/

crop_it_flat = "yes"; // [yes,no]
crop_flat = crop_it_flat == "yes" ? true : false;

part = "hexring"; // [sphenoid_hendecahedron,floret,floret_pair,tricolumn,hexring,column]
//part = "sphenoid_hendecahedron"; // ??
//part = "floret";
//part = "floret_pair";
//part = "tricolumn";
//part = "hexring"; // nice!
//part = "forest"; // buggy for F6 rendering ...
//part = "bicolumn"; // not implemented
//part = "column";

// if(crop_flat==true): half & quater numbers have effect
// hight of colums (full, half & quater numbers preferrable)
hc = 2;

// random seed for the colum heights in the "forest"
seed = 54*1;

// overall scaling factor
scal = 4;

// hack to get proper manifold model
eps = 0.01*1;


/*
 optional todo:

 1) add elongation distance
 (hendecahedron elongation as describes in source)
 for elongation shifting points is not enough;
 the points lying on the xy plane split up to two,
 every adjacent pair of two of those points create two new triangles
 el = 0*1; // elongation

 2)
 // if > 0 cut a cylindrical channel trough the colums axes 
 //hollow_column_radius = 0;

 // implement dicolumn
 // debug forest
 // calculate alpha2 & shiftx analytically instead of eyeballing 
*/


// #################################
s = sqrt(3);
c6 = cos(60);
s6 = sin(60);

// internal rotation of rod element
alpha1 = 22*1;
// for inter rod surface matching 
alpha2 = -11.08*1;
shiftx = 4.582*1;
shifty = 0*1;
shiftz = 0*1;

// base vectors
b0 = [0,0,0]*1;
b1 = [shiftx,shifty,shiftz]*1;
b2 = [shiftx*c6-shifty*s6,shiftx*s6+shifty*c6,shiftz]*1;
b3 = 1*1;

// list of corners
a = [13/7,3*s/7,+1  ]*1; // a..0
b = [1   ,s    ,0   ]*1; // b..1
c = [2   ,s    ,+1/2]*1; // c..2
d = [5/2 ,s/2  ,0   ]*1; // d..3
e = [9/4 ,s/4  ,+1/2]*1; // e..4
f = [2   ,0    ,0   ]*1; // f..5
g = [0   ,0    ,+1/2]*1; // g..6
h = [2   ,s    ,-1/2]*1; // h..7
dummyzero =   [0,0,0]*1; // don't know why i was left out in source
j = [9/4 ,s/4  ,-1/2]*1; // j..9
k = [0   ,0    ,-1/2]*1; // k..10
l = [13/7,3*s/7,-1  ]*1; // l..11


ps = [a,b,c,d,e,f,g,h,dummyzero,j,k,l]*1;

ts = [[6,0,4],[6,4,5], // quadrangle out of two koplanar trianhles
      [10,6,5],
      [10,5,9],[10,9,11],
      [4,0,2],[4,2,3],
      [5,4,3],[5,3,9],
      [9,3,7],[9,7,11],
      [10,11,7],[10,7,1],
      [6,10,1],
      [6,1,2],[6,2,0],
      [1,7,2],
      [2,7,3]]*1;

module sphenoid_hendecahedron(){
  polyhedron(points=ps,triangles=ts,convexity =3); }
// ##################################
// size estimation cube
// translate([10,30,0]) cube([10,10,10]);



scale([scal,scal,scal]) customized();

module customized()
{
  if(part == "column") {column(hc);}
  if(part == "tricolumn") {tricolumn(hc);}
  if(part == "hexring") {hexring(hc);}
  if(part == "forest") {forest();}

  if(part == "sphenoid_hendecahedron")
  {sphenoid_hendecahedron();}
  if(part == "floret") {rod_slice1();}
  if(part == "floret_pair") {rod_element();}
}

module forest()
{
  n = 2;
  nn = (n*2+1);
  ntot = nn*nn;
  hight = rands(-1,6,ntot,seed);
  for(i=[-n:n])
  {
  for(j=[-n:n])
  {
    assign(ii=i+n,jj=j+n,rr=sqrt(i*i+j*j))
    {
      if(hight[ii+jj*nn] > 0)
      {
        translate(i*b1+j*b2)
        column(round(hight[ii+jj*nn]-2*rr)+1/2);
      }
    }
  }
  }
}


module hexring(n=2)
{
  hexringcoords = [b0,b1,b1+b2,2*b2,-b1+2*b2,-b1+b2];
  for(i=[0:len(hexringcoords)-1])
  {
    translate(hexringcoords[i]) column(n);
  }
}

module tricolumn(n=2)
{
    translate(b1) column(n);
    translate(b2) column(n);
    column(n);
}

module column(n=2)
{
  if(crop_flat==false)
  { 
    fullcolumn(n);
  } 
  else
  {
    intersection()
    {
      fullcolumn(n);
      translate([0,0,(2*n-1)/2])
        cube([6,6,2*n-1],center=true);
    }
  }
}

module fullcolumn(n=2)
{
  for(i=[0:n-1])
  {
    translate([0,0,(i-eps/2)*2]) rod_element();
  }
}


module rod_element()  // (floret)
{
  union()
  {
    rotate(alpha2,[0,0,1])
    {
      rod_slice1();
      color("orange") rod_slice2();
    }
  }
}

module rod_slice1()
{
  for(i=[0:5])
  {
    rotate(60*i,[0,0,1])
    sphenoid_hendecahedron();
  }
}

module rod_slice2()
{
  translate([0,0,1-eps])
  rotate(alpha1,[0,0,1]) scale([-1,1,1])
    rod_slice1();
}

//#########
//colored_corners();
module colored_corners(rr=0.1,fn=8)
{
  translate(a) color("red")    sphere(r=rr,$fn=fn);
  translate(b) color("orange") sphere(r=rr,$fn=fn);
  translate(c) color("yellow") sphere(r=rr,$fn=fn);
  translate(d) color("green")  sphere(r=rr,$fn=fn);
  translate(e) color("cyan")   sphere(r=rr,$fn=fn);
  translate(f) color("blue")   sphere(r=rr,$fn=fn);
  translate(g) color("violet") sphere(r=rr,$fn=fn);
  translate(h) color("magenta")sphere(r=rr,$fn=fn);
  translate(j) color("brown")  sphere(r=rr,$fn=fn);
  translate(k) color("black")  sphere(r=rr,$fn=fn);
  translate(l) color("white")  sphere(r=rr,$fn=fn);
}
// initial systematic creation order was wrong order:
ts_perm = [[6,4,0],[6,5,4], // quadrangle out of two koplanar triangles
      [10,5,6],
      [10,9,5],[10,11,9],
      [4,2,0],[4,3,2],
      [5,3,4],[5,9,3],
      [9,7,3],[9,11,7],
      [10,7,11],[10,1,7],
      [6,1,10],
      [6,2,1],[6,0,2],
      [1,2,7],
      [2,3,7]];
