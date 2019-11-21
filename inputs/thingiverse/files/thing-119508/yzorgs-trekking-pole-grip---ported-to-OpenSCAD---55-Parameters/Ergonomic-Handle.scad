// 2013 Lukas Süss aka mechadende
// License: public domain
// yzorgs trekking pole grip - ported to openscad
// derived from http://www.thingiverse.com/thing:42998

$fa= 5;
$fs=0.2;

//base size
s=22;


// z scale bottom ellipsoid
asz=1.4;
// z translate bottom ellipsoid
atz = 0.4;
//---------------
bsx = 0.47;
bsy = 0.47;
bsz = 1.7;
balpha = 13;
btx = 0.45; 
btz = 2.2;
//---------------
csx = 0.6;
csy = 0.6;
csz = 2.0;
calpha = 5;
ctx = -0.2; 
ctz = 2.2;
//---------------
dsx = 0.9;
dsy = 0.9;
//dsz=1.6 for yzorgs original style
dsz = 1.1;
dalpha = 110;
dtx = 0.05; 
dtz = 4.3;
//###############
e0r1 = 0.5;
e0r2 = 2.0;
e0sx = 3.5;
e0sy = 1;
e0sz = 1.7;
e0alpha = 5;
e0tx = -0.6; 
e0tz = 1.3;
//---------------
e1r1 = 0.5;
e1r2 = 1.4;
e1sx = 2.5;
e1sy = 1;
e1sz = 1.7;
e1alpha = 2;
e1tx = -0.6; 
e1tz = 1.9;
//---------------
e2r1 = 0.5;
e2r2 = 1.4;
e2sx = 2.1;
e2sy = 1;
e2sz = 1.7;
e2alpha = 10;
e2tx = -0.55; 
e2tz = 2.5;
//---------------
e3r1 = 0.5;
e3r2 = 1.4;
e3sx = 2.5;
e3sy = 1;
e3sz = 1.7;
e3alpha = -8;
e3tx = -0.45; 
e3tz = 3.4;
//---------------
show_1ccm_cube = false;

if(show_1ccm_cube==true)
{
  //size estimation cube
  translate([-s*2,0,0]) cube([10,10,10]);
}

difference()
{
union()
{
  // Bottom Part A
  translate([0,0,atz*s]) scale([1,1,asz])sphere(s);

  //Back Part B
  translate([btx*s,0,btz*s]) rotate(balpha,[0,1,0])  
    scale([bsx,bsy,bsz]) sphere(s);

  //Front Part C
  translate([ctx*s,0,ctz*s]) rotate(calpha,[0,1,0])  
    scale([csx,csy,csz]) sphere(s);

  //Top Part D
  translate([dtx*s,0,dtz*s]) rotate(dalpha,[0,1,0])  
    scale([dsx,dsy,dsz]) sphere(s);
}
union()
{
  translate([0,0,-50*s]) cube([10*s,10*s,100*s],center=true);
  //Cut0
  translate([e0tx*s,0,e0tz*s]) rotate(e0alpha,[0,1,0])  
    scale([e0sx,e0sy,e0sz]) torus(s*e0r1,s*e0r2);
  //Cut1
  translate([e1tx*s,0,e1tz*s]) rotate(e1alpha,[0,1,0])  
    scale([e1sx,e1sy,e1sz]) torus(s*e1r1,s*e1r2);
  //Cut2
  translate([e2tx*s,0,e2tz*s]) rotate(e2alpha,[0,1,0])  
    scale([e2sx,e2sy,e2sz]) torus(s*e2r1,s*e2r2);
  //Cut3
  translate([e3tx*s,0,e3tz*s]) rotate(e3alpha,[0,1,0])  
    scale([e3sx,e3sy,e3sz]) torus(s*e3r1,s*e3r2);
}
}



module torus(r1,r2)
{
  translate([r2-r1,0,0])
    rotate_extrude(convexity=4) translate([r2,0,0]) circle(r=r1);
}

