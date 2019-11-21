// 
// Customizable Ripples
// version 1.0   3/19/2016
// by DaoZenCiaoYen @ Thingiverse
// (Steve Van Ausdall)
//
// remix of: http://www.thingiverse.com/thing:24897
// OpenSCAD 3D surface plotter, z(x,y)
// Dan Newman, dan newman @ mtbaldy us
//

// preview[view:south east, tilt:top diagonal]

/* [Main] */
design = 0 ; // [0:Random, 1:Square, 2:Triangle, 3:Custom]
// how much of the function to show (zoom)
extent = 10 ; // [5:25]
// max distance between points
separation = 18 ; // [0:50]
// max amplitude of the waves
depth = 10 ; // [0:25]
// shifts the sine waves 
shift = 40 ; // [0:100]

/* [Random Design Settings] */
random_points = 3 ; // [1:5]
seed = 36 ; // [0:99]

/* [Custom Design Settings] */
custom_points = 5 ; // [1:5]
// [x,y,d,s]
point1 = [0,0,10,20] ;
// [x,y,d,s]
point2 = [10,0,6,30] ;
// [x,y,d,s]
point3 = [-10,0,6,30] ;
// [x,y,d,s]
point4 = [0,10,6,30] ;
// [x,y,d,s]
point5 = [0,-10,6,30] ;

/* [Size and Shape] */
// size, in mm (square)
dimension = 80 ; // [20:10:120]
// resolution, in scan lines
resolution = 50 ; // [5:50]
// height (negative is truncated) in mm
z_height = 4 ; // [1:20]

/* [Hidden] */
pi = 3.14159265358979;
ff = 0.001 ; // overlap to aid manifold processing

size = extent ;
nx = shift ; // center shift
sz = depth ; // amplitude
sep = separation ; // separation
px = random_points ; // max points
res = resolution ;
dim = dimension ;
rng = size*pi ;
sh = sqrt(3)/2*sep ;
hs = sh/2 ;

da = [
  [ // set 0 (random)
    rands(-sep,sep,px,seed), // x
    rands(-sep,sep,px,seed+1), // y
    rands(4,sz,px,seed), // sz
    rands(0,nx,px,seed), // n
    random_points-1], // p
  [ // set 1 (square)
    [-sep,-sep,sep,sep], // x
    [-sep,sep,sep,-sep], // y
    [sz,sz,sz,sz], // sz
    [nx,nx,nx,nx], // n
    3], // p
  [ // set 2 (triangle)
    [-sep,sep,0], // x
    [-sh,-sh,sh], // y
    [sz,sz,sz], // sz
    [nx,nx,nx], // n
    2], // p
  [ // set 3 (custom)
    [point1[0],point2[0],point3[0],point4[0],point5[0]], // x
    [point1[1],point2[1],point3[1],point4[1],point5[1]], // y
    [point1[2],point2[2],point3[2],point4[2],point5[2]], // sz
    [point1[3],point2[3],point3[3],point4[3],point5[3]], // n
    custom_points-1] // p
  ];

// A wave ripple function
function zr(x,y,s,n) = s*sin(180*(sqrt(x*x+y*y)+n)/pi)/sqrt((x*x+y*y)+n);

// Other example functions
function z2(x,y) = cos(x*y)*(x*x-y*y)/2000*depth;
function z3(x,y) = sqrt(cos(abs(x)*10)+cos(abs(y)*10));

// Multiple ripples added together
function zao(x,y,o,p) = (p<0 ? 0 : zao(x,y,o,p-1) +
  zr(x+da[o][0][p],y+da[o][1][p],da[o][2][p],da[o][3][p])) ;
function za(x,y,o) = zao(x,y,o,da[o][4]);

// which settings (da) to use
function z(x,y) = max(-z_height,za(x,y,design));

// other example functions 
//function z(x,y) = max(-z_height,z2(x,y));
//function z(x,y) = max(-z_height,z3(x,y));
//function z(x,y) = max(-z_height,z2(x,y)+z3(x,y));
//function z(x,y) = max(-z_height,z2(x,y)+za(x,y,design));


// Plot the function in 3d
3dplot([-rng,+rng],[-rng,+rng],[res,res],-z_height-3,[dim,dim]);


//
// The 3d surface generation code
//

// Pyramid vertices (template)
//
pyramid_vertices = [ // these aren't actually used below
  [0,0,0], [1,0,0], [0,0,1], [1,0,1],
  [0,1,0], [1,1,0], [0,1,1], [1,1,1],
  [0.5,0.5,1.5] ]; // center added for 9 faces
  
// The faces of the pyramid (indices of points above)
pyramid_faces = [
  [0,1,5,4],[0,2,3,1],[1,3,7,5],[7,6,4,5],[6,2,0,4],
  [2,8,3],[3,8,7],[7,8,6],[6,8,2]];

// 3dplot -- the 3d surface generator
//
// x_range -- 2-tuple [x_min, x_max], the minimum and maximum x values
// y_range -- 2-tuple [y_min, y_max], the minimum and maximum y values
//    grid -- 2-tuple [grid_x, grid_y] indicating the number of grid cells
//              along the x and y axes
//   z_min -- Minimum expected z-value; used to bound the underside of the surface
//    dims -- 2-tuple [x_length, y_length], the physical dimensions in millimeters

module 3dplot(x_range, y_range, grid, z_min, dims)
{
  dx = ( x_range[1] - x_range[0] ) / grid[0];
  dy = ( y_range[1] - y_range[0] ) / grid[1];

  scale([dims[0]/(max(x_range[1],x_range[0])-min(x_range[0],x_range[1])),
         dims[1]/(max(y_range[1],y_range[0])-min(y_range[0],y_range[1])),1])
  translate([-(x_range[0]+x_range[1])/2, -(y_range[0]+y_range[1])/2, -z_min])
  for ( x = [x_range[0] : dx  : x_range[1]] )
  {
    for ( y = [y_range[0] : dy : y_range[1]] )
    {
      polyhedron(
        points=[
          [x-ff,y-ff,z_min], // 0:[0,0,0]
          [x+dx,y-ff,z_min], // 1:[1,0,0]
          [x-ff,y-ff,z(x-ff,y-ff)], // 2:[0,0,1]
          [x+dx,y-ff,z(x+dx,y-ff)], // 3:[1,0,1]
          [x-ff,y+dy,z_min], // 4:[0,1,0]
          [x+dx,y+dy,z_min], // 5:[1,1,0]
          [x-ff,y+dy,z(x-ff,y+dy)], // 6:[0,1,1]
          [x+dx,y+dy,z(x+dx,y+dy)], // 7:[1,1,1],
          [x+dx/2,y+dy/2,z(x+dx/2,y+dy/2)] // 8:[0.5,0.5,1.5]
        ],
        faces=pyramid_faces);
    }
  }
}