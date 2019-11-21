/*
    remix of "Celtic knots as Lissajous knots"
    by Kit Wallace
    https://www.thingiverse.com/thing:2257185

    Lissajous Knot:
    https://en.wikipedia.org/wiki/Lissajous_knot
*/

Scale=20; // [1.0:0.5:60]
// Sides of rope - must be a divisor of 360
Sides=4; // [3,4,5,6,8,9,10,12,15,30,45,60]
// decrease for finer details
Step = 2; // [0.2:0.2:5]
// x scaling
vx = 1.0; // [0.0:0.1:4]
// y scaling
vy = 1.0; // [0.0:0.1:4]
// z scaling
vz = 1.0; // [0.0:0.1:4]
// Rope diameter
Rope_Diameter=2.0; // [0.5:0.1:6.0]
// true if knot is open or partial
Open = false; // [false,true]
// change for partial path 
Start=0; // [0:360]
// change for partial path
End=360; // [0:360]

// x_angle_multiple
nx = 3.0; // [0.5:0.5:30]
// y_angle_multiple
ny = 2.0; // [0.5:0.5:30]
// z_angle_multiple
nz = 7.0; // [0.5:0.5:30]
// (radians)
px_RAD = 0.7; // [0.0:0.1:4.0]
// (radians)
py_RAD = 0.2; // [0.0:0.1:4.0]
// (radians)
pz_RAD = 0.0; // [0.0:0.1:4.0]
// phase angle for profile (matters for low Sides)
Phase = 45; // [0:5:180]

/* [Hidden] */


// create a tube as a polyhedron 
// tube can be open or closed

// polyhedron constructor

function poly(name,vertices,faces,debug=[],partial=false) = 
    [name,vertices,faces,debug,partial];

function p_name(obj) = obj[0];
function p_vertices(obj) = obj[1];
function p_faces(obj) = obj[2];
  
module show_solid(obj) {
    polyhedron(p_vertices(obj),p_faces(obj),convexity=10);
};

// utility functions  
function m_translate(v) = [ [1, 0, 0, 0],
                            [0, 1, 0, 0],
                            [0, 0, 1, 0],
                            [v.x, v.y, v.z, 1  ] ];
                            
function m_rotate(v) =  [ [1,  0,         0,        0],
                          [0,  cos(v.x),  sin(v.x), 0],
                          [0, -sin(v.x),  cos(v.x), 0],
                          [0,  0,         0,        1] ]
                      * [ [ cos(v.y), 0,  -sin(v.y), 0],
                          [0,         1,  0,        0],
                          [ sin(v.y), 0,  cos(v.y), 0],
                          [0,         0,  0,        1] ]
                      * [ [ cos(v.z),  sin(v.z), 0, 0],
                          [-sin(v.z),  cos(v.z), 0, 0],
                          [ 0,         0,        1, 0],
                          [ 0,         0,        0, 1] ];
                            
function vec3(v) = [v.x, v.y, v.z];
function transform(v, m)  = vec3([v.x, v.y, v.z, 1] * m);
                            
function orient_to(centre,normal, p) = m_rotate([0, atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]) 
                     * m_rotate([0, 0, atan2(normal[1], normal[0])]) 
                     * m_translate(centre);

// solid from path


function circle_points(r, sides,phase=45) = 
    let (delta = 360/sides)
    [for (i=[0:sides-1]) [r * sin(i*delta + phase), r *  cos(i*delta+phase), 0]];

function loop_points(step,min=0,max=360) = 
    [for (t=[min:step:max-step]) f(t)];

function transform_points(list, matrix, i = 0) = 
    i < len(list) 
       ? concat([ transform(list[i], matrix) ], transform_points(list, matrix, i + 1))
       : [];

function tube_points(loop, circle_points,  i = 0) = 
    (i < len(loop) - 1)
     ?  concat(transform_points(circle_points, orient_to(loop[i], loop[i + 1] - loop[i] )), 
               tube_points(loop, circle_points, i + 1)) 
     : transform_points(circle_points, orient_to(loop[i], loop[0] - loop[i] )) ;

function loop_faces(segs, sides, open=false) = 
   open 
     ?  concat(
         [[for (j=[sides - 1:-1:0]) j ]],
         [for (i=[0:segs-3]) 
          for (j=[0:sides -1])  
             [ i * sides + j, 
               i * sides + (j + 1) % sides, 
              (i + 1) * sides + (j + 1) % sides, 
              (i + 1) * sides + j
             ]
        ] ,   
        [[for (j=[0:1:sides - 1]) (segs-2)*sides  + j]]
        )
     : [for (i=[0:segs]) 
        for (j=[0:sides -1])  
         [ i * sides + j, 
          i * sides + (j + 1) % sides, 
          ((i + 1) % segs) * sides + (j + 1) % sides, 
          ((i + 1) % segs) * sides + j
         ]   
       ]  
     ;

//  path with hulls

module hulled_path(path,r) {
    for (i = [0 : 1 : len(path) - 1 ]) {
        hull() {
            translate(path[i]) sphere(r);
            translate(path[(i + 1) % len(path)]) sphere(r);
        }
    }
};

// smoothed path by interpolate between points 

weight = [-1, 9, 9, -1] / 16;

function interpolate(path,n,i) =
        path[(i + n - 1) %n] * weight[0] +
        path[i]             * weight[1] +
        path[(i + 1) %n]    * weight[2] +
        path[(i + 2) %n]    * weight[3] ;

function subdivide(path,i=0) = 
    i < len(path) 
     ? concat([path[i]], 
              [interpolate(path,len(path),i)],
              subdivide(path, i+1))
     : [];

function smooth(path,n) =
    n == 0
     ?  path
     :  smooth(subdivide(path),n-1);


function path_segment(path,start,end) =
    let (l = len(path))
    let (s = max(floor(start * 360 / l),0),
         e = min(ceil(end * 360 / l),l - 1))
    [for (i=[s:e]) path[i]];


function scale(path,scale,i=0) =
    i < len(path)
      ?  concat( 
           [[path[i][0]*scale[0],path[i][1]*scale[1],path[i][2]*scale[2]]], 
           scale(path,scale,i+1)
         )
      :  [];

function curve_length(step,t=0) =
    t < 360
      ?  norm(f(t+step) - f(t)) + curve_length(step,t+step)
      :  0;

function map(t, min, max) =
      min + t* (max-min)/360;
    
//  create a knot from a path 

function path_knot(path,r,sides,kscale,phase=45,open=false)  =
  let(loop_points = scale(path,kscale))
  let(circle_points = circle_points(r,sides,phase))
  let(tube_points = tube_points(loop_points,circle_points))
  let(loop_faces = loop_faces(len(loop_points),sides,open))
  poly(name="Knot",
         vertices = tube_points,
         faces = loop_faces);

 // render_type function-1
           
R=Rope_Diameter/Scale;
RAD=180/PI;
px=px_RAD * RAD;
py=py_RAD * RAD;
pz=pz_RAD * RAD;

function f(t) = 
    [  cos(nx * t + px) ,
       cos(ny * t + py),
       cos(nz * t + pz)
    ];
 
            
Kscale=[vx,vy,vz];
Paths = [loop_points(Step,Start,End)];
scale(Scale)
for (k =[0:len(Paths) - 1]) {
   path = Paths[k];
 knot= path_knot(path,R,Sides,Kscale,Phase,Open);
 
   solid1=knot;  // apply transformations here
      show_solid(solid1);
};
