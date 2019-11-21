/***************************
*** Introduction

This OpenSCAD module allows for rotational extrusion of generic user-defined profiles,
introducing a pitch in the longitudinal direction, the most common application being
the creation of screws. 
The solid is built as a single polyhedron by transforming the 2D points found in the
profile array. No boolean operation is necessary, aiming at obtaining the ultimate
performance by producing the simplest possible object for the desired level of detail.

*** Arguments

* profile: array of 2D points defined as [[z1, f(z1)], [z2, f(z2)], ... [zn,f(zn)]].
  The function f(z) describes the shape of the thread (trapezoidal, square, triangular,
  sinusoidal, ...).
  The shape of the profile can be refined by adding more points, however this will
  also make it heavier to handle.
  The profile should should be defined over a closed interval (including the extremes)
  representing one period of the thread.
  The linspace helper function might be used to create the profile from a mathematical
  function (see example below).
* length: how far to go in the longitudinal direction, note that the mesh size increases
  linearly with this parameter.
* nthreads: allows the creation of multiple threads, it should be an integer.
  Negative number are also accepted, generating left threads.
  Zero results in no pitch, similar to rotate_extrude.
* f: the number of subdivisions in the angular direction, similar to $fn for a cylinder. 
  Note that if this parameter is too small, the resulting mesh could be completely wrong.
  A sufficient condition to satisfy correctness should be: f>period*nthreads/dz;
  where dz is the minimum sum of two consecutive z increments as defined in the profile.
  In the longitudinal direction the number of subdivisions is controlled directly by
  the number of points in the profile.

*** Example 

***************************/
period = 6; // choose the pitch
length = 30;  // the tallness
nthreads = 7; // the number of threads (<0 for left threads)
f = undef; // angular finesse, undef for autocompute

// A sinusoidal profile function...
function prof_sin(z) = [z, 10+sin(z*360/period)];
// ...which becomes a profile array with the help of linspace
prof = [for (z=linspace(start=0, stop=period, n=16)) prof_sin(z)];

// Otherwise define a square profile array defined manually
//prof = [[0, 11], [0.01, 9], [period/2, 9], [period/2+0.01, 11], [period, 11]];

// now the screw
render(convexity=10) revolve( prof, length=length, nthreads=nthreads, f=f);
/***************************

*** Licence

This OpenSCAD module was written by Dario Pellegrini <pellegrini dot dario at gmail dot com>
It is released under the Creative Commons Attribution (CC BY) licence v4.0 or later.
https://creativecommons.org/licenses/by/4.0/

*** Changelog

2018/11/09 Released v1.0

***************************/

function linspace(start,stop, n) = let (step=(stop-start)/(n)) concat( [ for (i = [0:1:n-step/2]) start+i*step], stop);

function xor(a,b) = (a && !b) || (!a && b);
function ceil_mult(n,m) = ceil(n/m)*m;  
function rotate_2D(p, a=0) = [cos(a)*p[0]-sin(a)*p[1], sin(a)*p[0]+cos(a)*p[1], p[2]];

function front(v) = v[0];
function back(v) = v[len(v)-1];
function pop_front(v) = [for (i=[1:1:len(v)-1]) v[i] ];
function reverse(v) = [for (i=[len(v)-1:-1:0]) v[i]];
function reverse_if(v, cond) = cond ? reverse(v) : v;

function lookup_2D(pts, z) = 
  let(x=[for (p=pts) [p[2],p[0]]], y=[for (p=pts) [p[2],p[1]]])
    [lookup(z,x), lookup(z,y), z];

function trim_duplicates(v) = let(N=len(v)-1) 
    concat([for (i=[0:1:N-1]) if (v[i] != v[i+1]) v[i]],
           (v[N-1] == v[N]) ? [] : [v[N]]); //adjusts the last one

function trim_bottom(pts, val) =
  concat([ for (i=[0:1:len(pts)-2])
    if ( pts[i+1][2]>val )
      (pts[i][2]<val) ? lookup_2D([pts[i],pts[i+1]], val) : pts[i]
  ], [back(pts)]);
    
function trim_top(pts, val) =
  concat([ for (i=[len(pts)-1:-1:1])
    if ( pts[i-1][2]<val ) 
      (pts[i][2]>val) ? lookup_2D([pts[i-1],pts[i]], val) : pts[i]
  ], [front(pts)]);

function trim(pts, b, t) = 
  reverse(trim_top(trim_bottom(trim_duplicates(pts), b), t));  

function flatten(l) = [ for (a = l) for (b = a) b ] ;

