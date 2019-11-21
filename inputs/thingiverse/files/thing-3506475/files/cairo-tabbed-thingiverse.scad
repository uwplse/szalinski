//Cairo Pentagonal tile with tabs
// kit wallace 

// form 0 = cairo, 1 = prismatic
form=1;
//length of short side
side=30;
// tab angle 
angle=70;
//width of tab as ratio
tab_width = 0.5;
// depth of tab as ratio
tab_depth= 0.1;
// tile inset for kerf/tolerance - absolute
inset=0;
// height = 0 for 2D
height=10;


function cairo() =
    let(r = sqrt(3)-1)
    [[r,120],[1,90],[1,120],[1,90],[1,120]];
    
function prismatic() =
    let(r = sqrt(3)-1)
    let(t = r*sqrt(3))
    [[t,90],[1,120], [r,120],[r,120],[1,90]];
    
module tabbed_tile(side,peri,tab,inset,height) {
    tab_peri=scale_peri(replace_sides(peri,[tab]),side);
    tile = inset_tile(peri_to_tile(tab_peri),inset);
    if (height>0)
        linear_extrude(height=height)
           fill_tile(tile,"red");  
    else 
        fill_tile(tile,"red");  
}




peris = [cairo(),prismatic()];

tab=sym_tab(tab_width,tab_depth,angle);

peri=peris[form];

tabbed_tile(side,peri,tab,inset,height);
// extracts from tiling library  - not all needed in this script
module fill_tiles (tiles,colors=["lightgreen"]) {
    for (i=[0:len(tiles)-1]) {
       colors = colors[i % len(colors)];
       fill_tile(tiles[i],colors); 
    }
}
module fill_tile(tile,col="red") {
    color(col)
       polygon(3d_to_2d(tile)); 
};
 // functions
function sym_tab1(shoulder_ratio,inset,angle) =
[
     [shoulder_ratio/2, 360-angle],
     [inset/sin(angle), angle],
     [2*inset/tan(angle)+(1-shoulder_ratio)/2, angle],
     [2*inset/sin(angle), 360-angle],
     [2*inset/tan(angle)+(1-shoulder_ratio)/2, 360-angle],
     [inset/sin(angle),angle],
     [shoulder_ratio/2, 0]
     ];

function sym_tab(tab_width,tab_depth,angle) =
[
     [(1 - tab_width)/2, 360-angle],
     [tab_depth/sin(angle), angle],
     [2*tab_depth/tan(angle)+ tab_width/2, angle],
     [2*tab_depth/sin(angle), 360-angle],
     [2*tab_depth/tan(angle)+ tab_width /2, 360-angle],
     [tab_depth/sin(angle),angle],
     [(1 - tab_width)/2, 0]
     ];


function explode_tiles(tiles,factor) =
   [for (t=tiles)  
     let (c = v_centre(t))
     let (d = c*factor)
     translate_tile(t,d)
   ]
  ;

function inset_group(g,d)=
   [for (t=g)  inset_tile(t,d)];
  
// create list of transformations 
// apply the transformations

function group_transforms(tiles,assembly,group=[],transforms=[],i=0) =
    i==len(assembly)
        ? transforms
        : let(move = assembly[i])
          let(source = move[0])
          let(source_i=source[0])
          let(source_side=len(source)==2 ? source[1] :0)
          let(mirror = len(source)==3 ? 1 : 0)
          let(source_tile = mirror==1 ? mirror_tile(tiles[source_i]) : tiles[source_i] )
          len(move) ==1
             ? let (m = m_edge_to_edge(edge(source_tile,0),edge(source_tile,source_side)))
               let (nt = copy_tile(source_tile,m))
               let (t= [source_i,m,mirror])            
               group_transforms(tiles,assembly,concat(group,[nt]),concat(transforms,[t]),i+1)
             : let (dest = move[1])
               let (dest_i=dest[0])
               let (dest_tile=group[dest_i])
               let (dest_side=dest[1])
               let (end = len(dest)==3 ? 1 : 0)
               let (m = m_edge_to_edge(edge(source_tile,source_side),edge(dest_tile,dest_side,end)))
               let (nt = copy_tile(source_tile,m))
               let (t= [source_i,m,mirror])
               group_transforms(tiles,assembly,concat(group,[nt]),concat(transforms,[t]),i+1);

function apply_group_transforms(tiles,transforms,group=[],i=0) =
     i==len(transforms)
        ? group
        : let (transform = transforms[i])
          let (source_tile=tiles[transform[0]])
          let (m=transform[1])
          let (mirror = transform[2])
          let(nt = 
                   mirror
                       ?  copy_tile(mirror_tile(source_tile,m))
                       :  copy_tile(source_tile,m)
                       )
          apply_group_transforms(tiles,transforms,concat(group,[nt]),i+1);

function m_edge_to_edge(edge1, edge2,end=0) =
  // need to 
    let (start = (end==0 || end== undef) ? 1 : 0)
    let (a = angle_between(  
                edge2[1] - edge2[0],
                edge1[0] - edge1[1]))
    let (t1 = m_translate(-edge1[start]))
    let (r =  m_rotate([0,0,-a]))
    let (t2 = m_translate(edge2[end])) 
    t1*r*t2;

function copy_tile(tile,m) =
    [for (p = tile) transform(p,m)];


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

function edge(points,i) =
   [points[i],points[(i +1) %len(points)]];

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
    
function v_centre(v) =  v_sum(v) / len(v);