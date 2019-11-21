
/*
 koch snowflakes and anti snowflakes
 
 This version is based on a square with replaced sides using a 45 90 45 triangle
 
 the curve and its anti-curve ( mirrored side) tesselate
 
 only up to order 4 since recursion breaks at higher orders
 higher orders are not practical for making anyway , even 4 probably isnt 
 
*/
// side length of base square
side=100;
// order of outer koch curve 0 to 4 
outer_order=1;
//parity of outer curve 0 for curve , 1 for anti-curve
outer_parity=1;
// wall thickness  - 0 if scaled
thickness=5;
// or scaled version
reduce=0.8;
// order of inner snowflake  0 to 4 
inner_order=1;
//parity of inner curve 0 for curve , 1 for anti-curve
inner_parity=1;
// extrude height 0 = no extrusion for laser cutting
height=80;
// height of base formed by outer to create a vase
base_height=1;

function r_peri(peri,sides,n,i=0) =
  i<n 
    ? r_peri(replace_sides(peri,sides),sides,n,i+1)
    : peri ;

sq = scale_peri(norm_peri([90,90,90,90]),side);
sides= [norm_peri([225,90,225,90]), 
       norm_peri([135,270,135,90])];
outer = r_peri(sq,[sides[outer_parity]],outer_order);
inner = r_peri(sq,[sides[inner_parity]],inner_order);
    
module outline(outer,inner) {
    outer_tile=centre_tile(peri_to_tile(outer));
    inner_tile=
       thickness >0 
         ? inset_tile(centre_tile(peri_to_tile(inner)),thickness)
         : centre_tile(peri_to_tile(scale_peri(inner,reduce)));
    difference() {
         fill_tile(outer_tile);
         fill_tile(inner_tile);
    }
}  
  
if (height > 0)
    linear_extrude(height=height)
      outline(outer,inner);
else 
    outline(outer,inner);
// extracts from tiling library

if (base_height >0)
    linear_extrude(height=base_height)
       fill_tile(centre_tile(peri_to_tile(outer)));  

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