function make_indx(pts, res=[], i=0) = (len(pts)==0) ? res :
  make_indx(pop_front(pts), concat(res,
    [[for (j=[0:1:len(front(pts))-1]) j+i]]), i+len(front(pts)));

function make_circular(v) = concat(v, [front(v)]);

function sort3(a,b,c) =
  (a<b) ? (b<c) ? [a,b,c] : (a<c) ? [a,c,b] : [c,a,b] :
 /*a>b*/  (b>c) ? [c,b,a] : (a>c) ? [b,c,a] : [b,a,c] ;

function make_triplet(v1,v2,last) = let( s=sort3(v1[0],v2[0],v2[1]) )
  xor(s[1]+1==s[2], last) ? [s[0],s[2],s[1]] : s;

function final_triplets(v1,v2,last) =
  (len(v1)==3) ? [make_triplet(v2,v1,last), make_triplet(v2,pop_front(v1),last)] :
  (len(v1)==2) ? [make_triplet(v2,v1,last)] : [];

function make_triplets(v1, v2, last, res=[]) = 
  (len(v1)<len(v2)) ? make_triplets(pop_front(v2), v1, last, concat(res, [make_triplet(v1,v2,last)] ) ) :
  (len(v2)==1) ? concat(res, final_triplets(v1,v2,last)) :
  make_triplets(pop_front(v2), v1, last, concat(res, [make_triplet(v1,v2, last)] ) );

function Na_euristic(dz, pthreads, Na) = 
  (Na > pthreads/dz) ? Na : Na_euristic(dz, pthreads, Na+1);

function compute_Na(dz, period, nthreads, Na) = let(nt=max(abs(nthreads),1))
   ceil_mult(min(200,(Na==undef ? Na_euristic(dz, period*nt, 3) : Na)), 2*nt);

module revolve(profile = [[]], length, nthreads=1, f=undef) {
  // Prepare some variables
  period = back(profile)[0]-front(profile)[0];
  profile_ext = [for (zp = [-period*abs(nthreads):period:length*(abs(nthreads)+1)]) for ( p=profile ) [ p[0]+zp, p[1]]];
  maxR = max([for (p=profile) p[1]]);
  dz = min([for (i=[2:1:len(profile)-1]) abs(profile[i][0]-profile[i-2][0]) ]);
  Na = compute_Na(dz, period, nthreads, f);
  if (f==undef && Na>200) echo("WARNING (revolve): the internal computation of \"f\" resulted in a value larger than 200, therefore it has been trimmed down. If the mesh is inconsistent please spefify manually a larger value.");
  echo(str("Na=", Na));
  stepa = 360/Na;

  // Compute the array of points
  pts = [for (an=[0:1:Na-1]) let(ai=an*stepa) trim( 
        [for (pn=profile_ext) let(zi=pn[0]+an*period*nthreads/Na, ri=pn[1] )
        rotate_2D([ri, 0, zi], ai)],
      profile[0][0], profile[0][0]+length )];
  // Compute the array of indexes: same structure as pts, but contains a progressive numbering
  indx = reverse_if(make_circular(make_indx(pts)), nthreads<0);

  // Compute the faces, this is the trickiest part...
  fcs = concat( [ for(i=[0:1:Na-1]) make_triplets(indx[i],indx[i+1], last=(nthreads>=0)?(i==Na-1):(i==0))],
                [[reverse_if([ for(i=[0:1:Na-1]) front(indx[i])], nthreads< 0),  //bottom
                  reverse_if([ for(i=[0:1:Na-1])  back(indx[i])], nthreads>=0)]] //top 
    );

  // Finally build the polyhedron
  polyhedron( points = flatten(pts), faces = flatten(fcs));

  //debugging
//  print_spheres(pts);
//  print_indx(indx, pts, stepa*sign(nthreads));
//  echo_pts(indx,pts);
//  echo_fcs(fcs);
}

//debugging modules
//module echo_pts(indx, pts)
//  for (col=[0:1:len(indx)-2]) for (row = [0:1:len(indx[col])-1])
//    echo(str(indx[col][row],"=", flatten(pts)[indx[col][row]]));
//
//module echo_fcs(fcs) 
//  for (f=fcs) echo(f);
//
//module print_spheres(pts) 
//  for (p=flatten(pts)) translate(p) color("red") sphere(r=0.2);
//
//module print_indx(indx, pts, stepa) 
//  for (an=[0:1:len(indx)-2]) for(zn=[0:1:len(indx[an])-1])
//  let(pt=flatten(pts)[indx[an][zn]]) 
//  translate(pt) rotate([90,0,90+an*stepa])
//  color("red") linear_extrude(0.02) scale(0.05)
//  text(str(indx[an][zn]), valign="center", halign="center", $fn=4);