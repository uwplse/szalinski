
/* see https://link.springer.com/content/pdf/10.1007%2F978-3-642-04397-0_7.pdf

missed configuration added
issues with offsetting fixed

Kit Wallace 2019-03-17
*/

//order of fibonacci curve 0 to 4 - higher causes recursion problems
k=3;
//width of pattern
width=60;
//inset amount for kerf/clearance -0.035 is typical for laser
inset=-0.1;
//height  0 is 2D for laser
height=6;

function fib(n) =
    n==0 ?0 :
    n==1 ?1 :
    fib(n-1)+fib(n-2);
    
function mirror(s,i=0) =  
   i <len(s)
     ? str(  s[i]=="R" ? "L" : "R",
             mirror(s,i+1))
     : "";

function fib_curve(n)=
    n==0 ? "" :
    n==1 ? "R" :
    n%3==2? str(fib_curve(n-1),fib_curve(n-2)) :
      str(fib_curve(n-1),mirror(fib_curve(n-2)));
  
     
function lr_to_peri(f) =
  [for (i=[0:len(f)-1])
      let(d=f[i])
      [1,d=="R"? 270: d=="L"? 90 : 0]
  ];

module fx(k,side=1,dir,inset=0) {
fib_curve=fib_curve(k);
fib_dir = k % 2 == 0 ?  fib_curve : mirror(fib_curve);   
peri=scale_peri(repeat_peri(lr_to_peri(fib_dir),4),side);
tile=inset_tile(peri_to_tile(peri),inset);
fill_tile(tile);
};

specs =  [[1,0,1],[4,0,3],[7,28,9],[10,12,23],[13,54,56]];

spec=specs[k];
n=spec[0];  // fibonacci order
t=spec[1];  // used for tessellation
dir= k % 2; // direction of path - 1 anticlockwise, -1 clockwise 
side = width / spec[2];
if (height > 0)
    linear_extrude(height=height)
      fx(n,t,side=side,dir=dir,inset=dir*inset); 
else 
      fx(n,t,side=side,dir=dir,inset=dir*inset); 

// extracts from tiling library

module fill_tile(tile,col="red") {
    color(col)
       polygon(3d_to_2d(tile)); 
};

 // functions
 
function replace_sides(peri,sides) =
 flatten( [for (i=[0:len(peri)-1])
      let (bside = peri[i])
      let (mside =  sides[i % len(sides)])
      let (mside_m = 
              len(mside) >1 
                 ? concat([for (i=[0:len(mside)-2]) mside[i]],[[mside[len(mside)-1][0],bside[1]]])
                 : [[mside[0][0],bside[1]]]
           )
      let (mside_length = peri_error(mside_m))
      let (mside_scaled = scale_peri(mside_m,bside[0]/mside_length))
      mside_scaled
  ]);

function peri_to_points(peri,pos=[0,0,0],dir=0,i=0) =
    i == len(peri)
      ? [pos]
      : let (side = peri[i])
        let (distance = side[0])
        let (newpos = pos + distance* [cos(dir), sin(dir),0])
        let (angle = side[1])
        let (newdir = dir + (180 - angle))
        concat([pos],peri_to_points(peri,newpos,newdir,i+1)) 
     ;                 

function peri_to_tile(peri,last=false) = 
    let (p = peri_to_points(norm_peri(peri)))  
    last 
       ? [for (i=[0:len(p)-1]) p[i]] 
       : [for (i=[0:len(p)-2]) p[i]]; 

function norm_peri(peri) =
     [for (p=peri)
        len(p)==undef
           ? [1,p]
           :[p.x,p.y] 
     ];
function repeat_peri(p,n) =
   norm_peri( flatten([for (i=[0:n-1]) p]));
    
function scale_peri(peri,scale) =
   [for (p=peri)
        len(p)==undef
           ? [scale,p]
           :[scale * p[0],p[1]] 
   ];
   
function peri_error(peri) = 
    norm(peri_end(peri));

function peri_end(peri) =
    let(t=peri_to_tile(peri,true))
    t[len(t)-1];    
  
function translate_tile(t,d) =
      [for (p=t) p+d]; 
        
function centre_tile(t) =
    let(c = v_avg(t))
    translate_tile(t,-c);

function inset_tile (tile, d=0.1) =
  [for (i=[0:len(tile)-1])
      let (v1 = unitv(tile[(i+len(tile) - 1 )% len(tile)] - tile[i]))
      let (v2 = unitv(tile[i] - tile[(i+1 )% len(tile)] ))
      let (vm = unitv((v1 - v2) /2))
      let (a = 180 - angle_between(v1,v2))
      let (offset = d / sin(a/2))
      tile[i]+offset * vm
  ];
  
 function angle_between(u, v) = 
     let (x= unitv(u) * unitv(v))
     let (y = x <= -1 ? -1 :x >= 1 ? 1 : x)
     let (a = acos(y))
     let (d = cross(u,v).z)
      d  > 0 ? a : 360- a;
  
function unitv(v)=  
   let (n = norm(v))
   n !=0 ? v/ norm(v) : v;
  
function 3d_to_2d(points)=
    [ for (p=points) [p.x,p.y]];
function v_avg(v) =v_sum(v) / len(v);
      
function zero(v) =
    len(v) == undef ? 0 : [for (i=[0:len(v)-1]) 0];
        
function v_sum_r(v,n,k) =
      k < n ?  v[k] + v_sum_r(v,n,k+1) : zero(v[0]) ;

function v_sum(v) = v_sum_r(v,len(v),0);
      
function flatten(l) = [ for (a = l) for (b = a) b ] ;