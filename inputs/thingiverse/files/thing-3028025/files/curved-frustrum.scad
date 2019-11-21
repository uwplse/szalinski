//  kit wallace random twisted frustrum
// - handle pent to hex transition - just double one of the pentagon points and interpolate
// create mid layer with extra point  ??
// todo - tilt top face 
// todo  - copy one face to the next version - ie the first side of both is given, not random
// also the relative orientation is given

// number of sides 
n=4;
// minimum length of side
min_length=3;
// maximum length of side
max_length=10;
// angle range
angle_range=30;
// height of frustrum
height=5;
//scale upper layer pc
upper_pc=90;
// layers
m=100;


// basic functions
function flatten(l) = [ for (a = l) for (b = a) b ] ;
function between(a,b,x) = x >= a && x <= b;

function depth(a) =
   len(a)== undef 
       ? 0
       : 1 + depth(a[0]);
                
// transformation matrices

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
 
function m_scale(v,s) =
     depth(v)==2
      	? [ [v[0],0,0,0],
	        [0,v[1],0,0],
	        [0,0,v[2],0],
	        [0,0,0,1]
          ]
        : [ [v,0,0,0],
	        [0,v,0,0],
	        [0,0,v,0],
	        [0,0,0,1]
          ];
          
function vec3(v) = [v.x, v.y, v.z];
function transform(v, m)  = vec3([v.x, v.y, v.z, 1] * m);

//  angles 

function angle_between(u, v) = 
     let (x= unitv(u) * unitv(v))
     let (y = x <= -1 ? -1 :x >= 1 ? 1 : x)
     let (a = acos(y))
     let (d = cross(u,v).z)
      d  > 0 ? a : 360- a;
               
// vector operations 
function zero(v) =
    len(v) == undef ? 0 : [for (i=[0:len(v)-1]) 0];
   
function slice(v,d,i=0) =
     i < len(v) ?  concat([v[i][d]], slice(v,d,i+1) ) : [] ;
   
function unitv(v)=  v/ norm(v);
   
function v_sum_r(v,n,k) =
      k < n ?  v[k] + v_sum_r(v,n,k+1) : zero(v[0]) ;

function v_sum(v) = v_sum_r(v,len(v),0);
  
function v_avg(v) =v_sum(v) / len(v);
    
function v_centre(v) =  avg(v);
  
function 3d_to_2d(points)=
    [ for (p=points) [p.x,p.y]];
        
function 2d_to_3d(points)=
    [ for (p=points) [p.x,p.y,0]];

function v_scale(v,scale) =
    let(m=m_scale(scale))
    [for (p=v) transform(p,m) ];

function v_rotate(v,angle) =
    let(m=m_rotate([0,0,angle]))
    [for (p=v) transform(p,m)];

function v_translate(v,d) =
    let(m=m_translate(d))
    [for (p=v) transform(p,m)];
  
//  perimeter operations   
//  perimeter is  defined as a sequence of length/interior angle pairs, going anticlockwise 

function peri_to_points(peri,pos=[0,0,0],dir=0,i=0) =
    i == len(peri)
      ? [pos]
      : let(side = peri[i])
        let (distance = side[0])
        let (newpos = pos + distance* [cos(dir), sin(dir),0])
        let (angle = side[1])
        let (newdir = dir + (180 - angle))
        concat([pos],peri_to_points(peri,newpos,newdir,i+1)) 
     ;  
        
function peri_to_tile(peri,last=false) = 
    let (p = peri_to_points(peri))  
    last 
       ? [for (i=[0:len(p)-1]) p[i]] 
       : [for (i=[0:len(p)-2]) p[i]]; 

function total_internal(peri) =
    v_sum(slice(peri,1));

function peri_length(peri) =
    v_sum(slice(peri,0));
            
function isPolygon(peri) =
       let (n = len(peri))
       abs(total_internal(peri) - (n - 2) * 180)<  0.01;
       
