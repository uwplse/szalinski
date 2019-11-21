
// author:  Lukas Süss aka mechadense
// date:    2014-07
// title:   parametric Hirth-joint
// license: public domain


/*
This is a trapezoidal Hirt-joint generator.

usage:
* either use customizer
* or use it as a library:
hirth(
  period_number,
  flank_angle,
  base_hight,
  vertex_radius,
  [cutround_diameter|default=0...do_not_cut_round],
  [bore_radius|default=0...no_bore],
  [vertical_stretching_factor|default=1],
  [colormarked_vertices|default=false]);
*/

/*

alternate name: V-tooth coupling
maybe related: curvic couplings

TODO:
  further subdivide mantle-triangles so that the mantle-flanks
  stay parallel to the z-axis and don't slant inward
  especially important for period_number=2 and high flank angles
  (see demogrid)

TODO: 
  create alternate more elegant volumetric version defined via halfspaces
  (plane normals)

TODO:
  Create a version that uses a regular polygon instead of a single point
  at the center. This is can enforces self centering on hirth couplings 
  of tubes (big bores) without aligning screw.
  such couplings can be found on bicycle axle couplings.

TODO: still buggy:
  with z0=1 and gamma0=45° the teeth should become triangular...

*/

// ################################ customizer parameters

/* [Global] */

// flank angle (looking from the side; measured from vertical)
gamma0 = 15;
// number of periods (>=2)
nn0 = 6; //[2:42]

// radius
r0 = 8; // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// scaling indentation depth (changes flank angle!)

// diameter of center bore
dbore0 = 3.25; // not yet implemented
// radius to cut from the polygonsal base shape (0 ... do not cut)
rcut0 = 7;

//increase groove depth / flank hight 
z0 = 1;
// hight of base body to centerpoint
h0 = 4;

// ################################# constants

/* [Hidden] */

pi = 3.141592653*1;
//centerpoint
cc = [0,0,0]*1;
//$fa = 5*1; $fn = 0.1*1;
degreetorad = ((2*pi)/360);
radtodegree = (360/(2*pi));


// ########################
// ########################
// ########################

// size estimation cube
// translate([0,0,20]) cube([10,10,10],center=true);

hirth(nn0,gamma0,h0,r0,rcut0,dbore0,z0); // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//pairing();// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//demogrid();// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


module pairing(expl=0.5)
{
  //color("orange") // ?
  translate([0,0,-expl/2])
  hirth(nn0,gamma0,h0,r0,rcut0,dbore0,z0);

  translate([0,0,+expl/2])
  rotate(360/nn0/2,[0,0,1]) scale([1,1,-1])
  hirth(nn0,gamma0,h0,r0,rcut0,dbore0,z0); 
}

module demogrid()
{
  for(i=[2:6]){ for(j=[1:5]){
    translate([(i-2)*r0*2.5,(j-1)*r0*2.5,0])
      hirth(i,10*j,h0,r0);
  }}
}

// ########################## 

module hirth(nn,              // * number of periods
             gamma,           // * flank angle
             h,               // * base body hight
             rr,              // * rough polygonal radius
             rcutround = 0,   // if > 0 => radius of intersecting cylinder 
             dbore = 0,       // 0 ... no bore
             z = 1,           // scale cutoff hight
             colvert = false) // for easier vertex identification
{
  // -------------- derived sizes
  n = max(2,nn);
  // periodicity angle
  a = 360/n;
  // double triagle to trapezoid cutoff hight
  // choosen such that at the unit circle 
  cutoff = a*degreetorad /3*z; // <= (gamma <= 45°)
  b = cutoff*tan(gamma) *radtodegree;
  a_head = a/2-b;
  a_root = a/2+b;
  h3 = [0,0,h]*1; // helper vector

  function h1(i) = [cos(i*a-a_head/2),sin(i*a-a_head/2),cutoff/2];
  function h2(i) = [cos(i*a+a_head/2),sin(i*a+a_head/2),cutoff/2];
  function r1(i) = [cos(i*a-a_root/2),sin(i*a-a_root/2),-cutoff/2];
  function r2(i) = [cos(i*a+a_root/2),sin(i*a+a_root/2),-cutoff/2];

  difference()
  {
    intersection()
    {
      for(i=[0:n-1])
      {
        toothpolyeder(i);
        // translate([cos(i*a)*1,sin(i*a)*1,-1]) // explode
        basepolyeder(i);
      }
      if(rcutround>0)
      {
        echo("cutround");
        translate([0,0,-3*h])
          cylinder(r=rcutround, h= 6*(h+10),$fa=4,$fs=0.2); // Hack
      }
    }
    if(dbore>0)
    {
      translate([0,0,-3*h])
        cylinder(r=dbore/2, h= 6*h,$fa=4,$fs=0.2);
    }
  }

  module toothpolyeder(i)
  {
    ps = [cc, h1(i)*rr, h2(i)*rr, r1(i)*rr, r2(i)*rr];
    ts = [ [0,1,3],[0,2,1],[0,4,2], // left top and right flank
           [1,4,3],[1,2,4], // mantle (todo: subdivide)
           [0,3,4] ]; // bottom
    polyhedron(points = ps, triangles = ts, convexity = 3);
  }

  module basepolyeder(i)
  {
    ps = [cc, r1(i)*rr, r2(i)*rr, r1(i+1)*rr,
          [0,0,-cutoff/2*rr]-h3, r1(i)*rr-h3, r2(i)*rr-h3, r1(i+1)*rr-h3];
    ts = [ [0,2,1],[0,3,2], [4,5,6],[4,6,7],    // top & bottom
           [1,6,5],[1,2,6], [2,7,6],[2,3,7],    //  mantle (todo: subdivide)
           [0,5,4],[0,1,5], [3,4,7],[3,0,4] ];  // antikoplanar :S 
    polyhedron(points = ps, triangles = ts, convexity = 3);
  }

  if(colvert)
  {
    for(i=[0:n-1])
    {
      color("red")    translate(h1(i)*s) sphere(r=1);
      color("orange") translate(h2(i)*s) sphere(r=1);
      color("yellow") translate(r1(i)*s) sphere(r=1);
      color("green")  translate(r2(i)*s) sphere(r=1);
    }
  }

}
