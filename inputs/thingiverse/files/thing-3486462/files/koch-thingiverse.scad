/*
 Koch snowflakes 
 
 only up to order 4 since recursion breaks at higher orders
 higher orders are not practical for making anyway , even 4 probably isnt (768 sides)
 
 kitwallace Mar 2019
*/
// side length of base triangle
side=40;
// order of outer koch snowflake 0 to 4 
outer_order=2;
// reduction in scale of inner snowflake
reduce=0.65;
// order of inner snowflake  0 to 4 
inner_order=1;
// extrude height 0 = no extrusion for laser cutting
height=2;

function koch_peri(peri,sides,n,i=0) =
  i<n 
    ? koch_peri(replace_sides(peri,sides),sides,n,i+1)
    : peri ;
    
module outline(outer,inner) {
    difference() {
         fill_tile(centre_tile(peri_to_tile(outer)));
         fill_tile(centre_tile(peri_to_tile(inner)));
    }
}  
     
koch_side = norm_peri([240,60,240,60]);
triangle = repeat_peri([[side,60]],3);
koch_outer= koch_peri(triangle,[koch_side],outer_order);
koch_inner= scale_peri(koch_peri(triangle,[koch_side],inner_order),reduce);
if (height > 0)
    linear_extrude(height=height)
      outline(koch_outer,koch_inner);
else 
    outline(koch_outer,koch_inner);
    
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

function 3d_to_2d(points)=
    [ for (p=points) [p.x,p.y]];
function v_avg(v) =v_sum(v) / len(v);
      
function zero(v) =
    len(v) == undef ? 0 : [for (i=[0:len(v)-1]) 0];
        
function v_sum_r(v,n,k) =
      k < n ?  v[k] + v_sum_r(v,n,k+1) : zero(v[0]) ;

function v_sum(v) = v_sum_r(v,len(v),0);
      
function flatten(l) = [ for (a = l) for (b = a) b ] ;