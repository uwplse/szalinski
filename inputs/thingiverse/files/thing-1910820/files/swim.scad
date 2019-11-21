use <write/Write.scad>
// Enter your name
name="Lazydog";
name_x = 1;
name_y = 1;
t=0.1;
ys=1;
hd=0.1;
hx=1.5;
hy=5;
hdx=0.5;
hdy=0.5;
hnx=3;
hny=6;

difference() {
    swim();
    holes();
    name();
}

module name() {
   translate([name_x,name_y,0])
   write(name,h=.5,t=2);
}

module swim() { 
// based on 4x6 base size

pts = [
[2,0],
[3.2,0.15],
[3.9,0.8],
[4,2],
[3.9,3.3],
[3.6,4.6],
[3.0,5.6],
[2,6],

[4-3.0,5.6],
[4-3.6,4.6],
[4-3.9,3.3],
[4-4,2],
[4-3.9,0.8],
[4-3.2,0.15],
[2,0]
];

pt2 = nSpline(pts,100);
scale([1,ys,1])
linear_extrude(t)
polygon(pt2);

} // end swim

module holes() {
  for (ix=[1:hnx]) {
    for (iy=[1:hny]) {
      x = hx+hdx*(ix-1);
      y = hy-hdy*(iy-1);
      translate([x,y*ys,0])
         linear_extrude(t)
      circle(hd,$fn=10);
    }
  }
}

////////////////////////////////////////////////////
// splines.scad - library for mulivariate splines
// Implementation: Rudolf Huttary (c), Berlin 
//  November 2015
//  commercial use prohibited
//
//  usage scheme - n-dimensional natural cubic spline interpolation 
//    A = [[...],[...],[...]]; // define Mxn matrix, M>2, n>1
//    B = nSplines(A, N);      // get interpolated Nxn matrix
//    C = gen_dat(B);          // interpret data and transform into trajectory
//    sweep(B);                // render 
//
//  for code examples  see: 
//     http://forum.openscad.org/Rendering-fails-difference-between-F5-and-F6-tp15041p15100.html
//     http://forum.openscad.org/general-extrusion-imperfect-tp14740p14752.html
//     knot() example in this file!
//
///// some information functions to measure diameter and bounding box of an interpolated system
//  usage:   
//    B = nSplines(A); 
//    echo(str("outer diam=",Max(Norm(B)))); 
//    echo(str("bounding box=",Box(B))); 


// testcode 
//A = [ 
//  [-4.3,    .57,   .1,  .3],
//  [-.9,     .32,   1,   .4],
//  [1.5,     .07,   .1,  .5],
//  [2.5,    -1.48,  -1,  1.6],
//  [5.6,    -1.68,  -2,  .7],
//  [6.6,     1 ,    1.5, .4],
//  [4.6,    .5 ,    1,   .3],
//  [-1 ,     -2,    1.3, .7],
//  [-5 ,     -2,    1.5, 1.8]
//  ]*10;


//A= [
//[2*x, 0, 0, 1],
//[x+dx, dy, 0, 1],
//[x, 0, 0, 1],
//[x-dx, dy, 0, 1],
//[0, 0, 0, 1],
//[x-dx, -dy, 0, 1],
//[x, 0, 0, 1],
//[x+dx, -dy, 0, 1],
//[2*x, 0, 0, 1],
//]*40;





module knot()
{
// knot
A = [ 
  [-5,    0,   0],
  [-1,    0,   0],
  [-.4,    0,   -.2],
  [.3,    .3,   .2],
  [.2,     -.5,   0],
  [0,     0,   -.5],
  [-.2,     .5,   -0],
  [-.3,    -.3,   .2],
  [.4,    0,   -.2],
  [1,    0,   0],
  [5,    0,   0],
  ]*10;


N = 200; 

nS = nSpline(A,N);   // 4D-Spline rasterized

translate([0,0,20])
//{
//  plot4D(nS);         // 4D-plot, 4th dim is implicit radius
//  plot4D(A, "red"); 
//}
plot3D(col3D(nS), r=2); // 3D-plot, radius explicit
plot3D(col3D(nS), r=2); // 3D-plot, radius explicit
plot3D(col3D(A), r=3, c="red"); 

}

module help() splines_help();

/////////////////////////////////////////////////////////////
// library stuff - modules //////////////////////////////////
module plot3D(A, r=1, c = "yellow")
{ 
  for(i=[0:len(A)-1])
    color(c)
    translate(A[i])
    sphere(r, $fn=30); 
}

module plot4D(A, c = "yellow")
{
  for(i=[0:len(A)-1])
    color(c)
    translate([A[i][0], A[i][1], A[i][2]])
    sphere(A[i][3], $fn=30); 
}

module help () help_splines(); 