function isConvex(peri,i=0) =
   i < len(peri)
     ? peri[i][1] > 0  && peri[i][1] < 180  && peri[i][0] > 0 && isConvex(peri,i+1)
     : true;     


     
// tile operations
    
function tile_to_peri(points) =
    [for (i=[0:len(points)-1])
        let (a = angle_between(
          points[(i+1) % len(points)] - points[i],
          points[(i+2) % len(points)] -  points[(i+1) % len(points)]))
          
       [norm(points[(i+1) % len(points)] - points[i]),
       180-a
       ]
    ] ;

function centre_tile(t) =
    let(c = v_avg(t))
    v_translate(t,-c);
     
// tile to object    
module fill_tile(tile,color="red") {
    color(color)
       polygon(3d_to_2d(tile)); 
};

function random_peri(n,min_length,max_length,min_angle,max_angle) =
   let (p1 =
    [for (i=[0:n-2])
        [rands(min_length,max_length,1)[0], 
         rands(min_angle,max_angle,1)[0]]
    ])
   let(p2 = tile_to_peri(peri_to_tile(p1,true)))  // close the polygon
   let(ln= p2[n-1][0])
   let(an= p2[n-1][1])
   let(an1= p2[n-2][1])
//   isConvex(p2) &&
   isPolygon(p2) &&
           between (min_length,max_length,ln)
       &&  between (min_angle,max_angle,an) 
       &&  between (min_angle,max_angle,an1) 
    
       ? p2
       : random_peri(n,min_length,max_length,min_angle,max_angle)

  ;

function inbetweenh(v1,v2,h,n) =
   len(v1)==len(v2)
   ?
    flatten([for (i=[0:n])
       let(r = i/n)
       flatten([for (j=[0:len(v1)-1])
           let(p1=v1[j])
           let(p2=v2[j])
           [[p1.x *( 1-r) + p2.x*r,
            p1.y *(1-r) + p2.y*r,
            h*r]]
       ])
     ])
    :false;


function inbetween(v1,v2,n) =
   len(v1)==len(v2)
   ?
    flatten([for (i=[0:n])
       let(r = i/n)
       flatten([for (j=[0:len(v1)-1])
           let(p1=v1[j])
           let(p2=v2[j])
           [p1*( 1-r) + p2*r]
       ])
     ])
    :false;
              
// frustrum 
function frustrum_faces(n,m) =
    concat(
     [[for (i=[0:n-1]) i]],            //bottom
     [[for (i=[0:n-1]) n*(m-1) + 2*n - i - 1]],  //top
     flatten([for(j=[0:m-1])
         let(k=j*n)
         [for (i=[0:n-1])                  // sides
         [k+i+n,k+(i+1)%n + n,k+(i+1)%n,k+i ]
         ]
     ])
    );

module loft(bottom,top,n) {
  
vertices=inbetween(bottom,top,m);   
faces= frustrum_faces(len(top),m);
polyhedron(vertices,faces);  
    
}
function triangle(a,b) = norm(cross(a,b))/2;

function tile_area(tile) =
     v_sum([for (i=[0:len(tile)-1])
           triangle(tile[i], tile[(i+1)%len(tile)]) ]);
     
// main    
average_angle=180 - 360/n;
min_angle=max(average_angle - angle_range,1);;
max_angle= min(average_angle +angle_range,179);  
p1=random_peri(n=n,min_length=min_length,max_length=max_length,min_angle=min_angle,max_angle=max_angle); 
t1=centre_tile(peri_to_tile(p1));
// echo(t1);

a1=tile_area(t1);       
p2=random_peri(n=n,min_length=min_length,max_length=max_length,min_angle=min_angle,max_angle=max_angle);    
  
t2=centre_tile(peri_to_tile(p2)); 
// echo(t2);
a2=tile_area(t2);
// echo(a2);
r=1 / sqrt(a2/a1);
// echo(r);
t3=v_scale(t2,r*upper_pc/100); 
// echo(t3);
t3h= v_translate(t3,[0,0,height]);
// echo(t3h);
loft(t1,t3h,m);