module help_splines()
{
  echo("\nModule prototypes:\n
=============\n
  help() - echos help in console
  help_splines() - echos help in console
  plot3D(A, r=1, c = \"yellow\")\n
  plot4D(A, c = \"yellow\")\n\n
  Function prototypes:\n
=============\n
  NxM = nSpline(S, N) - n-dim spline interpolation\n
  t = line_integral(S) - calcs line integral over 3D polygon\n
  coeffs = spline2D(x,y) - caculates coeffs for cubic spline\n
  y = spline2D_eval(coeffs, t, x) - evaluate spline at x\n
  Y = spline2D_rasterize(coeffs, t, N) - \n
  m = Max(A, flat=true) recursive max\n
  m = Min(A, flat=true) recursive min\n
  n = Norm(A) - recursive norm\n
  bb = Box(A) - boundingbox\n
  v = flat3(A, n=0) - flatten structured vector\n 
  
  "
); 
}


/////////////////////////////////////////////////////////////
// spline stuff - functions /////////////////////////////////
function nSpline(S, N) = 
// Rasterizes a PxM-dim vector sequence S into a NxM-dim sequence
// using a multivariate cubic spline interpolation scheme.
// along   a line integral 
// over P-dim polygon cord is used as common x-vector
//  S - is PxM-dim and denotes a seq of M-dim vectors to be
//      used as y-vectors
// returns NxM interpolated M-dim vectors
  let(M=len(S[0]))
  let(t = line_integral(S))
  transpose(
  [for(i=[0:M-1])
    let(C = col(S,i))
    let(coeffs = spline2D(t,C)) 
    (spline2D_rasterize(coeffs, t, N))]);

/////////////////////////////////////////////////////////////
//////// 2D cubic splines - main functions ///////////////// 
function spline2D(x,y) = 
// calculates coeffs of cubic spline segments 
// i.e. all coeffs of eq. systems Ax³+Bx²+Cx+D = y
//    x,y - paired vectors
//    [A, B, C, D]   returned vector values
  let(MT = eq_sys(x,y))  
  let(b = concat(0, solve_eq(MT[0], MT[1]), 0))
  let(N = len(x)-2) 
  let(dx = [for (i=[0:N])  x[i+1] - x[i]]) 
  let(A  = [for (i=[0:N]) (b[i+1]-b[i])/(3*dx[i])])
  let(C =  [for (i=[0:N]) (y[i+1]-y[i])/dx[i] - (b[i+1]-b[i])*dx[i]/3 - b[i]*dx[i]])
  [A, b, C, y]; 

function spline2D_rasterize(coeffs, t, N) = 
// evaluates a 2D-spline defined by coeffs for the ordered vector t
// at N equidistant points
// returns N vector containing sequence of interpolation values 
  let(T = raster(t,N))
  [for(i=[0:len(T)-1]) spline2D_eval(coeffs, t, T[i])];

function spline2D_eval(coeffs, t, x) = 
// evaluate spline represented by coeffs and t at x
// f(x) returned
    let(i = interval_idx(t,x))
    let(x_ = x-t[i])
    pow(x_,3)*coeffs[0][i]+
    pow(x_,2)*coeffs[1][i]+
           x_*coeffs[2][i]+
             coeffs[3][i] ;

/////////////////////////////////////////////////////////////
///stuff need for solving spline specific equation system ///
function eq_sys(x, y) = 
//transfers value pairs into eq.system M*x=T
//    x,y - paired vectors
//   [M, T] returned vector values with M - symmetric band (m=1) matrix 
//           in sparse lower band Nx2 representation
//   T - right side vector
    let(N = len(x)-3)
    let(T = [for (i=[0:N]) 
      3*((y[i+2]-y[i+1])/(x[i+2]-x[i+1]) - (y[i+1]-y[i])/(x[i+1]-x[i])) ])
    let(M = [for (i=[0:N]) 
      [(i==0)?0:(x[i+1]-x[i]), 2*(x[i+2]-x[i]) ]])
    [M, T]; 

function solve_eq(M,y) = 
// solves eq. system M*x = y, 
// M symmetric band (m=1) matrix, in sparse lower band representation
// uses Cholesky factorization L'*L*x=y
    let(N = len(M)-1)
    let(L = cholesky(M))
    LLx(L,y);
    
function LLx(L,y) =  
// solve L'Lx=y by first solving L'(Lx) = L'x_ = y and then Lx = x_
  let (N = len(y)-1) 
  let (x_ = [ for (i= [0:N]) Lx(i, L, y)]) 
            [ for (i= [0:N]) Lx_(i, N, L, x_)]; 
function Lx(i,L,y) =   (i==0)? y[0]/L[0][1]: (y[i] - Lx(i-1,L,y) * L[i][0])/L[i][1]; 
function Lx_(i,N,L,y) =(i==N)? y[i]/L[i][1]: (y[i] - Lx_(i+1,N,L,y) * L[i+1][0])/L[i][1]; 
    
function cholesky(A) = 
//  Cholesky factorization - applies only to symmetric band (m=1) matrix
// A - matrix to be factorized in sparse lower band representation
// returns Cholesky matrix in sparse lower band representation
    let(N=len(A)-1) 
    [ for(k= [0:N]) 
      let(Lk_ = Lk(A, k))
      [Lk_[0], Lk_[1]]
    ];
function Lk(A,k) = 
// recursive helper of cholesky()
  (k==0)?
    [0, sqrt(A[0][1]), A[0][1]]: 
      let(Lk_0  = (A[k][0] / Lk(A, k-1)[1])) 
      let(Ak_1  = (A[k][1] - Lk_0*Lk_0))
      let(Lk_1  = sqrt(Ak_1))
    [Lk_0, Lk_1, Ak_1];

/////////////////////////////////////////////////////////////
// some more general matrix and vector functions ////////////
function col(S,c=0) = 
// returns column c of matrix S
   [for(i=[0:len(S)-1]) S[i][c]]; 

function col3D(S) =
// returns first 3 columns of matrix S
   let(n=len(S[0])-1)
   [for(i=[0:len(S)-1]) 
     [S[i][0], (n>0)?S[i][1]:0, (n>1)?S[i][2]:0]]; 

function transpose(A) =
  [for(i=[0:len(A[0])-1])
    [for(j=[0:len(A)-1])
      A[j][i]]]; 

function line_integral(S) = let (M = len(S))
// calculates piecewise line integral over S, 
//    S is an ordered sequence of M distinct N-dim vectors
// returns ordered N-sequence of accumulated distances
    [for (i=[0:M-1]) lineT2(S,i)]; 
  
function lineT1(S, i, k) = 
// recursive helper of lineT2()
    let(t1 = pow((S[i][k]-S[i-1][k]),2))
    k==0 ? t1 : t1 + lineT1(S, i, k-1); 
  
function lineT2(S, i) = 
// recursive helper of line_integral()
    let(N = len(S[0]))
    let(t1  = pow(lineT1(S,i,N-1), .25)) 
    (i==0)? 0: (i==1) ? t1 : t1 + lineT2(S,i-1); 

function raster(t,N=100) = 
// splits interval covered by ordered vector t 
//    into N equ.dist. intervals
// returns raster as ordered N vector    
   let(d = t[len(t)-1]-t[0])
    [for (i=[0:N-1]) t[0]+i*d/(N-1)]; 

function interval_idx(t, x) = 
// returns index of interval containing real number x
// in ordered interval sequence defined by vector t
   let(N= len(t)-1)
  [for(i=[0:N-1]) 
    if(t[0]>x || (t[i]<=x && (t[i+1])>=x) || i==N-1) i][0];
 
    
// if flat == true 
//    max(vec of ... vec) 
// else
//    vec of (max(vec))
function Max(A, flat=true) = 
    let (m = 
      len(A[0])>1?
         [for(i=[0:len(A)-1]) Max(A[i])]:
          max(A) ) 
       flat?max(m):m; 

////////////////////////////////////////////////////////////////////
///// some information functions to measure diameter and bounding box of an interpolated system
//  usage:   
//    B = nSplines(A); 
//    echo(str("outer diam=",Max(Norm(B)))); 
//    echo(str("bounding box=",Box(B))); 
         
// if flat == true min(vec of ... vec) else vec of (min(vec))
function Max(A, flat=true) = 
    let (m = 
      len(A[0])>1?
         [for(i=[0:len(A)-1]) Max(A[i])]:
          max(A) ) 
       flat?max(m):m; 

// if flat == true max(vec of ... vec) else vec of (max(vec))
function Min(A, flat=true) = 
    let (m = 
      len(A[0])>1?
         [for(i=[0:len(A)-1]) Min(A[i])]:
          min(A) ) 
       flat?min(m):m; 

// norm of vec of vec ... vec3D       
function Norm(A) = 
  let (m = 
    len(A[0])>1?
       [for(i=[0:len(A)-1]) Norm(A[i])]:
        norm(A)) m;  

// calculate bounding box over vec of ... vec3D as [[x,y,z], [X,Y,Z]]

function Box(A) = [ 
    [min(flat3(A,0)), min(flat3(A,1)), min(flat3(A,2))], 
    [max(flat3(A,0)), max(flat3(A,1)), max(flat3(A,2))], 
    ]; 

// flatten  vec of vec of ... vec3D into vec of vec3D
function flat3(A, n=0) = 
      A[0][0][0] ==undef? A[n]:
      [for (i=[0:len(A)-1]) 
        for (j=[0:len(A[i])-1]) 
          flat3(A[i][j], n)];
    